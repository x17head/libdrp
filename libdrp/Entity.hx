package libdrp;

import kha.graphics2.Graphics;
import kha.Image;
import libdrp.Drp.AtlasImage;
import libdrp.View.ViewProperties;
import kha.Loader;
import kha.audio1.Audio;

/**
 * ...
 * @author Nate Edwards
 */
class Entity
{
	private var name:String;
	private var x:Float = 0;
	private var y:Float = 0;
	private var width:Float = 0;
	private var height:Float = 0;
	private var view:View;
	
	public function new(Name:String)
	{	
		name = Name;
	}
	
	public function setup(){};
	
	public function update(delta:Float){};

	public function draw(){};

	public function reset(){};
	
	//allows access to other entities and viewProperties
	public function addView(view:View)
	{
		this.view = view;
	}
	
	public function getName():String
	{
		return name;
	}
	
	public function getX():Float
	{
		return x;
	}
	
	public function getY():Float
	{
		return y;
	}
	
	public function getWidth():Float
	{
		return width;
	}
	
	public function getHeight():Float
	{
		return height;
	}
	
	//pass draw call to Drp draw stack
	public function drawImage(?image:Image = null,?name:String = null,x:Float,y:Float,?z:Float = 0,?w:Float = 1,?h:Float = 1,?r:Float = 0)
	{
		if (image != null)
		{
		Drp.drawCallOrdered(image,name,
					view.viewProperties.RealX + (x * view.viewProperties.scaleX), 
					view.viewProperties.RealY + (y * view.viewProperties.scaleY),
					z,
					image.width * view.viewProperties.scaleX * w, 
					image.height * view.viewProperties.scaleY * h,
					r);
		}
		else
		{
		var temp:AtlasImage = Drp.Atlas.get(name);
		Drp.drawCallOrdered(temp.image,name,
					view.viewProperties.RealX + (x * view.viewProperties.scaleX), 
					view.viewProperties.RealY + (y * view.viewProperties.scaleY),
					z,
					temp.width * view.viewProperties.scaleX * w, 
					temp.height * view.viewProperties.scaleY * h,
					r);
		}
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
	
	private function circleCollision(x1:Float, y1:Float, radius1:Float, x2:Float, y2:Float, radius2:Float):Bool
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		var radii = radius1 + radius2;
		if ( ( dx * dx )  + ( dy * dy ) < radii * radii ){
        return true;
    }
		else return false;
	}
	
	//set current scene
	
	public function setScene(scene:String)
	{
		Drp.setScene(scene);
	}
	
	//converts mouse from world coordinates to view coordinates
	public function MouseX():Int
	{
		return Std.int( (Drp.mouseX - view.viewProperties.RealX) / view.viewProperties.scaleX);
	}
	
	public function MouseY():Int
	{
		return Std.int( (Drp.mouseY - view.viewProperties.RealY) / view.viewProperties.scaleY);
	}
	public function MouseButton(button:Int):Bool
	{
		return Drp.mouseButton[button];
	}
	
	public function TouchX(finger:Int):Int
	{
		return Std.int( (Drp.touchX[finger] - view.viewProperties.RealX) / view.viewProperties.scaleX);
	}
	
	public function TouchY(finger:Int):Int
	{
		return Std.int( (Drp.touchY[finger] - view.viewProperties.RealY) / view.viewProperties.scaleY);
	}
	public function TouchDown(finger:Int):Bool
	{
		return Drp.touch[finger];
	}
	
	public function KeyboardKeyDown(key:String)
	{
		return Drp.keyboardKey(key);
	}
	
}
