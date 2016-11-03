package com.ar.ds.stack
{
	import com.ar.core.error.NullError;
	import com.ar.core.error.UnderflowError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class LinkedStack implements IStack
	{
		private var _topOfStack:StackNode;

		private var _size:int;

		/**
		 * Creates a new instance of LinkedStack.
		 */
		public function LinkedStack()
		{
			empty();
		}

		/**
		 * @inheritDoc
		 */
		public function push( item:Object ):void
		{
			if( item == null )
			{
				throw new NullError( "LinkedStack push item is null" )
			}

			_topOfStack = new StackNode( item, _topOfStack );

			_size++;
		}

		/**
		 * @inheritDoc
		 */
		public function top():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "LinkedStack top" );
			}

			return _topOfStack.data;
		}

		/**
		 * @inheritDoc
		 */
		public function pop():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "LinkedStack pop" );
			}

			var item:Object = _topOfStack.data;
			_topOfStack = _topOfStack.next;

			_size--;

			return item;
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			empty();
		}

		/**
		 * @inheritDoc
		 */
		public function empty():void
		{
			_topOfStack = null;
			_size = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return _topOfStack == null;
		}

		/**
		 * @inheritDoc
		 */
		public function getSize():int
		{
			return _size;
		}

		/**
		 * Creates and returns a string representation of the LinkedStack object.
		 */
		public function toString():String
		{
			return "[LinkedStack size:" + getSize() + "]";
		}
	}
}

import com.ar.core.utils.IDisposable;

class StackNode implements IDisposable
{
	public var data:Object;

	public var next:StackNode;

	/**
	 * Creates a new instance of StackNode.
	 */
	public function StackNode( data:Object, next:StackNode = null )
	{
		this.data = data;
		this.next = next;
	}

	/**
	 * @inheritDoc
	 */
	public function dispose():void
	{
		next = null;
		data = null;
	}

	/**
	 * Creates and returns a string representation of the StackNode object.
	 */
	public function toString():String
	{
		return "[LinkedNode data:" + data + "]";
	}

}