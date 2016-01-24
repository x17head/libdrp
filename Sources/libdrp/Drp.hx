package libdrp;

import kha.Sound;
import kha.audio1.Audio;
import kha.audio1.AudioChannel;
import haxe.xml.Fast;
import kha.graphics2.Graphics;
import kha.input.Keyboard;
import kha.Key;
import libdrp.Scene;
import kha.input.Mouse;
import kha.input.Gamepad;
import kha.input.Surface;
import kha.audio1.Audio;
import kha.Framebuffer;
import kha.Image;
import kha.Assets;
import kha.Blob;
import kha.input.Mouse;
import kha.input.Surface;
import haxe.ds.Vector;
import kha.Scaler;
import kha.System;

/**
 * ...
 * @author Nate Edwards
 */
class Drp
{
	public var scenes:Map<String,Scene>;

	public var graphics:Graphics;
	
	public var currentScene:Scene;
	
	public var Atlas:Map<String,AtlasImage>;
	//mouse
	public var mouseX:Int = 0;
	public var mouseY:Int = 0;
	public var mouseButton:Vector<Bool>;
	//if anyone has a mouse with more then 99 buttons let me know, ill increase it...
	private var maxMouseButtons:Int = 99;
	
	//touch vars
	public var touchFinger:Vector<Bool>;
	public var touchX:Vector<Int>;
	public var touchY:Vector<Int>;
	
	private var inputFramebuffer:Framebuffer;
	private var inputBackbuffer:Image;
	
	public function new() 
	{
		scenes = new Map<String,Scene>();
		Atlas = new Map<String,AtlasImage>();
	}

	
	public function addScene(name:String,scene:Scene)
	{
		scenes.set(name,scene);
	}
	
	public function setScene(name:String)
	{
		currentScene = scenes.get(name);
	}

	public function setGraphics(thegraphics:Graphics)
	{
		graphics = thegraphics;
	}
	
	//sound stuff
	public function playSound(sound:String)
	{

		var snd:Sound = Reflect.field(kha.Assets.sounds, sound);
		
		if (snd == null) return;
		
		Audio.play(snd,false);
	}
	
	public function playMusic(music:String)
	{
		//var mus = Loader.the.getMusic(music);
		
		//if (mus == null) return;
		
		//Audio.playMusic(mus);
	}
	
	//atlas stuff	
	public function loadAtlas(name:String)
	{
		var image:Image = Reflect.field(kha.Assets.images, name);
		var xmlBlob:Blob = Reflect.field(kha.Assets.blobs, name + "_xml");
		//trace(Assets.blobs.testAtlas1_xml.toString());
		var xml = Xml.parse(xmlBlob.toString());
		var fast:Fast = new Fast(xml.firstElement());
		
		for (item in fast.elements)
		{
			var temp = new Array<Float>();
			var count = 0;
			
			for (temp2 in item.elements)
			{
				temp[count] = Std.parseFloat(temp2.innerData);
				count++;
			}
			
			Atlas.set(item.name, {
			image:image,
			x:temp[0],
			y:temp[1],
			width:temp[2],
			height:temp[3]
			});
		}
	}
	
	public function drawAtlasImage(g:Graphics,name:String,x:Int,y:Int)
	{
		var atlasImage:AtlasImage = Atlas.get(name);
		if(atlasImage != null)
		{
			g.drawScaledSubImage(atlasImage.image,
								 atlasImage.x,atlasImage.y,
								 atlasImage.width,atlasImage.height,
								 x,y,
								 atlasImage.width,atlasImage.height);
		}
		
	}
	
	public function setInputScale(framebuffer:Framebuffer,backbuffer:Image)
	{
		this.inputFramebuffer = framebuffer;
		this.inputBackbuffer = backbuffer;
	}
	
	public function touch()
	{
		touchFinger = new Vector(10);
		touchX = new Vector(10);
		touchY = new Vector(10);
		Surface.get().notify(touchDown, touchUp, touchMove);
	}
	
