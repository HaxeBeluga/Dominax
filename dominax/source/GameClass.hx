package;

import flash.Lib;
import flixel.FlxGame;
	
class GameClass extends FlxGame
{	
	public static var host(default, null) : String;
	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		var ratioX:Float = stageWidth / 640;
		var ratioY:Float = stageHeight / 480;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		var fps:Int = 60;
	
		host = Lib.current.loaderInfo.parameters.host;
		
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), state.PlayState, ratio, fps, fps);
	}
}
