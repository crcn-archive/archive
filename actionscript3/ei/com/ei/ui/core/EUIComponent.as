package com.ei.ui.core
{
	import com.ei.display.IStyleableDisplayObject;
	import com.ei.display.StyleableDisplayObject;
	import com.ei.display.decor.ChildList;
	import com.ei.display.decor2.*;
	import com.ei.ui2.core.UIComponent;
	import com.ei.utils.style.StyleImp;
	
	import flash.display.DisplayObject;
	
	public class EUIComponent extends UIComponent implements  IStyleableDisplayObject
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		public var accurateDim:ChildList;
		private var styler:StyleableDisplayObject;
		
		public var box:BoxDecorator;
		public var constraints:ConstraintDecorator;
		public var aligner:AlignmentDecorator;
		public var percentRel:PercentRelativityDecorator;
		
		protected var _target:DisplayObject;
		
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function EUIComponent()
		{
			super();
			
			
			constraints = new ConstraintDecorator(this);
			
			
			aligner   = new AlignmentDecorator(this);
			
			
			
			//percent     = new PercentRelativity(this);
			accurateDim = new ChildList(this);
			styler      = new StyleableDisplayObject(this);
			percentRel  = new PercentRelativityDecorator(this);
			
			box		 = new BoxDecorator(this);
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		
		//--------------------
		// styler
		//--------------------
		
		/**
		 */
		
		public function set styleName(value:String):void
		{
			styler.styleName = value;
		}
		
		public function get styleName():String
		{
			return styler.styleName;
		}
		
		/**
		 */
		
		public function get implementor():StyleImp
		{
			return styler.implementor;
		}
		
		//----------------------
		// dimensions
		//----------------------
		
		/**
		 */
		
		override public function get width():Number
		{
			return accurateDim.width;
		}
		
		/**
		 */
		
		override public function get height():Number
		{
			return accurateDim.height;
		}
		
		//----------------------
		// Box
		//----------------------
		
		/**
		 */
		 
		public function set alignment(value:String):void
		{
			box.alignment = value;	
		}
		
		public function get alignment():String
		{
			return box.alignment;
		}
		
		/**
		 */
		
		public function set padding(value:Number):void
		{
			box.padding = value;
		}
		
		/**
		 */
		
		public function get padding():Number
		{
			return box.padding;
		}
		
		//----------------------
		// PercentRel
		//----------------------
		
		/**
		 */
		 
		public function set percentWidth(value:Number):void
		{
			percentRel.percentWidth = value;
		}
		
		public function get percentWidth():Number
		{
			return percentRel.percentWidth;
		}
		
		/**
		 */
		
		public function set percentHeight(value:Number):void
		{
			percentRel.percentHeight = value;
		}
		
		public function get percentHeight():Number
		{
			return percentRel.percentHeight;
		}
		
		/**
		 */
		
		public function set percentX(value:Number):void
		{
			percentRel.percentX = value;
		}
		
		public function get percentX():Number
		{
			return percentRel.percentX;
		}
		
		/**
		 */
		
		public function set percentY(value:Number):void
		{
			percentRel.percentY = value;	
		}
		
		public function get percentY():Number
		{
			return percentRel.percentY;
		}
		//----------------------
		// Constraints
		//----------------------
		
		/**
		 */
		 
		public function get left():Number
		{
			return constraints.left;
		}

		public function set left(pos:Number):void
		{
			constraints.left = pos;
		}
		
		/**
		 */
		
		public function get right():Number
		{
			return constraints.right;
		}
		
		public function set right(pos:Number):void
		{
			
			constraints.right = pos;
		}
		
		/**
		 */
		
		public function get top():Number
		{
			return constraints.top;
		} 
		
		public function set top(pos:Number):void
		{
			constraints.top = pos;
		}

		/**
		 */
		
		public function get bottom():Number
		{
			return constraints.bottom;
		}
		
		public function set bottom(pos:Number):void
		{
			constraints.bottom = pos;
		}
		
		/**
		 */
		
		public function get horizontalCenter():Number
		{
			return aligner.horizontalCenter;
		}
		
		public function set horizontalCenter(pos:Number):void
		{
			aligner.horizontalCenter = pos;
		}
		
		/**
		 */
		 
		public function get verticalCenter():Number
		{
			return aligner.verticalCenter;
		}
		
		public function set verticalCenter(pos:Number):void
		{
			aligner.verticalCenter = pos;	
		}
		
		
		 
		/*public function set restrictBounds(value:Boolean):void
		{
			alignerrestrictBounds = value;
		}
		
		public function get restrictBounds():Boolean
		{
			return alignerrestrictBounds;
		}*/
		
		/**
		 */
		
		/*public function set constrain(value:Boolean):void
		{
			alignerconstrain = value;
		}
		
		public function get constrain():Boolean
		{
			return alignerconstrain;
		}*/
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function setProperty(name:*,value:*):void
		{
			styler.setProperty(name,value);
		}

		
	}
}