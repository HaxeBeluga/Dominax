package state;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import haxe.remoting.HttpAsyncConnection;

/**
 * ...
 * @author Masadow
 */
class LoadState extends FlxSubState
{
	private var msg : String;
	private var cb : Dynamic -> (Void -> Void) -> Void;
	private var cmd : String;
	private var args : Array<Dynamic>;

	public function new(msg : String, cb : Dynamic -> (Void -> Void) -> Void, cmd : String, args : Array<Dynamic>)
	{
		super();

		this.msg = msg;
		this.cb = cb;
		this.cmd = cmd;
		this.args = args;
	}

	override public function create():Void
	{
		super.create();

		var txt = new FlxText(0, 350, 640, msg, 24);
		txt.alignment = "center";
		add(txt);

		//Prepare the request
//		var cnx = haxe.remoting.HttpAsyncConnection.urlConnect("http://" + GameClass.host);
		var cnx = haxe.remoting.HttpAsyncConnection.urlConnect("http://haxe/BelugaDemo/bin");
		// setup error handler
		cnx.setErrorHandler( function(err) FlxG.log.error(Std.string(err)) );
		cnx.Server.resolve(cmd).call(args, function(v) cb(v, done));
	}

	private function done()
	{
		//Request is done, we can close this state
		close();
	}
}
