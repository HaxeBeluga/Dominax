package ;

import beluga.module.account.Account;
import beluga.core.Beluga;
import haxe.web.Dispatch;

/**
 * ...
 * @author Masadow
 */
class ServerCppApi
{
	
	public function new()
	{
	}

	public function doLogin(id : Int)
	{
		Sys.println("Login attempt");
		var acc = Beluga.getInstance().getModuleInstance(Account);
		var usr = acc.getUser(id);
		return usr != null ? {id: usr.id, name: usr.login} : null;
	}
	
}