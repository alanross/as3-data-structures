package com.ar.ds.tree.quad
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class QuadNode
	{
		// x- and y- coordinates
		public var x:Number;
		public var y:Number;

		// four sub trees
		public var NW:QuadNode = null;
		public var NE:QuadNode = null;
		public var SE:QuadNode = null;
		public var SW:QuadNode = null;

		// associated data
		public var data:Object = null;

		/**
		 * Creates a new instance of QuadNode.
		 */
		public function QuadNode( x:Number, y:Number, data:Object )
		{
			this.x = x;
			this.y = y;
			this.data = data;
		}

		/**
		 * Creates and returns a string representation of the QuadNode object.
		 */
		public function toString():String
		{
			return "[QuadNode: x:" + x + ", y:" + y + "]";
		}
	}
}