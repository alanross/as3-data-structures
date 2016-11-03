package tests.ds
{
	import com.ar.core.log.Log;
	import com.ar.core.utils.StringUtils;
	import com.ar.ds.tree.trie.TrieTree;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionTrieTree
	{
		public function TestCollectionTrieTree()
		{
		}

		[BeforeClass]
		public static function setupRequirements():void
		{
			// the trie tree makes use of the log class for warnings etc.
			Log.initialize();
		}

		[Test(description="")]
		public function testBuild():void
		{
			//contains a duplicate
			var words:Vector.<String> = StringUtils.stringTokensToVector( "house,mouse,hou,se,doing,towing,house" );

			var tree:TrieTree = new TrieTree();
			tree.build( words );

			Assert.assertEquals( 6, tree.getSize() );
		}

		[Test(description="")]
		public function testInsert():void
		{
			var tree:TrieTree = new TrieTree();
			Assert.assertEquals( 0, tree.getSize() );

			tree.insert( "a" );
			Assert.assertEquals( 1, tree.getSize() );

			tree.insert( "b" );
			Assert.assertEquals( 2, tree.getSize() );

			tree.insert( "aa" );
			Assert.assertEquals( 3, tree.getSize() );

			tree.insert( "ab" );
			Assert.assertEquals( 4, tree.getSize() );

			tree.insert( "aa" ); // duplicates must be ignored
			Assert.assertEquals( 4, tree.getSize() );
		}

		[Test(description="")]
		public function testList():void
		{
			var words:Vector.<String> = StringUtils.stringTokensToVector( "a,aa,ab,abc,d,e,fg,g" );
			var expected:Vector.<String> = StringUtils.stringTokensToVector( "a,aa,ab,abc,d,e,fg,g" );

			var tree:TrieTree = new TrieTree();

			tree.build( words );
			tree.insert( "a" ); //duplicate
			tree.insert( "fg" ); //duplicate

			var result:Vector.<String> = tree.list();

			matchLists( expected, result );
		}

		[Test(description="")]
		public function testEmpty():void
		{
			var words:Vector.<String> = StringUtils.stringTokensToVector( "a,b" );
			var tree:TrieTree = new TrieTree();
			Assert.assertEquals( true, tree.isEmpty() );

			tree.insert( "a" );
			Assert.assertEquals( false, tree.isEmpty() );

			tree.empty();
			Assert.assertEquals( true, tree.isEmpty() );

			tree.build( words );
			Assert.assertEquals( false, tree.isEmpty() );
		}

		[Test(description="")]
		public function testGetSize():void
		{
			var words:Vector.<String> = StringUtils.stringTokensToVector( "a,b" );
			var tree:TrieTree = new TrieTree();

			Assert.assertEquals( 0, tree.getSize() );

			tree.insert( "a" );
			Assert.assertEquals( 1, tree.getSize() );

			tree.insert( "ab" );
			Assert.assertEquals( 2, tree.getSize() );

			//must ignore duplicates
			tree.insert( "a" );
			Assert.assertEquals( 2, tree.getSize() );

			tree.empty();
			Assert.assertEquals( 0, tree.getSize() );

			tree.build( words );
			Assert.assertEquals( 2, tree.getSize() );
		}

		[Test(description="")]
		public function testHasWord():void
		{
			var words:Vector.<String> = StringUtils.stringTokensToVector( "he,hey,hell,hello,house,mouse,spouse" );
			var prefix:Vector.<String> = StringUtils.stringTokensToVector( "h,he,hell" );
			var negatives:Vector.<String> = StringUtils.stringTokensToVector( ",test,negative" );
			var n:int;

			var tree:TrieTree = new TrieTree();
			tree.build( words );

			n = words.length;

			while( --n > -1 )
			{
				Assert.assertEquals( true, tree.has( words[n] ) );
			}

			n = prefix.length;

			while( --n > -1 )
			{
				Assert.assertEquals( true, tree.has( prefix[n] ) );
			}

			n = negatives.length;

			while( --n > -1 )
			{
				Assert.assertEquals( false, tree.has( negatives[n] ) );
			}

			Assert.assertEquals( false, tree.has( "" ) );
		}

		[Test(description="")]
		public function testSearchWords():void
		{
			var words:Vector.<String> = StringUtils.stringTokensToVector( "he,hey,hell,hello,house,mouse,spouse" );

			var tree:TrieTree = new TrieTree();
			tree.build( words );

			var result:Vector.<String>;
			var expected:Vector.<String>;

			//find all words with prefix h
			result = tree.find( "h" );
			expected = StringUtils.stringTokensToVector( "he,hey,hell,hello,house" );

			matchLists( expected, result );

			//find all words with prefix mo
			result = tree.find( "mo" );
			expected = StringUtils.stringTokensToVector( "mouse" );

			matchLists( expected, result );

			//find all words with prefix test
			result = tree.find( "test" );
			Assert.assertEquals( 0, result.length ); // should not find any
		}

		private function matchLists( haystack:Vector.<String>, needles:Vector.<String> ):void
		{
			Assert.assertEquals( true, (haystack.length == needles.length ) );

			var ni:int = needles.length;
			var needle:String;

			var hi:int;

			while( --ni > -1 )
			{
				needle = needles[ni];

				hi = haystack.length;

				while( --hi > -1 )
				{
					if( haystack[hi] == needle )
					{
						haystack.splice( hi, 1 );

						break;
					}
				}
			}

			Assert.assertEquals( 0, haystack.length ); // found all prefixes
		}

		public function toString():String
		{
			return "[TestCollectionTrieTree]";
		}
	}
}