package
{
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * TweenLite入門。マウスクリックした場所に移動する。
	 * ...
	 * @author umhr
	 */
	public class TweenLite1 extends Sprite 
	{
		private var _shape:Shape = new Shape();
		public function TweenLite1() 
		{
			// 赤い四角を描く
			_shape.graphics.beginFill(0xFF0000);
			_shape.graphics.drawRect( -20, -20, 40, 40);
			_shape.graphics.endFill();
			// 表示オブジェクトに登録
			addChild(_shape);
			
			// _sprite を x:400,y:300 に 4.5 秒で移動
			var tweenLite:TweenLite = new TweenLite(_shape, 4.5, { "x":400, "y":300 } );
			// 実行。
			tweenLite.play();
			
			// ステージ上をクリックしたら実行されるイベントを登録。
			// Flashのスタンダードなイベント登録方法。
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			// マウスの位置を取得します。
			var tx:Number = mouseX;
			var ty:Number = mouseY;
			
			var tweenLite:TweenLite = new TweenLite(_shape, 1, { "x":tx, "y":ty } );
			tweenLite.play();
			
		}
	}
}