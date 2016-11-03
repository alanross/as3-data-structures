package com.ar.ds.list
{
	import com.ar.core.error.ElementDoesNotExistError;
	import com.ar.core.error.NullError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class LinkedList extends AbstractLinkedList implements IList
	{
		/**
		 * Creates a new instance of LinkedList.
		 */
		public function LinkedList()
		{
			super();
		}

		/**
		 * Returns the node enveloping the object provided.
		 */
		public function getNode( o:Object ):ListNode
		{
			var tmp:ListNode = _head;

			while( tmp != null )
			{
				if( tmp.data == o )
				{
					return tmp;
				}

				tmp = tmp.next;
			}

			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function addFirst( o:Object ):Object
		{
			return addFirstNode( new ListNode( o ) ).data;
		}

		/**
		 * @inheritDoc
		 */
		public function addLast( o:Object ):Object
		{
			return addLastNode( new ListNode( o ) ).data;
		}

		/**
		 * @inheritDoc
		 */
		public function insertBefore( o:Object, next:Object ):Object
		{
			var node:ListNode = getNode( next );

			return insertBeforeNode( new ListNode( o ), node ).data;
		}

		/**
		 * @inheritDoc
		 */
		public function insertAfter( o:Object, prev:Object ):Object
		{
			var node:ListNode = getNode( prev );

			return insertAfterNode( new ListNode( o ), node ).data;
		}

		/**
		 * @inheritDoc
		 */
		public function remove( o:Object ):Object
		{
			if( o == null )
			{
				throw new NullError( "AbstractLinkedList removeNode" );
			}

			var tmp:ListNode = getNode( o );

			if( isEmpty() || !tmp )
			{
				throw new ElementDoesNotExistError( "AbstractLinkedList removeNode" );
			}

			tmp.prev.next = tmp.next;
			tmp.next.prev = tmp.prev;
			tmp.next = tmp.prev = null;
			_size--;

			return tmp.data;
		}

		/**
		 * @inheritDoc
		 */
		public function removeFirst():Object
		{
			return removeFirstNode().data;
		}

		/**
		 * @inheritDoc
		 */
		public function removeLast():Object
		{
			return removeLastNode().data;
		}

		/**
		 * @inheritDoc
		 */
		public function contains( o:Object ):Object
		{
			var tmp:ListNode = _head;

			while( tmp != null )
			{
				if( tmp.data == o )
				{
					return tmp.data;
				}

				tmp = tmp.next;
			}

			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIndexOf( o:Object ):int
		{
			var tmp:ListNode = _head;
			var i:int = 0;

			while( tmp != null )
			{
				if( tmp.data == o )
				{
					return i;
				}

				++i;
				tmp = tmp.next;
			}

			return -1;
		}

		/**
		 * @inheritDoc
		 */
		public function getAt( index:int ):Object
		{
			return getNodeAt( index ).data;
		}

		/**
		 * @inheritDoc
		 */
		public function getFirst():Object
		{
			return getFirstNode().data;
		}

		/**
		 * @inheritDoc
		 */
		public function getLast():Object
		{
			return getLastNode().data;
		}

		/**
		 * Creates and returns a string representation of the LinkedList object.
		 */
		override public function toString():String
		{
			return "[LinkedList]";
		}
	}
}