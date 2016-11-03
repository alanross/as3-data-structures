package com.ar.ds.graph
{
	import com.ar.core.error.NullError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class CostPathPair
	{
		private var cost:int = 0;
		private var path:Vector.<Edge> = null;

		public function CostPathPair( cost:int, path:Vector.<Edge> )
		{
			if( path == null )
			{
				throw ( new NullError( "path cannot be NULL." ) );
			}

			this.cost = cost;
			this.path = path;
		}

		public function getCost():int
		{
			return cost;
		}

		public function setCost( cost:int ):void
		{
			this.cost = cost;
		}

		public function getPath():Vector.<Edge>
		{
			return path;
		}

		public function getInfo():String
		{
			var info:String = "CostPathPair cost:" + cost + " path:\n";

			const n:int = path.length;

			for( var i:int = 0; i < n; ++i )
			{
				info += "\t" + path[i]
			}

			return info;
		}

		public function toString():String
		{
			return "[CostPathPair cost:" + cost + "]";
		}
	}
}
