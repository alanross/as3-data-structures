package com.ar.ds.tree.binary.search
{
	import com.ar.ds.compare.IComparator;
	import com.ar.ds.tree.binary.BinaryNode;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IBinaryTreeSearch
	{
		/**
		 * Conduct a binary tree search.
		 */
		function process( root:BinaryNode, key:*, comparator:IComparator ):Boolean;
	}
}