package com.ar.ds.tree.binary
{
	import com.ar.ds.compare.IComparator;
	import com.ar.math.Maths;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class AbstractBinaryTree
	{
		protected var root:BinaryNode;

		protected var comparator:IComparator;

		/**
		 * Creates a new instance of AbstractBinaryTree.
		 */
		public function AbstractBinaryTree( comparator:IComparator )
		{
			this.root = null;
			this.comparator = comparator;
		}

		/**
		 *
		 */
		protected function nodeAdd( node:BinaryNode, data:* ):void
		{
			if( comparator.compare( data, node.data ) < 0 ) //  data < node.data
			{
				if( node.left != null )
				{
					nodeAdd( node.left, data );
				}
				else
				{
					node.left = new BinaryNode( data );
				}
			}
			else if( comparator.compare( data, node.data ) > 0 ) //data > node.data
			{
				if( node.right != null )
				{
					nodeAdd( node.right, data );
				}
				else
				{
					node.right = new BinaryNode( data );
				}
			}

			//ignore values that already are present in tree
		}

		/**
		 *
		 */
		protected function nodeRemove( node:BinaryNode, data:* ):BinaryNode
		{
			if( node == null )
			{
				// Item not found; do nothing
				return node;
			}

			if( comparator.compare( data, node.data ) < 0 ) // data < node.data
			{
				node.left = nodeRemove( node.left, data );
			}
			else if( comparator.compare( data, node.data ) > 0 ) //data > node.data
			{
				node.right = nodeRemove( node.right, data );
			}
			else if( node.left != null && node.right != null ) // two children
			{
				node.data = nodeFindMin( node.right ).data;
				node.right = nodeRemove( node.right, node.data );
			}
			else
			{
				node = ( node.left != null ) ? node.left : node.right;
			}

			return node;
		}

		/**
		 *
		 */
		protected function nodeFindMin( node:BinaryNode ):BinaryNode
		{
			if( node != null )
			{
				while( node.left != null )
				{
					node = node.left;
				}
			}

			return node;
		}

		/**
		 *
		 */
		protected function nodeFindMax( node:BinaryNode ):BinaryNode
		{
			if( node != null )
			{
				while( node.right != null )
				{
					node = node.right;
				}
			}

			return node;
		}

		/**
		 *
		 */
		protected function nodeMirror( node:BinaryNode ):void
		{
			if( node != null )
			{
				// do the sub-trees
				nodeMirror( node.left );
				nodeMirror( node.right );

				// swap the left/right pointers
				var temp:BinaryNode = node.left;
				node.left = node.right;
				node.right = temp;
			}
		}

		/**
		 *
		 */
		protected function nodeGetSize( node:BinaryNode ):int
		{
			if( node == null )
			{
				return 0;
			}
			else
			{
				return ( nodeGetSize( node.left ) + 1 + nodeGetSize( node.right ) );
			}
		}

		/**
		 *
		 */
		protected function nodeGetMaxDepth( node:BinaryNode ):int
		{
			if( node == null )
			{
				return 0;
			}
			else
			{
				var lDepth:int = nodeGetMaxDepth( node.left );
				var rDepth:int = nodeGetMaxDepth( node.right );

				// use the larger + 1
				return ( Maths.max( lDepth, rDepth ) + 1 );
			}
		}

		/**
		 *
		 */
		protected function nodeGetNodeDepth( node:BinaryNode, data:*, level:int ):int
		{
			if( node == null )
			{
				return 0;
			}

			if( comparator.compare( node.data, data ) == 0 ) //node.data == data
			{
				return level;
			}

			return  nodeGetNodeDepth( node.left, data, level + 1 ) ||
					nodeGetNodeDepth( node.right, data, level + 1 );
		}

		/**
		 *
		 */
		protected function nodeGetLowestCommonAncestor( root:BinaryNode, a:BinaryNode, b:BinaryNode ):BinaryNode
		{
			// Check if one and two are in the root tree.
			while( root != null )
			{
				//if( root.data < a.data && root.data < b.data )
				if( comparator.compare( root.data, a.data ) < 0 && comparator.compare( root.data, b.data ) < 0 )
				{
					root = root.right;
				}
				//else if( root.data > a.data && root.data > b.data )
				else if( comparator.compare( root.data, a.data ) > 0 && comparator.compare( root.data, b.data ) > 0 )
				{
					root = root.left;
				}
				else
				{
					return root;
				}
			}

			return null;
		}

		/**
		 *
		 */
		public function get rootNode():BinaryNode
		{
			return root;
		}

		/**
		 * Creates and returns a string representation of the AbstractBinaryTree object.
		 */
		public function toString():String
		{
			return "[AbstractBinaryTree]";
		}
	}
}