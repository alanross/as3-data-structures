package com.ar.ds.tree.binary.traversal
{
	import com.ar.core.utils.IDisposable;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IBinaryTreeTraversal extends IDisposable
	{
		/**
		 * traverse the tree in order of concrete implementation.
		 */
		function process( node:BinaryNode ):Array;
	}
}