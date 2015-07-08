/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/
 
package com.bridge.node
{
	import com.bridge.core.BridgeModule;
	import com.bridge.core.ModuleType;
	import com.bridge.eval.CodeSegment;
	import com.ei.utils.info.ClassInfo;
	
	
	/**
	 * The Bridge Node Library acts as the model for the entire application. It holds the registered modules, along with the
	 * runtime actionscript parser, variables, and instances.
	 */
	 
	public class BridgeNodeLibrary
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _module_nodeNameHandlers:Array;
        private var _module_propertyHandlers:Array;
        private var _module_propertyValueHandlers:Array;
        private var _modules:Array;
       
		private var _valueParser:CodeSegment;
		private var _parseOmissions:Object;
       
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BridgeNodeLibrary()
		{
			_module_nodeNameHandlers      = new Array();
			_module_propertyHandlers      = new Array();
			_module_propertyValueHandlers = new Array();
			_modules 					  = new Array();
				
				
			_valueParser = new CodeSegment();
			
			_valueParser.setVariable("trace",trace);
			_valueParser.setVariable("isNaN",isNaN);
			_valueParser.setVariable("NaN",NaN);
			_valueParser.setVariable("undefined",undefined);
			_valueParser.setVariable("null",null);
			
			
			_parseOmissions				  = new Object();
			
			
		}
		
		/**
		 * registers a module to the Bridge Node Library. The module registered
		 * is used handle nodes while they are being executed.
		 * @param module the module instance
		 */
		
		public function registerModule(module:BridgeModule):void
		{
			
			
			if(!_modules[module.moduleNamespace])
        		_modules[module.moduleNamespace] = new Array();
        		
        		
        	//assoc with bridge builder that restarts the nodes
			try
			{
				for each(var mod in _modules[module.moduleNamespace])
					if(ClassInfo.getClass(mod) == ClassInfo.getClass(module))
					{
						trace("BridgeNodeLibrary::the module "+module.moduleNamespace+" shares the same namespace with a module of the same data-type. Ignoring"); 
						return;
					}
			}catch(e){}
		
    	
        	_modules[module.moduleNamespace].push(module);
        	
        	//for efficiency, separate the types of modules by
        	//their type so when they're called, they don't take 
        	//any extra time to parse the node
        	
        	//the modules can be more than one type
        	//trace(this.nodePath+":addModule("+module+") types:"+module.moduleType,"BridgeNode")
        	
        	
        	
        	
        	//register the module to the SymbolTable so that the ModuleExpression class
        	//can easily call the namespace
        	
        	var currentVar:Object = _valueParser.getVariable(module.moduleNamespace);
        	
        	
        	if(currentVar is Array)
        	{
        		currentVar.push(module);
        	}
        	else
        	if(currentVar is BridgeModule)
        	{
        		
        		var stack:Array = [currentVar];
        		stack.push(module);
        		
        		_valueParser.setVariable(module.moduleNamespace,stack);
        	}
        	else
        	{
        		_valueParser.setVariable(module.moduleNamespace,module);
        	}
        	
        	
        	for each(var type:String in module.moduleType)
        	{
        		if(type == ModuleType.NODE_NAME)
        		{
        			_module_nodeNameHandlers.push(module);
        		}
        		
        		if(type == ModuleType.PROPERTY_NAME)
        		{
        			
        			_module_propertyHandlers.push(module);
        		}
        		
        		if(type == ModuleType.VALUE)
        		{
        			_module_propertyValueHandlers.push(module);
        		}
        	}
		}
		
		
		/**
		 */
		
		 
		public function set nodeNameHandlers(value:Array):void
		{
			_module_nodeNameHandlers = value;
		}
		
		/**
		 * returns the modules that handle node names
		 */
		 
		public function get nodeNameHandlers():Array
		{
			return this._module_nodeNameHandlers;
		}
		
		/**
		 */
		
		public function set propertyHandlers(value:Array):void
		{
			_module_propertyHandlers = value;
		}
		
		/**
		 * returns modules that handler the property names
		 */
		
		
		public function get propertyHandlers():Array
		{
			return this._module_propertyHandlers;
		}
		
		/**
		 */
		
		public function set valueHandlers(value:Array):void
		{
			_module_propertyValueHandlers = value;
		}
		
		public function get valueHandlers():Array
		{
			return this._module_propertyValueHandlers;
		}
		
		/**
		 */
		 
		public function set modules(value:Array):void
		{
			_modules = value;
		}
		
		/**
		 * returns all the modules used
		 */
		
		public function get modules():Array
		{
			return this._modules;
		}
		
		/**
		 */
		
		public function set valueParser(parser:CodeSegment):void
		{
			_valueParser = parser;
		}
		
		/**
		 * returns the value parser that handles all the runtime actionscript code
		 */
		
		public function get valueParser():CodeSegment
		{
			return this._valueParser;
		}
		
		/**
		 */
		 
		public function set parseOmissions(value:Object):void
		{
			_parseOmissions = value;
		}
		
		/**
		 * returns all the parse omissions to ignore when handling
		 * attribute values
		 */
		
		public function get parseOmissions():Object
		{
			return this._parseOmissions;
		}
		
		/**
		 * returns a module registered in the Node Library
		 * @param clazz the class instance of the module to return
		 */
		
		public function getModule(clazz:Class):Array
		{
			var modules:Array = new Array();
			
			for each(var modNS:Array in _modules)
			{
				for each(var module:BridgeModule in modNS)
				{
					
					if(module is clazz)
						modules.push(module);
				}
			}
			
			
			
			return modules;
		}
		
		/**
		 * combines two or more libraries
		 */
		
		public function concat(...libraries:Array):BridgeNodeLibrary
		{
			var nlib:BridgeNodeLibrary = new BridgeNodeLibrary();
			
			for each(var lib:BridgeNodeLibrary in libraries)
			{
				registerMods(nlib,lib);	
			}
			
			registerMods(nlib,this);
			
			return nlib;
		}
		

		/**
		 */
		
		public function clone(isolate:Boolean = false):BridgeNodeLibrary
		{
			
			var lib:BridgeNodeLibrary = new BridgeNodeLibrary();
			lib.modules = this.modules;
			lib.valueHandlers = this.valueHandlers;
			lib.nodeNameHandlers = this.nodeNameHandlers;
			lib.propertyHandlers = this.propertyHandlers;
			lib.valueParser.symbolTable = this.valueParser.symbolTable;
			
			//we isolate the variables so that the new node can access the parent symbol table
			//but siblings and parent symbol tables cannot access this symbol table
			if(isolate)
				lib.valueParser.isolate();
			
			return lib;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function registerMods(target:BridgeNodeLibrary,lib:BridgeNodeLibrary):void
		{
			for each(var mod:Array in lib.modules)
			{
				for each(var m:BridgeModule in mod)
					target.registerModule(m);
			}
		}

	}
}