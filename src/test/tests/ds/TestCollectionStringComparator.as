package tests.ds
{
	import com.ar.ds.compare.StringComparator;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionStringComparator
	{
		public function TestCollectionStringComparator()
		{
		}

		[Test(description="")]
		public function test():void
		{
			var c:StringComparator = new StringComparator();

			c.caseInsensitive = true;

			Assert.assertEquals( 0, c.compare( "", "" ) );
			Assert.assertEquals( 0, c.compare( "a", "a" ) );
			Assert.assertEquals( 0, c.compare( "ab", "ab" ) );
			Assert.assertEquals( 0, c.compare( "AB", "AB" ) );
			Assert.assertEquals( 0, c.compare( "A", "a" ) );
			Assert.assertEquals( 0, c.compare( "a", "A" ) );

			c.caseInsensitive = false;

			Assert.assertEquals( 0, c.compare( "ab", "ab" ) );
			Assert.assertEquals( 0, c.compare( "AB", "AB" ) );
			Assert.assertEquals( -1, c.compare( "A", "a" ) );
			Assert.assertEquals( 1, c.compare( "a", "A" ) );

			Assert.assertEquals( -1, c.compare( "", "a" ) );

			Assert.assertEquals( 0, c.compare( null, null ) );
			Assert.assertEquals( 1, c.compare( null, "a" ) );
			Assert.assertEquals( -1, c.compare( "a", null ) );
		}

		public function toString():String
		{
			return "[TestCollectionStringComparator]";
		}
	}
}