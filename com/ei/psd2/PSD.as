package com.ei.psd2
{
	
	
	import com.ei.utils.SpriteUtils;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	
	public class PSD extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _source:String;
        private var _header:Header;
        private var _layers:Array;
        private var _colorMode:int;
        private var _colorTable:Array;
        private var _globalLayerResources:Array;
        private var _imageResources:Array;
        private var _tempGlobalLayerMask:ByteArray;
        private var _globalImage:GlobalImage;
        
        private var _stream:URLStream;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
		public function PSD()
		{
			_globalLayerResources = new Array();
			_imageResources 	  = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get header():Header
		{
			return _header;
		}
		
		public function set header(value:Header):void
		{
			_header = value;
		}
		
		/**
		 */
		
		public function get globalLayerResources():Array
		{
			return _globalLayerResources;
		}
		
		/**
		 */
		
		public function get resources():Array
		{
			return _imageResources;
		}
		
		/**
		 */
		 
		public function get bitsPerPixel():int
		{
			return _header.bitsPerPixel;
		}
		
		/**
		 */
		
		public function get size():Point
		{
			return new Point(_header.columns,_header.rows);
		}
		
		/**
		 */
		
		public function get channels():int
		{
			return _header.channels;	
		}
		
		/**
		 */
		
		public function get layers():Array
		{
			return _layers;
			
		}
		
		public function set stream(value:*):void
		{
			
			this.init();
			
			value.position = 0;
			
			var psdBytes:ByteArray = new ByteArray();
     		
     		value.readBytes(psdBytes,0,value.bytesAvailable);
     		
     		
			var reader:BinaryPSDReader = new BinaryPSDReader(psdBytes);
        	
        	
        	
        	var sig:String = new String(reader.readPSDChars(4));
        	
        	
        	
        	if(sig != "8BPS")
        		return;
        	
        	
        	_header = new Header(reader);
        	
        	//_globalImage = new GlobalImage(this);
        	
        	
        	var nPaletteLength:int = reader.readUint32();
        	
        	if(nPaletteLength > 0)
        	{
        		
        		
        		_colorTable = new Array();
        		
        		for(var i:int = 0; i < nPaletteLength; i+=3)
        		{
        			_colorTable.push(ColorControl.fromRGB(reader.readByte(),reader.readByte(),reader.readByte()));
        		}
        		
        		
        		if(_colorMode == ColorModes.Duotone)
        		{
        			//do nothing?
        		}
        		else
        		{
        			
        		}
        	}
        	
        	var nResLength:int = reader.readUint32();
        	
        	
        	reader.readPSDChars(nResLength);
        	
        	if(nResLength > 0)
        	{
        		
        		//LATER
        		//_imageResources = ImageResource.readImageResources(reader);
        		
        	}
        	
        	var nTotalLayersBytes:int = reader.readUint32();
        	var nAfterLayersDefinitions:int = reader.position + nTotalLayersBytes;
        	
        	
        	/*if(nTotalLayersBytes == 8)
        	{
        		//
        	}
        	else
        	{
        		*/
        		
        		

        		var nSize:int = reader.readUint32();
        		var nLayersEndPos:int = reader.position + nSize;

        		var nNumLayers:int = reader.readInt16();
        		
        		var bSkipFirstAlpha:Boolean = false;
        		

        		if(nNumLayers < 0)
        		{
        			bSkipFirstAlpha = true;
        			nNumLayers = -nNumLayers;
        		}
        		
        		
        		var loadOrderLayers:Array = new Array();
        		_layers = new Array();
        	
        		var layerInfo:Layer;
        		
        	
        		for(var nLayerNum:int = 0; nLayerNum < nNumLayers; nLayerNum++)
        		{
        			
        			
        			layerInfo = new Layer(reader,this);
        			
        			layerInfo.debugLayerLoadOrdinal = nLayerNum;
        			
        			_layers.push(layerInfo);
        			loadOrderLayers.push(layerInfo);
        		}
        	
        	
        		var layer:Layer;
        		
        		
        		
        		for(var layerNum:int = 0; layerNum < nNumLayers; layerNum++)
        		{
        			layer = loadOrderLayers[layerNum];
        			
        			//layer groups do NOT have pixels
        			
        			
        			layer.readPixels(reader);
        			
        			
        		}
        		
        		
        		
        		reader.jumpToEvenNthByte(4);
        		
        		if(reader.position != nLayersEndPos)
        			reader.position = nLayersEndPos;
        			
        		
        		var maskLength:int = reader.readUint32();
        		
        		
        		if(maskLength > 0)
        		{
        			
        			this._tempGlobalLayerMask = reader.readBytes(maskLength);
        			//_tempGlobalLayerMask = reader.readBytes(maskLength);
        			
        			
        			//IMP LATER
        		}
        		
        		var cpPos:int;
        		var sHeader:String;
        		var res:LayerResource;
        		
        		
        		
        		while(true)
        		{
        			cpPos = reader.position;
        			sHeader = reader.readPSDChars(4);
        			
        			reader.position = cpPos;
        			
        			if(sHeader != "8BIM")
        			{
        				break;
        			}
        			
        			
        			res = LayerResource.readLayerResource(reader,null);
        			
        			_globalLayerResources.push(res);
        		}
        		
        	//}
        	
        	
        	var readGlobalImage:Boolean = true;
        	
        	if(readGlobalImage)
        	{
        		_globalImage = new GlobalImage(this);
        		_globalImage.load(reader);
        		
        	}
        	
        	
        	
        	SpriteUtils.clear(this);
        	
        	//add the layers to the PSD
        	
        	var currentParent:Sprite = this;
        	var prevParent:Sprite;
        	
        	for each(var layer:Layer in layers)
        	{
        		var obj:Sprite;
        		
        		if(!layer.isGroupEnd())
        		{
        			obj = layer.displayObject as Sprite;
        			obj.visible = layer.visible;
        		
        		}
        		
        		if(!layer.isGroup() && !layer.isGroupEnd())
        		{
        			//trace(obj);
        			currentParent.addChild(obj);
        		}
        		
        		if(layer.isGroup())
        		{
        			//trace("IS GROUP");
        			//currentParent = obj;
        			//trace(currentParent,objcurrentParent.parent);
        		}
        		
        		//trace(currentParent,currentParent.parent,layer.isGroupEnd());
        		if(layer.isGroupEnd())
        		{
        			//currentParent = currentParent.parent as Sprite;
        		}
        		
        	}
        	
        	dispatchEvent(new PSDEvent(PSDEvent.COMPLETE));

		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function addResource(id:int):ImageResource
		{
			//var type:Type
			//_imageResources.push(
			
			return new ImageResource;
		}
		
        	
        	
        //--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function init():void
		{
			ImageResource.prepare();
		}
        	
       
 	}
}