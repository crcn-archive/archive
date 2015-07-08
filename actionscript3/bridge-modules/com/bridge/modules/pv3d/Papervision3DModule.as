package com.bridge.modules.pv3d
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.events.FMLEvent;
	
	import flash.utils.Dictionary;
	
	public class Papervision3DModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _3dSwaps:Dictionary;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Papervision3DModule(ns:String)
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("x",setX);
			this.nodeEvaluator.addHandler("y",setY);
			this.nodeEvaluator.addHandler("z",setZ);
			this.nodeEvaluator.addHandler("rotationX",setRotationX);
			this.nodeEvaluator.addHandler("rotationY",setRotationY);
			this.nodeEvaluator.addHandler("rotationZ",setRotationZ);
			this.nodeEvaluator.addHandler("zoom",setZoom);
			//this.nodeEvaluator.addHandler("setProperty",setProperty);
			
			_3dSwaps = new Dictionary();
			
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
			return [ModuleType.PROPERTY_NAME,ModuleType.NODE_NAME];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function setX():void
		{
			set3DProp("x");	
		}
		
		/**
		 */
		
		private function setY():void
		{
			set3DProp("y");
		}
		/**
		 */
		
		private function setZ():void
		{
			set3DProp("z");
			
		}
		
		
		/**
		 */
		
		private function setRotationX():void
		{
			set3DProp("rotationX");
			
		}
		
		
		/**
		 */
		
		private function setRotationY():void
		{
			set3DProp("rotationY");
			
		}
		
		
		/**
		 */
		
		private function setRotationZ():void
		{
			set3DProp("rotationZ");

		}
		
		/**
		 */
		
		private function setZoom():void
		{
			set3DProp("zoom");
		}
		
		
		
		private function set3DProp(name:String):void
		{
			
			var prop:Number = this.evaluatedNode.attributes[ this.evaluatedProperty ];
			
			var ui:BridgeUI3D = _3dSwaps[evaluatedNode];
			
			if(!ui)
			{
				ui = new BridgeUI3D(evaluatedNode);
				_3dSwaps[evaluatedNode] = ui; 
			}
			
			
			ui[name] = prop;
			
		}

	}
}
	import com.bridge.node.IBridgeNode;
	import com.bridge.events.FMLEvent;
	import com.bridge.modules.component.ComponentModule;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.render.BasicRenderEngine;
	import com.ei.utils.simpleObject.SimpleObject;
	import com.ei.utils.ClassDefinition;
	

	
	class BridgeUI3D 
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _rotationZ:Number;
		private var _rotationY:Number;
		private var _rotationX:Number;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		private var _zoom:Number;
		
		private var _camera:Camera3D;
		private var _scene:Scene3D;
		private var _viewport:Viewport3D;
		private var _renderer:BasicRenderEngine;
		
		private var _node:IBridgeNode;
		
		private var _inited:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		public function BridgeUI3D(node:IBridgeNode)
		{
			_node = node;
			
			node.addEventListener(FMLEvent.MODULES_EVALUATED,onNodeComplete);
			
			_camera = new Camera3D();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set rotationZ(value:Number):void
		{
			_rotationZ = value;
			trace(value);
			render();
		}
		
		public function get rotationZ():Number
		{
			return _rotationZ;
		}
		
		/**
		 */
		
		public function set rotationX(value:Number):void
		{
			_rotationX = value;
			
			render();
		}
		
		public function get rotationX():Number
		{
			return _rotationX;
		}
		
		/**
		 */
		
		public function set rotationY(value:Number):void
		{
			_rotationY = value;
			
			render();
		}
		
		public function get rotationY():Number
		{
			return _rotationY;
		}
		
		
		/**
		 */
		
		public function set x(value:Number):void
		{
			_x = value;
			
			render();
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		/**
		 */
		
		public function set y(value:Number):void
		{
			_y = value;
			
			render();
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		/**
		 */
		
		public function set z(value:Number):void
		{
			_z = value;
			
			render();
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		/**
		 */
		
		public function set zoom(value:Number):void
		{
			_zoom = value;
			
			render();
		}
		
		public function get zoom():Number
		{
			return _zoom;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		
		private function onNodeComplete(event:FMLEvent):void
		{
			event.target.removeEventListener(event.type,onNodeComplete);
			
			
			var comp:ComponentModule = _node.getUsedModule(ComponentModule) as ComponentModule;
			
			var id:String = _node.attributes["instance:id"];
			
			if(id)
			{
				trace("GO");
				_node.parentNode.addVariable("pv3d"+id,this);
			}
			if(!comp)
				return;
				
			
				
			
			
			//get the display object instance so we can remove it
			var instance:* = comp.getInstance(_node);
			
			var simpleObject:SimpleObject = comp.getSimpleObject(_node);
			simpleObject.targetDefinition = new ClassDefinition(this);
			
			_viewport = new Viewport3D();
			
			//swap the parent with this view port
			instance.parent.addChild(_viewport);
			
			
			//remove the original display object
			instance.parent.removeChild(instance);
			
			
			
			_scene = new Scene3D();
			
			
			var plane:Plane = new Plane(new MovieMaterial(instance));
			
			
			_scene.addChild( plane );
			
			
			_renderer = new BasicRenderEngine();
			
			
			_inited = true;
			
			render();
		}
		
		/**
		 */
		
		private function render():void
		{
			if(!_inited)
				return;
				
			//_camera.rotationX = _rotationX;
			//_camera.rotationY = _rotationY;
			_camera.rotationZ = _rotationZ;
			//_camera.x 		  = _x;
			//_camera.y 		  = _y;
			//_camera.z 		  = _z;
			//_camera.zoom 	  = _zoom;
			
			_renderer.renderScene(_scene,_camera,_viewport);
		}
		
	}