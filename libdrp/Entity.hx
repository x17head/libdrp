package libdrp;

import flash.accessibility.Accessibility;
import kha.graphics2.Graphics;
import kha.Image;


/**
 * ...
 * @author Nate Edwards
 */
class Entity
{
	//render vars
	public var scaleX:Float = 1;
	public var scaleY:Float = 1;
	public var StageRealX:Int = 0;
	public var StageRealY:Int = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0; //not used...yet
	
	public var width:Float = 0;
	public var height:Float = 0;
	public var rotation:Float = 0;
	
	public var clickable:Bool = false;
	public var touchable:Bool = false;
	
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
	
	public function load()
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