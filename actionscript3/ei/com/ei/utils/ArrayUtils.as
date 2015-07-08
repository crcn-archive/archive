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

package com.ei.utils
{
	public class ArrayUtils
	{
		
		/**
		 * takes out specific indexes of an array
		 */
		 
		public static function truncate(target:Array,indexes:Array):Array
		{
			var newArray:Array = new Array();
			
			for(var i:int = 0; i < target.length; i++)
				
				//make sure the index isn't in the exlusions
				if(indexes.indexOf(i) == -1)
				{
					//push the value to the new array
					
					
					newArray.push(target[i]);
				}
				
				//garbage collect
				delete target[i];
				
			
			
			return newArray;
		}
		
		/**
		 */
		
		public static function truncateByValue(target:Array,values:Array):Array
		{
			var newArray:Array = new Array();
			
			
			for(var i:int = 0; i < target.length; i++)
			{	
				//make sure the index isn't in the exlusions
				if(values.indexOf(target[i]) == -1)
				{
					//push the value to the new array
					
					
					newArray.push(target[i]);
				}
				
				//garbage collect
				delete target[i];
			}
			
			
				
			
			
			return newArray;
		}
		
		/**
		 * searches an array with a list of items
		 */
		 
		public static function getIndex(items:Array,target:Array,descending:Boolean = false):int
		{
			var index:int = -1;
			
			for each(var item:* in items)
			{
				if(descending)
					index = target.lastIndexOf(item);
				else
					index = target.indexOf(item);
				
				//cut it short if an item is found
				if(index != -1)
					break;
			}
			
			return index;
		}
		
		/**
		 * swap index values
		 */
		
		public static function swap(item:Array,index1:int,index2:int):void
		{
			var ch:* = item[ index1 ];
			var nx:* = item[ index2 ];
			
			item[index1] = nx;
			item[index2] = ch;
		}
		
		
		/**
		 */
		
		public static function insertAt(item:Array,value:*,index:int):Array
		{
			if(!item)
				return item;
				
			item.push(value);
			
			swap(item,index,item.length-1);
			
			return item;
			
			
		}
		

	}
}