package com.ar.ds.tree.redblack
{
	import com.ar.core.error.ElementDoesNotExistError;
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;
	import com.ar.ds.compare.IComparator;

	/**
	 * Based on
	 * http://algs4.cs.princeton.edu/33balanced/RedBlackBST.java
	 * https://github.com/fbuihuu/libtree/blob/master/rb.c
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class RedBlackTree extends AbstractRedBlackTree
	{
		public function RedBlackTree( comparator:IComparator )
		{
			super( comparator );
		}

		/**
		 * Add data to the tree structure.
		 */
		public function add( data:Object ):void
		{
			root = nodeAdd( root, data );
			root.color = BLACK;

//			assert( check(), "failed" );
		}

		/**
		 * Add a given data from the tree structure.
		 */
		public function remove( data:* ):void
		{
			if( !contains( data ) )
			{
				throw new ElementDoesNotExistError();
			}

			// if both children of root are black, set root to red
			if( !nodeIsRed( root.left ) && !nodeIsRed( root.right ) )
			{
				root.color = RED;
			}

			root = nodeRemove( root, data );

			if( !isEmpty() )
			{
				root.color = BLACK;
			}

//			assert( check(), "failed" );
		}

		/**
		 * Search for a value in the tree structure. Return true if the value is found, false otherwise.
		 */
		public function contains( key:* ):Boolean
		{
			return nodeContains( root, key );
		}

		/**
		 * Return the smallest value stored in the tree
		 */
		public function getMin():*
		{
			var node:RedBlackNode = nodeFindMin( root );

			return ( node ) ? node.data : null;
		}

		/**
		 * Return the largest value stored in the tree
		 */
		public function getMax():*
		{
			var node:RedBlackNode = nodeFindMax( root );

			return ( node ) ? node.data : null;
		}

		public function getSize():int
		{
			return nodeGetSize( root );
		}

		public function isEmpty():Boolean
		{
			return root == null;
		}

		public function getHeight():int
		{
			return nodeGetHeight( root );
		}

		public function getRank( key:* ):int
		{
			return nodeRank( root, key );
		}

//
//		// remove the key-value pair with the minimum key
//		public function removeMin():void
//		{
//			if( isEmpty() )
//			{
//				throw new ElementDoesNotExistError( "BST underflow" );
//			}
//
//			// if both children of root are black, set root to red
//			if( !nodeIsRed( root.left ) && !nodeIsRed( root.right ) )
//			{
//				root.color = RED;
//			}
//
//			root = nodeRemoveMin( root );
//
//			if( !isEmpty() )
//			{
//				root.color = RedBlackNode.BLACK;
//			}
//
//			assert( check(), "failed" );
//		}
//
//		// remove the key-value pair with the maximum key
//		public function removeMax():void
//		{
//			if( isEmpty() )
//			{
//				throw new ElementDoesNotExistError( "BST underflow" );
//			}
//
//			// if both children of root are black, set root to red
//			if( !nodeIsRed( root.left ) && !nodeIsRed( root.right ) )
//			{
//				root.color = RED;
//			}
//
//			root = nodeRemoveMax( root );
//
//			if( !isEmpty() )
//			{
//				root.color = RedBlackNode.BLACK;
//			}
//
//			assert( check(), "failed" );
//		}
//
//		// the largest key less than or equal to the given key
//		public function floor( key:RedBlackKey ):RedBlackKey
//		{
//			var x:RedBlackNode = nodeFloor( root, key );
//
//			if( x == null )
//			{
//				return null;
//			}
//			else
//			{
//				return x.key;
//			}
//		}
//
//		// the smallest key greater than or equal to the given key
//		public function ceiling( key:RedBlackKey ):RedBlackKey
//		{
//			var x:RedBlackNode = nodeCeiling( root, key );
//
//			if( x == null )
//			{
//				return null;
//			}
//			else
//			{
//				return x.key;
//			}
//		}
//
//		// the key of rank k
//		public function select( k:int ):RedBlackKey
//		{
//			if( k < 0 || k >= getSize() )
//			{
//				return null;
//			}
//
//			var x:RedBlackNode = nodeSelect( root, k );
//
//			return x.key;
//		}
//
//
		/**
		 * all of the keys, as an Iterable
		 */
		public function getKeys():Array
		{
			return getKeysBetween( getMin(), getMax() );
		}

		/**
		 * the keys between lo and hi, as an Iterable
		 */
		public function getKeysBetween( lo:*, hi:* ):Array
		{
			var queue:Array = new Array();

			nodeGetKeys( root, queue, lo, hi );

			return queue;
		}

		/**
		 *
		 */
		private function check():Boolean
		{
			if( !isBST() )
			{
				Log.info( Context.DEFAULT, this, "Not in symmetric order" );
			}
			if( !isSizeConsistent() )
			{
				Log.info( Context.DEFAULT, this, "Subtree counts not consistent" );
			}
			if( !isRankConsistent() )
			{
				Log.info( Context.DEFAULT, this, "Ranks not consistent" );
			}
			if( !is23() )
			{
				Log.info( Context.DEFAULT, this, "Not a 2-3 tree" );
			}
			if( !isBalanced() )
			{
				Log.info( Context.DEFAULT, this, "Not balanced" );
			}

			return isBST() && isSizeConsistent() && isRankConsistent() && is23() && isBalanced();
		}

		/**
		 * does this binary tree satisfy symmetric order?
		 * Note: this test also ensures that data structure is a binary tree since order is strict
		 */
		private function isBST():Boolean
		{
			return nodeIsBST( root, null, null );
		}

		/**
		 * are the getSize fields correct?
		 */
		private function isSizeConsistent():Boolean
		{
			return nodeIsSizeConsistent( root );
		}

		/**
		 * check that ranks are consistent
		 */
		private function isRankConsistent():Boolean
		{
//			var n:int = getSize();
//
//			for( var i:int = 0; i < n; i++ )
//			{
//				if( i != rank( select( i ) ) )
//				{
//					return false;
//				}
//			}
//
//			var keys:Array = getKeys();
//
//			n = keys.length;
//
//			for( var e:int = 0; e < n; e++ )
//			{
//				var key:* = keys[e];
//
//				if( key.compareTo( select( getRank( key ) ) ) != 0 )
//				{
//					return false;
//				}
//			}

			return true;
		}

		/**
		 * Does the tree have no red right links, and at most one (left)
		 * red links in a row on any path?
		 */
		private function is23():Boolean
		{
			return nodeIs23( root );
		}

		/**
		 * do all paths from root to leaf have same number of black edges?
		 */
		private function isBalanced():Boolean
		{
			var black:int = 0;     // number of black links on path from root to min
			var node:RedBlackNode = root;

			while( node != null )
			{
				if( !nodeIsRed( node ) )
				{
					black++;
				}
				node = node.left;
			}
			return nodeIsBalanced( root, black );
		}

		/**
		 * Creates and returns a string representation of the RedBlackTree object.
		 */
		override public function toString():String
		{
			return "[RedBlackTree]";
		}
	}
}