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
	
	public function new(name:String,type:Class<Entity>,total:Int) 
	{
		super();
		this.name = name;
		this.total = total;
		this.type = type;
		poolOfEntitys = new Array<Dynamic>();
		for (i in 0...total) poolOfEntitys[i] = Type.createInstance(type,[]);
	}
	
	override public function addView(view:View) 
	{
		super.addView(view);
		for (i in 0...poolOfEntitys.length) poolOfEntitys[i].addView(view);
	}
	
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
	
	public function getActive():Array<Entity>
	{
		var active = new Array<Entity>();
		
		for (i in 0...poolOfEntitys.length)
		{
			if (poolOfEntitys[i].active) active.push(poolOfEntitys[i]);
		}
		return active;
	}
	
	override public function update(delta:Float) 
	{
		for (i in 0...poolOfEntitys.length) if(poolOfEntitys[i].active) poolOfEntitys[i].update(delta);
	}
	
	override public function draw() 
	{
		for (i in 0...poolOfEntitys.length) if(poolOfEntitys[i].active) poolOfEntitys[i].draw();
	}
	
}