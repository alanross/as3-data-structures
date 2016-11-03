package tests.ds
{
	import com.ar.ds.compare.DateComparator;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionDateComparator
	{
		public function TestCollectionDateComparator()
		{
		}

		[Test(description="")]
		public function test():void
		{
			var c:DateComparator = new DateComparator();

			var d1:Date = new Date( 1970, 0, 1 );
			var d2:Date = new Date( 1970, 0, 2 );

			Assert.assertEquals( 0, c.compare( d1, d1 ) );
			Assert.assertEquals( -1, c.compare( d1, d2 ) );
			Assert.assertEquals( 1, c.compare( d2, d1 ) );

			Assert.assertEquals( 0, c.compare( null, null ) );
			Assert.assertEquals( 1, c.compare( null, d1 ) );
			Assert.assertEquals( -1, c.compare( d1, null ) );
		}

		public function toString():String
		{
			return "[TestCollectionDateComparator]";
		}
	}
}