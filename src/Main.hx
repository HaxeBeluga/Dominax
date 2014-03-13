package ;

import beluga.core.Beluga;
import beluga.core.api.BelugaApi;
import beluga.core.Widget;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import AccountDemo;
import src.view.Renderer;

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

	public function doDebug(d : Dispatch) {
		//Fonction test things
		trace(d.parts);
	}

	public function doDefault(d : Dispatch) {
		if (d.parts[0] != "" ) {
			d.dispatch(beluga.api);
		} else {
			doAccueil();
		}
	}

	public function doAccountDemo(d : Dispatch) {
		d.dispatch(new AccountDemo(beluga));
	}

	public function doAccueil() {
			var html = Renderer.renderDefault("page_accueil", "Accueil",{});
			Sys.print(html);
	}

}