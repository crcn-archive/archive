package com.ei.psd2
{

	import com.ei.display.decor.Dragger;
	import com.ei.psd2.display.PSDDisplayObject;
	import com.ei.psd2.layerResources.*;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class Layer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _document:PSD;
		private var _rect:Rectangle;

		private var _mask:Mask;
		
		private var _blendRanges:Array;
		
		private var _name:String;
		
		private var _isMerged:Boolean;

		private var _channels:Array;
		private var _visible:Boolean;
		private var _resources:Array = new Array();
		
		private var _layerResource:LayerResource;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
        
        public var debugLayerLoadOrdinal:int;
        public var blendKey:String = BlendKeys.norm;
        public var flags:int;
        public var opacity:Number = 1;
        public var clipping:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Layer(reader:BinaryPSDReader,doc:PSD)
		{
			
			
			_document = doc;
			_rect = new Rectangle();
			
			if(reader == null)
				return;
				
			
			channels = new Array();
			_rect	  = reader.readPSDRectangle();
			
			var numChannels:int = reader.readUint16()
			
			
			
			var channel:Channel;
			

			for(var channelNum:int = 0; channelNum < numChannels; channelNum++)
			{
				channel = new Channel(reader,this);
				
				//if(channels[channel.usage] != null)
				//	continue;//TODO:!!
				
				if(channel.usage == -2)
					trace("better change the channels to objects");
					
				channels.push(channel);	
				//channels[channel.usage] = channel;
			}
			
			var sHeader:String = reader.readPSDChars(4);
			
			
			if(sHeader != "8BIM")
				throw new Error("Layer ChannelHeader error!");
			
			
			var blend = reader.readPSDChars(4);
			
			
			
			var nBlend:int = -1;
			
			
			
			if(BlendKeys[blend])
			{
				blendKey = BlendKeys[blend];
			}
			/*
			
			CSHARP
			
			try
            {
                nBlend = (int)Enum.Parse(typeof(_blendKeysPsd), this.BlendKey);
            }
            catch
            {
                throw new Exception("Unknown blend key: " + this.BlendKey);
            }
            if (nBlend >= 0)
            {
                BlendKeys key = (BlendKeys)nBlend;
                this.BlendKey = Enum.GetName(typeof(BlendKeys), key);
            }
            
            */
            
            	//trace(reader.position);
            opacity  = Math.abs(reader.readByte() << 8)/256; //needs to be percent, opac in photoshop is 0-255
           
            clipping = reader.readByte();
            flags     = reader.readByte();
            
           
            
            reader.readByte(); //padding
            
            var extraDataSize:int = reader.readUint32();
            
            var nChannelEndPos:int = reader.position + extraDataSize;
            
           
            if(extraDataSize > 0)
            {
            	var nLength:int;
            	
            	_mask = new Mask(reader,this);
            	
            	
            	if(_mask.rectangle == null)
            	{
            		_mask = null;
            	}
            	
            	
            	_blendRanges = new Array();
            	
            	nLength = reader.readUint32();
            	
            	
            	for(var i:int = 0; i < nLength / 8; i++)
            	{
            		_blendRanges.push(reader.readUint32());
            		_blendRanges.push(reader.readUint32());
            		
            	}
            	
            	
            	
            	_name = reader.readPascalString();
            	
            	
            	var posBefore:int = reader.position;
            	
            	sHeader = reader.readPSDChars(4);
            	
            	
            	if(sHeader != "8BIM")
            	{
            		reader.position -= 2;
            		sHeader = reader.readPSDChars(4);
            	}
            	
            	if(sHeader != "8BIM")
            	{
            		reader.position = posBefore;
            	}
            	else
            	{
            		reader.position -= 4;
					
					
					//trace("LAYER");
            		_resources = LayerResource.readLayerResources(reader,null);
            		
            	
            		//trace(ObjectUtils.getLength(_resources));
            		//_layerResource = LayerResource.readLayerResource(reader,null);
            		//trace("READING DATA");
            		
            	}
            	if(reader.position != nChannelEndPos)
            	{
            		reader.position = nChannelEndPos;
            	}
            }
			
		}
		
		/**
		 */
		
		public function readPixels(reader:BinaryPSDReader):void
		{
			var numChannelsToRead:int = channels.length;
			
			
			//some layers don't have pixel data, however
			//they do have an 8 bit buffer instead, so skp ahead 8
			if(this.isGroup() || this.isGroupEnd())
			{
				reader.position += 8;
				return;
			}
			
			
			/*if(channels[-2])
			{
				trace(numChannelsToRead);
				numChannelsToRead--;
			}
			*/
			
			
			
			for each(var channel:Channel in channels)
			{
				if(channel.usage == -2)
				{
					numChannelsToRead--;
					break;
				}
			}
			
			
			var px:PixelData = new PixelData(width,height,bitsPerPixel,numChannelsToRead,isMerged);
			
			px.read(reader);

			var i:int = 0;
			
			
			for each(var ch:Channel in channels)
			{
				
				
				if(ch.usage != -2)
				{
					ch.data = px.getChannelData(i++);
					
					
					
				}
				
				
			}

			if(_mask != null)
			{
				px = new PixelData(width,height,bitsPerPixel,1,false);
				px.read(reader);
				_mask.data = px.getChannelData(0);
			}
			
			
		}
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get layerResource():LayerResource
		{
			return _layerResource;
		}
		
		
		/**
		 */
		
		public function get displayObject():DisplayObject
		{
			
			
			var sp:PSDDisplayObject = new PSDDisplayObject();
			
			
			
			
			if(!isGroup())
			{
				var obj:DisplayObject = new BitmapObject(this).displayObject;
			
			
				sp.addChild(obj);
				
				setDOValues(sp);
				
				if(_resources != null)
				{
					
					
					for each(var resource:LayerResource in _resources)
					{
						resource.draw(sp);
					}
					
					//obj = _layerResource.displayObject;
				}
			
				
				
			}
			else
			{
				setDOValues(sp);
			}
				
			
			
			
			
				
			
			
			
			var drg:Dragger = new Dragger(sp);
			
				
			return sp;
		}
		
		
		private function setDOValues(sp:PSDDisplayObject):void
		{
			sp.x = x;
			sp.y = y;
			sp.height = height;
			sp.width = width;
			sp.alpha = opacity;
			sp.blendMode = blendKey;
		}
		
		/**
		 */
		
		public function isGroup():Boolean
		{
			var res:UnicodeName = getLayerResource(UnicodeName) as UnicodeName;
			
			if(!res)
				return false;
				
			return res.name == "</Layer group>";
		}
		
		/**
		 */
		
		public function isGroupEnd():Boolean
		{
			var res:SectionDivider = getLayerResource(SectionDivider) as SectionDivider;
			
			return res != null && !isGroup();
		}
		
		/**
		 */
		
		public function getLayerResource(type:Class):LayerResource
		{
			for each(var res:LayerResource in _resources)
			{
				if(res is type)
				{
					return res;
				}
			}
			
			return null;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
         */
        
        public function get document():PSD
        {
        	return _document;
        }
        
        
	
        /**
         */
        
        public function get width():Number
        {
        	return _rect.width;
        }
        
        
        /**
		 */
		
		public function set width(value:Number):void
		{
			if(_rect == null)
				_rect = new Rectangle();
			
			_rect.width = value;
		}
        
        /**
         */
        
        public function get height():Number
        {
        	return _rect.height;
        }
        
        
        /**
		 */
		 
		public function set height(value:Number):void
		{
			if(_rect == null)
				_rect = new Rectangle();
			
			_rect.height = value;
		}
		
		/**
		 */
		
		public function get x():Number
		{
			return _rect.x;
		}
		
		/**
		 */
		
		public function get y():Number
		{
			return _rect.y;
		}
        
        /**
		 */
		
		public function get bitsPerPixel():int
		{
			return _document.bitsPerPixel;
		}
		
		/**
		 */
		
		public function get numChannels():*
		{
			return 
		}
		
		/**
		 */
		
		public function set visible(value:Boolean):void
		{
			//set { this.Flags = Endogine.Serialization.BinaryReaderEx.SetBit(this.Flags, (int)FlagValues.Invisible, !value); }
		}
		
		public function get visible():Boolean
		{
			return (this.flags & FlagValues.Invisible) == 0;
		}
		
		/**
		 */
		
		public function get isMerged():Boolean
		{
			return _isMerged;
		}
		
		public function set isMerged(value:Boolean):void
		{
			_isMerged = value;
		}

		/**
		 */
		
		
		/*public function get layerID():int
		{
			var res:LayerId = getResource(LayerId) as LayerId;
			
			if(res == null)
				return -999;
			
			return res.id;
		}
		
		
		public function set layerID(value:int):void
		{
			var res:LayerId = this.getOrCeateLayerResource(LayerId) as LayerId;
			res.id = value;
		}
		
		
		
		public function get referencePoint():Point
		{
			return ReferencePoint(this.getResource(ReferencePoint)).point;
		}
		
		
		public function get blendClipping():Boolean
		{
			return 	BlendClipping(this.getResource(BlendClipping)).value;
		}
		
		
		
		public function get blend():Boolean
		{
			return 	BlendElements(this.getResource(BlendElements)).value;
		}
		
		public function get knockout():Boolean
		{
			return 	Knockout(this.getResource(Knockout)).value;
		}
		
		
		public function get sheetColor():int //returns system.drawing.color
		{
			return SheetColor(this.getResource(SheetColor)).color;
		}
		
		*/
		 
		public function set channels(value:Array):void
		{
			_channels = value;
		}
		
		public function get channels():Array
		{
			return _channels;
		}
		
		
		
		
		/**
		 */
			
		public function get name():String
		{
			return _name;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		/*public function getResource(type:Class):LayerResource
		{
			for each(var res:LayerResource in _resources.Values)
			{
				if(res is type)
				{
					return res;
				}
			}
			
			return null;
		}*/
		
		/*public function getOrCeateLayerResource(type:Class):LayerResource
		{
			var res:LayerResource = getResource(type);
			
			if(res == null)
			{
				res = new type();
				_resources[res.tag] = res;
			}
			
			return res;
		}*/
		
	}
}