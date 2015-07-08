//abstract class
package com.bridge.ui.controls.media
{
	import flash.events.EventDispatcher;
	
	public class Player  extends EventDispatcher implements IPlayer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Player()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		public function get bufferTime():Number
		{
			return 0;
		}
		
		/**
		 */
		
		public function get currentTimeString():String
		{
			return "";
		}
		
		/**
		 */
		
		public function get paused():Boolean
		{
			return false;
		}
		
		/**
		 */
		
		public function get percentDone():Number
		{
			return 0;
		}
		
		/**
		 */
		
		public function get percentLoaded():Number
		{
			return 0;
		}
		
		public function get timeLeftString():String
		{
			return "";
		}
		
		/**
		 */
		
		public function get totalSeconds():Number
		{
			return 0;
		}
		
		/**
		 */
		public function set valume(value:Number):void
		{
			
		}
		
		public function get volume():Number
		{
			return 0;
		}
		
		public function set volume(value:Number):void
		{
			
		}
		
		public function set bufferTime(value:Number):void
		{
		}
		
		/**
		 */
		public function get type():String
		{
			return "player";
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function load(value:String):void
		{
			
			
			
		}
		
		public function pause():void
		{
		}
	
		public function play(position:Number = -1):void
		{	
		}
		
		public function stop():void
		{
		}
		
		public function togglePlay():void
		{
		}
		
		public function seek(percent:Number):void
		{
		}
		
		
		/**
		 */
		 
		public function addCuePoint(callback:Function,time:String,reausable:Boolean,...params:Array):void
		{
		}
		
		/**
		 */
		
		public function clearCuePoints():void
		{
		}
		
		
		
		
		
	}
}