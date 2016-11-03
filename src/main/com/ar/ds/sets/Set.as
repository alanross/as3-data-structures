package com.ar.ds.sets
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Set
	{
		/**
		 * Creates a new instance of Set.
		 */
		public function Set()
		{
		}

		/**
		 * If there are n objects than all 2^n subsets can be determined by
		 * iterating from 0 to 2*n and in each iteration by selecting the
		 * elements at the position having set bit in the counter. Like for given ex
		 * 111--{1,2,3}
		 * 110--{2,3}
		 * 101--{1,3}
		 * 100--{3}
		 * 011--{2,3}
		 * 010--{2}
		 * 001--{1}
		 * 000--{}
		 */
		public function getSubsets( input:Vector.<Object> ):Vector.<Object>
		{
			var n:int = input.length;
			var currentSubset:int = Math.pow( 2.0, n ) - 1; //2^n -1 to remove empty set
			var tmp:int;

			var result:Vector.<Object> = new Vector.<Object>();

			while( currentSubset > 0 )
			{
				tmp = currentSubset;

				var subset:Vector.<Object> = new Vector.<Object>();

				for( var i:int = 0; i < n; ++i )
				{
					if( ( tmp & 1 ) != 0 )
					{
						subset.push( input[i] );
					}

					tmp >>= 1;
				}

				result.push( subset );

				currentSubset--;
			}

			return result;
		}

		/**
		 * Creates and returns a string representation of the Set object.
		 */
		public function toString():String
		{
			return "[Set]";
		}
	}
}
