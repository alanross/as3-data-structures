package com.ar.ds.tree.interval
{
	/**
	 * Based on http://algs4.cs.princeton.edu/93intersection/IntervalST.java.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class IntervalNode
	{
		public var interval:Interval;
		public var data:Object;
		public var left:IntervalNode;
		public var right:IntervalNode;
		public var size:int;			// size of subtree rooted at this node
		public var max:int;				// max endpoint in subtree rooted at this node

		/**
		 * Creates a new instance of IntervalNode.
		 */
		public function IntervalNode( interval:Interval, data:Object )
		{
			this.interval = interval;
			this.data = data;
			this.size = 1;
			this.max = interval.max;
		}

		/**
		 * Creates and returns a string representation of the IntervalNode object.
		 */
		public function toString():String
		{
			return "[IntervalNode]";
		}
	}
}