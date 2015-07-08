/******************************************************************
 * State - used to have states in a sprite, similar to SimpleButton
 * but not limited to just buttons														
 *  
 * Author: Craig Condon
 * 
 * Purpose: to have states, like pages, allowing more flexiblity
 * 
 * Usage: use whenever multiple display objects are needed in one
 * sprite and are to be swapped out frequently
 * 
 * Note: <delete if none>
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.ei.display
{
	import flash.display.Sprite;
	
	public dynamic class State extends Sprite
	{
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		public function set currentState(state:String):void
		{
			clear();
			addChild(this[ state ]);
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 *gets rid of all the children on the stage
		 */
		 
		private function clear():void
		{
			for(var i:int = 0; i < this.numChildren; i++)
			{
				this.removeChildAt(0);
			}
		}
		 
	}
}