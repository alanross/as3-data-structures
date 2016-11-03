package com.ar.ds.compare
{
	/**
	 * The DateComparator compares two different Date objects
	 * to each other.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class DateComparator implements IComparator
	{
		/**
		 * Creates a new instance of DateComparator.
		 */
		public function DateComparator()
		{
		}

		/**
		 * @private
		 */
		private function process( a:Date, b:Date ):int
		{
			if( a == null && b == null )
			{
				return 0;
			}

			if( a == null )
			{
				return 1;
			}

			if( b == null )
			{
				return -1;
			}

			var na:Number = a.getTime();
			var nb:Number = b.getTime();

			if( na < nb )
			{
				return -1;
			}

			if( na > nb )
			{
				return 1;
			}

			return 0;
		}

		/**
		 * @inheritDoc
		 */
		public function compare( a:*, b:* ):int
		{
			return process( a, b );
		}

		/**
		 * Creates and returns a string representation of the DateComparator object.
		 */
		public function toString():String
		{
			return "[DateComparator]";
		}
	}
}