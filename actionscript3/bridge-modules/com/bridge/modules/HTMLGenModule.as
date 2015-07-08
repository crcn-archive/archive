package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	import flash.external.ExternalInterface;
	import flash.xml.XMLNode;
	
	public class HTMLGenModule extends EvaluableModule
	{
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function HTMLGenModule(ns:String = "")
		{
			super(ns);
			
			nodeEvaluator.addHandler("generate",generateHTML);
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
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		private function generateHTML():void
		{
			var md:JavascriptModule = new JavascriptModule();
			
			var htmlCode:String = evaluatedNode.firstChild.nodeValue;
			
			
			var data:String = 
			<![CDATA[
				var newDiv = document.createElement('div');
				newDiv.setAttribute('id','test');
				newDiv.innerHTML = '%data';
				
			]]>;
			
			
			var reg:RegExp = /([\r\n\t]+)+/igx;
			
			htmlCode = htmlCode.replace(reg,"");
			
			
			data = data.replace("%data",htmlCode);
			
			trace(data);
			
			ExternalInterface.call("function(){"+data+"}");
			
			//md.callFunction("document.write",[htmlCode]);
		}
		
		
		/**
		 */
		
		private function addElements(code:XMLNode):void
		{
			//ExternalInterace.call("document.create
		}
		

	}
}



class HTMLInstance
{
	
}