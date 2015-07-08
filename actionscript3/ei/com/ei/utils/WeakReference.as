package com.ei.utils
{
	import flash.utils.Dictionary;
	
	public class WeakReference
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _dict:Dictionary;
		
		public function WeakReference(ref:Object)
		{
			
			
			_dict = new Dictionary(true);
			
			_dict[ref] = null;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function getObject():Object
		{
			for(var obj:Object in _dict)
				return obj;
			
			
			return null;
		}

	}
}