package libdrp;

import kha.Game;
import kha.graphics2.Graphics;
import kha.Image;
import libdrp.ViewProperties;

/**
 * ...
 * @author Nate Edwards
 */
 
class View
{
	public var viewProperties:ViewProperties;
		
	var entitys : Array<Entity>;
	
	public function new(RealX:Int, RealY:Int, RealWidth:Int, RealHeight:Int, VirtualWidth:Int, VirtualHeight:Int)
	{		
		viewProperties =  new ViewProperties();
		
		viewProperties.RealX = RealX;
		viewProperties.RealY = RealY;
		viewProperties.RealWidth = RealWidth;
		viewProperties.RealHeight = RealHeight;
		
		viewProperties.VirtualWidth = VirtualWidth;
		viewProperties.VirtualHeight = VirtualHeight;
		
		viewProperties.scaleX = RealWidth/ VirtualWidth;
		viewProperties.scaleY = RealHeight / VirtualHeight;
		
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
	
}