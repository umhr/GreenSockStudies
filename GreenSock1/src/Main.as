package
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Main extends Sprite 
	{
		
		private var _sprite:Sprite = new Sprite();
		
		public function Main() 
		{
			// 赤い四角を描く
			_sprite.graphics.beginFill(0xFF0000);
			_sprite.graphics.drawRect( -20, -20, 40, 40);
			_sprite.graphics.endFill();
			// 表示オブジェクトに登録
			addChild(_sprite);
			
			// _sprite を x:400,y:300 に 4.5 秒で移動
			var tweenLite:TweenLite = new TweenLite(_sprite, 4.5, { "x":400, "y":300 } );
			// イベントを登録。
			// "onUpdate" このtweenが実行されている間、1フレーム毎に一回実行するイベントを登録することを宣言。
			// 実行するイベントはupdateである。
			// 通常のFlashのイベントとは異なる登録方法。
			// 恐らく処理の軽量化とパラメーターを渡すことを可能にするための仕様。
			tweenLite.eventCallback("onUpdate", update);
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
			
			var tweenLite:TweenLite = new TweenLite(_sprite, 1, { "x":tx, "y":ty } );
			tweenLite.eventCallback("onUpdate", update);
			tweenLite.play();
			
		}
		
		private function update():void {
			// 5度(degree)ずつ回転します。
			_sprite.rotation += 5;
		}
		
	}
	
}