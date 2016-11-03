package com.ar.ds.graph
{
	import com.ar.core.error.MissingImplementationError;
	import com.ar.core.error.NullError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Edge
	{
		public var from:Vertex;
		public var to:Vertex;
		public var cost:int = 0;

		public function Edge( from:Vertex, to:Vertex, cost:int = 0 )
		{
			if( from == null || to == null )
			{
				throw new NullError( "Both 'from' and 'to' vertices can not be null." );
			}

			this.from = from;
			this.to = to;
			this.cost = cost;
		}

		public function clone():Edge
		{
			return new Edge( from, to, cost );
		}

		public function compareTo( other:Edge ):int
		{
			return ( cost < other.cost ) ? -1 : ( cost > other.cost ) ? 1 : 0;
		}

		public function hashCode():int
		{
			//return cost * ( from.value.hashCode() * to.value.hashCode() );
			throw new MissingImplementationError();
		}

		public function equals( other:Edge ):Boolean
		{
			var c:Boolean = ( cost == other.cost );

			if( !c )
			{
				return false;
			}

			var f:Boolean = from.equals( other.from );

			if( !f )
			{
				return false;
			}

			var t:Boolean = to.equals( other.to );

			if( !t )
			{
				return false;
			}

			return true;
		}

		public function getInfo():String
		{
			return "Edge: [" + from.value + "]" + " --> " + "[" + to.value + "]" + " = " + cost;
		}

		public function toString():String
		{
			return "[Edge]";
		}
	}
}
