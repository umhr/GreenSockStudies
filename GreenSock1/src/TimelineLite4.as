package
{
	import com.bit101.components.HUISlider;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * TimelineLiteを用いたアニメーション。
	 * 二つのスライダによって、二つの値を操作している。
	 * timeによって、x座標が変化し、ratioによってy座標が変化する。
	 * ratioが0の時と1の時に、timeを変化に対する赤丸の動きが異なることに注意。
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
			
			addChild(_ball);
			
			_timeline.append(TweenLite.to(_ball, 1, { aX:100, pY:200 } ));
			_timeline.append(TweenLite.to(_ball, 1, { aX:150, pY:300 } ));
			_timeline.append(TweenLite.to(_ball, 1, { aX:350, pY:100 } ));
			_timeline.append(TweenLite.to(_ball, 1, { aX:400, pY:400 } ));
			_timeline.stop();
			
			// ステージ左上に表示するスライダー、操作するとonSlideTimeが実行される
			_slider1 = new HUISlider(this, 40, 20, "time", onSlideTime);
			_slider1.minimum = 0;
			_slider1.maximum = 4;
			
			// ステージ左上に縦に表示されるスライダー、操作するとonSlideRatioが実行される
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
		
		
		private function onSlideTime(e:Event):void 
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

