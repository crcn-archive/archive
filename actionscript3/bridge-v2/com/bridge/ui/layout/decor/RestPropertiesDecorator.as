package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.style.Style;
	
	dynamic public class RestPropertiesDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _properties:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function RestPropertiesDecorator(priority:int = -1)
		{
			super(priority);
			
			_properties = new Object();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get refreshTypes():Array
		{
			return [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function findProperties(style:Style):Array
		{
			
			_properties = new Object();
			
			var testStyle:Object = style.toObject();
			var props:Array = new Array();
			for(var prop:String in testStyle)
			{
				if(ui_internal::layoutManager.target.hasOwnProperty(prop))
				{
					props.push(prop);
				}
			}
			
			return props;
		}


		/**
		 */
		 
		override public function setProperty(name:String,value:*,draw:Boolean = true):void
		{
			
			_properties[name] = value;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function draw2():void
		{
			for(var prop:String in _properties)
			{
				currentTarget[prop] = _properties[prop];
			}
		}
		
		

	}
}