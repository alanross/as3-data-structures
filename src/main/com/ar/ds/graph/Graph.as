package com.ar.ds.graph
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Graph
	{
		public static const UNDIRECTED:int = 1;
		public static const DIRECTED:int = 2;

		private var vertices:Vector.<Vertex> = new Vector.<Vertex>();
		private var edges:Vector.<Edge> = new Vector.<Edge>();

		private var type:int;

		public function Graph( type:int = UNDIRECTED, v:Vector.<Vertex> = null, e:Vector.<Edge> = null )
		{
			this.type = type;

			if( v != null )
			{
				this.vertices = v;
			}

			if( e != null )
			{
				this.edges = e;
			}
		}

		public function clone():Graph
		{
			var g:Graph = new Graph( type );

			return g;
		}

		public function create1( g:Graph )
		{
			// Copy the vertices (which copies the edges)
			for each( var v:Vertex in g.getVerticies() )
			{
				this.vertices.push( new Vertex( v ) );
			}

			// Update the object references
			for each( var v:Vertex in this.vertices )
			{
				for each( var e:Edge in v.getEdges() )
				{
					var fromVertex:Vertex = e.from;
					var toVertex:Vertex = e.to;
					var indexOfFrom:int = this.vertices.indexOf( fromVertex );
					e.from = this.vertices[ indexOfFrom ];
					var indexOfTo:int = this.vertices.indexOf( toVertex );
					e.to = this.vertices[ indexOfTo ];
					this.edges.push( e );
				}
			}

			type = g.getType();
		}

		public function create2( type )
		{
			this.type = type;
		}

		public function create3( vertices:Vector.<Vertex>, edges:Vector.<Edge> )
		{
			this( UNDIRECTED, vertices, edges );
		}

		public function create4( type:int, vertices:Vector.<Vertex>, edges:Vector.<Edge> )
		{
			this.type = type;
			this.vertices.concat( vertices );
			this.edges.concat( edges );

			var index:int;

			for each( var e:Edge in edges )
			{
				var from:Vertex = e.from;
				var to:Vertex = e.to;

				if( this.vertices.indexOf( from ) == -1 || this.vertices.indexOf( to ) == -1 )
				{
					continue;
				}

				index = this.vertices.indexOf( from );
				var fromVertex:Vertex = this.vertices[ index ];
				index = this.vertices.indexOf( to );
				var toVertex:Vertex = this.vertices[ index ];
				fromVertex.addEdge( e );

				if( this.type == UNDIRECTED )
				{
					var reciprical:Edge = new Edge( toVertex, fromVertex, e.cost );
					toVertex.addEdge( reciprical );
					this.edges.push( reciprical );
				}
			}
		}


		public function getType():int
		{
			return type;
		}

		public function getVerticies():Vector.<Vertex>
		{
			return vertices;
		}

		public function getEdges():Vector.<Edge>
		{
			return edges;
		}

		public function getInfo():String
		{
			var info:String = "";

			const n:int = vertices.length;

			for( var i:int = 0; i < n; ++i )
			{
				info += vertices[i].getInfo();
			}

			return info;
		}

		public function toString():String
		{
			return "[Graph]";
		}
	}
}
