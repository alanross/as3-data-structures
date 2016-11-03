package com.ar.ds.queue
{
	import com.ar.core.error.UnderflowError;

	/**
	 * A simple queue implementation
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class VQueue implements IQueue
	{
		private var _elements:Vector.<Object>;
		private var _currentSize:int;
		private var _queueFront:int;
		private var _queueBack:int;

		/**
		 * Creates a new instance of VQueue.
		 */
		public function VQueue( capacity:int = 8 )
		{
			_elements = new Vector.<Object>( capacity, true );

			empty();
		}

		/**
		 * @private
		 */
		private function grow():void
		{
			var result:Vector.<Object> = new Vector.<Object>( _elements.length * 2, true );

			for( var i:int = 0; i < _currentSize; i++ )
			{
				_queueFront = increment( _queueFront );

				result[i] = _elements[i];
			}

			_elements = result;
			_queueFront = 0;
			_queueBack = _currentSize - 1;
		}

		/**
		 * Internal method to increment with wraparound.
		 *
		 * @param index any index in the array's range.
		 * @return x+1, or 0 if x is at the end of the array.
		 */
		private function increment( index:int ):int
		{
			if( ++index == _elements.length )
			{
				index = 0;
			}

			return index;
		}

		/**
		 * @inheritDoc
		 */
		public function enqueue( item:Object ):void
		{
			if( _currentSize == _elements.length )
			{
				grow();
			}

			_queueBack = increment( _queueBack );
			_elements[ _queueBack ] = item;
			_currentSize++;
		}

		/**
		 * @inheritDoc
		 */
		public function dequeue():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "VQueue remove" );
			}

			_currentSize--;

			const item:Object = _elements[ _queueFront ];

			_queueFront = increment( _queueFront );

			return item;
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			_elements = null;
		}

		/**
		 * @inheritDoc
		 */
		public function empty():void
		{
			_currentSize = 0;
			_queueFront = 0;
			_queueBack = -1;
		}

		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return _currentSize == 0;
		}

		/**
		 * @inheritDoc
		 */
		public function getFirst():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "VQueue getFirst" );
			}

			return _elements[ _queueFront ];
		}

		/**
		 * @inheritDoc
		 */
		public function getSize():int
		{
			return _currentSize;
		}

		/**
		 * Creates and returns a string representation of the VQueue object.
		 */
		public function toString():String
		{
			return "[VQueue size:" + getSize() + "]";
		}
	}
}