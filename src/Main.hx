package ;

import beluga.core.Beluga;
import beluga.core.Trigger;
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
			
			//Custom trigger
			var route : Array<Dynamic> = [
				{object: new Main(), method:"customTrigger", access: INSTANCE },
				{object: Main, method:"customTriggerStatic", access: STATIC }
			];
			beluga.triggerDispatcher.register(new Trigger({action: "customTrigger", route: route}));

			beluga.triggerDispatcher.dispatch("customTrigger");
			
			beluga.triggerDispatcher.dispatch("login_request");
			
			beluga.cleanup();
		} catch (e : BelugaException) {
			trace(e);
		}
	}
	
	public function customTrigger()
	{
		Sys.println("<br />Custom non-static");
	}
	
	public function customTriggerStatic()
	{
		Sys.println("<br />Custom static");
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