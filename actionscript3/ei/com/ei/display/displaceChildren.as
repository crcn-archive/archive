
override public function addChild(child:DisplayObject):DisplayObject
{
	return target.addChild(child);
}
		
		
/**
 */
		
override public function addChildAt(child:DisplayObject, index:int):DisplayObject
{
	return target.addChildAt(child,index);
}
		
		
/**
 */
		 
override public function removeChild(child:DisplayObject):DisplayObject
{
	return target.removeChild(child);
}
		
		
/**
 */
		
override public function removeChildAt(index:int):DisplayObject
{
	return target.removeChildAt(index);
}
		
		
/**
 */
		 
override public function contains(child:DisplayObject):Boolean
{
	return target.contains(child);
}
		
		
/**
 */
		
override public function getChildAt(index:int):DisplayObject
{
	return target.getChildAt(index);
}
	
/**
*/
		 
override public function getChildByName(name:String):DisplayObject
{
	return target.getChildByName(name);
}
		
		
/**
*/
		 
override public function getChildIndex(child:DisplayObject):int
{
	return target.getChildIndex(child);
}

/**
 */

override public function get numChildren():int
{
	return target.numChildren;
}
