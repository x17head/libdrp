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
		for (View in views) View.update(delta);
	}
	
	public function draw()
	{
		for (View in views) View.draw();
	}
	
	public function loadAssets(name:String)
	{
		Loader.the.loadRoom(name, setup);
	}
	//override this and create all your views and entitys here after the room has been loaded
	public function setup()
	{
		
	}
	
	public function unloadAssets()
	{
		
	}
}