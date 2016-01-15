package
{
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * TweenLiteと同様のイージングを作る場合の例を作成。
	 * 基本構造を示すことを優先しているので、実際に使う上での使いやすさや描画やメモリ最適化等は考慮していません。
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class TweenLite3 extends Sprite 
	{
		private var _red:Shape = new Shape();
		private var _maruRed:Shape = new Shape();
		private var _green:Shape = new Shape();
		private var _maruGreen:Shape = new Shape();
		private var _blue:Shape = new Shape();
		private var _maruBlue:Shape = new Shape();
		
		private var _timerLinear:Timer;
		private var _timerQuad:Timer;
		private var _timerCubic:Timer;
		public function TweenLite3() 
		{
			// 赤の四角を描く
			_red.graphics.beginFill(0xFF0000);
			_red.graphics.drawRect( -20, -20, 40, 40);
			_red.graphics.endFill();
			_red.y = 50;
			// 表示オブジェクトに登録
			addChild(_red);
			// 赤の円を描く
			_maruRed.graphics.beginFill(0xFF0000);
			_maruRed.graphics.drawCircle(0, 0, 20);
			_maruRed.graphics.endFill();
			_maruRed.y = 100;
			// 表示オブジェクトに登録
			addChild(_maruRed);
			
			// 緑の四角を描く
			_green.graphics.beginFill(0x00FF00);
			_green.graphics.drawRect( -20, -20, 40, 40);
			_green.graphics.endFill();
			_green.y = 200;
			addChild(_green);
			_maruGreen.graphics.beginFill(0x00FF00);
			_maruGreen.graphics.drawCircle(0, 0, 20);
			_maruGreen.graphics.endFill();
			_maruGreen.y = 250;
			addChild(_maruGreen);
			
			// 青の四角を描く
			_blue.graphics.beginFill(0x0000FF);
			_blue.graphics.drawRect( -20, -20, 40, 40);
			_blue.graphics.endFill();
			_blue.y = 350;
			addChild(_blue);
			_maruBlue.graphics.beginFill(0x0000FF);
			_maruBlue.graphics.drawCircle(0, 0, 20);
			_maruBlue.graphics.endFill();
			_maruBlue.y = 400;
			addChild(_maruBlue);
			
			// ステージ上をクリックしたら実行されるイベントを登録。
			// Flashのスタンダードなイベント登録方法。
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			_red.x = _green.x = _blue.x = 0;
			_maruRed.x = _maruGreen.x = _maruBlue.x = 0;
			
			// Linear
			new TweenLite(_red, 2, { "x":465, ease:Linear.easeOut } ).play();
			originalTweenLinear(_maruRed, 2, 465);
			
			// Quad.easeOut
			new TweenLite(_green, 2, { "x":465, ease:Quad.easeOut } ).play();
			originalTweenQuad(_maruGreen, 2, 465);
			
			// Cubic.easeOut
			new TweenLite(_blue, 2, { "x":465, ease:Cubic.easeOut } ).play();
			originalTweenCubic(_maruBlue, 2, 465);
		}
		
		private var _toXLinear:Number;
		private var _toXQuad:Number;
		private var _toXCubic:Number;
		
		// Linear
		private function originalTweenLinear(target:DisplayObject, time:Number, toX:Number):void {
			_toXLinear = toX;
			// ミリ秒単位で指定したタイマーイベント間の遅延 30fpsの場合、1000/30 = 33.3ミリ秒
			var delay:Number = 1000 / stage.frameRate;
			// 繰り返しの回数を指定します。継続時間とフレームレートから求める。
			var repeatCount:int = Math.ceil(time * stage.frameRate);
			
			_timerLinear = new Timer(delay, repeatCount);
			_timerLinear.addEventListener(TimerEvent.TIMER, timerLinear_timer);
			_timerLinear.start();
		}
		
		private function timerLinear_timer(e:TimerEvent):void 
		{
			// 現在の繰り返しは何回目か。
			var t:Number = _timerLinear.currentCount;
			// 出発地の x
			var b:Number = 0;
			// 目的地の x
			var c:Number = _toXLinear;
			// 指定した繰り返し回数。
			var d:Number = _timerLinear.repeatCount;
			
			_maruRed.x = easeLinear(t, b, c, d);
			
			// 最後だった場合、イベントをリムーブして、timerもGCへ
			if (_timerLinear.currentCount == _timerLinear.repeatCount) {
				_timerLinear.removeEventListener(TimerEvent.TIMER, timerLinear_timer);
				_timerLinear = null;
				return;
			}
		}
		
		// Quad
		private function originalTweenQuad(target:DisplayObject, time:Number, toX:Number):void {
			_toXQuad = toX;
			var delay:Number = 1000 / stage.frameRate;
			var repeatCount:int = Math.ceil(time * stage.frameRate);
			_timerQuad = new Timer(delay, repeatCount);
			_timerQuad.addEventListener(TimerEvent.TIMER, timerQuad_timer);
			_timerQuad.start();
		}
		
		private function timerQuad_timer(e:TimerEvent):void 
		{
			var t:Number = _timerQuad.currentCount;
			var b:Number = 0;
			var c:Number = _toXLinear;
			var d:Number = _timerQuad.repeatCount;
			_maruGreen.x = easeOutQuad(t, b, c, d);
			if (_timerQuad.currentCount == _timerQuad.repeatCount) {
				_timerQuad.removeEventListener(TimerEvent.TIMER, timerQuad_timer);
				_timerQuad = null;
				return;
			}
		}
		
		// Cubic
		private function originalTweenCubic(target:DisplayObject, time:Number, toX:Number):void {
			_toXCubic = toX;
			var delay:Number = 1000 / stage.frameRate;
			var repeatCount:int = Math.ceil(time * stage.frameRate);
			_timerCubic = new Timer(delay, repeatCount);
			_timerCubic.addEventListener(TimerEvent.TIMER, timerCubic_timer);
			_timerCubic.start();
		}
		
		private function timerCubic_timer(e:TimerEvent):void 
		{
			var t:Number = _timerCubic.currentCount;
			var b:Number = 0;
			var c:Number = _toXLinear;
			var d:Number = _timerCubic.repeatCount;
			_maruBlue.x = easeOutCubic(t, b, c, d);
			if (_timerCubic.currentCount == _timerCubic.repeatCount) {
				_timerCubic.removeEventListener(TimerEvent.TIMER, timerCubic_timer);
				_timerCubic = null;
				return;
			}
		}
		
		
		public static function easeLinear (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*t/d + b;
		}
		
		private static function easeOutQuad (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * (t /= d) * (t - 2) + b;
		}
		
		public static function easeOutCubic (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*((t=t/d-1)*t*t + 1) + b;
		}
		
	}
}