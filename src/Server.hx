package ;
import beluga.module.account.Account;
import beluga.core.Beluga;
import haxe.Session;

/**
 * ...
 * @author Masadow
 */
class Server
{

	public function new()
	{
	}
	
	public function login(id : String)
	{
		var acc = Beluga.getInstance().getModuleInstance(Account);
		var usr = acc.getUser(Std.parseInt(id));
		return usr != null ? {id: usr.id, name: usr.login} : null;
	}
	
}

