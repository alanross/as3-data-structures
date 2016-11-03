package com.ar.ds.skipList
{
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;

	/**
	 * Ported from:
	 * http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/Map/skip-list-impl.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class SkipListPrinter
	{
		public static function printHorizontal( list:SkipList ):void
		{
			// Record the position of each entry
			var node:SkipNode = list.head;

			while( node.down != null )
			{
				node = node.down;
			}

			var i:int = 0;

			while( node != null )
			{
				node.pos = i++;
				node = node.right;
			}

			node = list.head;

			var result:String = "";

			while( node != null )
			{
				result = getRow( node );

				Log.info( Context.DEFAULT, result );

				node = node.down;
			}
		}

		public static function printVertical( list:SkipList ):void
		{
			var result:String = "";

			var node:SkipNode = list.head;

			while( node.down != null )
			{
				node = node.down;
			}

			while( node != null )
			{
				result = getColumn( node );

				Log.info( Context.DEFAULT, result );

				node = node.right;
			}
		}

		public static function getRow( node:SkipNode ):String
		{
			var tmp:int = 0;

			var result:String = node.key;

			node = node.right;

			while( node != null )
			{
				var q:SkipNode = node;

				while( q.down != null )
				{
					q = q.down;
				}

				var pos:int = q.pos;

				result += " <-";

				for( var i:int = tmp + 1; i < pos; i++ )
				{
					result = result + "--------";
				}

				result += "> " + node.key;

				tmp = pos;

				node = node.right;
			}

			return result;
		}

		public static function getColumn( node:SkipNode ):String
		{
			var result:String = "";

			while( node != null )
			{
				result = result + " " + node.key;

				node = node.up;
			}

			return result;
		}

		/**
		 * Creates a new instance of SkipListPrinter.
		 */
		public function SkipListPrinter()
		{
			throw new Error( "SkipListPrinter class is static container only." );
		}

		/**
		 * Generates and returns the string representation of the SkipListPrinter object.
		 */
		public function toString():String
		{
			return "[SkipListPrinter]";
		}
	}
}