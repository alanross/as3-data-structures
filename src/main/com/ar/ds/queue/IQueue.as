package com.ar.ds.queue
{
	import com.ar.ds.ICollection;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IQueue extends ICollection
	{
		/**
		 * Insert a new item at end of the queue.
		 */
		function enqueue( item:Object ):void;

		/**
		 * Removes the least recently inserted item in the queue and returns it.
		 */
		function dequeue():Object;

		/**
		 * Returns the least recently inserted item in the queue without removing it.
		 */
		function getFirst():Object;
	}
}