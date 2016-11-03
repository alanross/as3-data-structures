package tests.ds
{
	import com.ar.ds.list.IList;
	import com.ar.ds.list.LinkedList;
	import com.ar.ds.list.iterator.IListIterator;
	import com.ar.ds.list.iterator.ListIterator;

	import org.flexunit.Assert;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class TestCollectionLinkedList
	{
		public function TestCollectionLinkedList()
		{
		}

		[Test(description="")]
		public function testFirst():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			list.addFirst( c );
			list.addFirst( b );
			list.addFirst( a );

			Assert.assertEquals( a, list.getAt( 0 ) );
			Assert.assertEquals( b, list.getAt( 1 ) );
			Assert.assertEquals( c, list.getAt( 2 ) );
			Assert.assertEquals( 3, list.getSize() );

			Assert.assertEquals( a, list.removeFirst() );
			Assert.assertEquals( b, list.removeFirst() );
			Assert.assertEquals( c, list.removeFirst() );
			Assert.assertEquals( 0, list.getSize() );
		}

		[Test(description="")]
		public function testLast():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			list.addLast( a );
			list.addLast( b );
			list.addLast( c );

			Assert.assertEquals( a, list.getAt( 0 ) );
			Assert.assertEquals( b, list.getAt( 1 ) );
			Assert.assertEquals( c, list.getAt( 2 ) );
			Assert.assertEquals( 3, list.getSize() );

			Assert.assertEquals( c, list.removeLast() );
			Assert.assertEquals( b, list.removeLast() );
			Assert.assertEquals( a, list.removeLast() );
			Assert.assertEquals( 0, list.getSize() );
		}

		[Test(description="")]
		public function testInsertAfter():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			list.addFirst( a );
			list.insertAfter( b, a );
			list.insertAfter( c, b );

			Assert.assertEquals( a, list.getAt( 0 ) );
			Assert.assertEquals( b, list.getAt( 1 ) );
			Assert.assertEquals( c, list.getAt( 2 ) );
			Assert.assertEquals( 3, list.getSize() );
		}

		[Test(description="")]
		public function testInsertBefore():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			list.addFirst( c );
			list.insertBefore( b, c );
			list.insertBefore( a, b );

			Assert.assertEquals( a, list.getAt( 0 ) );
			Assert.assertEquals( b, list.getAt( 1 ) );
			Assert.assertEquals( c, list.getAt( 2 ) );
			Assert.assertEquals( 3, list.getSize() );
		}

		[Test(description="")]
		public function testRemove():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			list.addFirst( c );
			list.addFirst( b );
			list.addFirst( a );

			Assert.assertEquals( 3, list.getSize() );
			Assert.assertEquals( a, list.remove( a ) );
			Assert.assertEquals( b, list.remove( b ) );
			Assert.assertEquals( c, list.remove( c ) );
			Assert.assertEquals( 0, list.getSize() );
		}

		[Test(description="")]
		public function testContains():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			Assert.assertNull( list.contains( a ) );

			list.addFirst( a );
			Assert.assertNotNull( list.contains( a ) );

			list.addFirst( b );
			list.addFirst( c );
			Assert.assertNotNull( list.contains( a ) );

			list.remove( a );
			Assert.assertNull( list.contains( a ) );
		}

		[Test(description="")]
		public function testGetSize():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			Assert.assertEquals( 0, list.getSize() );

			list.addFirst( a );
			list.addFirst( b );
			list.addFirst( c );
			Assert.assertEquals( 3, list.getSize() );

			list.remove( c );
			Assert.assertEquals( 2, list.getSize() );

			list.remove( b );
			list.remove( a );
			Assert.assertEquals( 0, list.getSize() );

			list.addFirst( a );
			list.addFirst( b );
			list.addFirst( c );
			Assert.assertEquals( 3, list.getSize() );

			list.empty();
			Assert.assertEquals( 0, list.getSize() );
		}

		[Test(description="")]
		public function testIsEmpty():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			Assert.assertEquals( true, list.isEmpty() );

			list.addFirst( a );
			Assert.assertEquals( false, list.isEmpty() );

			list.remove( a );
			Assert.assertEquals( true, list.isEmpty() );

			list.addFirst( c );
			list.addFirst( b );
			list.addFirst( a );
			Assert.assertEquals( false, list.isEmpty() );

			list.empty();
			Assert.assertEquals( true, list.isEmpty() );
		}

		[Test(description="")]
		public function testIterate():void
		{
			var a:String = "a";
			var b:String = "b";
			var c:String = "c";

			var list:IList = new LinkedList();

			var iterator:IListIterator = new ListIterator( list );

			list.addLast( a );
			list.addLast( b );
			list.addLast( c );

			var expected:Array = [a, b, c];
			var i:int = 0;

			while( iterator.hasNext() )
			{
				Assert.assertEquals( expected[i++], iterator.getNext() );
			}
		}

		public function toString():String
		{
			return "[TestCollectionLinkedList]";
		}
	}
}