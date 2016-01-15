package 
{
	import com.bit101.components.PushButton;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author umhr
	 */
	public class CRLFConverter extends Sprite 
	{
		private var _tf:TextField;
		private var _replacedText:String = "";
		public function CRLFConverter() 
		{
			init();
		}
		private function init():void 
		{
			graphics.beginFill(0xEEEEEE);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat("_sans", 12, 0x666666);
			title.text = "下のエリアにテキストをペーストしてください。\\nを削除します。";
			title.x = 8;
			title.y = 8;
			title.width = 400;
			title.height = 30;
			title.selectable = title.mouseEnabled = false;
			addChild(title);
			
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.border = true;
			_tf.x = 8;
			_tf.y = 32;
			_tf.width = stage.stageWidth - 16;
			_tf.height = 400;
			_tf.wordWrap = _tf.multiline = true;
			_tf.type = "input";
			_tf.addEventListener(Event.CHANGE, tf_change);
			_tf.background = true;
			_tf.backgroundColor = 0xFFFFFF;
			addChild(_tf);
			
			new PushButton(this, 8, 440, "Copy to Clipbord", onPush).width = _tf.width;
		}
		
		private function onPush(e:Event):void 
		{
			// OS のクリップボードを取得
			var clipboard:Clipboard = Clipboard.generalClipboard;
			
			// クリップボードに文字列をセット
			clipboard.setData(ClipboardFormats.TEXT_FORMAT , _replacedText);
		}
		
		private function tf_change(e:Event):void 
		{
			_replacedText = _tf.text;
			_replacedText = _replacedText.replace(/\n/g,"");
			_tf.text = _replacedText;
			
		}
		
	}
	
}