package com.ar.ds.queue
{
	import com.ar.core.error.UnderflowError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class LinkedQueue implements IQueue
	{
		private var _front:QueueNode;
		private var _back:QueueNode;
		private var _size:int;

		/**
		 * Creates a new instance of LinkedQueue.
		 */
		public function LinkedQueue()
		{
			empty();
		}

		/**
		 * @inheritDoc
		 */
		public function enqueue( item:Object ):void
		{
			if( isEmpty() )
			{
				// Make queue of one element
				_back = _front = new QueueNode( item );
			}
			else
			{
				// Regular case
				_back = _back.next = new QueueNode( item );
			}

			_size++;
		}

		/**
		 * @inheritDoc
		 */
		public function dequeue():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "LinkedQueue dequeue" );
			}

			var item:Object = _front.data;
			_front = _front.next;

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
			_front = null;
			_back = null;
			_size = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return _front == null;
		}

		/**
		 * @inheritDoc
		 */
		public function getFirst():Object
		{
			if( isEmpty() )
			{
				throw new UnderflowError( "LinkedQueue getFirst" );
			}

			return _front.data;
		}

		/**
		 * @inheritDoc
		 */
		public function getSize():int
		{
			return _size;
		}

		/**
		 * Creates and returns a string representation of the LinkedQueue object.
		 */
		public function toString():String
		{
			return "[LinkedQueue size:" + getSize() + "]";
		}
	}
}

import com.ar.core.utils.IDisposable;

class QueueNode implements IDisposable
{
	public var data:*;

	public var next:QueueNode;

	/**
	 * Creates a new instance of QueueNode.
	 */
	public function QueueNode( data:*, next:QueueNode = null )
	{
		this.data = data;
		this.next = next;
	}

	/**
	 * Frees all internal references of the object.
	 */
	public function dispose():void
	{
		next = null;
		data = null;
	}

	/**
	 * Creates and returns a string representation of the QueueNode object.
	 */
	public function toString():String
	{
		return "[QueueNode data:" + data + "]";
	}
}