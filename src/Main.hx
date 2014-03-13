package ;

import beluga.core.Beluga;
import beluga.core.api.BelugaApi;
import beluga.core.Widget;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import php.Web;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import AccountDemo;

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
			Dispatch.run(Web.getURI(), Web.getParams(), new Main());
		} catch (e : BelugaException) {
			trace(e);
		}
	}

	public function new() {

	}

	public function doBeluga(d : Dispatch) {
		d.dispatch(beluga.api);
	}

	public function doDebug() {
		//Fonction test things
		trace(haxe.crypto.Md5.encode("toto"));
	}

	public function doDefault(d : Dispatch) {
		d.dispatch(beluga.api);
	}

}