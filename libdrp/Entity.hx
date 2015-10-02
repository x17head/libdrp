package libdrp;

import kha.graphics2.Graphics;
import kha.Image;
import kha.audio1.Audio;
import libdrp.View.ViewProperties;
import kha.Loader;

/**
 * ...
 * @author Nate Edwards
 */
class Entity
{
	public var name:String;
	public var active:Bool = false;
	public var alive:Bool = false;
	//render vars
	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0; //not used...yet
	
	public var width:Float = 0;
	public var height:Float = 0;
	public var radius:Float = 0;
	public var rotation:Float = 0;
	
	private var view:View;
	
	//todo add render "depths" (levels?) so that blank filler gets rendered last, and cus its just usefull
	
	public function new()
	{	
		
	}
	//internal use only
	public function setView(view:View)
	{
		this.view = view;
	}
	//override this
	public function update(delta:Float)
	{
		
	}
	//override this
	public function draw(graphics:Graphics)
	{
		
	}
	
	//sound stuff
	
	public function playSound(sound:String)
	{
		var snd = Loader.the.getSound(sound);
		
		if (snd == null) return;
		
		Audio.playSound(snd);
	}
	
	public function playMusic(music:String)
	{
		var mus = Loader.the.getMusic(music);
		
		if (mus == null) return;
		
		Audio.playMusic(mus);
	}
	
	//draw stuff
	public function drawImage(image:String, x:Float, y:Float,graphics:Graphics)
	{
		var img = Loader.the.getImage(image);
		
		if (img == null) return;
		
		if (rotation != 0) graphics.pushRotation(rotation, 
		(view.viewProperties.RealX + (x * view.viewProperties.scaleX)) + (img.width * view.viewProperties.scaleX) / 2, 
		(view.viewProperties.RealY + (y * view.viewProperties.scaleY)) + (img.height * view.viewProperties.scaleY) / 2
		);
		
		graphics.drawScaledImage(img,
						view.viewProperties.RealX + (x * view.viewProperties.scaleX), 
						view.viewProperties.RealY + (y * view.viewProperties.scaleY), 
						img.width * view.viewProperties.scaleX, 
						img.height * view.viewProperties.scaleY
						);
						
		if (rotation != 0)graphics.popTransformation();
	}
	
	//<mouse stuff>
	public function MouseX():Int
	{
		return Std.int( (Drp.get().mouseX - view.viewProperties.RealX) / view.viewProperties.scaleX);
	}
	
	public function MouseY():Int
	{
		return Std.int( (Drp.get().mouseY - view.viewProperties.RealY) / view.viewProperties.scaleY);
	}
	//</mouse stuff>
	
	//<circle collision>
	private function circleCollision(x1:Float, y1:Float, radius1:Float, x2:Float, y2:Float, radius2:Float):Bool
	{
    //compare the distance to combined radii
    var dx = x2 - x1;
    var dy = y2 - y1;
    var radii = radius1 + radius2;
    if ( ( dx * dx )  + ( dy * dy ) < radii * radii ) return true;
    else return false;
	}
	
}