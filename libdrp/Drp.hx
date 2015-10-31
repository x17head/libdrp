package libdrp;

import haxe.ds.Vector;
import haxe.xml.Fast;
import kha.arrays.Float32Array;
import kha.graphics2.Graphics;
import kha.Image;
import kha.input.Keyboard;
import kha.Key;
import libdrp.Scene;
import kha.input.Mouse;
import kha.input.Gamepad;
import kha.input.Surface;
import kha.Loader;

/**
 * ...
 * @author Nate Edwards
 */
class Drp
{
	var scenes:Map<String,Scene>;
	
	public static var instance:libdrp.Drp;
	
	//touch vars
	public static var touch:Vector<Bool>;
	public static var touchX:Vector<Int>;
	public static var touchY:Vector<Int>;
	
	//keyboard var
	public var keyboardMap:Map<String,String>;
	
	//mouse vars
	public static var mouseX:Int = 0;
	public static var mouseY:Int = 0;
	public static var mouseButton:Vector<Bool>;
	//if anyone has a mouse with more then 99 buttons let me know, ill increase it...
	private var maxMouseButtons:Int = 99;
	
	//gamepad vars
	public var gamepad:Vector < Gamepad>;
	public var controllers:Vector<Controller>;
	
	//draw z var
	var drawListImage:Array<Image>;
	var drawListName:Array<String>;
	var drawListX:Array<Float>;
	var drawListY:Array<Float>;
	var drawListZ:Array<Float>;
	var drawListW:Array<Float>;
	var drawListH:Array<Float>;
	var drawListR:Array<Float>;
	
	var drawListCount:Int = 0;
	
	//atlas
	public static var Atlas:Map<String,AtlasImage>;
	
	public static var currentScene:Scene;
	
	public function new() 
	{
		if (instance == null)
		{
			scenes = new Map<String,Scene>();
		
			//setup touch
			touch = new Vector(10);
			touchX = new Vector(10);
			touchY = new Vector(10);
		
			//add #if so it doesnt crash if touch isnt supported.
			
			#if !sys_flash
			Surface.get().notify(touchDown, touchUp, touchMove);
			#end
			
			//setup mouse
			kha.input.Mouse.get(0).notify(mouseDown, mouseUp, mouseMove, mouseWheel);
			mouseButton = new Vector(maxMouseButtons);
			for ( i in 0...mouseButton.length)
			{
				mouseButton[i] = false;
			}
		
			//setup gamepads
			gamepad = new Vector(4);
			controllers = new Vector(4);		
			refreshControllers();
		
			//setup keyboard
			keyboardMap = new Map();
			Keyboard.get(0).notify(keyboardDown, keyboardUp);
		
			//setup draw lists
			drawListImage = new Array<Image>();
			drawListName = new Array<String>();
			drawListX = new Array<Float>();
			drawListY = new Array<Float>();
			drawListZ = new Array<Float>();
			drawListW = new Array<Float>();
			drawListH = new Array<Float>();
			drawListR = new Array<Float>();
			
			Atlas = new Map<String,AtlasImage>();
			
			instance = this;
		}
	}
	
	//singlton stuff
	public static function init()
	{
        instance = new Drp();
	}
	
	//<scene stuff>
	public static function addScene(name:String,screen:Scene)
	{
		instance._addScene(name, screen);
	}
	
	public function _addScene(name:String,screen:Scene)
	{
		scenes.set(name, screen);
	}
	
	public static function setScene(name:String)
	{
		instance._setScene(name);
	}
	
	public function _setScene(name:String)
	{
		currentScene = scenes.get(name);
	}
	
	//</scene stuff>
	
	//<mouse stuff>
	private function mouseDown(button:Int, x:Int, y:Int)
	{
		mouseButton[button] = true;
		mouseX = x;
		mouseY = y;
	}
	
	private function mouseUp(button:Int, x:Int, y:Int)
	{
		mouseButton[button] = false;
		mouseX = x;
		mouseY = y;
	}
	
	private function mouseMove(x:Int, y:Int,xMovement:Int,yMovement:Int)
	{
		mouseX = x;
		mouseY = y;
	}
	
	private function mouseWheel(wheel:Int)
	{
		//not done...
	}
	//</mouse stuff>
	
