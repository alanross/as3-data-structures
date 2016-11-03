package com.ar.ds.pool
{
	import com.ar.core.utils.IDisposable;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class ObjectPool implements IDisposable
	{
		private var _pool:Vector.<IPooledObject>;
		private var _poolGrowthRate:int;
		private var _clazz:Class;

		/**
		 * Creates a new instance of ObjectPool.
		 */
		public function ObjectPool( itemType:Class, poolGrowthRate:int = 8 )
		{
			_pool = new Vector.<IPooledObject>();
			_poolGrowthRate = poolGrowthRate;
			_clazz = itemType;
		}

		/**
		 * Extend the size of the pool
		 */
		private function grow():void
		{
			var n:int = _poolGrowthRate;

			while( --n > -1 )
			{
				_pool.push( new _clazz() );
			}
		}

		/**
		 * Provides an item from the pool.
		 */
		public function createItem():IPooledObject
		{
			if( 0 >= _pool.length )
			{
				grow();
			}

			var item:IPooledObject = _pool.pop();

			item.create();

			return item;
		}

		/**
		 * Put back item into the pool.
		 */
		public function releaseItem( item:IPooledObject ):void
		{
			item.expire();

			_pool.push( item );
		}

		/**
		 * clear the pool by removing all of its items.
		 */
		public function clear():void
		{
			_pool.splice( 0, _pool.length );
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			clear();

			_pool = null;
			_clazz = null;
		}

		/**
		 * The growth rate of the pool
		 */
		public function get poolGrowthRate():int
		{
			return _poolGrowthRate;
		}

		/**
		 * The growth rate of the pool
		 */
		public function set poolGrowthRate( value:int ):void
		{
			_poolGrowthRate = value;
		}

		/**
		 * Creates and returns a string representation of the ObjectPool object.
		 */
		public function toString():String
		{
			return "[ObjectPool]";
		}
	}
}