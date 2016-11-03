package com.ar.ds.tree.kd
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class KDTreePrinter
	{
		public function KDTreePrinter()
		{
		}

		public static function getString( tree:KDTree ):String
		{
			if( tree.root == null )
			{
				return "Tree has no nodes.";
			}

			return internalGetString( tree.root, "", true );
		}

		private static function internalGetString( node:KDNode, prefix:String, isTail:Boolean ):String
		{
			var result:String = '';

			if( node == null )
			{
				return result;
			}

			if( node.parent != null )
			{
				var side:String = "left";

				if( node.parent.greater != null && node.equalsData( node.parent.greater.data ) )
				{
					side = "right";
				}

				result += (prefix + (isTail ? "└── " : "├── ") + "[" + side + "] " + "depth=" + node.depth + " id=" + node.data + "\n");

			}
			else
			{
				result += (prefix + (isTail ? "└── " : "├── ") + "depth=" + node.depth + " id=" + node.data + "\n");
			}

			var children:Vector.<KDNode> = null;

			if( node.lesser != null || node.greater != null )
			{
				children = new Vector.<KDNode>( 2 );

				if( node.lesser != null )
				{
					children.push( node.lesser );
				}
				if( node.greater != null )
				{
					children.push( node.greater );
				}
			}
			if( children != null )
			{
				for( var i:int = 0; i < children.length - 1; i++ )
				{
					result += ( internalGetString( children[i], prefix + (isTail ? "    " : "│   "), false ) );
				}
				if( children.length >= 1 )
				{
					result += ( internalGetString( children[children.length - 1], prefix + (isTail ? "    " : "│   "), true ) );
				}
			}

			return result;
		}

		public function toString():String
		{
			return "[TreePrinter]";
		}
	}
}