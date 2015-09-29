package libdrp;

import kha.Game;
import kha.graphics2.Graphics;
import kha.Image;
import libdrp.View.ViewProperties;

/**
 * ...
 * @author Nate Edwards
 */
 
class View
{
	public var viewProperties:ViewProperties;
		
	var entitys : Array<Entity>;
	
	public function new(RealXin:Int, RealYin:Int, RealWidthin:Int, RealHeightin:Int, VirtualWidthin:Int, VirtualHeightin:Int)
	{		
		
		var viewPropertiesTEST:ViewProperties = { 
			RealX:RealXin,
			RealY:RealYin,
			RealWidth:RealWidthin,
			RealHeight:RealHeightin,
			VirtualWidth:VirtualWidthin,
			VirtualHeight:VirtualHeightin,
			scaleX:RealWidthin/ VirtualWidthin,
			scaleY:RealHeightin / VirtualHeightin 
			};
			
		viewProperties = viewPropertiesTEST;
		
		entitys = new Array<Entity>();
		
	}
	
	public function act(delta:Float):Void
	{
		//update all Actors
		for (Entity in entitys) Entity.act(delta);
	}
	
	public function draw(graphics:Graphics):Void
	{
		//render all Actors
		for (Entity in entitys) Entity.draw(graphics);
	}
	
	public function addEntity(entity: Entity) { 
		entitys.push(entity);
		entity.StageRealX = viewProperties.RealX;
		entity.StageRealY = viewProperties.RealY;
		entity.scaleX = viewProperties.scaleX;
		entity.scaleY = viewProperties.scaleY;
 	} 
	
	public function load()
	{
		for (Entity in entitys) Entity.load();
	}
	
}

typedef ViewProperties =
{
	RealX:Int,
	RealY:Int,
	RealWidth:Int,
	RealHeight:Int,
	VirtualWidth:Int,
	VirtualHeight:Int,
	scaleX:Float,
	scaleY:Float
}