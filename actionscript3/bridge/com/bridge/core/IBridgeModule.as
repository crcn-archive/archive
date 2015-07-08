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
 
package com.bridge.core
{
	import com.bridge.node.BridgeNode;
	
	public interface IBridgeModule
	{
		function evalNode(node:BridgeNode,property:* = null):void;
	}
}