package com.ei.display.decor
{
	public class DimensionInfo
	{
		//-----------------------------------------------------------
		// 
		// Private Variable
		//
		//-----------------------------------------------------------
		
		private var _pAlign:String;
		private var _pDem:String;
		
		private var _oAlign:String;
		private var _oDem:String;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function DimensionInfo(policy:String)
		{
			if(policy == AlignPolicy.HORIZONTAL)
			{
				_pAlign = "x";
				_pDem   = "width";
				
				_oAlign = "y";
				_oDem   = "height";
			}
			else
			{
				_pAlign = "y";
				_pDem   = "height";
				
				_oAlign = "x";
				_oDem   = "width";
			}
			
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function get positivePosition():String
		{
			return _pAlign;
		}
		
		
		/**
		 */
		 
		public function get negativePosition():String
		{
			return _oAlign;
		}
		
		
		/**
		 */
		 
		public function get positiveDimension():String
		{
			return _pDem;
		}
		
		
		/**
		 */
		
		public function get negativeDimension():String
		{
			return _oDem;
		}
	}
}