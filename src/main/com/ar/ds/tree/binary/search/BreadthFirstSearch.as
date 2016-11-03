package com.ar.ds.tree.binary.search
{
	import com.ar.ds.compare.IComparator;
	import com.ar.ds.queue.IQueue;
	import com.ar.ds.queue.LinkedQueue;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * BreadthFirstSearch:
	 *
	 * Assume BinaryNode containing integers. LinkedList used as the queue for
	 * storing children on the same level.
	 *
	 * It differs from the depth-first search in that it uses a queue to perform the search,
	 * so the order in which the nodes are visited is quite different. It has the extremely
	 * useful property that if all of the edges in a graph are unweighted (or the same weight)
	 * then the first time a node is visited is the shortest path to that node from the source node
	 *
	 * http://www.topcoder.com/tc?module=Static&d1=tutorials&d2=graphsDataStrucs2
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class BreadthFirstSearch implements IBinaryTreeSearch
	{
		/**
		 * Creates a new instance of BreadthFirstSearch.
		 */
		public function BreadthFirstSearch()
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

			var tmp:BinaryNode;

			var queue:IQueue = new LinkedQueue();

			queue.enqueue( root );

			while( queue.getSize() > 0 )
			{
				tmp = BinaryNode( queue.dequeue() );

				if( comparator.compare( tmp.data, key ) == 0 ) //tmp.data == key.data
				{
					return true;
				}
				if( tmp.left != null )
				{
					queue.enqueue( tmp.left );
				}
				if( tmp.right != null )
				{
					queue.enqueue( tmp.right );
				}
			}

			return false;
		}

		/**
		 * Creates and returns a string representation of the BreadthFirstSearch object.
		 */
		public function toString():String
		{
			return "[BreadthFirstSearch]";
		}
	}
}