package net;

import beluga.core.Beluga;
import beluga.module.account.Account;

/**
 * ...
 * @author Masadow
 */
class ServerApi implements IServerApi
{
	public function login(id : Int)
	{
		Sys.println("Login attempt");
		var acc = Beluga.getInstance().getModuleInstance(Account);
		var usr = acc.getUser(id);
		Sys.println("Return " + (usr != null ? usr.login : "null"));
		return usr != null ? {id: usr.id, name: usr.login} : null;
	}
}