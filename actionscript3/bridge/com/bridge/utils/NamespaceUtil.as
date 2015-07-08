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
 
package com.bridge.utils
{
	public class NamespaceUtil
	{
		
		/**
		 * adds a namespace to a node name 
		 * @param ns the namespace to add
		 * @param value the node name to add the namespace to
		 */
		
		public static function addNamespace(ns:String,value:String):String
		{
			if(ns.length > 0 && value.indexOf(ns+":") == -1)
			{
				return ns+":"+value;
			}
			
			return value;
		}
		
		/**
		 * removes a namespace from a node name regardless if the colon is present
		 * @param ns the namespace to remove
		 * @param value the node name to remove the namespace from
		 */
		
		public static function removeNamespace(ns:String,value:String):String
		{
			var reg:RegExp = new RegExp("^"+ns+":*","x");
			
			return value.replace(reg,"");
		}
		
		/**
		 * removes a namespace only if it's present
		 * @param ns the namespace to remove
		 * @param value the node name to remove the namespace from
		 */
		
		public static function removeNamespaceIfPresent(ns:String,value:String):String
		{
			var reg:RegExp = new RegExp("^"+ns+":","x");

			if(!value)
				return null;
				
			return value.replace(reg,"");
		}
		
		/**
		 * returns a namespace from a node name regardless if the colon is present 
		 * @param value the node name to extract the namespace from
		 */
		
		
		public static function getNamespace(value:String):String
		{

			var reg:RegExp = /\w+/i;
			
			if(!value)
				return "";
			
			var match:Array = value.match(reg);
			
			
			if(!match)
				return "";
			return match[0];
		}
		
		/**
		 * returns the given namespace only when the colon is present
		 * @param the node name to extract the namespace from
		 */
		
		
		public static function getNamespaceIfPresent(value:String):String
		{
			//FIX LATER
			
			var reg:RegExp = /^\w*(?=:.*)/i;
			
			var result:Array = value.match(reg);
			
			if(result == null)
				return "";
			
			return result[0];

		}
		
		/**
		 * checks if the given node name has a namespace
		 * @param ns the namespace to check
		 * @param value the node name to check for the namespace
		 */
		

		
		public static function hasNamespace(ns:String,value:String):Boolean
		{
			
			
			var reg:RegExp = new RegExp(ns+"(?=:)((?=[^=]*))?");
			
			var match:Array = value.match(reg);

			
			return match != null && match.length > 0 || ns == value;
		}
		
		/**
		 * compares two node names
		 */
		
		public static function compare(nodeName1:String,nodeName2:String):Boolean
		{
			
			if(nodeName1 == null || nodeName2 == null)
				return false;
				
			var ns1spl:Array = nodeName1.split(":");
			var ns2spl:Array = nodeName2.split(":");
			
			var ns1:String = "";
			var name1:String= "";
			
			var ns2:String= "";
			var name2:String= "";
			
			if(ns1spl.length > 1)
			{
				ns1 = ns1spl[0];
				name1 = ns1spl[1];
			}
			else
			{
				name1 = ns1spl[0];
			}
			
			if(ns2spl.length > 1)
			{
				ns2 = ns2spl[0];
				name2 = ns2spl[1];
			}
			else
			{
				name2 = ns2spl[0];
			}
			
			
			
			if(ns1 == "*" && name1 == "*")
			{
				return true;
			}
			
			if(name1 == "*" && ns1 == ns2)
			{
				
				return true;
			}
			
			if(ns1 == "" && name1 == nodeName2)
			{
				return true;
			}
			
			if(ns1 != "" && name1 != "" && ns1+":"+name1 == nodeName2)
			{
				return true;
			}
			
			return false;
		}

	}
}