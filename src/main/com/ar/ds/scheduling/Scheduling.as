package com.ar.ds.scheduling
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Scheduling
	{
		private var _optimalScore:int = 0;
		private var _optimalIntervals:Vector.<SchedulingInterval> = new Vector.<SchedulingInterval>();

		/**
		 * Creates a new instance of Scheduling.
		 */
		public function Scheduling()
		{
		}

		/**
		 * Returns the optimal schedules.
		 */
		public function getSchedule( intervals:Vector.<SchedulingInterval> ):Vector.<SchedulingInterval>
		{
			_optimalIntervals.splice( 0, _optimalIntervals.length );
			_optimalScore = 0;

			process( intervals.concat() );

			return _optimalIntervals;
		}

		/**
		 * Returns the accumulated score of the optimal schedules.
		 */
		public function getScore( intervals:Vector.<SchedulingInterval> ):int
		{
			_optimalIntervals.splice( 0, _optimalIntervals.length );
			_optimalScore = 0;

			process( intervals.concat() );

			return _optimalScore;
		}

		/**
		 * @private
		 */
		private function process( intervals:Vector.<SchedulingInterval> ):void
		{
			// 	 While ( I != ∅ ) do
			// 		 Accept the interval j from I with the earliest completion date.
			// 		 Delete j, and any interval which intersects j from I.

			if( intervals.length == 0 )
			{
				return;
			}

			var n:int = intervals.length;
			var minEnd:int = int.MAX_VALUE;
			var index:int = 0;
			var interval:SchedulingInterval;

			while( --n > -1 )
			{
				interval = intervals[ n ];

				if( minEnd > interval.max )
				{
					minEnd = interval.max;
					index = intervals.indexOf( interval );
				}
			}

			interval = intervals[ index ];

			_optimalIntervals.push( interval );

			_optimalScore += interval.score;

			n = intervals.length;

			while( --n > -1 )
			{
				interval = intervals[ n ];

				if( minEnd >= interval.min || minEnd >= interval.max )
				{
					intervals.splice( n, 1 );
				}
			}

			if( intervals.length > 0 )
			{
				process( intervals );
			}
		}

		/**
		 * Creates and returns a string representation of the Scheduling object.
		 */
		public function toString():String
		{
			return "[Scheduling]";
		}
	}
}
