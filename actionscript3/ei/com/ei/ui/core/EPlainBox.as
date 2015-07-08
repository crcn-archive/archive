package com.ei.ui.core
{
	
	//hackish, fix container so the mask will not show if the width is not defined
	
	import com.ei.display.decor.Box;
	import com.ei.display.decor.IBox;
	
	public class EPlainBox extends EUIComponent implements IBox
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _box:Box;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function EPlainBox(align:String)
		{
			super();
			_box = new Box(this,align);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		override public function get alignment():String
		{
			return _box.alignment;
		}
		
		override public function set alignment(align:String):void
		{
			_box.alignment = align;
		}
		
		
		/**
		 */
		 
		public function set margin(value:Number):void
		{
			_box.margin = value;
		}
		
		public function get margin():Number
		{
			return _box.margin;
		}
		
		
		/**
		 */
		
		public function set shrinking(value:Number):void
		{
			_box.shrinking = value;
		}
		
		public function get shrinking():Number
		{
			return _box.shrinking;
		}
		
	}
}