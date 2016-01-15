package
{
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * TweenLiteのデフォルトのイージングはQuad.easeOut。
	 * 同様のイージングを作る場合の例を作成。
	 * 基本構造を示すことを優先しているので、実際に使う上での使いやすさや描画やメモリ最適化等は考慮していません。
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class TweenLite2 extends Sprite 
	{
		private var _red:Shape = new Shape();
		private var _green:Shape = new Shape();
		private var _blue:Shape = new Shape();
		private var _timer:Timer;
		public function TweenLite2() 
		{
			// 赤の四角を描く
			_red.graphics.beginFill(0xFF0000);
			_red.graphics.drawRect( -20, -20, 40, 40);
			_red.graphics.endFill();
			_red.y = 100;
			// 表示オブジェクトに登録
			addChild(_red);
			
			// 緑の四角を描く
			_green.graphics.beginFill(0x00FF00);
			_green.graphics.drawRect( -20, -20, 40, 40);
			_green.graphics.endFill();
			_green.y = 200;
			// 表示オブジェクトに登録
			addChild(_green);
			
			// 青の四角を描く
			_blue.graphics.beginFill(0x0000FF);
			_blue.graphics.drawRect( -20, -20, 40, 40);
			_blue.graphics.endFill();
			_blue.y = 300;
			// 表示オブジェクトに登録
			addChild(_blue);
			
			// ステージ上をクリックしたら実行されるイベントを登録。
			// Flashのスタンダードなイベント登録方法。
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			_red.x = _green.x = _blue.x = 0;
			
			// デフォルトのイージングは Quad.easeOut
			new TweenLite(_red, 2, { "x":465 } ).play();
			
			// 明示的にQuad.easeOutのイージングを指定した場合。
			new TweenLite(_green, 2, { "x":465, ease:Quad.easeOut } ).play();
			
			// 自作のtweenエンジン
			originalTween(_blue, 2, 465);
		}
		
		private var _toX:Number;
		private function originalTween(target:DisplayObject, time:Number, toX:Number):void {
			
			_toX = toX;
			
			// ミリ秒単位で指定したタイマーイベント間の遅延 30fpsの場合、1000/30 = 33.3ミリ秒
			var delay:Number = 1000 / stage.frameRate;
			// 繰り返しの回数を指定します。継続時間とフレームレートから求める。
			var repeatCount:int = Math.ceil(time * stage.frameRate);
			
			_timer = new Timer(delay, repeatCount);
			_timer.addEventListener(TimerEvent.TIMER, timer_timer);
			_timer.start();
		}
		
		private function timer_timer(e:TimerEvent):void 
		{
			
			// 現在の繰り返しは何回目か。
			var t:Number = _timer.currentCount;
			// 出発地の x
			var b:Number = 0;
			// 目的地の x
			var c:Number = _toX;
			// 指定した繰り返し回数。
			var d:Number = _timer.repeatCount;
			
			_blue.x = easeOutQuad(t, b, c, d);
			
			// 最後だった場合、イベントをリムーブして、timerもGCへ
			if (_timer.currentCount == _timer.repeatCount) {
				_timer.removeEventListener(TimerEvent.TIMER, timer_timer);
				_timer = null;
				return;
			}
		}
		
		private static function easeOutQuad (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * (t /= d) * (t - 2) + b;
		}
		
	}
}