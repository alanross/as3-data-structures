package com.ar.ds.list.iterator
{
	import com.ar.ds.list.IList;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class ListIterator implements IListIterator
	{
		private var _list:IList;

		private var _index:int;

		/**
		 * Creates a new instance of ListIterator.
		 */
		public function ListIterator( list:IList ):void
		{
			_list = list;

			_index = -1;
		}

		/**
		 *
		 */
		public function getNext():Object
		{
			return _list.getAt( ++_index );
		}

		/**
		 *
		 */
		public function hasNext():Boolean
		{
			return ( _index < _list.getSize() - 1 );
		}

		/**
		 *
		 */
		public function remove():Object
		{
			return _list.remove( _list.getAt( _index ) );
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			_list = null;
			_index = NaN;
		}

		/**
		 * Creates and returns a string representation of the ListIterator object.
		 */
		public function toString():String
		{
			return "[ListIterator]";
		}
	}
}