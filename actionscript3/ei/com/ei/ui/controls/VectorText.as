
/******************************************************************
 * DisplayText - renders text as a bitmap so other properties can 
 * be used on it														
 *  
 * Author: Craig Condon
 * 
 * Purpose: so the other properties canbe used such as alpha, and
 * because when button mode is on Sprites, the arrow shows on the 
 * text
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/
package com.ei.ui.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class VectorText extends Sprite
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _text:String;
		private var _doo:Boolean;
		private var _width:Number;
		private var _height:Number;
		private var _bitmap:Bitmap;
		private var _swap:DisplayObject;
		private var _textField:TextField;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------

		/**
		*/
		
		public function VectorText()
		{
			addEventListener(Event.ADDED,onAdded);
			_textField = new TextField();
			_swap = _textField;
			_bitmap = new Bitmap();
			
			
			addChild(_swap);

		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function set alpha(value:Number):void
		{
			super.alpha = value;
			redraw();
		}
		
		/**
		 */
		
		public function setTextFormat(value:TextFormat):void
		{
			_textField.setTextFormat(value);
			
			redraw();
		}
		
		/**
		 */
		
		public function set antiAliasType(antiAliasType:String):void
		{
			_textField.antiAliasType = antiAliasType;
			redraw();
		}
		
		public function get antiAliasType():String
		{
			return _textField.antiAliasType;
		}
		
		/**
		 */
		
		public function set text(value:String):void
		{
			_textField.text = value;
			redraw();
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		
		/**
		 */
		
		public function set htmlText(value:String):void
		{
			_textField.htmlText = value;
			redraw();
		}
		
		public function get htmlText():String
		{
			return _textField.htmlText;
		}
		
		/**
		 */
		
		public function set embedFonts(value:Boolean):void
		{
			_textField.embedFonts = value;
			redraw();
		}
		
		public function get embedFonts():Boolean
		{
			return _textField.embedFonts;
		}
		
		
		/**
		 */
		
		public function set autoSize(value:String):void
		{
			_textField.autoSize = value;
			redraw();
		}
		
		public function get autoSize():String
		{
			return _textField.autoSize;
		}
		
		/**
		 */
		 
		override public function set width(value:Number):void
		{
			_textField.width = value;
			redraw();
		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			_textField.height = value;
			redraw();
		}
		
		
		/**
		 */
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value;
			
			redraw();
		}
		
		/**
		 */
		
		public function set multiline(value:Boolean):void
		{
			_textField.multiline = value;
			redraw();
		}
		
		public function get multiline():Boolean
		{
			return _textField.multiline;
		}
		
		/**
		 */
		
		public function set wordWrap(value:Boolean):void
		{
			_textField.wordWrap = value;
			redraw();
		}
		
		public function get wordWrap():Boolean
		{
			return _textField.wordWrap;
		}
		
		/**
		 */
		
		 public function set defaultTextFormat(format:TextFormat):void
		{
			_textField.defaultTextFormat = format;
			redraw();
		}
		
		/**
		 */
		
		public function set displayObjectOnly(value:Boolean):void
		{
			_doo = value;
		}
		
		/**
		 */
		 
		public function get displayObjectOnly():Boolean
		{
			return _doo;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function redraw():void
		{

			
			
			//check if the bitmap is already present, if alpha is less than zero, than we know that the bitmap took it out
			
			
			
			if(alpha < 1 || _doo)
			{
				if(this.contains(_bitmap))
					this.removeChild(_bitmap);
					
				var bitmapData:BitmapData = new BitmapData(_textField.width + 100,_textField.height,true,0xFFFFFF);
				bitmapData.draw(_textField);
				
				_bitmap =  new Bitmap(bitmapData);
				_bitmap.alpha = alpha;
				
				this.addChild(_bitmap);
				
				_textField.visible = false;
			
			}else
			{
				_textField.visible = true;
				
				if(this.contains(_bitmap))
					this.removeChild(_bitmap);
				
			}
			
			
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onAdded(event:Event):void
		{
			//event.target.removeEventListener(event.type,onAdded);
			if(event.target == this)
				redraw();
		}


	}
}