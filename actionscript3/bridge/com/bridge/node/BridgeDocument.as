/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/
 
package com.bridge.node
{
	import com.bridge.BridgeCore;
	import com.bridge.module.XMLNSModule;
	
	import flash.xml.XMLDocument;
	
	
	/**
	 * BridgeDocument is used when executing Bridge Applications
	 */
	
	public class BridgeDocument extends BridgeNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _firstChild:Object;
        private var _document:XMLDocument;
        
        
        //for when classes are not embedded
        private const _m1:XMLNSModule;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * The Constructor
         * @param script the script to execute
		 */
		 
		public function BridgeDocument(script:Object = null)
		{
			super(script);
			
			this.nodeLibrary.registerModule(new XMLNSModule("xmlns"));
			
		}
		
        
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * Parses and executes an XML script
         * @param xml the script to execute
		 */
		
		override public function parseXML(xml:Object):void
		{
			
			super.parseXML(xml);
			
			
			this.restart();
		}
		
		
		


	}
}