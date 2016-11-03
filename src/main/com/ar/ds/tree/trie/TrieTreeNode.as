package com.ar.ds.tree.trie
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TrieTreeNode
	{
		public static const EMPTY:String = "";

		public var glyph:String;

		public var level:int;

		public var wordEnd:Boolean = false;

		// points to the left most child of the node
		public var down:TrieTreeNode = null;

		// points to the right sibling of the node
		public var next:TrieTreeNode = null;

		/**
		 * Creates a new instance of TrieTreeNode.
		 */
		public function TrieTreeNode( glyph:String, level:int, next:TrieTreeNode = null )
		{
			this.glyph = glyph;
			this.level = level;
			this.next = next;
		}

		/**
		 * Creates and returns a string representation of the TrieTreeNode object.
		 */
		public function toString():String
		{
			return "[TrieTreeNode char:" + glyph + " level:" + level + "wordEnd:" + wordEnd + "]";
		}
	}
}