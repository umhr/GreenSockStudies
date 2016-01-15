package 
{
	import com.bit101.components.PushButton;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class UpSideView1 extends Sprite 
	{
		private var _lineList:Array/*Line*/ = [];
		private var _timeline:TimelineLite;
		
		/**
		 * 時間とzoomの割合を保持するオブジェクト（連想配列）
		 */
		private var _toObj:Object = { time:0, ratio:0 };
		public function UpSideView1() 
		{
			// 線を生成。
			var n:int = 32;
			for (var i:int = 0; i < n; i++) 
			{
				var line:Line = new Line();
				addChild(line);// ステージ上に配置
				_lineList[i] = line;// 配列に追加
			}
			
			// nの長さのタイムラインを作る。最初のページの表面から始まり、
			// 最後のページの裏面で終わるため、ページ数に1を加える。
			n = _lineList.length + 1;
			for (i = 0; i < n; i++) 
			{
				setPage(i);// i番目の位置を設定する。
				setTween();// 設定された位置を元にtimelineに登録する。
			}
			
			// ボタンを生成
			new PushButton(this, 65*0, 430, "to0", onPush).width = 50;
			new PushButton(this, 65*1, 430, "to16", onPush).width = 50;
			new PushButton(this, 65*2, 430, "toLast", onPush).width = 50;
			new PushButton(this, 65*3, 430, "+", onPush).width = 50;
			new PushButton(this, 65*4, 430, "-", onPush).width = 50;
			new PushButton(this, 65*5, 430, "zoom(1)", onPush).width = 50;
			new PushButton(this, 65*6, 430, "zoom(0)", onPush).width = 50;
			
			// 位置の初期化
			onZoomUpdate();
		}
		
		private function setPage(pageNum:Number):void 
		{
			var n:int = _lineList.length;
			for (var i:int = 0; i < n; i++) 
			{
				var proxy:Sprite = _lineList[i].proxy;
				var anchor:Sprite = _lineList[i].anchor;
				var poz:int = i - pageNum;
				if (i >= pageNum) {
					anchor.x = stage.stageWidth * 0.5 + 5;
					anchor.y = 170 - Math.abs(poz) * 5;
					anchor.rotation = 0;
					proxy.x = Math.min(Math.abs(poz), 2) * 15;
					proxy.y = 0;
					proxy.rotation = Math.max(20 - Math.abs(poz) * 5, 0);
				}else {
					anchor.x = stage.stageWidth * 0.5 - 5;
					anchor.y = 170 - Math.abs(poz + 1) * 5;
					anchor.rotation = 180;
					proxy.x = - Math.min(Math.abs(poz + 1), 2) * 15;
					proxy.y = 0;
					proxy.rotation = Math.min( -20 + Math.abs(poz + 1) * 5, 0);
				}
			}
		}
		
		private function setTween():void {
			var tweens:Array = [];
			var duration:Number = 1;
			if (_timeline == null) {
				_timeline = new TimelineLite();
				duration = 0;
			}
			var n:int = _lineList.length;
			for (var i:int = 0; i < n; i++) 
			{
				tweens[i] = TweenLite.to(_lineList[i], duration, { aX:_lineList[i].anchor.x, aY:_lineList[i].anchor.y, aRotation:_lineList[i].anchor.rotation, pX:_lineList[i].proxy.x, pY:_lineList[i].proxy.y, pRotation:_lineList[i].proxy.rotation, update:0 } );
			}
			_timeline.appendMultiple(tweens);
			_timeline.stop();
		}
		
		private function zoom(ratio:Number = 0):void {
			// _toObj.ratioを0.3秒かけてratioに変化させる。
			var tween:TweenLite = new TweenLite(_toObj, 0.3, { "ratio":ratio } );
			// 変化が実行されるたびに、onZoomUpdate関数を実行する。
			tween.eventCallback("onUpdate", onZoomUpdate);
			tween.play();
		}
		
		private function onZoomUpdate():void {
			var n:int = _lineList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_lineList[i].ratio = _toObj.ratio;
				_lineList[i].update = 0;
			}
		}
		
		/**
		 * ボタンが押されたら実行される関数。
		 * @param	e
		 */
		private function onPush(e:Event):void {
			var time:Number = 0;
			var duration:Number = 0;
			// 押されたボタンのラベルを取得
			var label:String = (e.target as PushButton).label;
			if (label == "to0") {
				time = 0;
				duration = 3;
			}else if(label == "to16"){
				time = 16;
				duration = 2;
			}else if(label == "toLast"){
				time = _lineList.length;
				duration = 3;
			}else if (label == "+") {
				time = Math.round(_timeline.time()) + 1;
				duration = 1;
			}else if(label == "-"){
				time = Math.round(_timeline.time()) - 1;
				duration = 1;
			}else if (label == "zoom(1)") {
				zoom(1);
				return;
			}else if (label == "zoom(0)") {
				zoom(0);
				return;
			}
			
			var tween:TweenLite = new TweenLite(_toObj, duration, { "time":time} );
			tween.eventCallback("onUpdate", onUpdate);
			tween.eventCallback("onComplete", onComplete);
			tween.play();
			zoom(1);
		}
		
		private function onUpdate():void {
			gotoAndStop(_toObj.time);
		}
		private function onComplete():void {
			//trace("onComplete");
			zoom(0);
		}
		
		public function gotoAndStop(value:Number):void {
			// 最小値0、最大値配列の長さであることを強制する。
			value = Math.min(Math.max(value, 0), _lineList.length);
			// タイムラインのvalue秒目に移動
			_timeline.gotoAndStop(value);
		}
	}
}
	
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	 class Line extends Sprite 
	{
		public var anchor:Sprite = new Sprite();
		public var proxy:Sprite = new Sprite();
		public var aX:Number = 0;
		public var aY:Number = 0;
		public var aRotation:Number = 0;
		public var pX:Number = 0;
		public var pY:Number = 0;
		public var pRotation:Number = 0;
		public var ratio:Number = 0;
		
		public function Line() 
		{
			init();
		}
		private function init():void 
		{
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(0, 0xFF0000);
			shape.graphics.moveTo( 0, 0);
			shape.graphics.lineTo(100, 0);
			addChild(shape);
		}
		public function get update():Number {
			return 0;
		}
		public function set update(value:Number):void {
			x = aX + pX * ratio;
			y = aY + pY * ratio;
			rotation = aRotation + pRotation * ratio;
		}
		
	}
