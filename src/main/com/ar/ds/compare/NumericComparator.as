package com.ar.ds.compare
{
	/**
	 * The NumericComparator compares two different numeric values
	 * to each other.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class NumericComparator implements IComparator
	{
		/**
		 * Creates a new instance of NumericComparator.
		 */
		public function NumericComparator()
		{
		}

		/**
		 * @private
		 */
		private function process( a:Number, b:Number ):int
		{
			if( isNaN( a ) && isNaN( b ) )
			{
				return 0;
			}

			if( isNaN( a ) )
			{
				return 1;
			}

			if( isNaN( b ) )
			{
				return -1;
			}

			return ( ( a < b ) ? -1 : ( a > b ) ? 1 : 0 );
		}

		/**
		 * @inheritDoc
		 */
		public function compare( a:*, b:* ):int
		{
			return process( a, b );
		}

		/**
		 * Creates and returns a string representation of the NumericComparator object.
		 */
		public function toString():String
		{
			return "[NumericComparator]";
		}
	}
}