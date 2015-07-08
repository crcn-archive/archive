package com.bridge.ui.skins.simple
{
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.skins.UISkin;
	import com.bridge.ui.style.Style;
	import com.bridge.ui.style.convertStyle;
	import com.ei.utils.SpriteUtils;
	
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class ColoredUIComponentSkin extends UISkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ColoredUIComponentSkin(controller:UIComponent,style:Style)
		{
			super(controller,style);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function init():void
		{
			this.draw();
		}
		
		/**
		 */
		override protected function change():void
		{
			this.draw();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function draw():void
		{
			
			var height:Number = 0;
			var width:Number  = 0;
			
			
			var nHeight:Number = style.getProperty("height");
			var nWidth:Number  = style.getProperty("width");
			
			if(nHeight) height = nHeight;
			if(nWidth)  width  = nWidth;
			
			//define the rotation
			var backgroundRotation:Number = Math.PI / (360 / style.getProperty("backgroundRotation"));
			
			var backgroundMatrix:Matrix = new Matrix();
			backgroundMatrix.createGradientBox(style.getProperty("width"),
											   style.getProperty("height"),
											   backgroundRotation);
			
			with(this.graphics)
			{
				clear();
				
				if(style.getProperty("backgroundVisible") !== false)
				{
					beginGradientFill(style.getProperty("backgroundFillType"),
									  convertStyle(Array,style.getProperty("backgroundColors")),
									  convertStyle(Array,style.getProperty("backgroundAlphas")),
									  convertStyle(Array,style.getProperty("backgroundRatios")),
									  backgroundMatrix,
									  style.getProperty("backgroundSpreadMethod"),
									  style.getProperty("backgroundInterpolationMethod"),
									  style.getProperty("backgroundfocalPointRatio"));
				}
				
				var tlRadius:Number = style.getProperty("topLeftRadius")
				var trRadius:Number = style.getProperty("topRightRadius");
				var brRadius:Number = style.getProperty("bottomRightRadius");
				var blRadius:Number = style.getProperty("bottomRightRadius");
				
			
				if(!isNaN(tlRadius)  && !isNaN(trRadius)  && !isNaN(brRadius) && !isNaN(blRadius))
				{
					
					drawRoundRectComplex(0,
										 0,
										 width,
										 height,
										 tlRadius,
										 trRadius,
										 blRadius,
										 brRadius);
				}
				
				else
				{
					drawRoundRect(0,
								  0,
								  width,
								  height,
								  style.getProperty("cornerRadius"),
								  style.getProperty("cornerRadius"));
				}
			}
			
			
			if(style.getProperty("filters"))
			{
				this.filters = convertStyle(Array,style.getProperty("filters"));
			}
			
			dispatchEvent(new Event(Event.RESIZE));
		}

	}
}