package state;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import haxe.remoting.HttpAsyncConnection;
import haxe.remoting.SocketConnection;
import state.LoadState.ServerApiImpl;
//import haxe.remoting.SocketProtocol.Socket;
import flash.net.Socket;
import net.ClientApi;

using SocketUtil;

class ServerApiImpl extends haxe.remoting.AsyncProxy<net.IServerApi> {
}

/**
 * Execute a query to the game server
 * @author Masadow
 */
class LoadState extends FlxSubState
{
	private static var socket : flash.net.XMLSocket = null;
	private static var scnx : SocketConnection;
	private static var server : ServerApiImpl;
	
	private var msg : String;
	private var cb : Dynamic -> Void;
	private var cmd : String;
	private var args : Array<Dynamic>;
	private var htmlRequest : Bool;

	public function new(msg : String, cb : Dynamic -> Void, cmd : String, args : Array<Dynamic>, htmlRequest : Bool = true)
	{
		super();

		this.msg = msg;
		this.cb = cb;
		this.cmd = cmd;
		this.args = args;
		this.htmlRequest = htmlRequest;
	}

	override public function create():Void
	{
		super.create();

		var txt = new FlxText(0, 350, 640, msg, 24);
		txt.alignment = "center";
		add(txt);

		if (htmlRequest)
		{
			var cnx = HttpAsyncConnection.urlConnect("http://" + GameClass.host + "/");
			cnx.setErrorHandler( function(err) FlxG.log.error(Std.string(err)) );
			cnx.Server.resolve(cmd).call(args, function(v) { cb(v); done(); } );
		}
		else
		{
			//Prepare socket if needed
			if (socket == null)
			{
				FlxG.log.add("Init socket");
				socket = new flash.net.XMLSocket();
				socket.addEventListener(flash.events.Event.CONNECT, send);
				socket.connect("localhost",3000);
				var context = new haxe.remoting.Context();
				context.addObject("client", new ClientApi());
				scnx = haxe.remoting.SocketConnection.create(socket,context);
				scnx.setErrorHandler( function(err) FlxG.log.error(Std.string(err)) );
				context.addObject("server", new ServerApiImpl(scnx.api));
			}
			else {
				send(null);
			}
		}
	}
	
	public function send(event:flash.events.Event)
	{ //socket only
		FlxG.log.add("Send request");
		scnx.api.resolve(cmd).call(args, function(v) { cb(v); done(); } );
	}

	private function done()
	{
		//Request is done, we can close this state
		close();
	}
}