	public function touchDown(touchNum:Int,x:Int,y:Int)
	{
		touchFinger[touchNum] = true;
		touchX[touchNum] = Scaler.transformX(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
		touchY[touchNum] = Scaler.transformY(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
	}
	
	public function touchUp(touchNum:Int,x:Int,y:Int)
	{
		touchFinger[touchNum] = false;
		touchX[touchNum] = Scaler.transformX(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
		touchY[touchNum] = Scaler.transformY(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
	}
	
	public function touchMove(touchNum:Int,x:Int,y:Int)
	{
		touchFinger[touchNum] = true;
		touchX[touchNum] = Scaler.transformX(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
		touchY[touchNum] = Scaler.transformY(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
	}
	
	public function mouse()
	{
		mouseButton = new Vector(maxMouseButtons);
			for ( i in 0...mouseButton.length)
			{
				mouseButton[i] = false;
			}	
		Mouse.get(0).notify(mouseDown,mouseUp,mouseMove,mouseWheel);
	}
	
	private function mouseDown(button:Int, x:Int, y:Int)
	{
		mouseButton[button] = true;
		mouseX = Scaler.transformX(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
		mouseY = Scaler.transformY(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
	}
	
	private function mouseUp(button:Int, x:Int, y:Int)
	{
		mouseButton[button] = false;
		mouseX = Scaler.transformX(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
		mouseY = Scaler.transformY(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
	}
	
	private function mouseMove(x:Int, y:Int,xMovement:Int,yMovement:Int)
	{
		mouseX = Scaler.transformX(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
		mouseY = Scaler.transformY(x,y,inputBackbuffer, inputFramebuffer, System.screenRotation);
	}
	
	private function mouseWheel(wheel:Int)
	{
		//not done...
	}
	
}
//lazy controller 
class Controller
{
	public var A:Float = 0;
	public var B:Float = 0;
	public var X:Float = 0;
	public var Y:Float = 0;
	
	public var START:Float = 0;
	public var BACK:Float = 0;
	
	public var LB:Float = 0;
	public var RB:Float = 0;
	public var LT:Float = 0;
	public var RT:Float = 0;
	
	public var LABUTTON:Float = 0;
	public var RABUTTON:Float = 0;
	
	public var DPADUP:Float = 0;
	public var DPADDOWN:Float = 0;
	public var DPADLEFT:Float = 0;
	public var DPADRIGHT:Float = 0;
	
	public var LANALOGX:Float = 0;
	public var LANALOGY:Float = 0;
	public var RANALOGX:Float = 0;
	public var RANALOGY:Float = 0;
	
	
	public function new()
	{	
	}
	
	public function axis(axisNum:Int, axisValue:Float)
	{
		if (axisNum == 0) LANALOGX = axisValue;
		if (axisNum == 1) LANALOGY = axisValue;
		
		if (axisNum == 2) RANALOGX = axisValue;
		if (axisNum == 3) RANALOGY = axisValue;
	}
	
	public function button(buttonNum:Int, buttonValue:Float)
	{
		if (buttonNum == 0) A = buttonValue;
		if (buttonNum == 1) B = buttonValue;
		if (buttonNum == 2) X = buttonValue;
		if (buttonNum == 3) Y = buttonValue;
		
		if (buttonNum == 4) LB = buttonValue;
		if (buttonNum == 5) RB = buttonValue;
		
		if (buttonNum == 6) BACK = buttonValue;
		if (buttonNum == 7) START = buttonValue;
		
		if (buttonNum == 8) LT = buttonValue;
		if (buttonNum == 9) RT = buttonValue;
		
		if (buttonNum == 10) LABUTTON = buttonValue;
		if (buttonNum == 11) RABUTTON = buttonValue;
		
		if (buttonNum == 12) DPADUP = buttonValue;
		if (buttonNum == 13) DPADDOWN = buttonValue;
		if (buttonNum == 14) DPADLEFT = buttonValue;
		if (buttonNum == 15) DPADRIGHT = buttonValue;
	}
}

typedef AtlasImage = 
{
	var image:Image;
	var x:Float;
	var y:Float;
	var width:Float;
	var height:Float;
}