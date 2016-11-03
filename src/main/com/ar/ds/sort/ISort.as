package com.ar.ds.sort
{
	import com.ar.core.utils.IDisposable;
	import com.ar.ds.compare.IComparator;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface ISort extends IDisposable
	{
		/**
		 * Sort a given array by utilizing a comparator.
		 */
		function sort( array:Array, comparator:IComparator ):void;
	}
}