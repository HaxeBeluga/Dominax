package ;
import php.Web;

/**
 * ...
 * @author Masadow
 */
class Server
{

	public function new() 
	{		
	}
	
	public function login()
	{
		return Web.getClientHeaders();
	}
	
}