package tests.ds
{
	import com.ar.ds.tree.quad.QuadTree;
	import com.ar.ds.tree.quad.QuadNode;

	import flash.geom.Rectangle;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionQuadTree
	{
		private const pointCount:int = 4;
		private const spacing:int = 10;

		private var _tree:QuadTree;
		private var _points:Vector.<QuadNode>;


		public function TestCollectionQuadTree()
		{
		}

		[Before]
		public function createTree():void
		{
			_tree = new QuadTree();

			_points = new Vector.<QuadNode>( pointCount * pointCount, true );

			var index:int = 0;

			// insert N random points in the unit square
			for( var i:int = 0; i < pointCount; ++i )
			{
				for( var e:int = 0; e < pointCount; ++e )
				{
					var x:int = e * spacing;
					var y:int = i * spacing;
					var data:String = "point" + index;

					_tree.add( x, y, data );
					_points[index++] = new QuadNode( x, y, data );
				}
			}
		}

		[Test(description="")]
		public function testSearchSinglePoint():void
		{
			var index:int = 0;

			for( var i:int = 0; i < pointCount; ++i )
			{
				for( var e:int = 0; e < pointCount; ++e )
				{
					var x:int = e * spacing;
					var y:int = i * spacing;

					var rect:Rectangle = new Rectangle( x, y, spacing, spacing );

					// this query must return an array with only one item.
					var result:String = _tree.searchInRange( rect )[0];
					var expected:String = String( _points[index++].data );

					Assert.assertEquals( expected, result );
				}
			}
		}

		[Test(description="")]
		public function testSearchRowRows():void
		{
			for( var i:int = 0; i < pointCount; ++i )
			{
				var rect:Rectangle = new Rectangle( 0, i * spacing, pointCount * spacing, spacing );
				var result:Array = _tree.searchInRange( rect );

				Assert.assertEquals( pointCount, result.length );

				for( var e:int = 0; e < result.length; ++e )
				{
					Assert.assertEquals( _points[i * pointCount + e].data, result[e] );
				}
			}
		}

		[Test(description="")]
		public function testSearchCols():void
		{
			for( var i:int = 0; i < pointCount; ++i )
			{
				var rect:Rectangle = new Rectangle( i * spacing, 0, spacing, pointCount * spacing );
				var result:Array = _tree.searchInRange( rect );

				Assert.assertEquals( pointCount, result.length );

				for( var e:int = 0; e < result.length; ++e )
				{
					Assert.assertEquals( _points[(e * pointCount) + i].data, result[e] );
				}
			}
		}

		[Test(description="")]
		public function testOutside():void
		{
			var rect:Rectangle = new Rectangle( -10, -10, 10, 10 );
			var result:Array = _tree.searchInRange( rect );

			Assert.assertEquals( 0, result.length );
		}

		public function toString():String
		{
			return "[TestCollectionQuadTree]";
		}
	}
}