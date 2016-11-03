package com.ar.ds.compare
{
	/**
	 * The implementation of IComparator allows two different items to be compared to each other.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IComparator
	{
		/**
		 * Compares two given items and returns one of the following three values:
		 *
		 * a negative value, if a should appear before b in a sorted sequence.
		 * 0, if a equals b.
		 * a positive value, if a should appear after b in a sorted sequence.
		 */
		function compare( a:*, b:* ):int;
	}
}