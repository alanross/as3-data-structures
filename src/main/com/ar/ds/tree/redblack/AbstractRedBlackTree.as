package com.ar.ds.tree.redblack
{
	import com.ar.core.error.ElementDoesNotExistError;
	import com.ar.core.utils.assert;
	import com.ar.ds.compare.IComparator;

	/**
	 * Based on
	 * http://algs4.cs.princeton.edu/33balanced/RedBlackBST.java
	 * https://github.com/fbuihuu/libtree/blob/master/rb.c
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class AbstractRedBlackTree
	{
		protected static const RED:Boolean = true;
		protected static const BLACK:Boolean = false;

		protected var root:RedBlackNode;
		protected var comparator:IComparator;

		/**
		 * Creates a new instance of AbstractRedBlackTree.
		 */
		public function AbstractRedBlackTree( comparator:IComparator )
		{
			this.root = null;
			this.comparator = comparator;
		}

		/**
		 *
		 */
		protected function nodeAdd( node:RedBlackNode, data:* ):RedBlackNode
		{
			if( node == null )
			{
				return new RedBlackNode( data, RED, 1 );
			}

			var cmp:int = comparator.compare( data, node.data );

			if( cmp < 0 )
			{
				node.left = nodeAdd( node.left, data );
			}
			else if( cmp > 0 )
			{
				node.right = nodeAdd( node.right, data );
			}
			else
			{
				node.data = data;
			}

			if( nodeIsRed( node.right ) && !nodeIsRed( node.left ) )
			{
				node = nodeRotateLeft( node );
			}
			if( nodeIsRed( node.left ) && nodeIsRed( node.left.left ) )
			{
				node = nodeRotateRight( node );
			}
			if( nodeIsRed( node.left ) && nodeIsRed( node.right ) )
			{
				nodeFlipColors( node );
			}

			node.numNodes = nodeGetSize( node.left ) + nodeGetSize( node.right ) + 1;

			return node;
		}

		/**
		 *
		 */
		protected function nodeRemove( node:RedBlackNode, data:* ):RedBlackNode
		{
			if( !nodeContains( node, data ) )
			{
				throw new ElementDoesNotExistError();
			}

			if( comparator.compare( data, node.data ) < 0 )
			{
				if( !nodeIsRed( node.left ) && !nodeIsRed( node.left.left ) )
				{
					node = nodeMoveRedLeft( node );
				}

				node.left = nodeRemove( node.left, data );
			}
			else
			{
				if( nodeIsRed( node.left ) )
				{
					node = nodeRotateRight( node );
				}
				if( comparator.compare( data, node.data ) == 0 && (node.right == null) )
				{
					return null;
				}
				if( !nodeIsRed( node.right ) && !nodeIsRed( node.right.left ) )
				{
					node = nodeMoveRedRight( node );
				}

				if( comparator.compare( data, node.data ) == 0 )
				{
					var result:RedBlackNode = nodeFindMin( node.right );
					node.data = result.data;
					node.right = nodeRemoveMin( node.right );
				}
				else
				{
					node.right = nodeRemove( node.right, data );
				}
			}

			return nodeBalance( node );
		}

		/**
		 *
		 */
		protected function nodeContains( node:RedBlackNode, data:* ):Boolean
		{
			while( node != null )
			{
				var cmp:int = comparator.compare( data, node.data );

				if( cmp < 0 )
				{
					node = node.left;
				}
				else if( cmp > 0 )
				{
					node = node.right;
				}
				else
				{
					return true;
				}
			}

			return false;
		}

		/**
		 *
		 */
		protected function nodeFindMin( node:RedBlackNode ):RedBlackNode
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
		protected function nodeFindMax( node:RedBlackNode ):RedBlackNode
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
		protected function nodeGetSize( node:RedBlackNode ):int
		{
			if( node == null )
			{
				return 0;
			}

			return node.numNodes;
		}

		/**
		 *
		 */
		protected function nodeGetHeight( x:RedBlackNode ):int
		{
			if( x == null )
			{
				return 0;
			}

			return 1 + Math.max( nodeGetHeight( x.left ), nodeGetHeight( x.right ) );
		}

		/**
		 *
		 */
		protected function nodeRank( node:RedBlackNode, data:* ):int
		{
			if( node == null )
			{
				return 0;
			}

			var cmp:int = comparator.compare( data, node.data );

			if( cmp < 0 )
			{
				return nodeRank( node.left, data );
			}
			else if( cmp > 0 )
			{
				return 1 + nodeGetSize( node.left ) + nodeRank( node.right, data );
			}
			else
			{
				return nodeGetSize( node.left );
			}
		}

		/**
		 *
		 */
		protected function nodeRemoveMin( node:RedBlackNode ):RedBlackNode
		{
			if( node.left == null )
			{
				return null;
			}

			if( !nodeIsRed( node.left ) && !nodeIsRed( node.left.left ) )
			{
				node = nodeMoveRedLeft( node );
			}

			node.left = nodeRemoveMin( node.left );
			return nodeBalance( node );
		}

		/**
		 *
		 */
		protected function nodeRemoveMax( node:RedBlackNode ):RedBlackNode
		{
			if( nodeIsRed( node.left ) )
			{
				node = nodeRotateRight( node );
			}

			if( node.right == null )
			{
				return null;
			}

			if( !nodeIsRed( node.right ) && !nodeIsRed( node.right.left ) )
			{
				node = nodeMoveRedRight( node );
			}

			node.right = nodeRemoveMax( node.right );

			return nodeBalance( node );
		}

		/**
		 * make a left-leaning link lean to the right
		 */
		protected function nodeRotateRight( node:RedBlackNode ):RedBlackNode
		{
			if( (node == null) || nodeIsRed( node.left ) )
			{
				throw new Error();
			}

			var leftNode:RedBlackNode = node.left;

			node.left = leftNode.right;
			leftNode.right = node;
			leftNode.color = leftNode.right.color;
			leftNode.right.color = RED;
			leftNode.numNodes = node.numNodes;
			node.numNodes = nodeGetSize( node.left ) + nodeGetSize( node.right ) + 1;

			return leftNode;
		}

		/**
		 * make a right-leaning link lean to the left
		 */
		protected function nodeRotateLeft( node:RedBlackNode ):RedBlackNode
		{
			if( (node == null) || nodeIsRed( node.right ) )
			{
				throw new Error();
			}

			var rightNode:RedBlackNode = node.right;

			node.right = rightNode.left;

			rightNode.left = node;
			rightNode.color = rightNode.left.color;
			rightNode.left.color = RED;
			rightNode.numNodes = node.numNodes;

			node.numNodes = nodeGetSize( node.left ) + nodeGetSize( node.right ) + 1;

			return rightNode;
		}

		/**
		 *
		 */
		protected function nodeIsRed( node:RedBlackNode ):Boolean
		{
			if( node == null )
			{
				return false;
			}

			return ( node.color == RED );
		}

		/**
		 *
		 */
		protected function nodeFlipColors( node:RedBlackNode ):void
		{
			// node must have opposite color of its two children
			assert( (node != null) && (node.left != null) && (node.right != null), "nodeFlipColors" );
			assert( (!nodeIsRed( node ) && nodeIsRed( node.left ) && nodeIsRed( node.right )) || (nodeIsRed( node ) && !nodeIsRed( node.left ) && !nodeIsRed( node.right )), "nodeFlipColors2" );

			node.color = !node.color;
			node.left.color = !node.left.color;
			node.right.color = !node.right.color;
		}

		/**
		 * Assuming that h is red and both h.left and h.left.left
		 * are black, make h.left or one of its children red.
		 *
		 */
		protected function nodeMoveRedLeft( node:RedBlackNode ):RedBlackNode
		{
			assert( (node != null), "nodeMoveRedLeft" );
			assert( nodeIsRed( node ) && !nodeIsRed( node.left ) && !nodeIsRed( node.left.left ), "nodeMoveRedLeft2" );

			nodeFlipColors( node );

			if( nodeIsRed( node.right.left ) )
			{
				node.right = nodeRotateRight( node.right );
				node = nodeRotateLeft( node );
			}

			return node;
		}

		/**
		 * Assuming that h is red and both h.right and h.right.left
		 * are black, make h.right or one of its children red.
		 */
		protected function nodeMoveRedRight( node:RedBlackNode ):RedBlackNode
		{
			assert( (node != null), "nodeMoveRedRight" );
			assert( nodeIsRed( node ) && !nodeIsRed( node.right ) && !nodeIsRed( node.right.left ), "nodeMoveRedRight2" );

			nodeFlipColors( node );

			if( nodeIsRed( node.left.left ) )
			{
				node = nodeRotateRight( node );
			}
			return node;
		}

		/**
		 * restore red-black tree invariant
		 */
		protected function nodeBalance( node:RedBlackNode ):RedBlackNode
		{
			assert( (node != null), "nodeBalance" );

			if( nodeIsRed( node.right ) )
			{
				node = nodeRotateLeft( node );
			}
			if( nodeIsRed( node.left ) && nodeIsRed( node.left.left ) )
			{
				node = nodeRotateRight( node );
			}
			if( nodeIsRed( node.left ) && nodeIsRed( node.right ) )
			{
				nodeFlipColors( node );
			}

			node.numNodes = nodeGetSize( node.left ) + nodeGetSize( node.right ) + 1;

			return node;
		}

		/**
		 * the key of rank k in the subtree rooted at x
		 */
		protected function nodeSelect( node:RedBlackNode, k:int ):RedBlackNode
		{
			assert( node != null, "nodeSelect" );
			assert( k >= 0 && k < nodeGetSize( node ), "nodeSelect2" );
			var t:int = nodeGetSize( node.left );
			if( t > k )
			{
				return nodeSelect( node.left, k );
			}
			else if( t < k )
			{
				return nodeSelect( node.right, k - t - 1 );
			}
			else
			{
				return node;
			}
		}

		/**
		 * Is the tree rooted at x a BST with all keys strictly between min and max
		 * (if min or max is null, treat as empty constraint)
		 * Credit: Bob Dondero's elegant solution
		 */
		protected function nodeIsBST( node:RedBlackNode, min:*, max:* ):Boolean
		{
			if( node == null )
			{
				return true;
			}
			if( min != null && comparator.compare( node.data, min ) <= 0 )
			{
				return false;
			}
			if( max != null && comparator.compare( node.data, max ) >= 0 )
			{
				return false;
			}

			return nodeIsBST( node.left, min, node.data ) && nodeIsBST( node.right, node.data, max );
		}

		/**
		 *
		 */
		protected function nodeIsSizeConsistent( node:RedBlackNode ):Boolean
		{
			if( node == null )
			{
				return true;
			}

			if( node.numNodes != nodeGetSize( node.left ) + nodeGetSize( node.right ) + 1 )
			{
				return false;
			}

			return nodeIsSizeConsistent( node.left ) && nodeIsSizeConsistent( node.right );
		}

		/**
		 * does every path from the root to a leaf have the given number of black links?
		 */
		protected function nodeIsBalanced( node:RedBlackNode, black:int ):Boolean
		{
			if( node == null )
			{
				return black == 0;
			}
			if( !nodeIsRed( node ) )
			{
				black--;
			}

			return nodeIsBalanced( node.left, black ) && nodeIsBalanced( node.right, black );
		}

		/**
		 *
		 */
		protected function nodeIs23( node:RedBlackNode ):Boolean
		{
			if( node == null )
			{
				return true;
			}
			if( nodeIsRed( node.right ) )
			{
				return false;
			}
			if( node != root && nodeIsRed( node ) && nodeIsRed( node.left ) )
			{
				return false;
			}

			return nodeIs23( node.left ) && nodeIs23( node.right );
		}

		/**
		 * add the keys between lo and hi in the subtree rooted at x to the queue
		 */
		protected function nodeGetKeys( node:RedBlackNode, queue:Array, lo:*, hi:* ):void
		{
			if( node == null )
			{
				return;
			}

			var cmpLo:int = comparator.compare( lo, node.data );
			var cmpHi:int = comparator.compare( hi, node.data );

			if( cmpLo < 0 )
			{
				nodeGetKeys( node.left, queue, lo, hi );
			}
			if( cmpLo <= 0 && cmpHi >= 0 )
			{
				queue.push( node.data );
			}
			if( cmpHi > 0 )
			{
				nodeGetKeys( node.right, queue, lo, hi );
			}
		}

		/**
		 * Creates and returns a string representation of the AbstractRedBlackTree object.
		 */
		public function toString():String
		{
			return "[AbstractRedBlackTree]";
		}
	}
}
