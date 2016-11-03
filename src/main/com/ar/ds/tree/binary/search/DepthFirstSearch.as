package com.ar.ds.tree.binary.search
{
	import com.ar.ds.compare.IComparator;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * The depth first search is well geared towards problems where we want to find
	 * any solution to the problem (not necessarily the shortest path),
	 * or to visit all of the nodes in the graph
	 *
	 * http://www.topcoder.com/tc?module=Static&d1=tutorials&d2=graphsDataStrucs2
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class DepthFirstSearch implements IBinaryTreeSearch
	{
		/**
		 * Creates a new instance of DepthFirstSearch.
		 */
		public function DepthFirstSearch()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function process( root:BinaryNode, key:*, comparator:IComparator ):Boolean
		{
			if( root == null )
			{
				return false;
			}

			if( comparator.compare( root.data, key ) == 0 ) // root.data == key.data
			{
				return true;
			}

			return process( root.left, key, comparator ) || process( root.right, key, comparator );
		}

		/**
		 * Creates and returns a string representation of the DepthFirstSearch object.
		 */
		public function toString():String
		{
			return "[DepthFirstSearch]";
		}
	}
}