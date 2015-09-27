package libdrp.input;

import kha.input.Mouse;

/**
 * ...
 * @author Nate Edwards
 */
class Mouse
{
	
	private var RealX:Int;
	private var RealY:Int;
	private var RealWidth:Int;
	private var RealHeight:Int;
	private var scaleX:Float;
	private var scaleY:Float;
	
	private var mouse:kha.input.Mouse;
	
	public var mouseX:Int = 0;
	public var mouseY:Int = 0;

	public function new(RealX:Int,RealY:Int,RealWidth:Int,RealHeight:Int,scaleX:Float,scaleY:Float) 
	{
		
		this.RealX = RealX;
		this.RealY = RealY;
		this.RealWidth = RealWidth;
		this.RealHeight = RealHeight;
		this.scaleX = scaleX;
		this.scaleY = scaleY;
		
		mouse = kha.input.Mouse.get(0);
		mouse.notify(mouseDown, mouseUp, mouseMove, mouseWheel);
	}
	
		private function mouseDown(button:Int, x:Int, y:Int)
	{
		mouseCheckXY(x, y);
	}
	
	private function mouseUp(button:Int, x:Int, y:Int)
	{
		mouseCheckXY(x, y);
	}
	
	private function mouseMove(x:Int, y:Int)
	{
		mouseCheckXY(x, y);
	}
	
	private function mouseWheel(wheel:Int)
	{
		
	}
	
	private function mouseCheckXY(x:Int, y:Int)
	{
		//check if input is in the stage
		if (x > RealX && x < (RealX + RealWidth) && y > RealY && y < (RealY + RealHeight))
		{
			mouseX = Std.int((x - RealX) / scaleX);
			mouseY = Std.int((y - RealY) / scaleY);
		}
	}
	
}