package com.ar.ds.tree.binary.traversal
{
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * Traverse the node's left subtree, then the node itself,
	 * and then its right subtree.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class InOrderTraversal implements IBinaryTreeTraversal
	{
		private var _result:Array;

		/**
		 * Creates a new instance of InOrderTraversal.
		 */
		public function InOrderTraversal()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function process( node:BinaryNode ):Array
		{
			_result = new Array;

			traverse( node );

			return _result;
		}

		/**
		 * @private
		 */
		private function traverse( node:BinaryNode ):void
		{
			if( node != null )
			{
				traverse( node.left );

				_result.push( node.data );

				traverse( node.right );
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			_result = null;
		}

		/**
		 * Creates and returns a string representation of the InOrderTraversal object.
		 */
		public function toString():String
		{
			return "[InOrderTraversal]";
		}
	}
}