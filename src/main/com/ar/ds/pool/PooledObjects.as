package com.ar.ds.pool
{
	import com.ar.core.error.ElementDoesNotExistError;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class PooledObjects
	{
		private static var _pools:Dictionary = new Dictionary();

		/**
		 * Creates a new instance of PooledObjects.
		 */
		public function PooledObjects()
		{
		}

		/**
		 * Provides a pooled item identified by its class definition.
		 */
		public static function createItem( item:Class, poolGrowthRate:int = 8 ):IPooledObject
		{
			var key:String = getQualifiedClassName( item );
			var pool:ObjectPool = _pools[ key ];

			if( null == pool )
			{
				pool = new ObjectPool( item, poolGrowthRate );

				_pools[ key ] = pool;

				return pool.createItem();
			}
			else
			{
				pool.poolGrowthRate = poolGrowthRate;

				return pool.createItem();
			}
		}

		/**
		 * Return a pooled item to the pool
		 */
		public static function releaseItem( item:IPooledObject ):void
		{
			const key:String = getQualifiedClassName( item );
			const pool:ObjectPool = _pools[ key ];

			if( null == pool )
			{
				throw new ElementDoesNotExistError( "No Pool found for given IPooledObject class" );
			}

			pool.releaseItem( item );
		}

		/**
		 * Clear the pool defined by its class definition.
		 */
		public static function clear( item:Class ):void
		{
			const key:String = getQualifiedClassName( item );
			const pool:ObjectPool = _pools[ key ];

			if( null == pool )
			{
				throw new ElementDoesNotExistError( "No Pool found for given IPooledObject class" );
			}

			pool.dispose();

			delete _pools[ key ];
		}

		/**
		 * Removes all pooled items.
		 */
		public static function clearAll():void
		{
			var pool:ObjectPool;

			for( var key:Object in _pools )
			{
				pool = _pools[ key ];
				pool.dispose();

				delete _pools[ key ];
			}
		}

		/**
		 * Creates and returns a string representation of the PooledObjects object.
		 */
		public function toString():String
		{
			return "[PooledObjects]";
		}
	}
}