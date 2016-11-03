package tests.ds
{
	import com.ar.ds.queue.IQueue;
	import com.ar.ds.queue.LinkedQueue;
	import com.ar.ds.queue.VQueue;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionQueue
	{
		public function TestCollectionQueue()
		{
		}

		[Test(description="")]
		public function testLinkedImplementation():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var queue:IQueue = new LinkedQueue();

			Assert.assertEquals( 0, queue.getSize() );

			queue.enqueue( a );
			queue.enqueue( b );
			queue.enqueue( c );

			Assert.assertEquals( 3, queue.getSize() );

			Assert.assertEquals( a, queue.getFirst() );

			Assert.assertEquals( a, queue.dequeue() );
			Assert.assertEquals( b, queue.dequeue() );
			Assert.assertEquals( c, queue.dequeue() );

			Assert.assertEquals( 0, queue.getSize() );

			Assert.assertEquals( true, queue.isEmpty() );
			queue.enqueue( a );
			queue.enqueue( b );
			queue.enqueue( c );
			Assert.assertEquals( false, queue.isEmpty() );

			queue.empty();
			Assert.assertEquals( true, queue.isEmpty() );
		}

		[Test(description="")]
		public function testVImplementation():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var queue:IQueue = new VQueue();

			Assert.assertEquals( 0, queue.getSize() );

			queue.enqueue( a );
			queue.enqueue( b );
			queue.enqueue( c );

			Assert.assertEquals( 3, queue.getSize() );

			Assert.assertEquals( a, queue.getFirst() );

			Assert.assertEquals( a, queue.dequeue() );
			Assert.assertEquals( b, queue.dequeue() );
			Assert.assertEquals( c, queue.dequeue() );

			Assert.assertEquals( 0, queue.getSize() );

			Assert.assertEquals( true, queue.isEmpty() );
			queue.enqueue( a );
			queue.enqueue( b );
			queue.enqueue( c );
			Assert.assertEquals( false, queue.isEmpty() );

			queue.empty();
			Assert.assertEquals( true, queue.isEmpty() );
		}

		public function toString():String
		{
			return "[TestCollectionQueue]";
		}
	}
}