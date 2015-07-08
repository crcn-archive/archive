package com.ei.display
{
	import com.ei.utils.style.CSSManager;
	import com.ei.utils.style.StyleImp;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class StyleableDisplayObject extends Sprite implements IStyleableDisplayObject
	{
		
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _currentStyle:String;
		private var _target:DisplayObject;
		private var _imp:StyleImp;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function StyleableDisplayObject(target:DisplayObject)
		{
			_imp = new StyleImp(target);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function get styleName():String
		{
			return _currentStyle;
		}
		
		/**
		 */
		
		public function set styleName(newStyle:String):void
		{
			try
			{
				_imp.style = CSSManager.styleSheet[ newStyle ];
				_currentStyle = newStyle;
			}catch(e:*)
			{
				trace(e);
			}
		}
		
		/**
		 */
		 
		public function get implementor():StyleImp
		{
			return _imp;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function setProperty(name:*,value:*):void
		{
			_imp.setProperty(name,value);
		}
		
	}
}