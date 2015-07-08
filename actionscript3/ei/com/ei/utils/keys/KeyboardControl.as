package com.ei.utils.keys
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	
	public class KeyboardControl
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _combos:Array;
        private var _key:Key;
        private var _focus:DisplayObject;
        private var _impCombos:Array;
        private var _enabled:Boolean;
		
		
		private var _keysDown:Array;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function KeyboardControl(focus:DisplayObject = null)
		{
			
			
			
			_focus = focus;
			
			_combos 	= new Array();
			_impCombos = new Array();
			
			
			_keysDown = new Array();
			
			enabled = true;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			
			if(!_focus)
				return;
			
			_focus.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			_focus.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
			
			if(value)
			{
				_focus.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
				_focus.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		
		
		public function set target(value:DisplayObject):void
		{
			enabled = true;
			
			_focus = value;
			
			
		}
		public function get target():DisplayObject
		{
			return _focus;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function isDown(code:*):Boolean
		{
			return _keysDown.indexOf(code) > -1;
		}
		
        /**
		 */
		
		public function setCombo(combo:Array,callback:Function,allowHold:Boolean = false,...params:Array):void
		{
			//trace(combo);
			
			_combos.push({combo:combo,callback:callback,hold:allowHold,params:params});
		}
		
		/**
		 */
		 
		 private function onKeyDown(event:KeyboardEvent):void
		 {
		 	_keysDown.push(event.keyCode);
		 	
		 	var isCombo:Boolean;
		 	var selected:Object;
		 	
		 	
		 	//for some reason control+c (4294967295) doesn't render as a number
		 	//what's going on???? 
		 	for each(var obj in _combos)
		 	{
		 		
		 		for each(var keyCode:* in obj.combo)
		 		{
					
		 			isCombo = isDown(new Number(keyCode));
		 			
		 			
		 			if(!isCombo)
		 				break;
		 		}
		 		
		 		
		 		if(isCombo)
		 		{
		 			selected = obj;
		 			break;
		 		}
		 	}
		 	
		 	
		 	
		 	var hasCombo:Boolean = _impCombos.indexOf(selected) > -1;

		 	if(selected != null && (!hasCombo || selected.hold))
		 	{
		 		selected.callback.apply(null,selected.params);
		 		_impCombos.push(selected);
		 	}
		 	
		 }
		 
		/**
		 */
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			
			var comboUp:Boolean;
			
			
			
			var index:int = _keysDown.indexOf(event.keyCode);
			
			while(index != -1)
			{
				delete _keysDown[index];
				
				index = _keysDown.indexOf(event.keyCode);
			}

		 	for each(var obj in _combos)
		 	{
		 		for each(var keyCode:int in obj.combo)
		 		{
		 			
		 			comboUp = !isDown(keyCode);
		 			
		 			if(!comboUp)
		 				break;
		 		}
		 		
		 		
		 		if(comboUp)
		 		{
		 			var index:int = _impCombos.indexOf(obj);
		 			
		 			if(index > -1)
		 			{
		 				delete _impCombos[index];
		 			}
		 			
		 		}
		 	}
		 	
		 	
		}
		

	}
}