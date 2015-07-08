package com.bridgeo.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import com.bridgeo.events.*;
	import com.bridgeo.command.*;
	
	public class BridgeOController extends FrontController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BridgeOController()
		{
			super();
			
			this.addCommand(BridgeOEvent.LOAD_CORE,LoadBridgeCoreCommand);
			this.addCommand(BridgeOEvent.ADD_SCRIPT,AddScriptCommand);
			this.addCommand(BridgeOEvent.OBFUSCATE,ObfuscateCommand);
			this.addCommand(BridgeOEvent.SELECT_OUTPUT,SelectOutputCommand);
		}

	}
}