	//<gamepad stuff>
		public function refreshControllers()
	{
		for (i in 0...3)
		{
			gamepad[i] = kha.input.Gamepad.get(i);
			controllers[i] = new Controller();
			if (gamepad[i] != null) gamepad[i].notify(controllers[i].axis, controllers[i].button);
		}
	}
	//</gamepad stuff>
	
	//<touch stuff>
	
	public function touchDown(touchNum:Int,x:Int,y:Int)
	{
		touch[touchNum] = true;
		touchX[touchNum] = x;
		touchY[touchNum] = y;
	}
	
	public function touchUp(touchNum:Int,x:Int,y:Int)
	{
		touch[touchNum] = false;
		touchX[touchNum] = x;
		touchY[touchNum] = y;
	}
	
	public function touchMove(touchNum:Int,x:Int,y:Int)
	{
		touch[touchNum] = true;
		touchX[touchNum] = x;
		touchY[touchNum] = y;
	}
	//</touch stuff>
	
	//<keyboard stuff>
	public function keyboardDown(key:Key, string:String)
	{
		keyboardMap.set(string, string);
	}
	
	public function keyboardUp(key:Key, string:String)
	{
		keyboardMap.remove(string);
	}
	
	public static function keyboardKey(string:String)
	{
		return instance._keyboardKey(string);
	}
	
	public function _keyboardKey(string:String)
	{
		return keyboardMap.exists(string);
	}
	
	//atlas stuff
	
	public static function loadAtlas(name:String)
	{
		instance._loadAtlas(name);
	}
	
	public function _loadAtlas(name:String)
	{
		var xml = Xml.parse(Loader.the.getBlob(name).toString());
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
			image:Loader.the.getImage(fast.name),
			x:temp[0],
			y:temp[1],
			width:temp[2],
			height:temp[3]
			});
		}
		
	}
	
	public static function unloadAtlas(name:String)
	{
		instance._unloadAtlas(name);
	}
	
	public function _unloadAtlas(name:String)
	{
		
	}
	
	//<batched draw call stuff>
	
	//adds draw call to the draw stack
	public static function drawCallOrdered(image:Image,name:String,x:Float,y:Float,z:Float,w:Float,h:Float,r:Float)
	{
		instance._drawCallOrdered(image, name, x, y, z, w, h, r);
	}
	
	public function _drawCallOrdered(image:Image,name:String,x:Float,y:Float,z:Float,w:Float,h:Float,r:Float)
	{
		
		drawListImage[drawListCount] = image;
		drawListName[drawListCount] = name;
		drawListX[drawListCount] = x;
		drawListY[drawListCount] = y;
		drawListZ[drawListCount] = z;
		drawListW[drawListCount] = w;
		drawListH[drawListCount] = h;
		drawListR[drawListCount] = r;
		drawListCount++;
	}
	
	public static function drawOrdered(graphics:Graphics)
	{
		instance._drawOrdered(graphics);
	}
	
	//executes draw calls in desired order
	public function _drawOrdered(graphics:Graphics)
	{
		var numberDrawn:Int = 0;
		var currentZ:Int = 0;
		while (numberDrawn != drawListCount)
		{
			for ( i in 0...drawListCount)
			{
				if (drawListZ[i] == currentZ)
				{
					if (drawListR[i] != 0) graphics.pushRotation(drawListR[i], 
						drawListX[i] + drawListW[i] / 2, 
						drawListY[i] + drawListH[i] / 2
						);
						
					if (drawListName[i] == null)
					{
						graphics.drawScaledImage(drawListImage[i], 
						drawListX[i], 
						drawListY[i], 
						drawListW[i], 
						drawListH[i]
						);
					}
					
					if (drawListName[i] != null)
					{
						//do atlas magic here...
						var tempImageAtlas:AtlasImage = Atlas.get(drawListName[i]);
						
						graphics.drawScaledSubImage(drawListImage[i],
						tempImageAtlas.x,
						tempImageAtlas.y,
						tempImageAtlas.width,
						tempImageAtlas.height,
						drawListX[i], 
						drawListY[i], 
						drawListW[i], 
						drawListH[i]
						);
					}
						
					if (drawListR[i] != 0)graphics.popTransformation();
					numberDrawn++;
				}
			}
			currentZ++;
		}
		drawListCount = 0;
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