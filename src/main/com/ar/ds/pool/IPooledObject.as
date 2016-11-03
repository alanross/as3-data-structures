package com.ar.ds.pool
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IPooledObject
	{
		/**
		 * Called when item is proved by the pool.
		 */
		function create():void;

		/**
		 * Called when item is put back into the pool.
		 */
		function expire():void;
	}
}