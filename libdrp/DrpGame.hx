package libdrp;

import kha.Game;
import kha.Framebuffer;
import kha.Color;
import kha.graphics2.Graphics;
import kha.Image;
import kha.Loader;
import kha.Scaler;
import kha.math.FastMatrix3;
import kha.Scheduler;
import kha.Configuration;
import kha.LoadingScreen;
import libdrp.Drp;

/**
 * ...
 * @author Nate Edwards
 */
class DrpGame extends Game
{

	var backbuffer:Image;
	var delta:Float;
	var lastFrameDeltaTime:Float;
	var graphics:Graphics;
	var game:Drp;
	
	override function init(): Void {
		backbuffer = Image.createRenderTarget(width, height);
		deltaSetup();
		game = new Drp();
		setup();
		Configuration.setScreen(this);
	}
	
	//override this
	function setup()
	{
		
	}
	
	function deltaSetup()
	{
		lastFrameDeltaTime = Scheduler.time();
	}
	
	function deltaUpdate()
	{
		delta = Scheduler.time() - lastFrameDeltaTime;
		lastFrameDeltaTime = Scheduler.time();
	}
	
	override function render(frame: Framebuffer): Void 
	{	
		graphics = backbuffer.g2; 
		graphics.begin();
		graphics.clear(Color.Black);
		
		graphics.transformation = FastMatrix3.identity();
		
		draw(graphics);
		
		graphics.end(); 
		 		 
		startRender(frame);
		Scaler.scale(backbuffer, frame, kha.Sys.screenRotation);
		endRender(frame); 
	}
	
	function draw(graphics:Graphics)
	{
		game.get().currentScreen.draw(graphics);
	}
	
	function act(delta:Float)
	{
		game.get().currentScreen.act(delta);
	}
	
	override function update()
	{
		deltaUpdate();
		act(delta);
	}
}