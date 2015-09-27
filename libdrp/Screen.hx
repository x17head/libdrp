package libdrp;

import kha.graphics2.Graphics;
import kha.Loader;

/**
 * ...
 * @author Nate Edwards
 */
class Screen
{

	var assetsLoaded:Bool = false;
	
	var views:Array<View>;
	
	public function new() 
	{
		views = new Array<View>();
	}
	
	public function addView(view:View)
	{
		views.push(view);
	}
	
	public function act(delta:Float)
	{
		if(assetsLoaded)for (View in views) View.act(delta);
	}
	
	public function draw(graphics:Graphics)
	{
		if(assetsLoaded)for (View in views) View.draw(graphics);
	}
	
	public function loadAssets(name:String)
	{
		Loader.the.loadRoom(name, assetsLoadedCallback);
	}
	
	public function assetsLoadedCallback()
	{
		assetsLoaded = true;
		for (View in views) View.load();
	}
	
	public function unloadAssets()
	{
		
	}
}