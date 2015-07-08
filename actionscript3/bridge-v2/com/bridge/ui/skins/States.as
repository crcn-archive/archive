package com.bridge.ui.skins
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class States
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _currentState:String;
		
		private var _states:Object;
		
		private var _targetParent:Sprite;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function States(targetParent:Sprite)
		{
			_currentState = "";
			_targetParent = targetParent;
			_states = new Object();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		
		
		public function set currentState(value:String):void
		{
			
			setCurrentState(false);
			
			_currentState = value;
			
			
			setCurrentState(true);
		}
		
		/**
		 */
		public function get currentState():String
		{
			return _currentState;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function addState(name:String,...children:Array):void
		{
			_states[name] = children;
			
			_currentState = name;
			
			setCurrentState(false);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function setCurrentState(visible:Boolean):void
		{
			if(_states[_currentState] is Array)
			{
				for each(var d:DisplayObject in _states[_currentState])
				{
					d.visible = visible;
				}
			}
		}

	}
}