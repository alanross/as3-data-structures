package com.ar.ds.stack
{
	import com.ar.ds.ICollection;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IStack extends ICollection
	{
		/**
		 * Returns the most recently added object at the top of
		 * the stack without removing it.
		 */
		function top():Object;

		/**
		 * Removes the object from the top of the stack and returns it.
		 */
		function pop():Object;

		/**
		 * Insert a new item on to the stack.
		 */
		function push( item:Object ):void;
	}
}