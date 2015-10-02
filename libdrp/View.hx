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
		
	public var entitys : Array<Entity>;
	
	public function new(RealX_in:Int, RealY_in:Int, RealWidth_in:Int, RealHeight_in:Int, VirtualWidth_in:Int, VirtualHeight_in:Int)
	{		
		
		var viewPropertiesTEST:ViewProperties = { 
			RealX:RealX_in,
			RealY:RealY_in,
			RealWidth:RealWidth_in,
			RealHeight:RealHeight_in,
			VirtualWidth:VirtualWidth_in,
			VirtualHeight:VirtualHeight_in,
			scaleX:RealWidth_in/ VirtualWidth_in,
			scaleY:RealHeight_in / VirtualHeight_in 
			};
			
		viewProperties = viewPropertiesTEST;
		
		entitys = new Array<Entity>();
		
	}
	
	public function update(delta:Float):Void
	{
		//update all Actors
		for (Entity in entitys) Entity.update(delta);
	}
	
	public function draw(graphics:Graphics):Void
	{
		//render all Actors
		for (Entity in entitys) Entity.draw(graphics);
	}
	
	public function addEntity(entity: Entity) { 
		entitys.push(entity);
		entity.setView(this);
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