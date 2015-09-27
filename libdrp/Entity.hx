package libdrp;

import kha.graphics2.Graphics;
import kha.Image;


/**
 * ...
 * @author Nate Edwards
 */
class Entity
{
	public var scaleX:Float = 1;
	public var scaleY:Float = 1;
	
	public var StageRealX:Int = 0;
	public var StageRealY:Int = 0;
	
	public var rotation:Float = 0;
	
	//todo add render "depths" (levels?) so that blank filler gets rendered last, and cus its just usefull
	
	public function new() 
	{	
	}
	
	public function act(delta:Float)
	{
		
	}
	
	public function draw(graphics:Graphics)
	{
		
	}
	
	public function drawImage(image:Image, x:Float, y:Float,graphics:Graphics)
	{
		if (image == null) return;
		
		if (rotation != 0) graphics.pushRotation(rotation, 
		(StageRealX + (x * scaleX)) + (image.width * scaleX) / 2, 
		(StageRealY + (y * scaleY)) + (image.height * scaleY) / 2
		);
		
		graphics.drawScaledImage(image, 
						StageRealX + (x * scaleX), 
						StageRealY + (y * scaleY), 
						image.width * scaleX, 
						image.height * scaleY
						);
						
		if (rotation != 0)graphics.popTransformation();
	}
	
}