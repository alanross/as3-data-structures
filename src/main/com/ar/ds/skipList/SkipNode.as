package com.ar.ds.skipList
{
	import com.ar.ds.compare.StringComparator;

	/**
	 * Ported from:
	 * http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/Map/skip-list-impl.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class SkipNode
	{
		public static var negInf:String = "-oo";  // -inf key value
		public static var posInf:String = "+oo";  // +inf key value

		private static var comparator:StringComparator = new StringComparator();

		public var key:String;
		public var data:Object;

		public var up:SkipNode;
		public var down:SkipNode;
		public var left:SkipNode;
		public var right:SkipNode;

		public var pos:int;

		/**
		 * Creates a new instance of SkipNode.
		 */
		public function SkipNode( key:String, data:Object )
		{
			this.key = key;
			this.data = data;
		}

		/**
		 *
		 */
		public function compareTo( otherKey:String ):Number
		{
			return comparator.compare( this.key, otherKey );
		}

		/**
		 * Creates and returns a string representation of the SkipNode object.
		 */
		public function toString():String
		{
			return "[SkipNode key:" + key + "]";
		}
	}
}
