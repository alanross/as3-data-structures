package com.ar.ds.sort
{
	import com.ar.ds.compare.IComparator;
	import com.ar.math.Maths;

	/**
	 * QuickSort is a divide and conquer algorithm which relies on a partition operation
	 * ( average Θ(n log(n)), worst case Θ(n2) )
	 *
	 * 1. Pick an element, called a pivot, from the list.
	 * 2. Reorder the list so that all elements with values less than the pivot come before the pivot,
	 *      while all elements with values greater than the pivot come after it (equal values can go either way).
	 *      After this partitioning, the pivot is in its final position. This is called the partition operation.
	 * 3. Recursively sort the sub-list of lesser elements and the sub-list of greater elements.
	 *
	 * Pro:
	 *  - Low memory requirement
	 *  - Typically faster than merge sort when the data is stored in memory
	 *  - More efficient at handling slow-to-access sequential media.
	 *  - QuickSort is space constant
	 *
	 * Cons:
	 *  - Θ(n2) in worst case
	 *  - Consistently poor choices of pivots can result in drastically slower O(n²) performance,
	 *      but if at each step we choose the median as the pivot then it works in O(n log n).
	 *  - Makes more comparisons than MergeSort
	 *
	 * http://en.wikipedia.org/wiki/Quicksort
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class QuickSort implements ISort
	{
		private var _comparator:IComparator;

		/**
		 * Creates a new instance of QuickSort.
		 */
		public function QuickSort()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function sort( array:Array, comparator:IComparator ):void
		{
			_comparator = comparator;

			process( array, 0, array.length - 1 );
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			_comparator = null;
		}

		/**
		 * @private
		 */
		private function process( array:Array, left:int, right:int ):void
		{
			var i:int = left;
			var j:int = right;

			const pivot:* = array[ Maths.round( (left + right) / 2 ) ];

			while( i <= j )
			{
				//array[i] < pivot
				while( _comparator.compare( array[i], pivot ) < 0 )
				{
					i++;
				}

				//array[j] > pivot
				while( _comparator.compare( array[j], pivot ) > 0 )
				{
					j--;
				}

				if( i <= j )
				{
					swap( array, i, j );
					i++;
					j--;
				}
			}

			if( left < j )
			{
				process( array, left, j );
			}

			if( i < right )
			{
				process( array, i, right );
			}
		}

		/**
		 * @private
		 */
		private function swap( array:Array, i:int, j:int ):void
		{
			var tmp:* = array[i];
			array[i] = array[j];
			array[j] = tmp;
		}

		/**
		 * Creates and returns a string representation of the QuickSort object.
		 */
		public function toString():String
		{
			return "[QuickSort]";
		}

	}
}
