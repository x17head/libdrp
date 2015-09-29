package libdrp;

import kha.graphics2.Graphics;
import kha.Image;
import libdrp.View.ViewProperties;

/**
 * ...
 * @author Nate Edwards
 */
class Entity
{
	//render vars
	public var scaleX:Float = 1;
	public var scaleY:Float = 1;
	public var ViewRealX:Int = 0;
	public var ViewRealY:Int = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0; //not used...yet
	
	public var width:Float = 0;
	public var height:Float = 0;
	public var rotation:Float = 0;
	
	//todo add render "depths" (levels?) so that blank filler gets rendered last, and cus its just usefull
	
	public function new()
	{	
	}
	
	public function update(delta:Float)
	{
		
	}
	
	public function draw(graphics:Graphics)
	{
		
	}
	
	public function load()
	{
		
	}
	
	public function drawImage(image:Image, x:Float, y:Float,graphics:Graphics)
	{
		if (image == null) return;
		
		if (rotation != 0) graphics.pushRotation(rotation, 
		(ViewRealX + (x * scaleX)) + (image.width * scaleX) / 2, 
		(ViewRealY + (y * scaleY)) + (image.height * scaleY) / 2
		);
		
		graphics.drawScaledImage(image, 
						ViewRealX + (x * scaleX), 
						ViewRealY + (y * scaleY), 
						image.width * scaleX, 
						image.height * scaleY
						);
						
		if (rotation != 0)graphics.popTransformation();
	}
	
	//<mouse stuff>
	public function MouseX():Int
	{
		return Std.int( (Drp.get().mouseX - ViewRealX) / scaleX);
	}
	
	public function MouseY():Int
	{
		return Std.int( (Drp.get().mouseY - ViewRealY) / scaleY);
	}
	//</mouse stuff>
}