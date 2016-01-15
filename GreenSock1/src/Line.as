package 
{
	
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	public class Line extends Sprite 
	{
		public var anchor:Sprite = new Sprite();
		public var proxy:Sprite = new Sprite();
		//public var ratio:Sprite = new Sprite();
		
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
			y = aY + pY * 1;
			rotation = aRotation + pRotation * ratio;
		}
		
	}
	
}