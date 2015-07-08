package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.hurlant.eval.ByteLoader;
	import com.hurlant.eval.Evaluator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	
	public class ES4AS3Module extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ES4AS3Module(ns:String)
		{
			super(ns);
			this.nodeEvaluator.addHandler("compile",compile);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function get moduleType():Array
		{
			return [ModuleType.NODE_NAME];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		private function compile():void
		{
			var source:String = evaluatedNode.attributes.source;
			
			
			var load:URLLoader = new URLLoader();
			load.addEventListener(Event.COMPLETE,onLoad);
			load.load(new URLRequest(source));
	
		}
		
		/**
		 */
		
		private function onLoad(event:Event):void
		{
			event.target.removeEventListener(event.type,onLoad);
			
			var source:String = event.target.data;
			
			var evaluator:Evaluator = new Evaluator();
			trace(source);
			var bytes:ByteArray = evaluator.eval(source);
			
			ByteLoader.loadBytes(bytes);
			
			
		}
		
		
		
		

	}
}