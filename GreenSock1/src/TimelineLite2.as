package
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * TimelineLiteを用いたアニメーション。
	 * 複数オブジェクトのタイムライン
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class TimelineLite2 extends Sprite 
	{
		private var _timeline:TimelineLite = new TimelineLite();
		
		public function TimelineLite2() 
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
			
			// 4つのポジションを複数のオブジェクトに対して設定する。
			n = 4;
			for (i = 0; i < n; i++) {
				// 複数のオブジェクトを指定する時には、Array（配列）を使う。
				var tweens:Array/*TweenLite*/ = [];
				var m:int = ballList.length;
				for (var j:int = 0; j < m; j++) 
				{
					var tx:Number = i == j?400:200;
					var duration:Number = 1;// 変化にかかる時間（秒）。
					tweens[j] = TweenLite.to(ballList[j], duration, { x:tx } );
				}
				// 配列をまるごと登録。
				_timeline.appendMultiple(tweens);
				_timeline.stop();
			}
			
			// ステージ上をクリックしたら実行されるイベントを登録。
			// Flashのスタンダードなイベント登録方法。
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			// タイムラインの時刻を0秒目から再生する。
			_timeline.gotoAndPlay(0);
		}
		
	}
}