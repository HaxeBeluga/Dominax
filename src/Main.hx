package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.Account;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import php.Web;

/**
 * Beluga #1
 * Load the account class
 * Use it to generate login form, subscribe form, logged homepage
 * @author Masadow
 */

class Main 
{
	static var beluga : Beluga;


	static function main() 
	{
		try {
			beluga = new Beluga();
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

}