package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.Account;
import beluga.core.BelugaException;

/**
 * Beluga #1
 * Load the account class
 * Use it to generate login form, subscribe form, logged homepage
 * @author Masadow
 */

class Main 
{
	static var beluga;

	static function main() 
	{
//		try {
			beluga = new Beluga();
			var acc = beluga.getModuleInstance(Account);
			beluga.run();
		//} catch (e : BelugaException) {
			//trace(e);
		//}
	}

//	public static function index(isLogged : Bool) {
	public static function index() {
		trace("You are logged in");
		var acc = beluga.getModuleInstance(Account);
		if (!acc.isLogged())
			beluga.webDispatcher.redirect('login');
	}
	
	public static function login() {
		var acc = beluga.getModuleInstance(Account);
		var loginBox : Widget = acc.getWidget("login"); //Generic method for all modules
		loginBox.context.login = "Toto"; // For instance, it would fill the username field with Toto
		var subscribeBox : Widget = acc.getWidget("subscribe");
		
		var html : String = loginBox.render() + subscribeBox.render();
		Sys.print(html);
	}

}