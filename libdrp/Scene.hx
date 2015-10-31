package libdrp;

import kha.graphics2.Graphics;
import kha.Loader;

/**
 * ...
 * @author Nate Edwards
 */
//scene is a container class for one or more views
class Scene
{
	var loaded = false;
	
	var views:Array<View>;
	
	public function new() 
	{
		views = new Array<View>();
	}
	
	public function addView(view:View)
	{
		views.push(view);
	}
	
	public function update(delta:Float)
	{
		if(loaded)for (View in views) View.update(delta);
	}
	
	public function draw()
	{
		if(loaded)for (View in views) View.draw();
	}
	
	public function loadAssets(name:String)
	{
		Loader.the.loadRoom(name, setup);
	}
	
	public function setup()
	{
		for (View in views) View.setup();
		loaded = true;
	}
	
	public function unloadAssets()
	{
		
	}
}