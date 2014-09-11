package ;
import haxe.ds.StringMap.StringMap;
import haxe.remoting.SocketProtocol.Socket;
#if (php || neko)
import haxe.Session;
#end
import sys.net.Host;
import haxe.web.Dispatch;

/**
 * ...
 * @author Masadow
 */
class Server
{

	public function new()
	{
	}
	
	public static function main()
	{
		var host : String = "localhost";
		var port : String = "3000";
		var args : Array<String> = Sys.args();
		if (args.length == 2) {
			host = args[0];
			port = args[1];
		}
		
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new ServerCppApi());
		var server = new Socket();
		server.bind(new Host(host), Std.parseInt(port));
		server.listen(100);
		var policyserver = new XmlPolicyServer(host);
		var clients : Array<Socket> = [server, policyserver.socket];
		
		Sys.println("Server running on " + host + ":" + port);
		while (true)
		{
			for (socket in Socket.select(clients, [], []).read) //Retrieve ready sockets to read
			{
				trace("Incomming request");
//				if ((untyped socket.__client) == null)
				if (socket == server)
				{
					trace("Incomming connection");
					//Incomming connection
					var s = server.accept();
					clients.push(s);
//					var response = '<cross-domain-policy><allow-access-from domain="*" to-ports="*" /></cross-domain-policy>\x00';
//					s.write(response);
					s.output.writeByte(1);
					trace("Client connected");
				}
				else if (socket == policyserver.socket)
				{
					policyserver.update();
				}
				else
				{
					trace("Incomming message");
					//Receiving client request
					try {
						var l = socket.input.readLine();
						trace("Data : " + l);
						var nparams = Std.parseInt(l);
						Sys.println("params : " + nparams);
						var request = socket.input.readLine();
						var params = new StringMap<String>();
						for (i in 0...nparams)
							params.set("" + i, socket.input.readLine());
						Dispatch.run(request, params, new ServerCppApi());
					}
					catch (e : Dynamic)
					{
						//Close socket
						clients.remove(socket);
						socket.close();
						trace("Client disconnected");
					}
					trace("Message treated");
				}
			}
//			client = server.accept();
		}
//		socket.
	}
}
