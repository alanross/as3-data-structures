package com.ar.ds.compare
{
	/**
	 * The StringComparator compares two strings to each other.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class StringComparator implements IComparator
	{
		private var _caseInsensitive:Boolean;

		/**
		 * Creates a new instance of StringComparator.
		 */
		public function StringComparator( caseInsensitive:Boolean = false )
		{
			_caseInsensitive = caseInsensitive;
		}

		/**
		 * @private
		 */
		private function process( a:String, b:String ):int
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

			if( _caseInsensitive )
			{
				a = a.toLocaleLowerCase();
				b = b.toLocaleLowerCase();
			}

			const result:int = a.localeCompare( b );

			if( result < 0 )
			{
				return -1;
			}
			if( result > 0 )
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
		 * enable the comparison to be case insensitive.
		 */
		public function get caseInsensitive():Boolean
		{
			return _caseInsensitive;
		}

		/**
		 * enable the comparison to be case insensitive.
		 */
		public function set caseInsensitive( value:Boolean ):void
		{
			_caseInsensitive = value;
		}

		/**
		 * Creates and returns a string representation of the StringComparator object.
		 */
		public function toString():String
		{
			return "[StringComparator]";
		}
	}
}