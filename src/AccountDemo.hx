package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.SubscribeFailCause;
import beluga.module.account.Account;
import php.Web;

/**
 * Beluga #1
 * @author Masadow
 */

class AccountDemo
{

	public var beluga(default, null) : Beluga;
	public var acc(default, null) : Account;

	public function new(beluga : Beluga) {
		this.beluga = beluga;
		this.acc = beluga.getModuleInstance(Account);
	}

	public static function doSubscribeSuccess(user : User) {
		Web.setHeader("Content-Type", "application/json");
		Sys.println("{
			\"state\":success
		}");
	}

	public static function doSubscribeFail(cause : SubscribeFailCause, login : String, password : String) {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.doSubscribeFail " + cause);
	}

	public function doSubscribePage() {
        var subscribeBox : Widget = acc.getWidget("subscribe");
        var html : String = subscribeBox.render();
        Sys.print(html);
	}

}