package com.bridge.ui.utils.tween.easing
{
	public class Quadratic{
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t*t/(d*d) + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c*t*t/(d*d) + 2*c*t/d + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return 2*c*t*t/(d*d) + b;
			var ts = t - d/2;
			return -2*c*ts*ts/(d*d) + 2*c*ts/d + c/2 + b;
		}
	}
}