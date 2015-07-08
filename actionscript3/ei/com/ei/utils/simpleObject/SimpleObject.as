package com.ei.utils.simpleObject
{
	import com.ei.events.SimplifyEvent;
	import com.ei.utils.ClassApply;
	import com.ei.utils.ClassDefinition;
	import com.ei.utils.StringUtils;
	import com.ei.utils.info.ClassInfo;
	import com.ei.utils.info.PropertyType;
	
	import flash.events.EventDispatcher;
	
	
	
	public class SimpleObject extends EventDispatcher
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _auto:Boolean;
		private var _target:Object;
		private var _info:ClassInfo;
		private var _propertyValues:Object;
		private var _definition:ClassDefinition;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------

		/**
		*/
		
		public function SimpleObject(def:ClassDefinition = null,auto:Boolean = true)
		{

			_auto = auto;
			targetDefinition = def;
			_info = new ClassInfo(def.instance);
		}
		
		
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		
		/**
		*/
		
		public function get instance():*
		{
			//if the class has not been instantiated yet then 
			//return the definition instance so the value is not null
			if(_target == null)
			{
				return _definition.instance;
			}
			
			return _target;
		}
		
		
		/**
		 */
		
		public function get targetDefinition():*
		{
			return _definition;
		}
		
		/**
		 */
		
		public function set targetDefinition(target:ClassDefinition):void
		{
			//the target definition is needed for the object to work
			//so return NULL if it does not exist
			if(target == null)
				return;
				
			_definition 	= target;
			
			
			_propertyValues = new Object();
			
			//if the instance is a class than we can use it as a temporary target
			if(!(target.instance is Class))
			{
				_target = target.instance;
			}
			else
			{
				_target = null;
			}
			
			//go through all the properties in the definition since they are default
			//and set them
			for(var propertyName:String in _definition.defaultProperties)
			{
				setProperty(propertyName,_definition.defaultProperties);
			}
			
			
			//initialize the class if there are no constructor params
			if(_definition.constructorParams.length == 0)
			{
				initInst();
			}
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
	//	public function initialize()
		
		
		/**
		 */
		
		public function setProperty(name:String,value:*):void
		{
			//names can be rewritten in the class definitions
			//so retrieve the actual name of the property
			var actualName:String = getName(name);
			
			//set the default property 
			_propertyValues[ actualName ] = value;
			
			//try to initialize the class 
			initInst();
		}
		
		/**
		 */

		public function getProperty(name:String):*
		{
			//retrieve the actual name of the property
			var actualName:String = getName(name);
			
			//return the default property
			return _definition.defaultProperties[ actualName ];
		}
		
		/**
		*/
		
		public function getInstance(inst:String = null):Object
		{
			
			if(inst == null)
			{
				if(_target == null)
					return _definition.instance;
				else
					return _target;
			}
			
			var spl:Array = inst.split(".");
			var newInst:* = _target;
			
			//go through each period and find the instance, but make SURE
			//it exists, otherwie return a null
			if(spl.length > 1)
			{
				
				for each(var i:String in spl)
				{

					if(hasProperty(newInst,i))
					{
						newInst = newInst[ i ];
					}
					else
					{
						newInst = null;
						break;
					}
				}
			}
			
			//check if the STATIC variable has it
			try{
				if(_definition.instance[inst])
				{
					newInst = _definition.instance;
				}
			}catch(e:*){}
			
			return newInst;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */

		private function initInst():void
		{

			// handle the constructor
			if(_target == null)
			{
				var constValues:Array = new Array();
				
				for each(var param:String in _definition.constructorParams)
				{
					
					
					//changed to check if undefined because param could be boolean false
					if(_propertyValues[ param ] != undefined)
					{
						constValues.push(_propertyValues[ param ]);
					}
					else
					{
						constValues = null;
						break;
					}
				}
				
				if(constValues != null)
				{
					_target = ClassApply.getInstance(_definition.instance,constValues);
					setProperties();

					dispatchEvent(new SimplifyEvent(SimplifyEvent.CLASS_EXECUTED));
				}
			}
			else
			{
				setProperties();
				dispatchEvent(new SimplifyEvent(SimplifyEvent.CLASS_EXECUTED));
			}
		
		}
		
		/**
		 */

		private function setProperties():void
		{
			
			for(var property:String in _propertyValues)
			{
				
				var val:*     = _propertyValues[ property ];
				var newInst:* = getInstance(property);
				
				//sometimes hasOwnProperty does not work, like in Array, so use New Inst just in case
				//dynamic objects must be taken into account as well
				var hasProp:Boolean = hasProperty(newInst,property) || _info.isDynamic;
				
				//must contain letters numbers, @ signs, underscores or dollar signs
				var isValidProperty:Boolean = StringUtils.isVar(property);

				if(newInst != null && hasProp && isValidProperty)
				{
					if(isMethod(property))
					{
						setMethodParams(property,val);	
					}
					else
					{
						try
						{
							newInst[ property ] = val;
						}catch(e:*)
						{
							trace("SimpleObject::"+e);
						}
					}
					
					
					delete _propertyValues[ property ];
				}
				
			}// for
			
		}
		
		
		
		/**
		 */

		private function getName(name:String):String
		{
			
			//if name is a NEW name then get the old one
			//so the object doesn't get confused
			
			if(_definition.propertyNames[ name ])
			{
				return _definition.propertyNames[ name ];
			}
			else
			{
				return name;
			}
		}
		
		/**
		 */
		
		private function hasProperty(inst:*,property:String):Boolean
		{
			try
			{
				inst.hasOwnProperty("x");
				return (inst.hasOwnProperty(property) || inst[ property ]);
			}
			catch(e:*){}
			return false;
		}
		
		
		//--------------------
		// Handle the Methods
		//--------------------
		
		/**
		 */
		 
		private function isMethod(property:*):Boolean
		{
			
			//if the instance exists then continue
			var hasProp:Boolean = false;
				
			//sometimes hasOwnProperty does not work, like in Array, so use New Inst just in case
			try
			{
				hasProp = (_target.hasOwnProperty(property) || _target[ property ]);
				
				//shittier, but it's passed if the publicAPI fails, which usually means the instance is an array
				hasProp = _target[ property ] is Function;
				
				//usually an error is caught only when the instance is an array
				try{
					return _info.publicAPI[ property ].type == PropertyType.METHOD;
				}catch(e:*){
				}
				
			}
			catch(e:*){

			}
			

			return hasProp;
			
		}
		
		/**
		 */
		
		private function setMethodParams (name:*,value:*):void
		{
			var newValue:* = value;
			
			if(isMethod(name))
			{
				
				var firstParamIsArray:Boolean = false;
				try{

					firstParamIsArray = _info.publicAPI[ name ].getParamTypeClass(0).prototype is Array && _info.publicAPI[ name ].paramLength == 1;
				}catch(e:*){}
				
				if(!(value is Array) || firstParamIsArray)
				{
					newValue = [value];
				}
				
				
					
				try
				{
					_target[ name ].apply(_target,newValue);
				}catch(e:*){}
			}
		}
		
		
		//--------------------
		// Handle the properties
		//--------------------
		


	}
}