package ;
import flash.net.Socket;

/**
 * ...
 * @author Masadow
 */
class SocketUtil
{
	public static function sendRequest(socket : Socket, request : String, args : Array<Dynamic>)
	{
		socket.writeObject(args.length + "\n");
		socket.writeObject(request + "\n");
		for (arg in args)
			socket.writeObject(arg + "\n");
		socket.flush();
	}
	
}