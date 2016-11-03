package com.ar.ds.list
{
	import com.ar.core.utils.IDisposable;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class ListNode implements IDisposable
	{
		// Reference to next node linked to this node
		internal var next:ListNode;

		// Reference to previous node linked to this node
		internal var prev:ListNode;

		// Payload of the node
		public var data:Object;

		/**
		 * Creates a new instance of ListNode.
		 */
		public function ListNode( data:Object = null ):void
		{
			this.data = data;
		}

		/**
		 * Frees all internal references of the object.
		 */
		public function dispose():void
		{
			prev = null;
			next = null;
			data = null;
		}

		/**
		 * Creates and returns a string representation of the ListNode object.
		 */
		public function toString():String
		{
			return "[ListNode data:" + data + "]";
		}
	}
}