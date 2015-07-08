package com.bridge.ui.utils.tween.easing{
	public class Exponential{
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			var flip = 1;
			if (c < 0) {
				flip *= -1;
				c *= -1;
			}
			return flip * (Math.exp(Math.log(c)/d * t)) + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			var flip = 1;
			if (c < 0) {
				flip *= -1;
				c *= -1;
			}
			return flip * (-Math.exp(-Math.log(c)/d * (t-d)) + c + 1) + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			var flip = 1;
			if (c < 0) {
				flip *= -1;
				c *= -1;
			}
			if (t < d/2) return flip * (Math.exp(Math.log(c/2)/(d/2) * t)) + b;
			return flip * (-Math.exp(-2*Math.log(c/2)/d * (t-d)) + c + 1) + b;
		}
	}
}