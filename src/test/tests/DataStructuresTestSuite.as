package tests
{
	import tests.ds.TestCollectionBinaryTree;
	import tests.ds.TestCollectionDateComparator;
	import tests.ds.TestCollectionLinkedList;
	import tests.ds.TestCollectionNumericComparator;
	import tests.ds.TestCollectionQuadTree;
	import tests.ds.TestCollectionQueue;
	import tests.ds.TestCollectionStack;
	import tests.ds.TestCollectionStringComparator;
	import tests.ds.TestCollectionTrieTree;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public final class DataStructuresTestSuite
	{
		// collection
		public var tc01:TestCollectionDateComparator;
		public var tc02:TestCollectionNumericComparator;
		public var tc03:TestCollectionStringComparator;
		public var tc04:TestCollectionLinkedList;
		public var tc05:TestCollectionQueue;
		public var tc06:TestCollectionStack;
		public var tc07:TestCollectionBinaryTree;
		public var tc08:TestCollectionQuadTree;
		public var tc09:TestCollectionTrieTree;
	}
}