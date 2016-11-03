package com.ar.ds.list.iterator
{
	import com.ar.ds.list.IList;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class ListRingIterator implements IListIterator
	{
		private var _list:IList;

		private var _index:int;

		/**
		 * Creates a new instance of ListRingIterator.
		 */
		public function ListRingIterator( list:IList ):void
		{
			_list = list;

			_index = -1;
		}

		/**
		 *
		 */
		public function getNext():Object
		{
			_index = ( _index + 1 ) % _list.getSize();

			return _list.getAt( _index );
		}

		/**
		 *
		 */
		public function hasNext():Boolean
		{
			return ( _list.getSize() > 0 );
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
		 * Creates and returns a string representation of the ListRingIterator object.
		 */
		public function toString():String
		{
			return "[ListRingIterator]";
		}
	}
}