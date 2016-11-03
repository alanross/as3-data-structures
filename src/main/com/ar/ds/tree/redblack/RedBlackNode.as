package com.ar.ds.tree.redblack
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class RedBlackNode
	{
		public var left:RedBlackNode;
		public var right:RedBlackNode;
		public var color:Boolean; //red is true, black is false
		public var numNodes:int;

		public var data:*;

		public function RedBlackNode( data:*, isRed:Boolean, numNodes:int )
		{
			this.data = data;
			this.color = isRed;
			this.numNodes = numNodes;
		}

		public function toString():String
		{
			return "[RedBlackNode]";
		}
	}
}