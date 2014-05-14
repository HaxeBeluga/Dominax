package state;

import flash.Lib;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.text.FlxText;
import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = true;
		#end

		super.create();

		var loadState = new LoadState("Connecting to the server ...", Player.login, "login", [GameClass.playerId]);
		loadState.closeCallback = init;
		this.openSubState(loadState);
	}
	
	public function init()
	{
		if (Player.logged == null)
		{
			var error = new FlxText(0, 200, 640, "Unable to connect to the server, please make sure you are logged in", 32);
			error.alignment = "center";
			add(error);
		}
		else
			add(new FlxText(50, 50, 0, "Welcome " + Player.logged.name, 16));
	}

	override public function update():Void 
	{
		super.update();
	}
}
