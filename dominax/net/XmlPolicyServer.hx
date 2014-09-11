package ;

import sys.net.Socket;
import sys.net.Host;
import haxe.io.Bytes;
/**
 * Compiled separatly under neko.
 */

class XmlPolicyServer {
	public var socket : Socket;
	
    public function new(host : String) {
        socket = new Socket();
        try{
            socket.bind( new Host( host ), 843 );

            socket.listen( 10 );
        }
        catch (z:Dynamic) {
            Sys.stdout().writeString("Server Start Failed. \n");
            return;
        }
		Sys.println("Policy server running on " + host + ":843");
        //while (true) {
        //}
    }
	
	public function update()
	{
		trace("Receive policy request");
		var cnx = socket.accept();
		var tbuf = Bytes.alloc(30);
		var cont = true;
		var msg : String = '';
		while (cont)
		{
			try
			{
				cnx.waitForRead();
				var len = cnx.input.readBytes(tbuf, 0, 30);
				msg += tbuf.toString().substr(0, len);
				cont = msg.indexOf('\x00') < 0; // read up to null byte
			}
			catch (e : Dynamic)
			{

				var x = Std.string(e);
				if (x != 'Eof')
				{
					trace('Error: $x');
				}
				cont = false;

			}
		}
		var msg_cut = msg.substr(1, 6);
		
		if ( msg_cut == 'policy' ) {    
			var response = '<cross-domain-policy><allow-access-from domain="*" to-ports="*" /></cross-domain-policy>\x00';
			cnx.write(response);
			trace("Allow policy");
		}
		cnx.shutdown(true, true);		
	}
}