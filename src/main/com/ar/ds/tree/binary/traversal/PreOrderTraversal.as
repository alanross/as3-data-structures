package com.ar.ds.tree.binary.traversal
{
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * Each parent node is traversed before its children is called.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class PreOrderTraversal implements IBinaryTreeTraversal
	{
		private var _result:Array;

		/**
		 * Creates a new instance of PreOrderTraversal.
		 */
		public function PreOrderTraversal()
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
				_result.push( node.data );

				traverse( node.left );

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
		 * Creates and returns a string representation of the PreOrderTraversal object.
		 */
		public function toString():String
		{
			return "[PreOrderTraversal]";
		}
	}
}