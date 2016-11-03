package com.ar.ds.tree.kd
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class KDData
	{
		public static const K:int = 3;

		public static const X_AXIS:int = 0;
		public static const Y_AXIS:int = 1;
		public static const Z_AXIS:int = 2;

		public var x:Number = Number.NEGATIVE_INFINITY;
		public var y:Number = Number.NEGATIVE_INFINITY;
		public var z:Number = Number.NEGATIVE_INFINITY;

		public static function compareX( a:KDData, b:KDData ):Number
		{
			return ( ( a.x < b.x ) ? -1 : ( a.x > b.x ) ? 1 : 0 );
		}

		public static function compareY( a:KDData, b:KDData ):Number
		{
			return ( ( a.y < b.y ) ? -1 : ( a.y > b.y ) ? 1 : 0 );
		}

		public static function compareZ( a:KDData, b:KDData ):Number
		{
			return ( ( a.z < b.z ) ? -1 : ( a.z > b.z ) ? 1 : 0 );
		}

		public static function getEuclideanDistance( o1:KDData, o2:KDData ):Number
		{
			return Math.sqrt( Math.pow( (o1.x - o2.x), 2 ) + Math.pow( (o1.y - o2.y), 2 ) + Math.pow( (o1.z - o2.z), 2 ) );
		}

		public function KDData( x:Number, y:Number, z:Number = 0 )
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public function getDistanceToData( data:KDData ):Number
		{
			return getEuclideanDistance( data, this );
		}

		public function toString():String
		{
			return "[KDData x:" + x + ", y:" + y + ", z:" + z + "]";
		}
	}
}

