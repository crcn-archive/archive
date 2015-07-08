package com.bridge.psd
{
	import com.bridge.modules.component.ComponentModule;
	import com.bridge.node.BridgeDocument;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.ComponentClassDefinition;
	import com.ei.psd2.Layer;
	import com.ei.psd2.PSD;
	
	import flash.display.DisplayObject;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	public class BridgeGenerator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _node:BridgeNode;
		
		private var index:int;
		
		[Embed(source="bridgeCore.xml",mimeType="application/octet-stream")]
        private var _bridgeInit:Class;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BridgeGenerator()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function generateBridge(root:DisplayObject,psd:PSD):BridgeNode
		{
			
			var rootNode:XMLDocument;
			var currentParent:XMLNode = rootNode =  new XMLDocument();
			rootNode.ignoreWhite = true;
			rootNode.parseXML("<Bridge></Bridge>");
			
			currentParent = currentParent.firstChild;
			
        	var comp:ComponentModule = new ComponentModule();
        	comp.setRouterNode("Bridge",new ComponentClassDefinition(root));
        	
        	_node = new BridgeDocument();
        	_node.addModule(comp);
        	_node.parseXML(new _bridgeInit());
        	
        	var currentNode:XMLNode;
        	
        	for each(var layer:Layer in psd.layers)
        	{
        		
        		
        		if(!layer.isGroupEnd())
        		{
        			
        			
        			
        			if(layer.isGroup())
        			{
        				currentNode = new XMLDocument(generateGroup(layer));
        			}
        			else
        			{
        				currentNode = new XMLDocument(generateNode(layer));
        			}
        			
        			currentParent.appendChild(currentNode);
        			
        		}
        		else
        		{
        			
        			if(layer.name.indexOf("Bridge:p:") == 0)
					{
						var name:String = layer.name.replace("Bridge:p:","");
						currentParent.nodeName = "Sprite";
						
						currentParent.attributes["comp:parentProperty"] = name;
						
						
						
					}
					else
					if(layer.name.indexOf("Bridge:") == 0)
					{
        				currentParent.nodeName = layer.name.replace("Bridge:","");
     				}
        			
        			currentParent = currentParent.parentNode.parentNode;
       
        		}
        		
        		
        		if(layer.isGroup())
        		{
        			
        			currentParent = currentNode.firstChild;
        			
        		}
        		
        		
        		
        	}
        	
        	
        	var doc:BridgeDocument = new BridgeDocument();
        	
        	_node.appendChild(doc);
        	
        	trace(rootNode.toString());
        	
        	doc.parseXML(rootNode.toString());
        	
        	
        	return doc;

		}
			
			
		
		
		
		public function generateNode(layer:Layer):String
		{
			
			var ref:String = "instance"+(index++);
			
			_node.addVariable(ref,layer.displayObject);
			
			
			var name:String = layer.name;
			
			var parentProp:String = "";
			
			
			if(name.indexOf("Bridge:p:") == 0)
			{
				name = name.replace("Bridge:p:","");
				
				parentProp = ' comp:parentProperty="'+name+'"';
				
			}
			
			name = "Image";
			
			var source:String = 'source="{'+ref+'}"';
			var x:String      = ' x="'+layer.x+'"';
			var y:String      = ' y="'+layer.y+'"';
			var visible:String = ' visible="{'+layer.visible+'}"';
			var blendMode:String = ' blendMode="'+layer.blendKey+'"';
			
		
			return "<"+name+" "+parentProp+source+x+y+visible+blendMode+" />";
			
		}
		
		public function generateGroup(layer:Layer):String
		{
			var name:String = layer.name;
			
			
			
			if(name.indexOf("Bridge:") != 0)
			{
				name = "Sprite";
			}
			else
			{
				name = name.replace("Bridge:","");
			}
			
			return "<"+name+" />";
		}
	}
}