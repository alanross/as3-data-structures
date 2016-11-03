package tests.ds
{
	import com.ar.ds.compare.NumericComparator;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionNumericComparator
	{
		public function TestCollectionNumericComparator()
		{
		}

		[Test(description="")]
		public function test():void
		{
			var c:NumericComparator = new NumericComparator();

			Assert.assertEquals( 0, c.compare( 1, 1 ) );
			Assert.assertEquals( 0, c.compare( -1, -1 ) );
			Assert.assertEquals( 0, c.compare( 0, 0 ) );

			Assert.assertEquals( 0, c.compare( 1.1, 1.1 ) );
			Assert.assertEquals( 0, c.compare( -1.1, -1.1 ) );
			Assert.assertEquals( 0, c.compare( 0.1, 0.1 ) );

			Assert.assertEquals( 0, c.compare( int.MAX_VALUE, int.MAX_VALUE ) );
			Assert.assertEquals( 0, c.compare( int.MIN_VALUE, int.MIN_VALUE ) );

			Assert.assertEquals( -1, c.compare( -1.0, 1.0 ) );
			Assert.assertEquals( 1, c.compare( 1.0, -1.0 ) );

			Assert.assertEquals( 0, c.compare( NaN, NaN ) );
			Assert.assertEquals( 1, c.compare( NaN, 0.0 ) );
			Assert.assertEquals( -1, c.compare( 0.0, NaN ) );
		}

		public function toString():String
		{
			return "[TestCollectionNumericComparator]";
		}
	}
}