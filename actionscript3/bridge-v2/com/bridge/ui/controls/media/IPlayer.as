package com.bridge.ui.controls.media
{
	public interface IPlayer
	{
		function get percentDone():Number;
		function set volume(value:Number):void;
		function get volume():Number;
		function set bufferTime(value:Number):void;
		function get bufferTime():Number;
		function get percentLoaded():Number;
		function get currentTimeString():String;
		function get timeLeftString():String;
		function get totalSeconds():Number;
		function addCuePoint(cue:Function,time:String,reausable:Boolean,...params:Array):void;
		function clearCuePoints():void;
		function load(value:String):void;
		function togglePlay():void;
		function get paused():Boolean;
		//function play():void;
		function pause():void;
		function stop():void;
		function seek(value:Number):void;
		function get type():String;
		
	}
}