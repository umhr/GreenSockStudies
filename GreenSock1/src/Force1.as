package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ステージ上をスワイプすると円が移動します。
	 * 離した瞬間の加速度から摩擦量の割合だけ減衰してとまります。
	 * ...
	 * @author umhr
	 */
	public class Force1 extends Sprite 
	{
		/**
		 * マウスの位置を保持
		 */
		private var _mouseMoveValue:Number = 0;
		/**
		 * 差分を保持
		 */
		private var _currentDistanceValue:Number = 0;
		/**
		 * マウスが押下されている(true)か否(false)かを示す
		 */
		private var _isMouseDown:Boolean;
		/**
		 * 円の描画オブジェクト
		 */
		private var _circle:Shape = new Shape();
		/**
		 * 摩擦量
		 */
		private var _friction:Number = 0.1;
		
		public function Force1()
		{
			_circle.graphics.beginFill(0xFF0000, 1);
			_circle.graphics.drawCircle(0, 0, 25);
			_circle.graphics.endFill();
			_circle.x = 200;
			_circle.y = 200;
			addChild(_circle);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			// マウスが押下されている状態のフラグを下げる。
			_isMouseDown = false;
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			// マウスが押下されたx座標を保持。
			_mouseMoveValue = mouseX;
			// マウスが押下されている状態のフラグを立てる。
			_isMouseDown = true;
		}
		
		public function enterFrame(e:Event = null):void 
		{
			if (_isMouseDown) {
				// マウスが押下されている場合は、前回のマウス位置との差分をとる。
				_currentDistanceValue = mouseX - _mouseMoveValue;
				_mouseMoveValue = mouseX;
			}else {
				// マウスが上がっている場合は、摩擦の割合だけ差分を減らす。
				_currentDistanceValue *= (1 - _friction);
			}
			
			// 円のx座標を保持する。
			var currentValue:Number = _circle.x;
			// 差分を加算する。
			currentValue += _currentDistanceValue;
			
			// ステージの範囲内なら、新しい座標となる。
			if (0 < currentValue && currentValue < stage.stageWidth) {	
				_circle.x = currentValue;
			}else {
				// ステージの外なら、差分の符号を反転する。
				_currentDistanceValue = -_currentDistanceValue;
			}
			
		}
		
	}	
}