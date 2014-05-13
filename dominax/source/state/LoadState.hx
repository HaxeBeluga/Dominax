package state;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxG;

/**
 * ...
 * @author Masadow
 */
class LoadState extends FlxSubState
{
	
	private var msg : String;
	private var cb : (Void -> Void) -> Void;

	public function new(msg : String, cb : (Void -> Void) -> Void)
	{
		super();
		
		this.msg = msg;
		this.cb = cb;
	}
	
	override public function create():Void 
	{
		super.create();
		
		var txt = new FlxText(0, 350, 640, msg, 24);
		txt.alignment = "center";
		add(txt);
		
		//Prepare the request
		FlxG.log.add("callback");
		cb(done);
	}
	
	private function done()
	{
		//Request is done, we can close this state
		FlxG.log.add("done");
		close();
	}
	
	override public function update():Void 
	{
		super.update();
	}
}