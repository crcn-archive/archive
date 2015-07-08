package com.ei.psd2.effectResources
{
	import com.ei.psd2.ColorControl;
	import com.ei.psd2.DynVal;
	import com.ei.psd2.display.PSDDisplayObject;
	
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class GradientFillEffect extends Effect
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function GradientFillEffect(displayObject:PSDDisplayObject,resource:DynVal)
		{
			super(displayObject,resource);
			
			
			
			var resources:Array = resource.children;
			
			//effect not enabled don't continue
			if(!resources[0].value)
				return;
				
				
			var alpha:Number 		= 1;
			var angle:Number 		= resources[4].value;
			var gradientType:String = resources[5].value;
			var reverse:Boolean     = resources[6].value;
			var scale:Number		= resources[7].value;
			
			//this.traceRoute(resources[3]);
			
			var colors:Object 		= getColors(resources[3].children[3],alpha);
			
			
			var newDisp:Sprite = new Sprite();
			
			with(newDisp.graphics)
			{
				
				var backgroundRotation:Number = Math.PI / (180 / (-angle));
				
				var backgroundMatrix:Matrix = new Matrix();
				backgroundMatrix.createGradientBox(displayObject.width,
											  	   displayObject.height,
											  	   backgroundRotation);
											  	   
				beginGradientFill("linear",colors.colors,colors.alphas,colors.ratios,backgroundMatrix);
				drawRect(0,0,displayObject.width,displayObject.height);
				endFill();
													  
			}
			
			displayObject.addChild(newDisp);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function getColors(res:DynVal,alpha:int):Object
		{
			
			var colorData:Object = new Object();
			colorData.colors = new Array();
			colorData.ratios = new Array();
			colorData.alphas = new Array();
			
			var maxLoc:int = 4096;
			var maxASLoc:int = 255;
			
			for each(var child:DynVal in res.children)
			{
				
				
				
				//trace(child.children[0].children[0].value,
				//										   child.children[0].children[1].value,
				//										   child.children[0].children[2].value);
				
				colorData.colors.push( ColorControl.fromRGB2(
														   child.children[0].children[0].value,
														   child.children[0].children[1].value,
														   child.children[0].children[2].value));
				
				//trace(child.children[2].value);
											   
				colorData.ratios.push(maxASLoc*(child.children[2].value/maxLoc));
				colorData.alphas.push(alpha);
				
			}
			
			
			return colorData;
			
		}		
		

	}
}