package com.bridge.modules
{
	
	import com.bridge.node.IBridgeNode;
	import com.bridge.core.ModuleType;
	import com.bridge.core.BridgeModule;
	import flash.utils.getDefinitionByName;
	import com.bridge.core.EvaluableModule;
	
	
	public class FMLHandlerModule extends EvaluableModule
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FMLHandlerModule(ns:String = "")
		{
			super(ns);
			
			nodeEvaluator.addHandler("pause",pauseScript);
			nodeEvaluator.addHandler("resume",resumeScript);
			nodeEvaluator.addHandler("pauseAll",pauseAllScript);
			nodeEvaluator.addHandler("resumeAll",resumeAllScript);
			nodeEvaluator.addHandler("addModule",addModule);
			nodeEvaluator.addHandler("omitParser",omitParsing);
			nodeEvaluator.addHandler("execute",executeNodes);
			
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
		
		private function pauseScript():void
		{
			var nodeTarget:IBridgeNode = evaluatedNode.parentNode;
			
			var target:String = evaluatedNode.attributes["target"];
			
			if(target)
			{
				nodeTarget = getBackReference(target,nodeTarget);
			}
			
			//pause has no child nodes so pause the parent script
			nodeTarget.pause();
		}
		
		/**
		 */
		
		private function resumeScript():void
		{
			var nodeTarget:IBridgeNode = evaluatedNode.parentNode;
			
			var target:String = evaluatedNode.attributes["target"];
			
			if(target)
			{
				nodeTarget = getBackReference(target,nodeTarget);
			}

			nodeTarget.resume();
		}
		
		/**
		 */
		
		private function pauseAllScript():void
		{
			//trace("FMLHandlerModule:pauseAllScript()");
			
			evaluatedNode.parentNode.pauseAll();
		}
		
		/**
		 */
		
		private function resumeAllScript():void
		{
			
			evaluatedNode.parentNode.resumeAll();
		}
		
		/**
		 */
		
		private function addModule():void
		{
			//required
			var moduleClass:Class  = getDefinitionByName(evaluatedNode.attributes.source) as Class;

			var moduleNS:String = "";
			
			if(evaluatedNode.attributes.namespace)
				moduleNS    = evaluatedNode.attributes.namespace;
			
			var module:BridgeModule    = new moduleClass(moduleNS);
			
			evaluatedNode.addModule(module);
		}
		
		/**
		 */
		
		private function omitParsing():void
		{
			var name:String = evaluatedNode.attributes.node;
			var property:String = evaluatedNode.attributes.property;
			

			evaluatedNode.omitParsing(name,property);
		}
		
		/**
         */
        
        private function executeNodes():void
        {
        	var type:String = evaluatedNode.attributes["type"];
        	var name:String = evaluatedNode.attributes["name"];
        	
        	
        	var rootNode:IBridgeNode = evaluatedNode.rootNode;
        	
        	scanAndExecute(rootNode,type,name);
        	
        }
        
        /**
         */
        
        private function scanAndExecute(rootNode:IBridgeNode,type:String,name:String):void
        {
        	for each(var child:IBridgeNode in rootNode)
        	{
        		if(child.nodeName == name)
        		{
        			child.restart();
        		}
        		
        		if(child.hasChildNodes())
        		{
        			scanAndExecute(child,type,name);
        		}
        	}
        }
		
        
        
        /**
         */
        
        private function getBackReference(reference:String,caller:IBridgeNode):IBridgeNode
        {
        	var currentRef:IBridgeNode = caller;
        	var backRef:Array	   = reference.split("../");
        	
        	
        	var refName:String;
        	
        	
        	for(var i:int = 1; i < backRef.length; i++)
        	{
        		
        		refName = backRef[i];
        		
        		/*if(refName.length > 0)
        		{
        			for(var j:int = 0; j < currentRef.childNodes; j++)
        			{
        				
        			}
        		}*/
        		
        		currentRef = currentRef.parentNode;
        	}
        	
        	
        	return currentRef;
        }
        
        
        
	}
}