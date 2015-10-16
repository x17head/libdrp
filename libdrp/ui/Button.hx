package libdrp.ui;

import libdrp.Entity;

/**
 * ...
 * @author Nate Edwards
 */
class Button extends Entity
{

	public function new(Name:String) 
	{
		super(Name);
	}
	
	public function ButtonMouseOver()
	{
		
	}
	
	public function ButtonMouseClick()
	{
		
	}
	
	public function ButtonTouchDown()
	{
		
	}
	
	override public function update(delta:Float) 
	{
		if (MouseX() > x && MouseX() < x + width && MouseY() > y && MouseY() < y + height)
		{
			ButtonMouseOver();
			if (MouseButton(0)) ButtonMouseClick();
		}
		
		if (TouchX(0) > x && TouchX(0) < x + width && TouchY(0) > y && TouchY(0) < y + height)
		{
			if (TouchDown(0)) ButtonTouchDown();
		}
	}
}