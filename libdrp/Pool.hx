package libdrp;
import haxe.xml.Check.Attrib;
import libdrp.View;

/**
 * ...
 * @author Nate Edwards
 */
class Pool extends Entity
{
	var total:Int;
	var type:Class<Entity>;
	var poolOfEntitys:Array<Dynamic>;
	//pool object must be named so they can be got through view.getEntity()
	//the total is final
	public function new(name:String,type:Class<Entity>,total:Int) 
	{
		super(name);
		this.total = total;
		this.type = type;
		poolOfEntitys = new Array<Dynamic>();
		for (i in 0...total) poolOfEntitys[i] = Type.createInstance(type,[]);
	}
	
	override public function setup() 
	{
		for (Dynamic in poolOfEntitys) Dynamic.setup();
	}
	
	override public function addView(view:View) 
	{
		super.addView(view);
		for (i in 0...poolOfEntitys.length) poolOfEntitys[i].addView(view);
	}
	
	override public function reset() 
	{
		for (i in 0...poolOfEntitys.length) poolOfEntitys[i].reset();
	}
	//find the first avaiable entity and activates it, if none are available it does nothing
	public function add(input:Array<Dynamic>)
	{
		for (i in 0...poolOfEntitys.length) 
		{
			if (!poolOfEntitys[i].active) 
			{
				poolOfEntitys[i].pool(input);
				break;
			}
		}
	}
	//returns an array of active entities
	public function getActive():Array<Entity>
	{
		var active = new Array<Entity>();
		
		for (i in 0...poolOfEntitys.length)
		{
			if (poolOfEntitys[i].active) active.push(poolOfEntitys[i]);
		}
		return active;
	}
	//update active entities in the pool
	override public function update(delta:Float) 
	{
		for (i in 0...poolOfEntitys.length) if(poolOfEntitys[i].active) poolOfEntitys[i].update(delta);
	}
	//draw active entities in the pool
	override public function draw() 
	{
		for (i in 0...poolOfEntitys.length) if(poolOfEntitys[i].active) poolOfEntitys[i].draw();
	}
	
}