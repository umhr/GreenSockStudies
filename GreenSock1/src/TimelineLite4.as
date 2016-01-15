package
{
	import com.bit101.components.HUISlider;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * TimelineLiteを用いたアニメーション。
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class TimelineLite4 extends Sprite 
	{
		private var _ball:Ball = new Ball();
		private var _timeline:TimelineLite = new TimelineLite();
		private var _slider1:HUISlider;
		private var _slider2:HUISlider;
		
		public function TimelineLite4() 
		{
			
			//_ball.aY = 100;
			addChild(_ball);
			
			// 4つのポジションを指定する。初期位置が0段階目なので、合計5段階になることに注意。
			// 1段階あたりdurationが1秒なので、0秒から始まり、4秒目までの4秒間のポジションが決定される。
			// 2.3秒目は、2段階目から0.3だけ3段階目に近いポジションに補完して実行される。
			_timeline.append(TweenLite.to(_ball, 1, { aX:100, pY:200 } ));
			_timeline.append(TweenLite.to(_ball, 1, { aX:200, pY:300 } ));
			_timeline.append(TweenLite.to(_ball, 1, { aX:300, pY:100 } ));
			_timeline.append(TweenLite.to(_ball, 1, { aX:400, pY:400 } ));
			_timeline.stop();
			
			// ステージ左上に表示するスライダー、操作するとonSlideが実行される
			_slider1 = new HUISlider(this, 40, 20, "time", onSlide);
			_slider1.minimum = 0;
			_slider1.maximum = 4;
			
			_slider2 = new HUISlider(this, 20, 40, "ratio", onSlideRatio);
			_slider2.minimum = 0;
			_slider2.maximum = 1;
			_slider2.rotation = 90;
			
			stage.addEventListener(Event.ENTER_FRAME, stage_enterFrame);
		}
		
		private function stage_enterFrame(e:Event):void 
		{
			_ball.update();
		}
		
		
		private function onSlide(e:Event):void 
		{
			// スライダーの値に応じた値を設定する。
			var newTime:Number = (_slider1.value);
			
			// タイムラインの時刻をnewTime 秒目に移動する。
			_timeline.gotoAndStop(newTime);
		}
		
		private function onSlideRatio(e:Event):void 
		{
			// スライダーの値に応じた値を設定する。
			_ball.ratio = _slider2.value;
			
		}
		
	}
}


// インナークラス　クラスファイル内のプライベートなクラス。
// wonderflでは１クラスファイルしか使えないため、このような記述を行っている。
	import flash.display.Shape;
	/**
	 * ...
	 * @author umhr
	 */
	class Ball extends Shape 
	{
		public var aX:Number = 0;
		public var aY:Number = 0;
		public var pX:Number = 0;
		public var pY:Number = 0;
		public var ratio:Number = 0;
		
		public function Ball() 
		{
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(0, 0, 20);
			graphics.endFill();
		}
		
		public function update():void {
			this.x = aX + pX * ratio;
			this.y = aY + pY * ratio;
		}
		
	}

