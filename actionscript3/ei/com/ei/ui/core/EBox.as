package com.ei.ui.core
{

	import com.ei.display.decor.IBox;
	import com.ei.display.decor.Box;
	
	public class EBox extends EContainer implements IBox
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
		 
		public function EBox(align:String)
		{
			super();
			//_box = new Box(content,align);
		}
		
		//-----------------------------------------------------------
		// 9
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