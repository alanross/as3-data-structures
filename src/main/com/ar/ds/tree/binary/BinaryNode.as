package com.ar.ds.tree.binary
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class BinaryNode
	{
		public var left:BinaryNode;
		public var right:BinaryNode;
		public var data:*;

		/**
		 * Creates a new instance of BinaryNode.
		 */
		public function BinaryNode( data:* )
		{
			this.left = null;
			this.right = null;
			this.data = data;
		}

		/**
		 * Creates and returns a string representation of the BinaryNode object.
		 */
		public function toString():String
		{
			return "[BinaryNode data:" + data + "]";
		}
	}
}