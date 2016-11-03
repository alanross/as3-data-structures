package com.ar.ds
{
	import com.ar.core.utils.IDisposable;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface ICollection extends IDisposable
	{
		/**
		 * Test if the structure is logically empty. Returns true if empty, false otherwise.
		 */
		function isEmpty():Boolean;

		/**
		 * Make the structure logically empty.
		 */
		function empty():void;

		/**
		 * The number of items held by the structure.
		 */
		function getSize():int;
	}
}