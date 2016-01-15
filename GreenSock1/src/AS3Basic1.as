package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * 数、文字、配列、trace、暗黙の型変換、値渡し、参照渡しの例です。
	 * ...
	 * @author umhr
	 */
	public class AS3Basic1 extends Sprite 
	{
		private var _logTextField:TextField;
		public function AS3Basic1() 
		{
			// FlashではActionScriptをつかいます。
			// 極基本の文法はwikipediaの説明を参照。
			// https://ja.wikipedia.org/wiki/ActionScript
			
			// ◆数
			// 数はint,uint,Numeberの三種類です。
			
			// int型　32bitの整数型です。負の数を扱えます。
			var a:int = -1;
			
			// uint型　32bitの整数型です。
			var b:uint = 2;
			
			// Number型 64bitの浮動小数点型です。(他の言語のdouble型にあたる)
			var c:Number = 12.5;
			
			// ◆暗黙の型変換
			setTrace("◆暗黙の型変換");
			// 暗黙の型変換が行われ、dには、1.5が入ります。
			var d:Number = 3 / b; 
			setTrace(d);// 出力結果「1.5」
			
			// ◆文字
			setTrace("\n◆文字");
			// String型 文字列型です。
			var str:String = "あいうえお";
			setTrace(str);// 出力結果「あいうえお」
			
			// ◆配列
			setTrace("\n◆配列");
			//　Array型は配列型です。配列内の型は指定しません。
			var myList:Array = [];
			myList[0] = 4;
			myList[1] = 1.3;
			myList[2] = "a";
			myList[10] = "xyz";
			myList[1] += 1;
			setTrace(myList);// 出力結果「4,2.3,a,,,,,,,,xyz」
			
			// ＊注＊ 次のようなint型を指定するかのような書き方をする場合があるが、
			// 型指定はできません。
			// var sample:Array/*int*/ = [];
			// 「/*int*/」はコメントとして書かれているので、コンパイラは無視する。
			// コードエディタの一部は型指定があるかのように補完を行う。
			
			// 型指定をする配列Vector型を使う。
			// var sample:Vector.<int> = new Vector.<int>();
			
			// ◆連想配列
			setTrace("\n◆連想配列");
			var obj:Object = {time:12, ratio:0.5 };
			obj["time"] += 2.5;
			obj.ratio += 0.1;
			obj["key1"] = "abc";
			obj["key2"] = 33;
			for (var p:String in obj) { 
				setTrace(p + ":" + obj[p]);
			}
			// 出力結果「time:14.5」
			// 出力結果「key1:abc」
			// 出力結果「ratio:0.6」
			// 出力結果「key2:33」
			
			
			// ◆値渡し
			setTrace("\n◆値渡し");
			setTrace(a);// 出力結果「-1」
			myFunction1(a);
			setTrace(a);// 出力結果「-1」
			
			// ◆参照渡し
			setTrace("\n◆参照渡し");
			setTrace(myList[0]);// 出力結果「4」
			myFunction2(myList);
			setTrace(myList[0]);// 出力結果「5」
			
		}
		
		// 関数にプリミティブ（int,uint,Number,Boolean,String）を渡す場合には、
		// 値渡しになります。
		private function myFunction1(num:int):void {
			num ++;
		}
		
		// 関数にプリミティブではないオブジェクトを渡す場合には、参照渡しになります。
		private function myFunction2(list:Array):void {
			list[0] ++;
		}
		
		private function setTrace(... arguments):void {
			if (_logTextField == null) {
				_logTextField = new TextField();
				_logTextField.border = true;
				_logTextField.width = 400;
				_logTextField.height = 400;
				addChild(_logTextField);
			}
			
			var n:int = arguments.length;
			for (var i:int = 0; i < n; i++) 
			{
				_logTextField.appendText(arguments[i] + "\n");
			}
			
			// ◆trace
			// デバッグ時に変数の中身を確認したい場合は、traceを使います。
			// trace()ではprintf("a = %d",1)のような変換ができません。
			// 渡した値を出力するのみの機能です。
			// trace関数に渡すと、デバッグ時の出力ウィンドウに出力されます。
			// カンマ区切りで複数の値を渡せます。
			// trace(1,2,3);// 出力結果「1 2 3」
			trace(arguments);
		}
		
		
		
	}
	
}