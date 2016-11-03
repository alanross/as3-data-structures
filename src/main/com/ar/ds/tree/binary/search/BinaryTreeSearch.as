package com.ar.ds.tree.binary.search
{
	import com.ar.ds.compare.IComparator;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * A simple binary search performed on the tree accessed by its root node.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class BinaryTreeSearch implements IBinaryTreeSearch
	{
		/**
		 * Creates a new instance of BinaryTreeSearch.
		 */
		public function BinaryTreeSearch()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function process( root:BinaryNode, key:*, comparator:IComparator ):Boolean
		{
			var current:BinaryNode = root;

			while( current != null )
			{
				if( comparator.compare( current.data, key ) > 0 ) // current.data > key.data
				{
					current = current.left;
				}
				else if( comparator.compare( current.data, key ) < 0 ) // current.data < key.data
				{
					current = current.right;
				}
				else
				{
					return true;
				}
			}

			return false;
		}

		/**
		 * Creates and returns a string representation of the BinaryTreeSearch object.
		 */
		public function toString():String
		{
			return "[BinaryTreeSearch]";
		}
	}
}