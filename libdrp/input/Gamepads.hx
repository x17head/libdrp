package libdrp.input;

import kha.input.Gamepad;

/**
 * ...
 * @author Nate Edwards
 */
class Gamepads
{
	public static var __instance:Gamepads;
	
	public var gamepad:Array < Gamepad>;
	public var controllers:Array<Controller>;
	
	public function new() 
	{
		gamepad = new Array<Gamepad>();
		controllers = new Array<Controller>();		
		refreshControllers();
	}
	
	public function refreshControllers()
	{
		for (i in 0...3)
		{
			gamepad[i] = kha.input.Gamepad.get(i);
			controllers[i] = new Controller();
			if (gamepad[i] != null) gamepad[i].notify(controllers[i].axis, controllers[i].button);
		}
	}
	
	public static function get():Gamepads
    {
        if (Gamepads.__instance == null)
            Gamepads.__instance = new Gamepads();
        return Gamepads.__instance;
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