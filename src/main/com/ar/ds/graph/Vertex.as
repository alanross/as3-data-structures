package com.ar.ds.graph
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Vertex
	{
		public var value:Object = null;
		public var weight:int;
		public var edges:Vector.<Edge> = new Vector.<Edge>();

		public function Vertex( value:Object, weight:int = 0 )
		{
			this.value = value;
			this.weight = weight;
		}

		public function clone():Vertex
		{
			var vertex:Vertex = new Vertex( value, weight );

			for( var i:int = 0; i < edges.length; ++i )
			{
				vertex.edges.push( edges[i].clone() );
			}

			return vertex;
		}

		public function addEdge( e:Edge ):void
		{
			edges.push( e );
		}

		public function getEdges():Vector.<Edge>
		{
			return edges;
		}

		public function pathTo( v:Vertex ):Boolean
		{
			const n:int = edges.concat.length;

			for( var i:int = 0; i < n; ++i )
			{
				var e:Edge = edges[i];

				if( e.to == ( v ) )
				{
					return true;
				}
			}
			return false;
		}

		public function compareTo( v:Vertex ):int
		{
			if( value == null || v.value == null )
			{
				return -1;
			}

			return value.compareTo( v.value );
		}

		/**
		 * {@inheritDoc}
		 */
		public function equals( other:Vertex ):Boolean
		{
			var values:Boolean = ( value == other.value );

			if( !values )
			{
				return false;
			}

			var weight:Boolean = ( weight == other.weight );

			if( !weight )
			{
				return false;
			}

			return true;
		}

		public function getInfo():String
		{
			var info:String = "Vertex: value:" + value + ", weight:" + weight + ", edges:\n";

			const n:int = edges.length;

			for( var i:int = 0; i < n; ++i )
			{
				info += "\t" + edges[i].getInfo();
			}

			return info;
		}

		public function toString():String
		{
			return "[Vertex weight:" + weight + "]";
		}
	}
}

		
