package libdrp;

import libdrp.Scene;

/**
 * ...
 * @author Nate Edwards
 */
class Drp
{
	var scenes:Map<String,Scene>;
	
	public static var __instance:libdrp.Drp;
	
	public var currentScene:Scene;
	
	public function new() 
	{
		scenes = new Map<String,Scene>();
	}
	
	public static function get():Drp
	{
		if (Drp.__instance == null)
            Drp.__instance = new Drp();
        return Drp.__instance;
	}
	
	public function addScene(name:String,screen:Scene)
	{
		scenes.set(name, screen);
	}
	
	public function setScene(name:String)
	{
		if (currentScene != null) currentScene.unloadAssets();
		currentScene = scenes.get(name);
	}
	
}