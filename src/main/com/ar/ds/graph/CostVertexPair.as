package com.ar.ds.graph
{
	import com.ar.core.error.NullError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class CostVertexPair
	{
		private var cost:int = int.MAX_VALUE;
		private var vertex:Vertex = null;

		public function CostVertexPair( cost:int, vertex:Vertex )
		{
			if( vertex == null )
			{
				throw ( new NullError( "vertex cannot be NULL." ) );
			}

			this.cost = cost;
			this.vertex = vertex;
		}

		public function compareTo( other:CostVertexPair ):int
		{
			if( other == null )
			{
				throw new NullError( "CostVertexPair 'p' must be non-NULL." );
			}

			if( cost < other.cost )
			{
				return -1;
			}

			if( cost > other.cost )
			{
				return 1;
			}

			return 0;
		}

		public function getInfo():String
		{
			return "CostVertexPair vertex:" + vertex.value + ", cost:" + cost;
		}

		public function toString():String
		{
			return "[CostVertexPair cost:" + cost + "]";
		}
	}
}