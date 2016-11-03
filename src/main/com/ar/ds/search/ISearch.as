package com.ar.ds.search
{
	import com.ar.core.utils.IDisposable;
	import com.ar.ds.compare.IComparator;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface ISearch extends IDisposable
	{
		/**
		 * Searches for an item in a sorted list.
		 */
		function search( sortedArray:Array, key:*, comparator:IComparator ):int
	}
}