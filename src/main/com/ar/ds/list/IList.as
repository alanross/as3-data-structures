package com.ar.ds.list
{
	import com.ar.ds.ICollection;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IList extends ICollection
	{
		/**
		 *  Add a new node to the head of list.
		 */
		function addFirst( o:Object ):Object;

		/**
		 * Appends the node to the end of this list.
		 */
		function addLast( o:Object ):Object;

		/**
		 * Insert node before given node.
		 */
		function insertBefore( o:Object, next:Object ):Object;

		/**
		 * Insert node after given node.
		 */
		function insertAfter( o:Object, prev:Object ):Object;

		/**
		 * Remove given node from the list
		 */
		function remove( o:Object ):Object;

		/**
		 * Remove and return the item at the head of the list.
		 */
		function removeFirst():Object;

		/**
		 * Remove and return the item at the tail of the list.
		 */
		function removeLast():Object;

		/**
		 * Returns true if this list holds the given node.
		 */
		function contains( o:Object ):Object;

		/**
		 * Returns the index of first occurrence of the given node.
		 * -1 is returned if the list does not hold the node.
		 */
		function getIndexOf( o:Object ):int;

		/**
		 * Returns the node at given index
		 */
		function getAt( index:int ):Object;

		/**
		 * The head node of the list.
		 */
		function getFirst():Object;

		/**
		 * The tail node of the list.
		 */
		function getLast():Object;
	}
}