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
	
	//fps stuff
	private var FPS_totalFrames:Int = 0;
	private var FPS_elapsedTime:Float = 0;
	public var fps:Int = 0;
	private var FPS_previousTime:Float = 0;	
	
	override function init(): Void {
		backbuffer = Image.createRenderTarget(width, height);
		Drp.init();
		setup();
		Configuration.setScreen(this);
	}
	
	//override this
	function setup()
	{
		
	}
	
	function deltaUpdate()
	{
		var currentTime:Float = Scheduler.time();
		delta = (currentTime - FPS_previousTime);
		FPS_previousTime = currentTime;
		
        FPS_elapsedTime += delta;		
		if (FPS_elapsedTime >= 1.0) {
			fps = FPS_totalFrames;
			FPS_totalFrames = 0;
			FPS_elapsedTime = 0;
			trace(fps);
		}
	}
	
	override function render(frame: Framebuffer): Void 
	{	
		draw();
		
		graphics = backbuffer.g2; 
		graphics.begin();
		graphics.clear(Color.Black);
		
		graphics.transformation = FastMatrix3.identity();
		
		Drp.drawOrdered(graphics);
		
		graphics.end(); 
		 		 
		startRender(frame);
		Scaler.scale(backbuffer, frame, kha.Sys.screenRotation);
		endRender(frame);
		//fps
		FPS_totalFrames++;
	}
	
	function draw()
	{
		Drp.currentScene.draw();
	}
	
	override function update()
	{
		deltaUpdate();
		Drp.currentScene.update(delta);
	}
}