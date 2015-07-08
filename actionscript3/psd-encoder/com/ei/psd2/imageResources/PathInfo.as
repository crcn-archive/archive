package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	import com.ei.psd2.RecordType;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class PathInfo extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var pathNum:int;
		public var commands:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function PathInfo(imgRes:ImageResource)
		{
			trace("CHECK PATHINFO CLASS");
			super(imgRes);
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			
			pathNum = this.id - 2000;
			this.id = 2000;
			
			var numKnots = 0;
			var cnt:int = 0;
			commands = new Array();
			
			while(reader.bytesToEnd > 0)
			{
				var rtype:int = reader.readUint16();
				
				if(cnt == 0 && rtype != -1/*rtype != RecordType.PathFill*/)
					throw new Error("PathInfo start error!");
					
				switch(rtype)
				{
					case RecordType.InitialFill:
						reader.baseStream.position += 1;
						var allPixelStart:Boolean = reader.readBoolean();
						
						reader.baseStream.position += 22;
					break;
					case RecordType.PathFill:
						if(cnt != 0)
							throw new Error("Path Fill?!?!");
							
						reader.baseStream.position += 24;
					break;
					case RecordType.Clipboard:
						var rect:Rectangle = new Rectangle();
						rect.y = reader.readPSDSingle();
						rect.x = reader.readPSDSingle();
						rect.height = reader.readPSDSingle();
						rect.width = reader.readPSDSingle();
						var clp:Clipboard = new Clipboard();
						clp.rectangle = rect;
						clp.scale = reader.readPSDSingle();
						reader.baseStream.position += 4;
						
						this.commands.push(clp);
					break;
					case RecordType.ClosedPathLength:
					case RecordType.OpenPathLength:
						numKnots = reader.readUint16();
						reader.baseStream.position += 22;
						var path:NewPath = new NewPath();
						path.open = (rtype == RecordType.OpenPathLength);
						this.commands.push(path);
					break;
					case RecordType.ClosedPathBezierKnotLinked:
                    case RecordType.ClosedPathBezierKnotUnlinked:
                    case RecordType.OpenPathBezierKnotLinked:
                    case RecordType.OpenPathBezierKnotUnlinked:
                    	var bz:BezierKnot = new BezierKnot();
                    	
                    	var pts:Array = new Array();
                    	
                    	for(var i:int = 0; i < 3; i++)
                    	{
                    		var y:Number = reader.readPSDFixedSingle();
                    		pts[i] = null;
                    		//pts[i] = new Point(reader.readPSDFixedSingle(),y) / 256;
                    	}
                    	
                    	bz.control1 = pts[0];
                    	bz.anchor = pts[1];
                    	bz.control2 = pts[2];
                    	bz.linked = (rtype == RecordType.ClosedPathBezierKnotLinked || rtype == RecordType.OpenPathBezierKnotLinked);
                    	
                    	commands.push(bz);
                    	numKnots--;
                    break;
				}
				cnt++;
			}
			
			//reader.close();
		}

	}
}
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
class BezierKnot
{
	public var control1:Point;
	public var anchor:Point;
	public var control2:Point;
	public var linked:Boolean;
	
	
}

class Clipboard
{
	public var rectangle:Rectangle;
	public var scale:Number;
}

class NewPath
{
	public var open:Boolean;
}