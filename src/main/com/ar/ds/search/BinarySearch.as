package com.ar.ds.search
{
	import com.ar.ds.compare.IComparator;

	/**
	 * Worst case performance    O(log n)
	 * Best case performance    O(1)
	 * Average case performance    O(log n)
	 * Worst case space complexity
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class BinarySearch implements ISearch
	{
		private var _comparator:IComparator;

		/**
		 * Creates a new instance of BinarySearch.
		 */
		public function BinarySearch()
		{
		}

		/**
		 * @inheritDoc
		 *
		 * Requires input array to be sorted!
		 */
		public function search( sortedArray:Array, key:*, comparator:IComparator ):int
		{
			_comparator = comparator;

			return process( sortedArray, key, 0, sortedArray.length - 1 );
		}

		/**
		 * @private
		 */
		private function process( array:Array, key:*, low:int, high:int ):int
		{
			if( high < low )
			{
				// not found
				return -1;
			}

			var mid:int = low + (high - low) / 2;

			var result:int = _comparator.compare( array[mid], key );

			if( result > 0 ) // array[mid] > key
			{
				return process( array, key, low, mid - 1 );
			}
			if( result < 0 ) // array[mid] < key
			{
				return process( array, key, mid + 1, high );
			}

			// found
			return mid;
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			_comparator = null;
		}

		/**
		 * Creates and returns a string representation of the BinarySearch object.
		 */
		public function toString():String
		{
			return "[BinarySearch]";
		}
	}
}