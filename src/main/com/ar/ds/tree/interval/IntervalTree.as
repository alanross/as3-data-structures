package com.ar.ds.tree.interval
{
	import com.ar.core.error.ElementAlreadyExistsError;
	import com.ar.core.error.ElementDoesNotExistError;

	/**
	 * Based on http://algs4.cs.princeton.edu/93intersection/IntervalST.java.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class IntervalTree extends AbstractIntervalTree
	{
		/**
		 * Creates a new instance of IntervalTree.
		 */
		public function IntervalTree()
		{
		}

		/**
		 *
		 */
		public function add( interval:Interval, data:Object ):void
		{
			if( contains( interval ) )
			{
				throw new ElementAlreadyExistsError();
			}

			root = nodeRandomizedInsert( root, interval, data );
		}

		/**
		 *
		 */
		public function remove( interval:Interval ):void
		{
			if( !contains( interval ) )
			{
				throw new ElementDoesNotExistError();
			}

			root = nodeRemove( root, interval );
		}

		/**
		 *
		 */
		public function contains( interval:Interval ):Boolean
		{
			return ( getAt( interval ) != null );
		}

		/**
		 *
		 */
		public function getAt( interval:Interval ):Object
		{
			return nodeGetAt( root, interval );
		}

		/**
		 *
		 */
		public function search( interval:Interval ):Interval
		{
			return nodeSearch( root, interval );
		}

		/**
		 *
		 */
		public function searchInRange( interval:Interval ):Vector.<Interval>
		{
			var result:Vector.<Interval> = new Vector.<Interval>();

			nodeSearchInRange( root, interval, result );

			return result;
		}

		/**
		 *
		 */
		public function getSize():int
		{
			return nodeSize( root );
		}

		/**
		 *
		 */
		public function getHeight():int
		{
			return nodeHeight( root );
		}

		/**
		 *
		 */
		public function checkIntegrity():Boolean
		{
			return count() && max();
		}

		/**
		 *
		 */
		public function count():Boolean
		{
			return nodeCheckCount( root );
		}

		/**
		 *
		 */
		public function max():Boolean
		{
			return nodeCheckMax( root );
		}

		/**
		 * Creates and returns a string representation of the IntervalTree object.
		 */
		override public function toString():String
		{
			return "[IntervalTree]";
		}
	}
}