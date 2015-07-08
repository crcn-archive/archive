

//waits for the parent display object to be added to the stage

package com.bridge.ui.core
{
	import com.ei.utils.ArrayUtils;
	
	import flash.display.DisplayObject;
	
	public class ViewProxy extends ObjectProxy
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _childList:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */

		public function ViewProxy()
		{
			_childList = [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get numChildren():int
		{
			if(target)
			{
				return target.numChildren;
			}
			
			return _childList.length;
		}
		
		/**
		 */
		override public function set target(value:Object):void
		{
			super.target = value;
			
			for each(var child:DisplayObject in _childList)
			{
				target.addChild(child);
			}
			
			_childList = [];
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function removeAllChildren():void
		{
			for each(var child:DisplayObject in _childList)
			{
				target.removeChild(child);
			}
			
			_childList = [];
		}
        /**
		 */
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			
			_childList.push(child);
			
			if(target)
			{
				target.addChild(child);
			}
			
			
			
			return child;
		}
		
		/**
		 */
		public function addChildAt(child:DisplayObject,index:int):DisplayObject
		{
			ArrayUtils.insertAt(_childList,child,index);
			
			if(target)
			{
				target.addChildAt(child,index);
			}
			
			
			return child;
		}
		
		/**
		 */
		public function contains(child:DisplayObject):Boolean
		{
			if(target)
			{
				return target.contains(child);
			}
			
			return _childList.indexOf(child) > -1;
		}
		
		/**
		 */
		public function getChildAt(index:int):DisplayObject
		{
			
			
			if(target)
			{
				
				//do not use numChildren because it may loop back to this numChildren
				//if the child is out of bounds then return null
				try
				{
					return target.getChildAt(index);
				}catch(e:*)
				{
					//trace("VewProxy::"+e);
					return null;
				}
				
			}
			
			return _childList[index];
		}
		
		/**
		 */
		public function getChildIndex(child:DisplayObject):int
		{
			if(target)
			{
				return target.getChildIndex(child);
			}
			
			return _childList.indexOf(child);
		}
		
		/**
		 */
		public function removeChild(child:DisplayObject):DisplayObject
		{
			var index:int = _childList.indexOf(child);
			
			if(index > -1)
			{
				if(index == 0)
					_childList.pop();
				else
					_childList.splice(index-1,1);
			}
			
			
			if(target && target.contains(child))
			{
				target.removeChild(child);
			}
			
			
			return child;
		}
		
		/**
		 */
		 
		public function removeChildAt(index:int):DisplayObject
		{
			var rChild:DisplayObject;
			
			//if(!this.getChildAt(index))
			//	return null;
				
			if(target)
			{
				try
				{
					rChild = target.removeChildAt(index);
				}catch(e:*)
				{
					//index out of bounds
					return null;
				}
			}
			
			
			if(!rChild)
				rChild = _childList.splice(index-1,1)[0];
			
			return rChild;
		}
		
	}
}