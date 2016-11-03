package com.ar.ds.skipList
{
	import com.ar.core.error.MissingImplementationError;
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;

	/**
	 * Ported from:
	 * http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/Map/skip-list-impl.html
	 *
	 * null      null
	 *  ^         ^
	 *  |         |
	 * head ---> null <-- -inf <----> +inf --> null
	 *  |         |
	 *  v         v
	 * null      null
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class SkipList
	{
		private var _head:SkipNode;
		private var _tail:SkipNode;
		private var _size:int;
		private var _height:int;

		/**
		 * Creates a new instance of SkipList.
		 */
		public function SkipList()
		{
			var p1:SkipNode = new SkipNode( SkipNode.negInf, null );
			var p2:SkipNode = new SkipNode( SkipNode.posInf, null );

			_head = p1;
			_tail = p2;

			p1.right = p2;
			p2.left = p1;

			_size = 0;
			_height = 0;
		}

		/**
		 * Returns the reference of the newly created node.
		 */
		private function insertAfterAbove( p:SkipNode, q:SkipNode, key:String ):SkipNode
		{
			var newNode:SkipNode = new SkipNode( key, null );

			// Use the links before they are changed
			newNode.left = p;
			newNode.right = p.right;
			newNode.down = q;

			// Update the existing links.
			p.right.left = newNode;
			p.right = newNode;
			q.up = newNode;

			return newNode;
		}

		/**
		 * findEntry(k): find the largest key x <= k on the LOWEST level of the Skip List
		 */
		private function findNode( key:String ):SkipNode
		{
			var p:SkipNode;

			p = _head;

			while( true )
			{
				/* --------------------------------------------
				 Search RIGHT until you find a LARGER entry

				 E.g.: k = 34

				 10 ---> 20 ---> 30 ---> 40
				 ^
				 |
				 p stops here
				 p.right.key = 40
				 -------------------------------------------- */
				while( p.right.key != SkipNode.posInf && p.right.compareTo( key ) <= 0 )
				{
					p = p.right;
				}

				// Go down one level if you can...
				if( p.down != null )
				{
					p = p.down;
				}
				else
				{
					// We reached the LOWEST level... Exit...
					break;
				}
			}

			return p;
		}

		/**
		 * Returns the value associated with a key.
		 */
		public function getAt( key:String ):Object
		{
			var p:SkipNode = findNode( key );

			return ( key == p.key ) ? p.data : null;
		}

		public function contains( key:String ):Boolean
		{
			return ( getAt( key ) != null );
		}

		/**
		 * Add a key-value pair in the map, replacing previous one if it exists.
		 * */
		public function add( k:String, data:Object ):void
		{
			var p:SkipNode = findNode( k );

			if( k == p.key )
			{
				p.data = data;

				return;
			}

			var q:SkipNode = new SkipNode( k, data );

			q.left = p;
			q.right = p.right;
			p.right.left = q;
			p.right = q;

			var i:int = 0; // Current level = 0

			while( Math.random() < 0.5 )
			{
				// Coin flip success: make one more level....
				// Check if height exceed current height. If so, make a new EMPTY level
				if( i >= _height )
				{
					_height = _height + 1;

					var p1:SkipNode = new SkipNode( SkipNode.negInf, null );
					var p2:SkipNode = new SkipNode( SkipNode.posInf, null );

					p1.right = p2;
					p1.down = _head;

					p2.left = p1;
					p2.down = _tail;

					_head.up = p1;
					_tail.up = p2;

					_head = p1;
					_tail = p2;
				}

				// Scan backwards...
				while( p.up == null )
				{
					p = p.left;
				}

				p = p.up;

				// Add one more (k,v) to the column
				var e:SkipNode = new SkipNode( k, null );  // Don't need the value...

				// Initialize links of e
				e.left = p;
				e.right = p.right;
				e.down = q;

				// Change the neighboring links..
				p.right.left = e;
				p.right = e;
				q.up = e;

				q = e;		// Set up q for the next iteration

				i++;		// increase level
			}

			_size = _size + 1;
		}

		/**
		 * Removes the key-value pair with a specified key.
		 */
		public function remove( key:String ):void
		{
			throw new MissingImplementationError();
		}

		/**
		 * Returns the number of entries in the list.
		 */
		public function size():int
		{
			return _size;
		}

		/**
		 * Returns whether or not the list is empty.
		 */
		public function isEmpty():Boolean
		{
			return ( _size == 0 );
		}

		public function get head():SkipNode
		{
			return _head;
		}

		public function get tail():SkipNode
		{
			return _tail;
		}

		public function toString():String
		{
			return "[SkipList size:" + size + "]";
		}
	}
}
