package tests.ds
{
	import com.ar.core.utils.ArrayUtils;
	import com.ar.ds.compare.NumericComparator;
	import com.ar.ds.tree.binary.BinaryTree;
	import com.ar.ds.tree.binary.search.BreadthFirstSearch;
	import com.ar.ds.tree.binary.search.DepthFirstSearch;
	import com.ar.ds.tree.binary.traversal.InOrderTraversal;
	import com.ar.ds.tree.binary.traversal.LevelOrderTraversal;
	import com.ar.ds.tree.binary.traversal.PostOrderTraversal;
	import com.ar.ds.tree.binary.traversal.PreOrderTraversal;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionBinaryTree
	{
		private var _tree:BinaryTree;

		public function TestCollectionBinaryTree()
		{
		}

		[Before]
		public function createTree():void
		{
			//      5
			//   3-| |-6
			//2-| |-4  |-7
			//           |-8

			_tree = new BinaryTree( new NumericComparator() );
			_tree.add( 5 );
			_tree.add( 3 );
			_tree.add( 2 );
			_tree.add( 4 );
			_tree.add( 6 );
			_tree.add( 7 );
			_tree.add( 8 );
		}

		[Test(description="")]
		public function testPreOrderTraversal():void
		{
			var expected:Array = [5, 3, 2, 4, 6, 7, 8];
			var result: Array = _tree.traverse( new PreOrderTraversal() );

			Assert.assertEquals( true, ArrayUtils.isEqual( expected, result ) );
		}

		[Test(description="")]
		public function testInOrderTraversal():void
		{
			var expected:Array = [2, 3, 4, 5, 6, 7, 8];
			var result: Array = _tree.traverse( new InOrderTraversal() );

			Assert.assertEquals( true, ArrayUtils.isEqual( expected, result ) );
		}

		[Test(description="")]
		public function testPostOrderTraversal():void
		{
			var expected:Array = [2, 4, 3, 8, 7, 6, 5];
			var result: Array = _tree.traverse( new PostOrderTraversal() );

			Assert.assertEquals( true, ArrayUtils.isEqual( expected, result ) );
		}

		[Test(description="")]
		public function testLevelOrderTraversal():void
		{
			var expected:Array = [5, 3, 6, 2, 4, 7, 8];
			var result: Array = _tree.traverse( new LevelOrderTraversal() );

			Assert.assertEquals( true, ArrayUtils.isEqual( expected, result ) );
		}

		[Test(description="")]
		public function testGetSize():void
		{
			Assert.assertEquals( 7, _tree.getSize() );
		}

		[Test(description="")]
		public function testGetNodeDepth():void
		{
			Assert.assertEquals( 0, _tree.getNodeDepth( 5 ) );
			Assert.assertEquals( 1, _tree.getNodeDepth( 3 ) );
			Assert.assertEquals( 1, _tree.getNodeDepth( 6 ) );
			Assert.assertEquals( 2, _tree.getNodeDepth( 2 ) );
			Assert.assertEquals( 2, _tree.getNodeDepth( 4 ) );
			Assert.assertEquals( 2, _tree.getNodeDepth( 7 ) );
			Assert.assertEquals( 3, _tree.getNodeDepth( 8 ) );
		}

		[Test(description="")]
		public function testBFS():void
		{
			var bfs:BreadthFirstSearch = new BreadthFirstSearch();

			Assert.assertEquals( true, _tree.contains( bfs, 5 ) );
			Assert.assertEquals( true, _tree.contains( bfs, 3 ) );
			Assert.assertEquals( true, _tree.contains( bfs, 6 ) );
			Assert.assertEquals( true, _tree.contains( bfs, 2 ) );
			Assert.assertEquals( true, _tree.contains( bfs, 4 ) );
			Assert.assertEquals( true, _tree.contains( bfs, 7 ) );
			Assert.assertEquals( true, _tree.contains( bfs, 8 ) );

			Assert.assertEquals( false, _tree.contains( bfs, NaN ) );
			Assert.assertEquals( false, _tree.contains( bfs, 19 ) );
		}

		[Test(description="")]
		public function testDFS():void
		{
			var dfs:DepthFirstSearch = new DepthFirstSearch();

			Assert.assertEquals( true, _tree.contains( dfs, 5 ) );
			Assert.assertEquals( true, _tree.contains( dfs, 3 ) );
			Assert.assertEquals( true, _tree.contains( dfs, 6 ) );
			Assert.assertEquals( true, _tree.contains( dfs, 2 ) );
			Assert.assertEquals( true, _tree.contains( dfs, 4 ) );
			Assert.assertEquals( true, _tree.contains( dfs, 7 ) );
			Assert.assertEquals( true, _tree.contains( dfs, 8 ) );

			Assert.assertEquals( false, _tree.contains( dfs, NaN ) );
			Assert.assertEquals( false, _tree.contains( dfs, 19 ) );
		}

		public function toString():String
		{
			return "[TestCollectionBinaryTree]";
		}
	}
}