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
	
	public class ClassApply
	{
		
		/**
		 * retrieves an instance of an object by using just its class
		 * and parameters as an array
		 */
		 
		public static function getInstance(cls:Class,p:Array):*
		{
			var length:int = p.length;
			if(!cls)
				return null;
				
			
			switch(length)
			{
				case 0:
					return new cls();
				break;
				
				case 1:
					return new cls(p[0]);
				break;
				
				case 2:
					return new cls(p[0],p[1]);
				break;
				
				case 3:
					return new cls(p[0],p[1],p[2]);
				break;
				
				case 4:
					return new cls(p[0],p[1],p[2],p[3]);
				break;
				
				case 5:
					return new cls(p[0],p[1],p[2],p[3],p[4]);
				break;
				
				case 6:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5]);
				break;
				
				case 7:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6]);
				break;
				
				case 8:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7]);
				break;
				
				case 9:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8]);
				break;
				
				case 10:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9]);
				break;
				
				case 11:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10]);
				break;
				
				case 12:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11]);
				break;
				
				case 13:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12]);
				break;
				
				case 14:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12],p[13]);
				break;
				
				case 15:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12],p[13],p[14]);
				break;
				
				case 16:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12],p[13],p[14],p[15]);
				break;
				
				case 17:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12],p[13],p[14],p[15],p[16]);
				break;
				
				case 18:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12],p[13],p[14],p[15],p[16],p[17]);
				break;
				
				case 19:
					return new cls(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],p[11],p[12],p[13],p[14],p[15],p[16],p[17],p[18]);
				break;
				
			}//switch
			
			return null;
		}
	}
}