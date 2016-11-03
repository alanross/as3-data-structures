package com.ar.ds.tree.interval
{
	/**
	 * Based on http://algs4.cs.princeton.edu/93intersection/IntervalST.java.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class AbstractIntervalTree
	{
		protected var root:IntervalNode;

		/**
		 * Creates a new instance of AbstractIntervalTree.
		 */
		public function AbstractIntervalTree()
		{
		}

		/**
		 *
		 */
		protected function nodeInsert( node:IntervalNode, interval:Interval, value:Object ):IntervalNode
		{
			if( node == null )
			{
				return new IntervalNode( interval, value );
			}

			var cmp:int = interval.compareTo( node.interval );

			if( cmp < 0 )
			{
				node.left = nodeInsert( node.left, interval, value );
				node = nodeRotateRight( node );
			}
			else
			{
				node.right = nodeInsert( node.right, interval, value );
				node = nodeRotateLeft( node );
			}

			return node;
		}

		/**
		 *
		 */
		protected function nodeRemove( node:IntervalNode, interval:Interval ):IntervalNode
		{
			if( node == null )
			{
				return null;
			}

			var cmp:int = interval.compareTo( node.interval );

			if( cmp < 0 )
			{
				node.left = nodeRemove( node.left, interval );
			}
			else if( cmp > 0 )
			{
				node.right = nodeRemove( node.right, interval );
			}
			else
			{
				node = nodeJoinLR( node.left, node.right );
			}

			nodeFix( node );

			return node;
		}

		/**
		 *
		 */
		protected function nodeGetAt( node:IntervalNode, interval:Interval ):Object
		{
			if( node == null )
			{
				return null;
			}

			var cmp:int = interval.compareTo( node.interval );

			if( cmp < 0 )
			{
				return nodeGetAt( node.left, interval );
			}
			else if( cmp > 0 )
			{
				return nodeGetAt( node.right, interval );
			}
			else
			{
				return node.data;
			}
		}

		/**
		 *
		 */
		protected function nodeSearch( node:IntervalNode, interval:Interval ):Interval
		{
			while( node != null )
			{
				if( interval.intersects( node.interval ) )
				{
					return node.interval;
				}
				else if( node.left == null )
				{
					node = node.right;
				}
				else if( node.left.max < interval.min )
				{
					node = node.right;
				}
				else
				{
					node = node.left;
				}
			}

			return null;
		}

		/**
		 *
		 */
		protected function nodeSearchInRange( node:IntervalNode, interval:Interval, list:Vector.<Interval> ):Boolean
		{
			var found1:Boolean = false;
			var found2:Boolean = false;
			var found3:Boolean = false;

			if( node == null )
			{
				return false;
			}
			if( interval.intersects( node.interval ) )
			{
				list.push( node.interval );

				found1 = true;
			}
			if( node.left != null && node.left.max >= interval.min )
			{
				found2 = nodeSearchInRange( node.left, interval, list );
			}
			if( found2 || node.left == null || node.left.max < interval.min )
			{
				found3 = nodeSearchInRange( node.right, interval, list );
			}

			return found1 || found2 || found3;
		}

		/**
		 *
		 */
		protected function nodeRandomizedInsert( node:IntervalNode, interval:Interval, value:Object ):IntervalNode
		{
			if( node == null )
			{
				return new IntervalNode( interval, value );
			}

			if( Math.random() * nodeSize( node ) < 1.0 )
			{
				return nodeInsert( node, interval, value );
			}

			var cmp:int = interval.compareTo( node.interval );

			if( cmp < 0 )
			{
				node.left = nodeRandomizedInsert( node.left, interval, value );
			}
			else
			{
				node.right = nodeRandomizedInsert( node.right, interval, value );
			}

			nodeFix( node );

			return node;
		}

		/**
		 *
		 */
		protected function nodeFix( node:IntervalNode ):void
		{
			if( node == null )
			{
				return;
			}

			node.size = 1 + nodeSize( node.left ) + nodeSize( node.right );

			node.max = max3( node.interval.max, nodeMax( node.left ), nodeMax( node.right ) );
		}

		/**
		 *
		 */
		protected function nodeRotateRight( node:IntervalNode ):IntervalNode
		{
			var x:IntervalNode = node.left;
			node.left = x.right;
			x.right = node;
			nodeFix( node );
			nodeFix( x );
			return x;
		}

		/**
		 *
		 */
		protected function nodeRotateLeft( node:IntervalNode ):IntervalNode
		{
			var x:IntervalNode = node.right;
			node.right = x.left;
			x.left = node;
			nodeFix( node );
			nodeFix( x );
			return x;
		}

		/**
		 *
		 */
		protected function nodeJoinLR( a:IntervalNode, b:IntervalNode ):IntervalNode
		{
			if( a == null )
			{
				return b;
			}

			if( b == null )
			{
				return a;
			}

			if( Math.random() * (nodeSize( a ) + nodeSize( b )) < nodeSize( a ) )
			{
				a.right = nodeJoinLR( a.right, b );

				nodeFix( a );

				return a;
			}
			else
			{
				b.left = nodeJoinLR( a, b.left );

				nodeFix( b );

				return b;
			}
		}

		/**
		 *
		 */
		protected function nodeSize( node:IntervalNode ):int
		{
			if( node == null )
			{
				return 0;
			}
			else
			{
				return node.size;
			}
		}

		/**
		 *
		 */
		protected function nodeHeight( node:IntervalNode ):int
		{
			if( node == null )
			{
				return 0;
			}

			return 1 + Math.max( nodeHeight( node.left ), nodeHeight( node.right ) );
		}

		/**
		 *
		 */
		protected function nodeCheckCount( node:IntervalNode ):Boolean
		{
			if( node == null )
			{
				return true;
			}

			return nodeCheckCount( node.left ) && nodeCheckCount( node.right ) && (node.size == 1 + nodeSize( node.left ) + nodeSize( node.right ));
		}

		/**
		 *
		 */
		protected function nodeCheckMax( node:IntervalNode ):Boolean
		{
			if( node == null )
			{
				return true;
			}

			return node.max == max3( node.interval.max, nodeMax( node.left ), nodeMax( node.right ) );
		}

		/**
		 *
		 */
		protected function nodeMax( node:IntervalNode ):int
		{
			return ( node == null ) ? int.MIN_VALUE : node.max;
		}

		/**
		 *
		 */
		protected function max3( a:int, b:int, c:int ):int
		{
			return Math.max( a, Math.max( b, c ) );
		}

		/**
		 * Creates and returns a string representation of the AbstractIntervalTree object.
		 */
		public function toString():String
		{
			return "[AbstractIntervalTree]";
		}
	}
}