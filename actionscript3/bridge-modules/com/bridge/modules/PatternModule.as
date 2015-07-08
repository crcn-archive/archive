package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.IBridgeNode;
	
	public class PatternModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _type:String;
        private var _pattern:RegExp;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function PatternModule(ns:String = "")
		{
			super(ns);
			nodeEvaluator.addHandler("pattern",searchPattern);
			nodeEvaluator.addHandler("result",getResult);
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
			return [ModuleType.NODE_NAME,ModuleType.PROPERTY_NAME];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		private function getResult():void
		{
			
		}
		
        /**
		 */
		
		private function searchPattern():void
		{
			//pause the node so the children are last to be parsed
			evaluatedNode.pause();
			
			var rootNode:IBridgeNode = evaluatedNode.rootNode;
			_type 				  = evaluatedNode.attributes.type;
			_pattern			  = new RegExp(evaluatedNode.attributes.search);
			
			evalXMLDocument(rootNode);
			
			
			
		}
		
		/**
		 */
		
		private function evalXMLDocument(node:IBridgeNode):void
		{
			
			var result:String;
			
			for each(var child:IBridgeNode in node.childNodes)
			{
				//do not process any children that are arleady executed
				if(!child.complete)
				{
					if(child.hasChildNodes())
					{
						evalXMLDocument(child);
					}
					
					
					
					switch(_type)
					{
						case "value":
							for(var key:String in child.attributes)
							{
								if(_pattern.test(child.attributes[key]))
								{
									result = replaceWithResult(child,evaluatedNode.childNodes.join(""),child.attributes[key]);
									
									child.parseXML(result);
								}
							}
						break;
						case "property":
							for(var key:String in child.attributes)
							{
								if(_pattern.test(key))
								{
									result = replaceWithResult(child,evaluatedNode.childNodes.join(""),key);
									child.parseXML(result);
								}
							}
						break;
						case "nodeName":
						
							if(_pattern.test(child.nodeName))
							{
								result = replaceWithResult(child,evaluatedNode.childNodes.join(""),child.nodeName);
	
								child.parseXML(result);
							}
						break;
					}
				}
			}
		}
		
		/**
		 */
		
		private function replaceWithResult(orgChild:IBridgeNode,child:String,toMatch:String):String
		{
			var newChild:String = child;
			var result:String = toMatch.match(_pattern).toString();

			newChild = newChild.replace("<"+moduleNamespace+":resultNode />",String(orgChild));
			newChild = newChild.replace(moduleNamespace+":resultNodeName",orgChild.nodeName);
			newChild = newChild.replace(moduleNamespace+":resultValue",result);
			
			return newChild;
		}
	}
}