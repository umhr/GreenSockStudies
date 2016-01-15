package
{
	import com.bit101.components.Slider;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * スライダーの位置によって、再生位置を決定。
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class TimelineLite3 extends Sprite 
	{
		private var _timeline:TimelineLite = new TimelineLite();
		private var _slider:Slider;
		public function TimelineLite3() 
		{
			var ballList:Array/*Shape*/ = [];
			
			// 赤丸は6個
			var n:int = 6;
			for (var i:int = 0; i < n; i++) 
			{
				var ball:Shape = new Shape();
				ball.graphics.beginFill(0xFF0000);
				ball.graphics.drawCircle(0, 0, 20);
				ball.graphics.endFill();
				ball.x = 100;
				ball.y = 100 + 50 * i;
				addChild(ball);
				ballList[i] = ball;
			}
			
			// 4段階のポジションを指定する。
			n = 4;
			for (i = 0; i < n; i++) {
				var tweens:Array/*TweenLite*/ = [];
				
				var m:int = ballList.length;
				for (var j:int = 0; j < m; j++) 
				{
					var tx:Number = i == j?400:200;
					var duration:Number = 1;// 変化にかかる時間（秒）。
					tweens[j] = TweenLite.to(ballList[j], duration, { x:tx } );
				}
				
				_timeline.appendMultiple(tweens);
				_timeline.stop();
			}
			
			// ステージ左上に表示するスライダー、操作するとonSlideが実行される
			_slider = new Slider("horizontal", this, 16, 16, onSlide);
			_slider.minimum = 0;
			_slider.maximum = 1;
			
		}
		
		private function onSlide(e:Event):void 
		{
			// スライダーの値に応じた値を設定する。
			var newTime:Number = (_slider.value);
			newTime *= 4;// 4秒間のアニメーションなので0～4となるように、4倍する。
			
			// タイムラインの時刻をnewTime 秒目に移動する。
			_timeline.gotoAndStop(newTime);
		}
		
	}
}