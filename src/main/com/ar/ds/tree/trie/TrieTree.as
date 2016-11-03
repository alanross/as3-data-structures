package com.ar.ds.tree.trie
{
	import com.ar.core.error.MissingImplementationError;
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;
	import com.ar.core.utils.StringUtils;
	import com.ar.ds.ICollection;

	/**
	 * A Trie tree implementation to check, in a timely manner, if a word exists
	 * in a large collection of words and to return a list of words of which given
	 * word is a prefix of.
	 *
	 * Each word is split up into single chars. Each char is then stored in a
	 * single node. The root node does not store a char.
	 *
	 * This example stores the words aa, ab, ac, mm, mn and z.
	 * "..." indicates a node can hold link to as many nodes as characters in alphabet.
	 *
	 *                  root
	 *         /   ...   |   ...   \
	 *        a          m          z
	 *      / | \       / \
	 *     a  b  c     m   n
	 *
	 * Usages:
	 * - auto completion
	 * - type-ahead requests
	 *
	 * Java version on which this port is based on:
	 * http://logos.cs.uic.edu/340/assignments/Solutions/Wordpopup/curso/trie.java
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TrieTree implements ICollection
	{
		private var _root:TrieTreeNode;

		private var _numEntries:int;

		/**
		 * Creates a new instance of TrieTree.
		 */
		public function TrieTree()
		{
			_root = null;

			_numEntries = 0;
		}

		/**
		 * Follows the tree from root until the prefix is found.
		 * Ignores if string is full word or only prefix of word.
		 */
		private function findLastNodeForString( str:String ):TrieTreeNode
		{
			if( StringUtils.isEmpty( str ) )
			{
				return null;
			}

			var node:TrieTreeNode = _root;

			const n:int = str.length;

			//go through every char of string
			for( var i:int = 0; i < n; ++i )
			{
				//move node down each time
				if( node.down != null )
				{
					node = node.down;
				}
				//if node can't go down, and str hasn't been found yet, its not in the tree
				else
				{
					return null;
				}

				//search the children lists for the correct path to follow
				while( str.charAt( i ) != node.glyph )
				{
					//if the correct path hasn't been found str is not in tree
					if( node.next == null )
					{
						return null;
					}

					node = node.next;
				}
			}

			return node;
		}

		/**
		 * Add each complete word which can be reached from given node to a result list.
		 * E.g. Starting from 'love' the node will contain 'e' and list all word of
		 * which 'love' is prefix, like 'lovely', 'loved'.
		 */
		private function recursiveList( node:TrieTreeNode, str:String, result:Vector.<String> ):void
		{
			while( node != null && node.glyph != TrieTreeNode.EMPTY )
			{
				recursiveList( node.down, str + node.glyph, result );

				if( node.wordEnd )
				{
					result.push( str + node.glyph );
				}

				node = node.next;
			}
		}

		/**
		 * Inserts given words list into dictionary.
		 */
		public function build( words:Vector.<String> ):void
		{
			var n:int = words.length;

			for( var i:int = 0; i < n; ++i )
			{
				insert( words[i] );
			}
		}

		/**
		 * Insert a string into the dictionary.
		 */
		public function insert( str:String ):void
		{
			//remove punctuation and special characters
			str = str.toLowerCase().replace( /[^a-zA-Z äöüÄÖÜß 0-9]+/gi, "" );

			if( StringUtils.isEmpty( str ) )
			{
				return;
			}

			var level:int = 0;

			if( _root == null )
			{
				_root = new TrieTreeNode( TrieTreeNode.EMPTY, level );
			}

			var node:TrieTreeNode = _root;
			var nextNode:TrieTreeNode = _root;
			var parentNode:TrieTreeNode = _root;

			var glyph:String;
			var index:int = 0;

			// loop until every char in str is inserted
			while( index < str.length )
			{
				level++;

				glyph = str.charAt( index );

				// there are no chars on this tree level yet. create a new node with given char
				if( node.down == null )
				{
					node.down = new TrieTreeNode( glyph, level );

					//this will make a lot of null check obsolete
					node.down.next = new TrieTreeNode( TrieTreeNode.EMPTY, level );
					node.down.next.down = node;

					node = node.down;
				}
				// No chars on this tree level yet, insert it at right position or ignore if this char already exists
				else
				{
					parentNode = node;
					node = node.down;

					// char has smallest value, so prepend before existing ones
					if( glyph < node.glyph )
					{
						node = new TrieTreeNode( glyph, level, node );
						parentNode.down = node;
					}
					// find correct place where to append char
					else if( glyph > node.glyph )
					{
						// find the correct position to insert char based on alphabetical order
						while( node.glyph != TrieTreeNode.EMPTY && glyph > node.glyph )
						{
							nextNode = node;
							node = node.next;
						}

						// this char does not exist yet, so append it
						if( glyph != node.glyph )
						{
							node = new TrieTreeNode( glyph, level, node );
							nextNode.next = node;
						}
					}
				}

				index++;
			}


			if( node.wordEnd != true )
			{
				//at this point it will always be at the start of a word
				node.wordEnd = true;

				_numEntries++;
			}
			else
			{
				Log.trace( Context.DEFAULT, this, "ignoring insert as " + str + " already exists" );
			}
		}

		/**
		 * Removes a given string from the tree
		 * @param str
		 */
		public function remove( str:String ):void
		{
			_numEntries--;

			throw new MissingImplementationError();
		}

		/**
		 * Returns true if string is found; false otherwise.
		 */
		public function has( str:String ):Boolean
		{
			return ( findLastNodeForString( str ) != null );
		}

		/**
		 * list all words in the dictionary.
		 */
		public function list():Vector.<String>
		{
			var result:Vector.<String> = new Vector.<String>();

			if( _root == null )
			{
				return result;
			}

			recursiveList( _root.down, "", result );

			return result;
		}

		/**
		 * Returns a list of all strings of which given string is prefix.
		 * The list is empty if string is not a prefix of any word.
		 */
		public function find( str:String ):Vector.<String>
		{
			var result:Vector.<String> = new Vector.<String>();

			const node:TrieTreeNode = findLastNodeForString( str );

			// nothing found
			if( node == null )
			{
				return result;
			}

			if( node.wordEnd )
			{
				result.push( str );
			}

			//populate result list with all words of which str is prefix
			recursiveList( node.down, str, result );

			return result;
		}

		/**
		 * Clear the TrieTree.
		 */
		public function empty():void
		{
			_root = null;

			_numEntries = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			_root = null;

			_numEntries = 0;
		}

		/**
		 * Returns the number of word entries in the dictionary.
		 */
		public function getSize():int
		{
			return _numEntries;
		}

		/**
		 * Returns true if the dictionary is empty
		 */
		public function isEmpty():Boolean
		{
			return ( 0 == _numEntries );
		}

		/**
		 * Creates and returns a string representation of the TrieTree object.
		 */
		public function toString():String
		{
			return "[TrieTree size:" + getSize() + "]";
		}
	}
}
