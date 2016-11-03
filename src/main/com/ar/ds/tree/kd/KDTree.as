package com.ar.ds.tree.kd
{
	import com.ar.core.error.ElementDoesNotExistError;

	/**
	 * A k-d tree (short for k-dimensional tree) is a space-partitioning data structure for organizing
	 * points in a k-dimensional space. k-d trees are a useful data structure for several applications,
	 * such as searches involving a multidimensional search key (e.g. range searches and nearest neighbor
	 * searches). k-d trees are a special case of binary space partitioning trees.
	 *
	 * Based on:
	 * http://code.google.com/p/java-algorithms-implementation/source/browse/trunk/src/com/jwetherell/algorithms/data_structures/KdTree.java?r=368
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class KDTree
	{
		private var _root:KDNode = null;

		/**
		 * Creates a new instance of KDTree.
		 */
		public function KDTree()
		{
			_root = null;
		}

		/**
		 * Add data to the tree. Tree can contain multiple equal values.
		 */
		public function add( data:KDData ):void
		{
			if( data == null )
			{
				return;
			}

			if( _root == null )
			{
				_root = new KDNode( data );

				return;
			}

			var node:KDNode = _root;

			var newNode:KDNode;

			while( true )
			{
				if( node.compareToData( data ) <= 0 )
				{
					//Lesser
					if( node.lesser == null )
					{
						newNode = new KDNode( data, KDData.K, node.depth + 1 );
						newNode.parent = node;
						node.lesser = newNode;
						break;
					}
					else
					{
						node = node.lesser;
					}
				}
				else
				{
					//Greater
					if( node.greater == null )
					{
						newNode = new KDNode( data, KDData.K, node.depth + 1 );
						newNode.parent = node;
						node.greater = newNode;
						break;
					}
					else
					{
						node = node.greater;
					}
				}
			}
		}

		/**
		 * Remove given data from tree.
		 */
		public function remove( data:KDData ):void
		{
			if( data == null )
			{
				throw new ElementDoesNotExistError();
			}

			var node:KDNode = getNode( data );

			if( node == null )
			{
				throw new ElementDoesNotExistError();
			}

			var parent:KDNode = node.parent;

			var nodes:Vector.<KDData>;

			if( parent != null )
			{
				if( parent.lesser != null && node.equalsNode( parent.lesser ) )
				{
					nodes = getNodes( node );

					if( nodes.length > 0 )
					{
						parent.lesser = createNode( nodes, node.k, node.depth );
						if( parent.lesser != null )
						{
							parent.lesser.parent = parent;
						}
					}
					else
					{
						parent.lesser = null;
					}
				}
				else
				{
					nodes = getNodes( node );

					if( nodes.length > 0 )
					{
						parent.greater = createNode( nodes, node.k, node.depth );

						if( parent.greater != null )
						{
							parent.greater.parent = parent;
						}
					}
					else
					{
						parent.greater = null;
					}
				}
			}
			else
			{
				//root
				nodes = getNodes( node );

				if( nodes.length > 0 )
				{
					_root = createNode( nodes, node.k, node.depth );
				}
				else
				{
					_root = null;
				}
			}
		}

		/**
		 * Checks if given data is held by the tree.
		 */
		public function contains( data:KDData ):Boolean
		{
			if( data == null )
			{
				return false;
			}

			return ( getNode( data ) != null );
		}

		/**
		 * @private
		 */
		private function createNode( list:Vector.<KDData>, k:int, depth:int ):KDNode
		{
			if( list == null || list.length == 0 )
			{
				return null;
			}

			var axis:int = depth % k;

			list = KDNode.sort( list, axis );

			var mediaIndex:int = list.length / 2;

			var node:KDNode = new KDNode( list[ mediaIndex ], k, depth );

			if( list.length > 0 )
			{
				if( (mediaIndex - 1) >= 0 )
				{
					var less:Vector.<KDData> = list.slice( 0, mediaIndex );
					if( less.length > 0 )
					{
						node.lesser = createNode( less, k, depth + 1 );
						node.lesser.parent = node;
					}
				}
				if( (mediaIndex + 1) <= (list.length - 1) )
				{
					var more:Vector.<KDData> = list.slice( mediaIndex + 1, list.length );
					if( more.length > 0 )
					{
						node.greater = createNode( more, k, depth + 1 );
						node.greater.parent = node;
					}
				}
			}

			return node;
		}

		/**
		 * @private
		 */
		private function getNode( data:KDData ):KDNode
		{
			if( _root == null || data == null )
			{
				return null;
			}

			var node:KDNode = _root;

			while( true )
			{
				if( node.equalsData( data ) )
				{
					return node;
				}
				else if( node.compareToData( data ) < 0 )
				{
					//Greater
					if( node.greater == null )
					{
						return null;
					}
					else
					{
						node = node.greater;
					}
				}
				else
				{
					//Lesser
					if( node.lesser == null )
					{
						return null;
					}
					else
					{
						node = node.lesser;
					}
				}
			}

			return null;
		}

		/**
		 * @private
		 */
		private function getNodes( root:KDNode ):Vector.<KDData>
		{
			var list:Vector.<KDData> = new Vector.<KDData>();

			if( root == null )
			{
				return list;
			}

			if( root.lesser != null )
			{
				list.push( root.lesser.data );
				list.concat( getNodes( root.lesser ) );
			}
			if( root.greater != null )
			{
				list.push( root.greater.data );
				list.concat( getNodes( root.greater ) );
			}

			return list;
		}

		/**
		 * Return found neighbors of given data point.
		 */
		public function getNearestNeighbours( maxNumNeighbours:int, data:KDData ):Vector.<KDData>
		{
			if( data == null )
			{
				return null;
			}

			//Map used for results
			var foundNodes:Vector.<KDNode> = new Vector.<KDNode>();

			//Find the closest leaf node
			var prev:KDNode = null;
			var node:KDNode = _root;

			while( node != null )
			{
				if( node.compareToData( data ) < 0 )
				{
					//Greater
					prev = node;
					node = node.greater;
				}
				else
				{
					//Lesser
					prev = node;
					node = node.lesser;
				}
			}

			var leaf:KDNode = prev;

			if( leaf != null )
			{
				//Used to not re-examine nodes
				var examined:Vector.<KDNode> = new Vector.<KDNode>();

				//Go up the tree, looking for better solutions
				node = leaf;

				while( node != null )
				{
					//Search node
					searchNode( data, node, maxNumNeighbours, foundNodes, examined );

					node = node.parent;
				}
			}

			var result:Vector.<KDData> = new Vector.<KDData>();

			const n:int = foundNodes.length;

			for( var i:int = 0; i < n; ++i )
			{
				result.push( foundNodes[i].data );
			}

			return result;
		}

		/**
		 * @private
		 */
		private function searchNode( data:KDData, node:KDNode, K:int, foundNodes:Vector.<KDNode>, examinedNodes:Vector.<KDNode> ):void
		{
			examinedNodes.push( node );

			//Search node
			var lastNode:KDNode = null;
			var lastDistance:Number = Number.MAX_VALUE;
			if( foundNodes.length > 0 )
			{
				lastNode = foundNodes[ foundNodes.length - 1];
				lastDistance = lastNode.data.getDistanceToData( data );
			}

			var nodeDistance:Number = node.data.getDistanceToData( data );

			if( nodeDistance < lastDistance )
			{
				if( foundNodes.length == K && lastNode != null )
				{
					foundNodes.splice( foundNodes.indexOf( lastNode ), 1 );
				}

				foundNodes.push( node );
			}
			else if( nodeDistance == lastDistance )
			{
				foundNodes.push( node );
			}
			else if( foundNodes.length < K )
			{
				foundNodes.push( node );
			}

			lastNode = foundNodes[ foundNodes.length - 1];
			lastDistance = lastNode.data.getDistanceToData( data );

			var axis:int = node.depth % node.k;
			var lesser:KDNode = node.lesser;
			var greater:KDNode = node.greater;
			var p1:Number;
			var p2:Number;
			var lineIntersectsCube:Boolean;

			//Search children branches, if axis aligned distance is less than current distance
			if( lesser != null && (examinedNodes.indexOf( lesser ) == -1 ) )
			{
				examinedNodes.push( lesser );

				p1 = Number.MIN_VALUE;
				p2 = Number.MIN_VALUE;

				if( axis == KDData.X_AXIS )
				{
					p1 = node.data.x;
					p2 = data.x - lastDistance;
				}
				else if( axis == KDData.Y_AXIS )
				{
					p1 = node.data.y;
					p2 = data.y - lastDistance;
				}
				else
				{
					p1 = node.data.z;
					p2 = data.z - lastDistance;
				}

				lineIntersectsCube = ( p2 <= p1 );

				//Continue down lesser branch
				if( lineIntersectsCube )
				{
					searchNode( data, lesser, K, foundNodes, examinedNodes );
				}
			}
			if( greater != null && (examinedNodes.indexOf( greater ) == -1 ) )
			{
				examinedNodes.push( greater );

				p1 = Number.MIN_VALUE;
				p2 = Number.MIN_VALUE;

				if( axis == KDData.X_AXIS )
				{
					p1 = node.data.x;
					p2 = data.x + lastDistance;
				}
				else if( axis == KDData.Y_AXIS )
				{
					p1 = node.data.y;
					p2 = data.y + lastDistance;
				}
				else
				{
					p1 = node.data.z;
					p2 = data.z + lastDistance;
				}

				lineIntersectsCube = (p2 >= p1);

				//Continue down greater branch
				if( lineIntersectsCube )
				{
					searchNode( data, greater, K, foundNodes, examinedNodes );
				}
			}
		}

		/**
		 *
		 */
		public function get root():KDNode
		{
			return _root;
		}

		/**
		 * Creates and returns a string representation of the KDTree object.
		 */
		public function toString():String
		{
			return "[KDTree]";
		}
	}
}