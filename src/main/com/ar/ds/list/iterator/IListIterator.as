package com.ar.ds.list.iterator
{
	import com.ar.core.utils.IDisposable;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IListIterator extends IDisposable
	{
		/**
		 * Returns the next element in the iteration.
		 */
		function getNext():Object;

		/**
		 * Returns true if the iteration has more elements.
		 */
		function hasNext():Boolean;

		/**
		 * Removes from the underlying collection the last element
		 * returned by the iterator (optional operation). This method
		 * can be called only once per call to next. The behavior
		 * of an iterator is unspecified if the underlying collection
		 * is modified while the iteration is in progress in any way
		 * other than by calling this method.
		 */
		function remove():Object;
	}
}