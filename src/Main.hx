package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.Account;

/**
 * Beluga #1
 * Load the account class
 * Use it to generate login form, subscribe form, logged homepage
 * @author Masadow
 */

class Main 
{
	static var beluga = new Beluga();

	static function main() 
	{
		var acc = beluga.getModuleInstance(Account, "");
//		acc.test();
//		trace(acc);
//		AccountImpl.getInstance().test();
//		trace(acc.a);
		beluga.run();
	}

//	public static function index(isLogged : Bool) {
	public static function index() {
		trace("You are logged in");
		var acc = beluga.getModuleInstance(Account, "");
		if (!acc.isLogged())
			beluga.webDispatcher.redirect('login');
	}
	
	public static function login() {
		var acc = beluga.getModuleInstance(Account);
		var loginBox : Widget = acc.getWidget("login"); //Generic method for all modules
		loginBox.context.login = "Toto"; // For instance, it would fill the username field with Toto
		var html : String = loginBox.render();
		var subscribeBox : Widget = acc.getWidget("subscribe");
		Sys.print(html);
	}

}