package com.ar.ds.tree.kd
{
	import com.ar.core.error.ValueError;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class KDNode
	{
		public var k:int = 3;
		public var depth:int = 0;
		public var parent:KDNode = null;
		public var lesser:KDNode = null;
		public var greater:KDNode = null;
		public var data:KDData = null;

		public static function sort( list:Vector.<KDData>, axis:int ):Vector.<KDData>
		{
			if( axis == KDData.X_AXIS )
			{
				return list.sort( KDData.compareX );
			}
			else if( axis == KDData.Y_AXIS )
			{
				return list.sort( KDData.compareY );
			}
			else if( axis == KDData.Z_AXIS )
			{
				return list.sort( KDData.compareZ );
			}
			else
			{
				throw new ValueError( "Axis is unknown: " + axis );
			}
		}


		public function KDNode( data:KDData, k:int = 0, depth:int = 0 )
		{
			this.data = data;
			this.k = k;
			this.depth = depth;
		}

		public function compareToData( key:KDData ):int
		{
			var axis:int = depth % k;

			if( axis == KDData.X_AXIS )
			{
				return KDData.compareX( this.data, key );
			}
			else if( axis == KDData.Y_AXIS )
			{
				return KDData.compareY( this.data, key );
			}
			else if( axis == KDData.Z_AXIS )
			{
				return KDData.compareZ( this.data, key );
			}
			else
			{
				throw new ValueError( "Axis is unknown: " + axis );
			}
		}

		public function compareToNode( node:KDNode ):int
		{
			var axis:int = depth % k;

			if( axis == KDData.X_AXIS )
			{
				return KDData.compareX( this.data, node.data );
			}
			else if( axis == KDData.Y_AXIS )
			{
				return KDData.compareY( this.data, node.data );
			}
			else if( axis == KDData.Z_AXIS )
			{
				return KDData.compareZ( this.data, node.data );
			}
			else
			{
				throw new ValueError( "Axis is unknown: " + axis );
			}
		}

		public function equalsNode( node:KDNode ):Boolean
		{
			if( node == null )
			{
				return false;
			}

			return ( compareToNode( node ) == 0 );
		}

		public function equalsData( key:KDData ):Boolean
		{
			if( key == null )
			{
				return false;
			}

			return ( compareToData( key ) == 0 );
		}








//		public static function compare1( depth:int, k:int, a:KDData, b:KDData ):int
//		{
//			var axis:int = depth % k;
//
//			if( axis == KDData.X_AXIS )
//			{
//				return KDData.compareX( a, b );
//			}
//			else if( axis == KDData.Y_AXIS )
//			{
//				return KDData.compareY( a, b );
//			}
//			else if( axis == KDData.Z_AXIS )
//			{
//				return KDData.compareZ( a, b );
//			}
//			else
//			{
//				throw new ValueError( "Axis is unknown: " + axis );
//			}
//		}
//
//		public function equals( node:KDNode ):Boolean
//		{
//			if( node == null )
//			{
//				return false;
//			}
//
//			return ( compareTo( node ) == 0 );
//		}
//
//		public function compareTo( node:KDNode ):int
//		{
//			return compare( depth, k, data, node.data );
//		}

		public function toString():String
		{
			return "[KDNode k:" + k + ", depth:" + depth + ", id:" + data + "]";
		}
	}
}