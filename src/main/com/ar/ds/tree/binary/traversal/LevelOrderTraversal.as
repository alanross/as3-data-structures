package com.ar.ds.tree.binary.traversal
{
	import com.ar.ds.list.IList;
	import com.ar.ds.list.LinkedList;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * Traverse all nodes of level, then all of next.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class LevelOrderTraversal implements IBinaryTreeTraversal
	{
		private var _result:Array;

		/**
		 * Creates a new instance of LevelOrderTraversal.
		 */
		public function LevelOrderTraversal()
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
			if( node == null )
			{
				return;
			}

			var tmp:BinaryNode;

			var list:IList = new LinkedList();

			list.addLast( node );

			while( list.getSize() > 0 )
			{
				// check this
				tmp = BinaryNode( list.removeFirst() );

				_result.push( tmp.data );

				if( tmp.left != null )
				{
					list.addLast( tmp.left );
				}
				if( tmp.right != null )
				{
					list.addLast( tmp.right );
				}
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
		 * Creates and returns a string representation of the LevelOrderTraversal object.
		 */
		public function toString():String
		{
			return "[LevelOrderTraversal]";
		}
	}
}