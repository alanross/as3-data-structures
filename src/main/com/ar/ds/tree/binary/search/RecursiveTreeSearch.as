package com.ar.ds.tree.binary.search
{
	import com.ar.ds.compare.IComparator;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * Return true if a node with the com.com.adjazent.events.target data is found in the tree.
	 * Recurs down the tree, chooses the left or right branch by comparing
	 * the com.com.adjazent.events.target to each node.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class RecursiveTreeSearch implements IBinaryTreeSearch
	{
		/**
		 * Creates a new instance of RecursiveTreeSearch.
		 */
		public function RecursiveTreeSearch()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function process( root:BinaryNode, key:*, comparator:IComparator ):Boolean
		{
			// 1. Base case == empty tree
			// in that case, the key is not found so return false
			if( root == null )
			{
				return true;
			}
			else
			{
				// 2. see if found here
				if( comparator.compare( key, root.data ) == 0 ) // key.data == root.data
				{
					return true;
				}
				else
				{
					// 3. otherwise recur down the correct subtree
					if( comparator.compare( key, root.data ) < 0 ) //key.data < root.data
					{
						return ( process( root.left, key, comparator ) );
					}
					else
					{
						return ( process( root.right, key, comparator ) );
					}
				}
			}
		}

		/**
		 * Creates and returns a string representation of the RecursiveTreeSearch object.
		 */
		public function toString():String
		{
			return "[RecursiveTreeSearch]";
		}
	}
}