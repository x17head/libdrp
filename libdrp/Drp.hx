package libdrp;

import libdrp.Screen;

/**
 * ...
 * @author Nate Edwards
 */
class Drp
{
	var screens:Map<String,Screen>;
	
	public static var __instance:libdrp.Drp;
	
	public var currentScreen:Screen;
	
	public function new() 
	{
		screens = new Map<String,Screen>();
	}
	
	public function get():Drp
	{
		if (Drp.__instance == null)
            Drp.__instance = new Drp();
        return Drp.__instance;
	}
	
	public function addScreen(name:String,screen:Screen)
	{
		screens.set(name, screen);
	}
	
	public function setScreen(name:String)
	{
		if (currentScreen != null) currentScreen.unloadAssets();
		currentScreen = screens.get(name);
	}
	
}