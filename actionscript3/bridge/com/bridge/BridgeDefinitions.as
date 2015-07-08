package com.bridge
{
	import com.bridge.module.*;
	import com.bridge.module.bind.BindableModule;
	import com.bridge.module.component.*;
	import com.bridge.node.BridgeNode;
	import com.bridge.ui.controls.*;
	import com.bridge.ui.controls.media.VideoPlayer;
	import com.bridge.ui.controls.media.audio.AudioFactory;
	import com.bridge.ui.core.*;
	import com.bridge.ui.style.CSSManager;
	import com.bridge.ui.utils.tween.Tween;
	import com.bridge.ui.utils.tween.easing.*;
	import com.ei.display.decor.Dragger;
	import com.ei.utils.ArrayUtils;
	import com.ei.utils.ObjectUtils;
	import com.ei.utils.SpriteUtils;
	import com.ei.utils.StringUtils;
	import com.ei.utils.keys.KeyboardControl;
	
	
	internal class BridgeDefinitions
	{	
		//modules
		private var _m1:LoadManagerModule;
		private var _m2:JSBroadcastModule;
		private var _m3:CallFunctionModule;
		private var _m4:LoopModule;
		private var _m5:EventModule;
		private var _m6:JavascriptModule;
		private var _m7:ChangeComponentPropertyModule;
		private var _m8:ScriptModule;
		private var _m9:NodeInstanceModule;
		private var _m10:ExternalAssetModule;
		private var _m11:XMLNSModule;
		private var _m12:ScriptExclusionModule;
		private var _m13:ComponentModule;
		private var _m14:InstanceModule;
		private var _m15:BindableModule;
		private var _m16:FMLHandlerModule;
		private var _m17:ConditionalModule;
		private var _m18:SleepModule;
		private var _m19:CreateFunctionModule;
		private var _m20:VariableModule;
		
		//components
		private var _c1:Tween;
		private var _c2:Dragger;
		private var _c3:Button;
		private var _c4:Canvas;
		private var _c5:Container;
		private var _c6:UIComponent;
		private var _c7:TextArea;
		private var _c8:Label;
		private var _c9:Text;
		private var _c10:TextInput;
		private var _c11:Image;
		private var _c12:VideoPlayer;
		private var _c13:AudioFactory;
		
		//utils
		private var _u1:Bounce;
		private var _u2:Elastic;
		private var _u3:Back;
		private var _u4:Strong;
		private var _u5:None;
		private var _u6:Exponential;
		private var _u7:Quadratic;
		private var _u8:Regular;
		private var _u9:Sinusoidal;
		private var _u10:KeyboardControl;
		private var _u11:CSSManager;
		private var _u12:SpriteUtils;
		private var _u13:ObjectUtils;
		private var _u14:StringUtils;
		private var _15:ArrayUtils;
		private var _u16:RegExp;
		
		//other
		private var _o1:BridgeNode;
		
	
	}
}
		
		
		

