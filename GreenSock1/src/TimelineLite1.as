package
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * TimelineLiteを用いたアニメーション。
	 * Tweenを連続的に登録しタイムラインを作り、
	 * 時間を指定して再生を可能にする。
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class TimelineLite1 extends Sprite 
	{
		private var _timeline:TimelineLite = new TimelineLite();
		
		public function TimelineLite1() 
		{
			var ball :Shape = new Shape();
			ball.graphics.beginFill(0xFF0000);
			ball.graphics.drawCircle(0, 0, 20);
			ball.graphics.endFill();
			ball.x = 0;
			ball.y = 100;
			addChild(ball);
			
			// 4つのポジションを指定する。初期位置が0段階目なので、
			// 合計5段階になることに注意。
			// 1段階あたりdurationが1秒なので、0秒から始まり、
			// 4秒目までの4秒間のポジションが決定される。
			// 2.3秒目は、2段階目から0.3だけ3段階目に近い
			// ポジションに補完して実行される。
			_timeline.append(TweenLite.to(ball, 1, { x:100 } ));
			_timeline.append(TweenLite.to(ball, 1, { x:200 } ));
			_timeline.append(TweenLite.to(ball, 1, { x:250, y:250 } ));// カンマで区切ると複数の値を設定可能
			_timeline.append(TweenLite.to(ball, 1, { x:400 } ));
			_timeline.stop();
			
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