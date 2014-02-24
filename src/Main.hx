package ;

import beluga.core.Beluga;
<<<<<<< HEAD
import beluga.core.api.BelugaApi;
=======
>>>>>>> 0da8e59247b1876c9c6d19657e1ddf3838b179f4
import beluga.core.Widget;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import php.Web;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import beluga.module.account.SubscribeFailCause;

/**
 * Beluga #1
 * Load the account class
 * Use it to generate login form, subscribe form, logged homepage
 * @author Masadow
 */

class Main 
{
	public static var beluga : Beluga;


	static function main()
	{
		try {
			beluga = Beluga.getInstance();
			Dispatch.run(Web.getParamsString(), Web.getParams(), new Main());
		} catch (e : BelugaException) {
			trace(e);
		}
	}

	public function new() {

	}

	public function doDefault(d : Dispatch) {
		doBeluga(d);
		
		//Display index page
		
	}

	public function doBeluga(d : Dispatch) {
		d.dispatch(beluga.api);
	}

	public function doAccount(d : Dispatch) {
		d.dispatch(new AccountDemo(beluga));
	}

	public function doDebug() {
		//Fonction test things
		trace(haxe.crypto.Md5.encode("toto"));
	}

}