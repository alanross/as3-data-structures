package com.ar.ds.stack
{
	import com.ar.core.error.UnderflowError;

	/**
	 * Last In First Out
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class VStack implements IStack
	{
		private var _elements:Vector.<Object>;

		private var _topOfStack:int;

		/**
		 * Creates a new instance of VStack.
		 */
		public function VStack( capacity:int = 8 )
		{
			_elements = new Vector.<Object>( capacity, true );

			_topOfStack = -1;
		}

		/**
		 * @private
		 */
		private function grow():void
		{
			var result:Vector.<Object> = new Vector.<Object>( _elements.length * 2, true );

			const n:int = _elements.length;

			for( var i:int = 0; i < n; ++i )
			{
				result[i] = _elements[i];
			}

			_elements = result;
		}

		/**
		 * @inheritDoc
		 */
		public function push( item:Object ):void
		{
			if( _topOfStack + 1 == _elements.length )
			{
				grow();
			}

			_elements[ ++_topOfStack ] = item;
		}

		/**
		 * @inheritDoc
		 */
		public function top():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "VStack top" );
			}

			return _elements[ _topOfStack ];
		}

		/**
		 * @inheritDoc
		 */
		public function pop():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "VStack pop" );
			}

			return _elements[ _topOfStack-- ];
		}

		/**
		 * @inheritDoc
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
			_topOfStack = -1;
		}

		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return _topOfStack == -1;
		}

		/**
		 * @inheritDoc
		 */
		public function getSize():int
		{
			return (_topOfStack > 0 ) ? _topOfStack + 1 : 0;
		}

		/**
		 * Creates and returns a string representation of the VStack object.
		 */
		public function toString():String
		{
			return "[VStack size:" + getSize() + "]";
		}
	}
}