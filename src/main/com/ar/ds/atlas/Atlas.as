package com.ar.ds.atlas
{
	import com.ar.core.error.ElementDoesNotExistError;
	import com.ar.core.error.NullError;
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;
	import com.ar.core.utils.StringUtils;

	import flash.utils.Dictionary;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class Atlas
	{
		private var _dictionary:Dictionary;

		public function Atlas()
		{
			_dictionary = new Dictionary();
		}

		protected function addElement( element:IAtlasElement ):Boolean
		{
			var id:String = element.id;

			if( StringUtils.isEmpty( id ) )
			{
				Log.warn( Context.DEFAULT, this, "Ignoring. Can not prepare element with empty id." );

				return false;
			}

			id = id.toLowerCase();

			if( hasElementWithId( id ) )
			{
				Log.warn( Context.DEFAULT, this, "Ignoring. Element already exists." );

				return false;
			}

			_dictionary[id] = element;

			return true;
		}

		protected function removeElement( element:IAtlasElement ):Boolean
		{
			var id:String = element.id;

			if( StringUtils.isEmpty( id ) )
			{
				Log.warn( Context.DEFAULT, this, "Ignoring. Can not remove element with empty id." );

				return false;
			}

			id = id.toLowerCase();

			if( !hasElementWithId( id ) )
			{
				Log.warn( Context.DEFAULT, this, "Ignoring. Element does not exists." );

				return false;
			}

			delete _dictionary[id];

			return true;
		}

		protected function getElement( id:String ):IAtlasElement
		{
			if( StringUtils.isEmpty( id ) )
			{
				throw new NullError( this + " Can not retrieve element with empty id." );
			}

			id = id.toLowerCase();

			if( !hasElementWithId( id ) )
			{
				throw new ElementDoesNotExistError();
			}

			return _dictionary[ id ];
		}

		protected function hasElement( element:IAtlasElement ):Boolean
		{
			return hasElementWithId( element.id );
		}

		protected function hasElementWithId( id:String ):Boolean
		{
			return ( _dictionary[ id.toLowerCase() ] != null );
		}

		public function getAllElements():Vector.<IAtlasElement>
		{
			var result:Vector.<IAtlasElement> = new Vector.<IAtlasElement>();

			for each ( var value:* in _dictionary )
			{
				result.push( value );
			}

			return result;
		}

		public function getAllElementsInfo():String
		{
			var result:String = "[\n";

			for each ( var value:* in _dictionary )
			{
				result += "\t" + value + "\n";
			}

			return result + "]";
		}

		public function dispose():void
		{
			for( var key:* in _dictionary )
			{
				removeElement( key );
			}

			_dictionary = null;
		}

		public function toString():String
		{
			return "[Atlas]";
		}
	}
}