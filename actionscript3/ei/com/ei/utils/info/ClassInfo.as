package com.ei.utils.info
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	public class ClassInfo
	{
		
		
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _instance:Object;
		private var _propertyInfo:Object;
		private var _isDynamic:Boolean;
		private var _description:XML;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function ClassInfo(obj:Object)
		{
			
			
			
			_instance = obj;
			init();
		}
		
		
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function get baseClassInfo():ClassInfo
		{
			var data:XMLDocument = new XMLDocument();
			data.ignoreWhite = true;
			
			data.parseXML(new String(_description..extendsClass));
			
			if(data.firstChild)
			{
				
				return new ClassInfo(getDefinitionByName(data.firstChild.attributes.type));
			}
			
			return null;
		}
		
		/**
		 */
		 
		public function get publicAPI():Object
		{
			return _propertyInfo;
		}
		
		/**
		 */
		 
		public function get name():String
		{
			var fullPath:String = getQualifiedClassName(_instance);
			return getName(fullPath);
		}
		
		
		/**
		 */
		
		public static function getClass(obj:Object):Class
		{
			return getDefinitionByName(getQualifiedClassName(obj)) as Class;
		}
		
		/**
		 */
		
		public function get isDynamic():Boolean
		{
			return _isDynamic;
		}
		
		
		/**
		 */
		public function get instance():Object
		{
			return _instance;
		}
		
		/**
		 */
		public function get extendedBaseInfo():Array
		{
			var data:XMLDocument = new XMLDocument();
			data.ignoreWhite = true;
			
			data.parseXML(new String(_description..extendsClass));
			
			
			var extended:Array = new Array();
			var path:String;
			for each(var node:XMLNode in data.childNodes)
			{
				path = node.attributes.type;
				extended.push(new ClassInfo(getDefinitionByName(path)));
			}
			
			return extended;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Info
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function extendsClass(clazz:Class):Boolean
		{
			for each(var classInfo:Object in _description..extendsClass)
			{
				if(getDefinitionByName(classInfo.@type) == clazz)
				{
					return true;
				}
			}
			return false;
		}
		/**
		 */
		
		public function getType(property:String):String
		{
			return _propertyInfo[ property ].type;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		
		/**
		 */
		 
		private function init():void
		{
			_propertyInfo = new Object();
			
			//get the class info
			_description = describeType(_instance);
			
			_isDynamic = _description.@isDynamic == "true";
			
			//get the public methods
			var pbMethods:XMLList  = _description..method;
	
			//get the public accessors
			var pbAccessors:XMLList = _description..accessor;

			//get the public accessors
			var pbVariables:XMLList = _description..variable;

			//create a new method stack to return
			var methods:Object = new Object();
						
			assignName(pbAccessors,AccessorInfo);
			
			assignName(pbMethods,MethodInfo);
			
			assignName(pbVariables,VariableInfo);
		}
		/**
		 */
		
		private function assignName(nodes:XMLList,type:Class):void
		{
			//go through each method and assign them to the methods stack
			
			var propertyName:String;
			
			for(var i:int = 0; i < nodes.length(); i++)
			{
				
				propertyName = nodes[i].@name;
				//for now  just get the param count, the vaue isn't really important for what 
				//needs to e done
				
				switch(propertyName)
				{
					case "hasOwnProperty"://do nothing
					case "isPrototypeOf":
					case "propertyIsEnumerable":
					break;	
					default:
						_propertyInfo[ propertyName ] = new type(nodes[i]);
					break;
				}
				
				
				
			}
		}
		
		/**
		 */
		 
		private function getName(path:String):String
		{
			var justName:Array = path.split("::");

			return justName[justName.length-1];
		}
	}
}