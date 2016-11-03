package com.ar.ds.tree.binary.traversal
{
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * Children are traversed before their respective parents are traversed.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class PostOrderTraversal implements IBinaryTreeTraversal
	{
		private var _result:Array;

		/**
		 * Creates a new instance of PostOrderTraversal.
		 */
		public function PostOrderTraversal()
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

				traverse( node.right );

				_result.push( node.data );
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
		 * Creates and returns a string representation of the PostOrderTraversal object.
		 */
		public function toString():String
		{
			return "[PostOrderTraversal]";
		}
	}
}