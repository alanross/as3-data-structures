package com.ar.ds.list
{
	import com.ar.core.error.ElementDoesNotExistError;
	import com.ar.core.error.NullError;
	import com.ar.core.error.OutOfBoundsError;
	import com.ar.core.utils.IDisposable;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class AbstractLinkedList implements IDisposable
	{
		protected var _head:ListNode;
		protected var _tail:ListNode;
		protected var _size:int;

		/**
		 * Creates a new instance of AbstractLinkedList.
		 */
		public function AbstractLinkedList():void
		{
			empty();
		}

		/**
		 * Insert a node at the beginning of the list.
		 */
		protected function addFirstNode( node:ListNode ):ListNode
		{
			return insertAfterNode( node, _head );
		}

		/**
		 * Append a node to the end of the list.
		 */
		protected function addLastNode( node:ListNode ):ListNode
		{
			if( null == node )
			{
				throw new NullError();
			}

			return insertAfterNode( node, _tail.prev );
		}

		/**
		 * Inserts a node before other provided node.
		 */
		protected function insertBeforeNode( node:ListNode, next:ListNode ):ListNode
		{
			node.prev = next.prev;
			node.next = next;
			node.prev.next = node;
			node.next.prev = node;

			_size++;

			return node;
		}

		/**
		 * Inserts a node behind other provided node.
		 */
		protected function insertAfterNode( node:ListNode, prev:ListNode ):ListNode
		{
			node.prev = prev;
			node.next = prev.next;
			node.prev.next = node;
			node.next.prev = node;

			_size++;

			return node;
		}

		/**
		 * Removes given node from the list.
		 */
		protected function removeNode( node:ListNode ):ListNode
		{
			if( node == null )
			{
				throw new NullError( "AbstractLinkedList removeNode" );
			}

			if( isEmpty() || !containsNode( node ) )
			{
				throw new ElementDoesNotExistError( "AbstractLinkedList removeNode" );
			}

			var tmp:ListNode = node;

			tmp.prev.next = tmp.next;
			tmp.next.prev = tmp.prev;
			tmp.next = tmp.prev = null;
			_size--;

			return tmp;
		}

		/**
		 * Removes the first node from the list.
		 */
		protected function removeFirstNode():ListNode
		{
			if( isEmpty() )
			{
				throw new ElementDoesNotExistError( "AbstractLinkedList removeFirstNode" );
			}

			return removeNode( _head.next );
		}

		/**
		 * Removes the last node from the list.
		 */
		protected function removeLastNode():ListNode
		{
			if( isEmpty() )
			{
				throw new ElementDoesNotExistError( "AbstractLinkedList removeLastNode" );
			}

			return removeNode( _tail.prev );
		}

		/**
		 * Returns the node if it exists, null otherwise.
		 */
		protected function containsNode( node:ListNode ):ListNode
		{
			var tmp:ListNode = _head;

			while( tmp != null )
			{
				if( tmp == node )
				{
					return tmp;
				}

				tmp = tmp.next;
			}

			return null;
		}

		/**
		 * Returns the index of the node.
		 */
		protected function getIndexOfNode( node:ListNode ):int
		{
			var tmp:ListNode = _head;
			var i:int = 0;

			while( tmp != null )
			{
				if( tmp == node )
				{
					return i;
				}

				++i;
				tmp = tmp.next;
			}

			return -1;
		}

		/**
		 * Provides the node at given index.
		 */
		protected function getNodeAt( index:int ):ListNode
		{
			if( index >= getSize() || index < 0 )
			{
				throw new OutOfBoundsError( index, 0, getSize() );
			}

			var tmp:ListNode = _head.next;

			for( var i:int = 0; i < index; ++i )
			{
				tmp = tmp.next;
			}

			return tmp;
		}

		/**
		 * Provides the first node.
		 */
		protected function getFirstNode():ListNode
		{
			if( _head.next == _tail )
			{
				throw new ElementDoesNotExistError( "AbstractLinkedList getFirstNode" );
			}

			return _head.next;
		}

		/**
		 * Provides the last node.
		 */
		protected function getLastNode():ListNode
		{
			if( _tail.prev == _head )
			{
				throw new ElementDoesNotExistError( "AbstractLinkedList getLastNode" );
			}

			return _tail.prev;
		}

		/**
		 * Returns true if the list contains no items, false otherwise.
		 */
		public function isEmpty():Boolean
		{
			return ( _size == 0 );
		}

		/**
		 * Remove all items from the list
		 */
		public function empty():void
		{
			var tmp:ListNode = _head;
			var node:ListNode;

			while( tmp != null )
			{
				node = tmp;
				tmp = tmp.next;
				node.dispose();
			}

			_head = new ListNode();
			_tail = new ListNode();

			_head.next = _tail;
			_tail.prev = _head;

			_size = 0;
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			var tmp:ListNode = _head;
			var node:ListNode;

			while( tmp != null )
			{
				node = tmp;
				tmp = tmp.next;
				node.dispose();
			}

			_head = null;
			_tail = null;
			_size = 0;
		}

		/**
		 * Returns the number of elements stored in the list.
		 */
		public function getSize():int
		{
			return _size;
		}

		/**
		 * Creates and returns a string representation of the AbstractLinkedList object.
		 */
		public function toString():String
		{
			return "[AbstractLinkedList]";
		}
	}
}