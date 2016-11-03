package com.ar.ds.scheduling
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class SchedulingInterval
	{
		private var _min:Number;
		private var _max:Number;
		private var _score:Number;

		/**
		 * Creates a new instance of SchedulingInterval.
		 */
		public function SchedulingInterval( min:Number, max:Number, score:Number )
		{
			_min = min;
			_max = max;
			_score = score;
		}

		/**
		 * The min max of the interval.
		 */
		public function get min():Number
		{
			return _min;
		}

		/**
		 * The max max of the interval.
		 */
		public function get max():Number
		{
			return _max;
		}

		public function get score():Number
		{
			return _score;
		}

		/**
		 * Creates and returns a string representation of the SchedulingInterval object.
		 */
		public function toString():String
		{
			return "[SchedulingInterval score:" + _score + ", min:" + _min + ", max:" + _max + " ]";
		}
	}
}