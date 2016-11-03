package com.ar.ds.tree.quad
{
	import flash.geom.Rectangle;

	/**
	 * A tree data structure in which each internal node has exactly four children.
	 * Used most often to partition a two-dimensional space by recursively subdividing
	 * it into four quadrants or regions.
	 *
	 * Usages
	 * - Spatial indexing
	 * - Efficient collision detection in two dimensions
	 * - View frustum culling of terrain data
	 *
	 * Based on http://algs4.cs.princeton.edu/92search/QuadTree.java.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class QuadTree
	{
		private var _root:QuadNode;
		private var _size:int = 0;

		/**
		 * Creates a new instance of QuadTree.
		 */
		public function QuadTree()
		{
		}

		/**
		 * @private
		 */
		private function processAdd( node:QuadNode, x:Number, y:Number, data:Object ):QuadNode
		{
			if( node == null )
			{
				return new QuadNode( x, y, data );
			}
			else if( x < node.x && y < node.y )
			{
				node.SW = processAdd( node.SW, x, y, data );
			}
			else if( x < node.x && y >= node.y )
			{
				node.NW = processAdd( node.NW, x, y, data );
			}
			else if( x >= node.x && y < node.y )
			{
				node.SE = processAdd( node.SE, x, y, data );
			}
			else if( x >= node.x && y >= node.y )
			{
				node.NE = processAdd( node.NE, x, y, data );
			}

			return node;
		}

		/**
		 * @private
		 */
		private function processSearch( node:QuadNode, rect:Rectangle, result:Array ):void
		{
			if( node == null )
			{
				return;
			}

			var xMin:int = rect.x;
			var yMin:int = rect.y;
			var xMax:int = rect.x + rect.width;
			var yMax:int = rect.y + rect.height;

			if( rect.contains( node.x, node.y ) )
			{
				result.push( node.data );
			}
			if( xMin < node.x && yMin < node.y )
			{
				processSearch( node.SW, rect, result );
			}
			if( xMin < node.x && yMax >= node.y )
			{
				processSearch( node.NW, rect, result );
			}
			if( xMax >= node.x && yMin <= node.y )
			{
				processSearch( node.SE, rect, result );
			}
			if( xMax >= node.x && yMax >= node.y )
			{
				processSearch( node.NE, rect, result );
			}
		}

		/**
		 * Insert (x, y) into appropriate quadrant
		 */
		public function add( x:Number, y:Number, data:Object ):void
		{
			_size++;

			_root = processAdd( _root, x, y, data );
		}

		/**
		 * Range search.
		 */
		public function searchInRange( rect:Rectangle ):Array
		{
			var result:Array = new Array();

			processSearch( _root, rect, result );

			return result;
		}

		/**
		 * Returns the number of elements the tree is holding
		 */
		public function getSize():int
		{
			return _size;
		}

		/**
		 * Creates and returns a string representation of the QuadTree object.
		 */
		public function toString():String
		{
			return "[QuadTree]";
		}
	}
}