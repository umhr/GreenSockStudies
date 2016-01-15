package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Ball extends Shape 
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

}