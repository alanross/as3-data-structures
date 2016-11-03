package com.ar.ds.tree.binary
{
	import com.ar.ds.compare.IComparator;
	import com.ar.ds.tree.binary.search.IBinaryTreeSearch;
	import com.ar.ds.tree.binary.traversal.IBinaryTreeTraversal;

	/**
	 * A data structure which has the following properties:
	 * - The left subtree of a node contains only nodes with keys less than the node's key.
	 * - The right subtree of a node contains only nodes with keys greater than the node's key.
	 * - The left and right subtree must each also be a binary search tree.
	 * - There must be no duplicate nodes.
	 *
	 *           Average     Worst case
	 * Space     O(n)        O(n)
	 * Search    O(log n)    O(log n)
	 * Insert    O(log n)    O(log n)
	 * Delete    O(log n)    O(log n)
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class BinaryTree extends AbstractBinaryTree
	{
		/**
		 * Creates a new instance of BinaryTree.
		 */
		public function BinaryTree( comparator:IComparator )
		{
			super( comparator );
		}

		/**
		 * Add data to the tree structure.
		 */
		public function add( data:* ):void
		{
			if( root == null )
			{
				root = new BinaryNode( data );
			}
			else
			{
				nodeAdd( root, data );
			}
		}

		/**
		 * Add a given data from the tree structure.
		 */
		public function remove( data:* ):void
		{
			nodeRemove( root, data );
		}

		/**
		 * Traverse the tree structure.
		 */
		public function traverse( traverse:IBinaryTreeTraversal ):Array
		{
			return traverse.process( root );
		}

		/**
		 * Search for a value in the tree structure. Return true if the value is found, false otherwise.
		 */
		public function contains( search:IBinaryTreeSearch, key:* ):Boolean
		{
			return search.process( root, key, comparator );
		}

		/**
		 * Return the smallest value stored in the tree
		 */
		public function getMin():*
		{
			var node:BinaryNode = nodeFindMin( root );

			return ( node ) ? node.data : null;
		}

		/**
		 * Return the largest value stored in the tree
		 */
		public function getMax():*
		{
			var node:BinaryNode = nodeFindMax( root );

			return ( node ) ? node.data : null;
		}

		/**
		 * Mirror the tree.
		 */
		public function mirror():void
		{
			nodeMirror( root );
		}

		/**
		 * Return the depth level of the given node.
		 */
		public function getNodeDepth( value:* ):int
		{
			return nodeGetNodeDepth( root, value, 0 );
		}

		/**
		 * Return the number of elements held by the tree structure.
		 */
		public function getSize():int
		{
			return nodeGetSize( root );
		}

		/**
		 * Return the maximum amount of levels held by the tree.
		 */
		public function getMaxDepth():int
		{
			return nodeGetMaxDepth( root );
		}

		/**
		 * Return the lowest common ancestor of two given nodes.
		 */
		public function getLowestCommonAncestor( one:BinaryNode, two:BinaryNode ):*
		{
			var node:BinaryNode = nodeGetLowestCommonAncestor( root, one, two );

			return ( node ) ? node.data : null;
		}

		/**
		 * Creates and returns a string representation of the BinaryTree object.
		 */
		override public function toString():String
		{
			return "[BinaryTree]";
		}
	}
}