package net;

/**
 * ...
 * @author Masadow
 */
// define a typed remoting API
class ClientApiImpl extends haxe.remoting.AsyncProxy<net.IClientApi> {
}

// our client class
class ClientData extends ServerApi {

	var api : ClientApiImpl;
	var name : String;

	public function new( scnx : haxe.remoting.SocketConnection ) {
		api = new ClientApiImpl(scnx.client);
		(cast scnx).__private = this;
	}

	public function leave() {
		Server.clients.remove(this);
	}

	public static function ofConnection( scnx : haxe.remoting.SocketConnection ) : ClientData {
		return (cast scnx).__private;
	}

}

// server loop

class Server {

	public static var clients = new List<ClientData>();

	static function initClientApi( scnx : haxe.remoting.SocketConnection, context : haxe.remoting.Context ) {
		trace("Client connected");
		scnx.setErrorHandler(function (error) { trace(error); } );
		var c = new ClientData(scnx);
		context.addObject("api", c);
	}

	static function onClientDisconnected( scnx ) {
		trace("Client disconnected");
		ClientData.ofConnection(scnx).leave();
	}

	static function main() {
		var host = "localhost";
		var domains = [host];
		var s = new neko.net.ThreadRemotingServer(domains);
		s.initClientApi = initClientApi;
		s.clientDisconnected = onClientDisconnected;
		trace("Starting server...");
		s.run(host,3000);
	}
}
