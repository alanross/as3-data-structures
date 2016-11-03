package com.ar.ds.scheduling
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class WeightedScheduling
	{
		/**
		 * Creates a new instance of WeightedScheduling.
		 */
		public function WeightedScheduling()
		{
		}

		/**
		 * Returns the optimal schedules.
		 */
		public function getSchedule( intervals:Vector.<SchedulingInterval> ):Vector.<SchedulingInterval>
		{
			var optimalIntervals:Vector.<SchedulingInterval> = new Vector.<SchedulingInterval>();

			process( intervals, optimalIntervals );

			return optimalIntervals;
		}

		/**
		 * Returns the accumulated score of the optimal schedules.
		 */
		public function getScore( intervals:Vector.<SchedulingInterval> ):int
		{
			var optimalIntervals:Vector.<SchedulingInterval> = new Vector.<SchedulingInterval>();

			var optimalScore:int = process( intervals, optimalIntervals );

			return optimalScore;
		}

		/**
		 *
		 */
		public function process( inputIntervals:Vector.<SchedulingInterval>, optimalIntervals:Vector.<SchedulingInterval> ):int
		{
			// 1. Sort intervals in ascending order of starting time.
			// 2. For 1 ≤ i ≤ n, find the smallest j > i such that interval j doesn't overlap with interval i.
			// 3. For i = n down to 1, compute value(i) using Equation (3.1.1) and store it in memory.
			// 4. The weight of the optimum schedule is value(1).
			// runs O(n log n).

			optimalIntervals.splice( 0, optimalIntervals.length );

			inputIntervals.sort( sortEndAscending );

			var interval:SchedulingInterval;
			var n:int = inputIntervals.length;

			// remember results
			var memIntervals:Array = new Array(); 	// boolean
			var memScore:Array = new Array( n ); 	// int

			memScore[ 0 ] = 0;

			// find intervals that have highest score and fit
			for( var i:int = 1; i < n; ++i )
			{
				interval = inputIntervals[i ];

				var score:int = interval.score;
				var npi:int = getIndexOfNextPossibleInterval( inputIntervals, i );

				memScore[ i ] = getMax( score + memScore[ npi ], memScore[ i - 1 ] );

				//true if interval is to be kept for optimal score
				memIntervals[ i ] = ( score + memScore[ npi ] > memScore[ i - 1 ] );
			}

			//Add scores to accumulated score
			var optimalScore:int = 0;

			for( var e:int = 0; e < n; ++e )
			{
				if( memIntervals[ e ] )
				{
					interval = inputIntervals[ e ];
					optimalScore += interval.score;
					optimalIntervals.push( interval );
				}

			}

			return optimalScore;
		}

		/**
		 * Returns largest possible index of interval that would
		 * fit in front of given interval index without conflict.
		 */
		private function getIndexOfNextPossibleInterval( intervals:Vector.<SchedulingInterval>, intervalIndex:int ):int
		{
			var diff:int = int.MAX_VALUE;
			var result:int = 0;
			var n:int = intervals.length;

			var a:SchedulingInterval = intervals[ intervalIndex ];

			for( var index:int = 0; index < n; ++index )
			{
				var b:SchedulingInterval = intervals[ index ];

				if( b.max < a.min )
				{
					if( diff > ( a.min - b.max ) )
					{
						diff = a.min - b.max;
						result = index;
					}
				}
			}

			return result;
		}

		/**
		 * Return the larger of both values.
		 */
		private function getMax( a:int, b:int ):int
		{
			return ( a > b ) ? a : b;
		}

		/**
		 * Compare two intervals.
		 */
		public function sortEndAscending( a:SchedulingInterval, b:SchedulingInterval ):Number
		{
			return ( a.max < b.max ) ? -1 : ( a.max > b.max ) ? 1 : 0;
		}

		/**
		 * Creates and returns a string representation of the WeightedScheduling object.
		 */
		public function toString():String
		{
			return "[WeightedScheduling]";
		}
	}

}