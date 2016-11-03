package tests.ds
{
	import com.ar.ds.stack.IStack;
	import com.ar.ds.stack.LinkedStack;
	import com.ar.ds.stack.VStack;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionStack
	{
		public function TestCollectionStack()
		{
		}

		[Test(description="")]
		public function testLinkedImplementation():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var stack:IStack = new LinkedStack();

			Assert.assertEquals( 0, stack.getSize() );

			stack.push( a );
			stack.push( b );
			stack.push( c );

			Assert.assertEquals( 3, stack.getSize() );

			Assert.assertEquals( c, stack.top() );

			Assert.assertEquals( c, stack.pop() );
			Assert.assertEquals( b, stack.pop() );
			Assert.assertEquals( a, stack.pop() );

			Assert.assertEquals( 0, stack.getSize() );

			Assert.assertEquals( true, stack.isEmpty() );
			stack.push( a );
			stack.push( b );
			stack.push( c );
			Assert.assertEquals( false, stack.isEmpty() );

			stack.empty();
			Assert.assertEquals( true, stack.isEmpty() );
		}

		[Test(description="")]
		public function testVImplementation():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var stack:IStack = new VStack();

			Assert.assertEquals( 0, stack.getSize() );

			stack.push( a );
			stack.push( b );
			stack.push( c );

			Assert.assertEquals( 3, stack.getSize() );

			Assert.assertEquals( c, stack.top() );

			Assert.assertEquals( c, stack.pop() );
			Assert.assertEquals( b, stack.pop() );
			Assert.assertEquals( a, stack.pop() );

			Assert.assertEquals( 0, stack.getSize() );

			Assert.assertEquals( true, stack.isEmpty() );
			stack.push( a );
			stack.push( b );
			stack.push( c );
			Assert.assertEquals( false, stack.isEmpty() );

			stack.empty();
			Assert.assertEquals( true, stack.isEmpty() );
		}

		public function toString():String
		{
			return "[TestCollectionStack]";
		}
	}
}