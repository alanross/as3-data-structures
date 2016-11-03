package com.ar.ds.tree.interval
{
	/**
	 * Based on http://algs4.cs.princeton.edu/93intersection/IntervalST.java.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Interval
	{
		public var min:int;
		public var max:int;

		/**
		 * Creates a new instance of IntervalData.
		 */
		public function Interval( min:int, max:int )
		{
			if( min <= max )
			{
				this.min = min;
				this.max = max;
			}
			else
			{
				throw new Error( "Illegal interval" );
			}
		}

		/**
		 *
		 */
		public function intersects( other:Interval ):Boolean
		{
			if( other.max < min )
			{
				return false;
			}

			return ( max >= other.min );
		}

		/**
		 *
		 */
		public function inRange( rangeValue:int ):Boolean
		{
			return (min <= rangeValue) && (rangeValue <= max);
		}

		/**
		 *
		 */
		public function compareTo( other:Interval ):int
		{
			if( min < other.min )
			{
				return -1;
			}
			else if( min > other.min )
			{
				return 1;
			}
			else if( max < other.max )
			{
				return -1;
			}
			else if( max < other.max )
			{
				return 1;
			}

			return 0;
		}

		/**
		 * Creates and returns a string representation of the Interval object.
		 */
		public function toString():String
		{
			return "[Interval min:" + min + ", max:" + max + "]";
		}
	}
}