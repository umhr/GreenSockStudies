package 
{
	
	import com.bit101.components.PushButton;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class UpSideView2 extends Sprite 
	{
		private var _lineList:Array/*Line*/ = [];
		private var _timeline:TimelineLite;
		private var toObj:Object = { time:0, r:0 };
		private var _touchArea:Sprite = new Sprite();
		private var _count:int = 0;
		private var _base:Sprite = new Sprite();
		public function UpSideView2() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			addChild(_base);
			//_base.rotationX = -90;
			//_base.y = 200;
			
			addLine();
			var n:int = _lineList.length+1;
			for (var i:int = 0; i < n; i++) 
			{
				setPage(i);
				setTween();
			}
			
			_touchArea = new Sprite();
			_touchArea.graphics.beginFill(0xFF0000, 0);
			_touchArea.graphics.drawRect(0, 0, 465, 465);
			_touchArea.graphics.endFill();
			_touchArea.x = 0;
			//_touchArea.y = 200;
			_touchArea.addEventListener(MouseEvent.MOUSE_DOWN, touchArea_mouseDown);
			_touchArea.addEventListener(MouseEvent.MOUSE_MOVE, touchArea_mouseMove);
			_touchArea.addEventListener(MouseEvent.MOUSE_UP, touchArea_mouseUp);
			addChild(_touchArea);
			
			new PushButton(this, 0, 400, "to0", onPush).width = 50;
			new PushButton(this, 100, 400, "to16", onPush).width = 50;
			new PushButton(this, 200, 400, "toLast", onPush).width = 50;
			new PushButton(this, 300, 400, "+", onPush).width = 50;
			new PushButton(this, 400, 400, "-", onPush).width = 50;
			
			new PushButton(this, 0, 430, "on", onPush2).width = 50;
			new PushButton(this, 100, 430, "off", onPush2).width = 50;
			
			
			onUpdate2();
			
			stage.addEventListener(Event.ENTER_FRAME, stage_enterFrame);
		}
		
		private function stage_enterFrame(e:Event):void 
		{
			if (_count == 0 && !isMouseDown) {
				zoom(0);
			}else if (_count < 0 && toObj.r == 0) {
				zoom(1);
			}
			
			_count ++;
		}
		
		private function zoom(ratio:Number = 0):void {
			var tween:TweenLite = new TweenLite(toObj, 0.3, {"ratio":ratio } );
			tween.eventCallback("onUpdate", onUpdate2);
			tween.play();
		}
		
		private function touchArea_mouseUp(e:MouseEvent):void 
		{
			
			var duration:Number = 1;
			var time:Number = Math.round(_timeline.time());
			var tween2:TweenLite = new TweenLite(toObj, duration, { "time":time} );
			tween2.eventCallback("onUpdate", onUpdate);
			tween2.eventCallback("onComplete", onComplete);
			tween2.play();
			_count = -10;
			isMouseDown = false;
		}
		private var isMouseDown:Boolean = false;
		private var _mouseDown:Point = new Point();
		private var _moveDown:Point = new Point();
		private function touchArea_mouseMove(e:MouseEvent):void 
		{
			if (e.buttonDown) {
				var time:Number = _timeline.time() + (_moveDown.x - mouseX) * 0.005;
				gotoAndStop(time);
				toObj.time = time;
				_moveDown.x = mouseX;
				isMouseDown = true;
			}else {
				isMouseDown = false;
			}
		}
		
		private function touchArea_mouseDown(e:MouseEvent):void 
		{
			_mouseDown.x = _moveDown.x = mouseX;
			_mouseDown.y = _moveDown.y = mouseY;
			isMouseDown = true;
		}
		
		private function onPush2(e:Event):void {
			var ratio:Number;
			var label:String = (e.target as PushButton).label;
			if (label == "on") {
				ratio = 1;
			}else if (label == "off") {
				ratio = 0;
			}
			zoom(ratio);
		}
		
		private function onUpdate2():void {
			var n:int = _lineList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_lineList[i].ratio = toObj.r;
				_lineList[i].update = 0;
			}
		}
		
		private function onPush(e:Event):void {
			var time:Number = 0;
			var duration:Number = 0;
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
			}else if(label == "+"){
				time = Math.round(_timeline.time()) + 1;
				duration = 1;
			}else if(label == "-"){
				time = Math.round(_timeline.time()) - 1;
				duration = 1;
			}
			var tween:TweenLite = new TweenLite(toObj, duration, { "time":time} );
			tween.eventCallback("onUpdate", onUpdate);
			tween.eventCallback("onComplete", onComplete);
			tween.play();
		}
		
		private function onUpdate():void {
			gotoAndStop(toObj.time);
		}
		private function onComplete():void {
			trace("onComplete");
		}
		
		public function gotoAndStop(value:Number):void {
			
			value = Math.min(Math.max(value, 0), _lineList.length);
			_timeline.gotoAndStop(value);
			//zSort();
			_count = -30;
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
					anchor.x = stage.stageWidth * 0.5+5;
					anchor.rotation = 0;
					proxy.rotation = Math.max(20 - Math.abs(poz) * 5, 0);
					proxy.x = Math.min(Math.abs(poz), 2) * 15;
					proxy.y = 120 - Math.abs(poz) * 5 + 50;
				}else {
					anchor.x = stage.stageWidth * 0.5-5;
					anchor.rotation = 180;
					proxy.rotation = Math.min(-20+Math.abs(poz+1) * 5, 0);
					proxy.x = - Math.min(Math.abs(poz+1), 2)*15;
					proxy.y = 120 - Math.abs(poz + 1) * 5 + 50;
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
				tweens[i] = TweenLite.to(_lineList[i], duration, { aX:_lineList[i].anchor.x, aRotation:_lineList[i].anchor.rotation, pX:_lineList[i].proxy.x, pY:_lineList[i].proxy.y, pRotation:_lineList[i].proxy.rotation, update:0 } );
			}
			_timeline.appendMultiple(tweens);
			_timeline.stop();
		}
		
		private function addLine():void 
		{
			var n:int = 32;
			for (var i:int = 0; i < n; i++) 
			{
				var shape:Line = new Line();
				_base.addChild(shape);
				_lineList[i] = shape;
			}
		}
		
	}
	
}