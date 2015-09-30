package libdrp;

import haxe.ds.Vector;
import libdrp.Scene;
import kha.input.Mouse;
import kha.input.Gamepad;
import kha.input.Surface;

/**
 * ...
 * @author Nate Edwards
 */
class Drp
{
	var scenes:Map<String,Scene>;
	
	public static var __instance:libdrp.Drp;
	
	//touch vars
	private var __touch:Surface;
	public var touch:Vector<Bool>;
	public var touchX:Vector<Int>;
	public var touchY:Vector<Int>;
	
	//mouse vars
	private var __mouse:kha.input.Mouse;
	public var mouseX:Int = 0;
	public var mouseY:Int = 0;
	public var mouseButton:Vector<Bool>;
	//if anyone has a mouse with more then 99 buttons let me know, ill increase it...
	private var maxMouseButtons:Int = 99;
	
	//gamepad vars
	public var gamepad:Vector < Gamepad>;
	public var controllers:Vector<Controller>;
	
	public var currentScene:Scene;
	
	public function new() 
	{
		scenes = new Map<String,Scene>();
		
		//setup touch
		touch = new Vector(10);
		touchX = new Vector(10);
		touchY = new Vector(10);
		__touch = Surface.get(0);
		if(__touch != null)__touch.notify(touchDown, touchUp, touchMove);
		//setup mouse
		__mouse = kha.input.Mouse.get(0);
		if(__mouse != null)__mouse.notify(mouseDown, mouseUp, mouseMove, mouseWheel);
		mouseButton = new Vector(maxMouseButtons);
		for ( i in 0...mouseButton.length)
		{
			mouseButton[i] = false;
		}
		//setup gamepads
		gamepad = new Vector(4);
		controllers = new Vector(4);		
		refreshControllers();
	}
	
	//singlton stuff
	public static function get():Drp
	{
		if (Drp.__instance == null)
            Drp.__instance = new Drp();
        return Drp.__instance;
	}
	
	//<scene stuff>
	public function addScene(name:String,screen:Scene)
	{
		scenes.set(name, screen);
	}
	
	public function setScene(name:String)
	{
		if (currentScene != null) currentScene.unloadAssets();
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
	
	private function mouseMove(x:Int, y:Int)
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
}

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