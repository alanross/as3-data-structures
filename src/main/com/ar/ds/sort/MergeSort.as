package com.ar.ds.sort
{
	import com.ar.ds.compare.IComparator;

	/**
	 * MergeSort is an ( best, average, worst Θ(n log(n) ) ) comparison-based sorting algorithm.
	 * Most implementations produce a stable sort, meaning that the implementation preserves
	 * the input order of equal elements in the sorted output. It is a divide and conquer algorithm.
	 *
	 * 1. If the list is of length 0 or 1, then it is already sorted. Otherwise:
	 * 2. Divide the unsorted list into two sublists of about half the size.
	 * 3. Sort each sublist recursively by re-applying the merge sort.
	 * 4. Merge the two sublists back into one sorted list.
	 *
	 * Pro:
	 *  - When the data set is huge and is stored on external devices such as a hard drive, merge sort is faster
	 *  - Minimizes expensive reads of the external drive
	 *  - Lends itself well to parallel computing
	 *  - Often best choice for sorting linked list (which then requires only Θ(1) extra space)
	 *  - Makes fewer comparisons than QuickSort
	 *  - when it's extremely important that your algorithm run faster than O(n^2)
	 *  - when you need either a stable sort (elements that compare equal are not rearranged)
	 *  - using sequential (rather than random-access) "memory"
	 *      ( data as it is received from a network connection, or sorting data structures
	 *      which don't allow efficient random access like linked lists )
	 *
	 * Cons:
	 *  - Used memory depends on the structure you're sorting.
	 *
	 * http://en.wikipedia.org/wiki/Merge_sort
	 * http://www.cs.princeton.edu/courses/archive/spr07/cos226/lectures/04MergeQuick.pdf
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class MergeSort implements ISort
	{
		private var _comparator:IComparator;

		/**
		 * Creates a new instance of MergeSort.
		 */
		public function MergeSort()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function sort( array:Array, comparator:IComparator ):void
		{
			_comparator = comparator;

			process( array, new Array( array.length ), 0, array.length - 1 );
		}

		/**
		 * Internal method that makes recursive calls.
		 *
		 * @param array an array of Comparable items.
		 * @param tmpArray an array to place the merged result.
		 * @param left the left-most index of the subarray.
		 * @param right the right-most index of the subarray.
		 */
		private function process( array:Array, tmpArray:Array, left:int, right:int ):void
		{
			if( left < right )
			{
				var center:int = (left + right) / 2;

				process( array, tmpArray, left, center );
				process( array, tmpArray, center + 1, right );

				var leftPos:int = left;
				var rightPos:int = center + 1;
				var rightEnd:int = right;

				var leftEnd:int = rightPos - 1;
				var tmpPos:int = leftPos;
				var numElements:int = rightEnd - leftPos + 1;

				// Main merge loop
				while( leftPos <= leftEnd && rightPos <= rightEnd )
				{
					//( a[leftPos] <= a[rightPos] )
					if( _comparator.compare( array[leftPos], array[rightPos] ) <= 0 )
					{
						tmpArray[tmpPos++] = array[leftPos++];
					}
					else
					{
						tmpArray[tmpPos++] = array[rightPos++];
					}
				}

				// Copy rest of first half
				while( leftPos <= leftEnd )
				{
					tmpArray[tmpPos++] = array[leftPos++];
				}

				// Copy rest of right half
				while( rightPos <= rightEnd )
				{
					tmpArray[tmpPos++] = array[rightPos++];
				}

				// Copy tmpArray back
				for( var i:int = 0; i < numElements; i++, rightEnd-- )
				{
					array[rightEnd] = tmpArray[rightEnd];
				}
			}
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			_comparator = null;
		}

		/**
		 * Creates and returns a string representation of the MergeSort object.
		 */
		public function toString():String
		{
			return "[MergeSort]";
		}
	}
}

