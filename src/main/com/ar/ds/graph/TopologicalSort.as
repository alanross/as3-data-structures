package com.ar.ds.graph
{
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TopologicalSort
	{
		public static function sort( graph:Graph ):Vector.<Vertex>
		{
			var sorted:Vector.<Vertex> = new Vector.<Vertex>();
			var noOutgoing:Vector.<Vertex> = new Vector.<Vertex>();

			var i:int;
			var n:int;
			var vertex:Vertex;
			var edge:Edge;

			n = graph.getVerticies().length;

			for( i = 0; i < n; ++i )
			{
				vertex = graph.getVerticies()[i];

				if( vertex.getEdges().length == 0 )
				{
					noOutgoing.push( vertex );
				}
			}

			while( noOutgoing.length > 0 )
			{
				vertex = noOutgoing.shift();

				sorted.push( vertex );

				n = graph.getEdges().length;

				for( i = 0; i < n; ++i )
				{
					edge = graph.getEdges()[i];

					var v2:Vertex = edge.from;
					var v3:Vertex = edge.to;

					if( v3 == (vertex) )
					{
						graph.getEdges().splice( i, 1 );
						v2.getEdges().splice( i, 1 );
					}
					if( v2.getEdges().length == 0 )
					{
						noOutgoing.push( v2 );
					}
				}
			}

			if( graph.getEdges().length > 0 )
			{
				Log.warn( Context.DEFAULT, "Cycle detected." );
			}

			return sorted;
		}

		public function TopologicalSort()
		{
		}

		public function toString():String
		{
			return "[TopologicalSort]";
		}
	}
}