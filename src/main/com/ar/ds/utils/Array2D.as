package com.ar.ds.utils
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class Array2D
	{
		private var _grid:Array;
		private var _rows:int;
		private var _cols:int;

		/**
		 * Creates a new instance of Array2D.
		 */
		public function Array2D( numCols:int, numRows:int )
		{
			_cols = numCols;
			_rows = numRows;
			_grid = new Array( _cols * _rows );
		}

		/**
		 * Resets the complete 2DArray to a given value.
		 */
		public function reset( val:* ):void
		{
			var n:int = _cols * _rows;

			for( var i:int = 0; i < n; ++i )
			{
				_grid[ i ] = val;
			}
		}

		/**
		 * Returns the value at given position.
		 */
		public function getValue( x:int, y:int ):*
		{
			return _grid[ y * _cols + x ];
		}

		/**
		 * Sets the value at given position.
		 */
		public function setValue( x:int, y:int, val:* ):void
		{
			_grid[ y * _cols + x ] = val;
		}

		/**
		 * Returns a string representation of the 2d array.
		 */
		public function print( sep:String = "," ):String
		{
			var info:String = "";
			var sep:String = ",";
			var l:int = sep.length;

			for( var y:int = 0; y < _rows; ++y )
			{
				info += "[";

				for( var x:int = 0; x < _cols; ++x )
				{
					info += _grid[ y * _cols + x ] + sep;
				}

				info = info.substring( 0, info.length - l ) + "]\n";
			}

			return info;
		}

		/**
		 * Number of rows.
		 */
		public function get rows():int
		{
			return _rows;
		}

		/**
		 * Number of columns.
		 */
		public function get cols():int
		{
			return _cols;
		}

		/**
		 * Generates and returns the string representation of the Array2D object.
		 */
		public function toString():String
		{
			return "[Array2D cols:" + _cols + ", rows:" + _rows + ", length:" + _grid.length + "]";
		}
	}
}