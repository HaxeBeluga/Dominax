package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.SubscribeFailCause;
import beluga.module.account.Account;

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
		Sys.println("AccountHandler.doSubscribeSuccess");
	}

	public static function doSubscribeFail(cause : SubscribeFailCause, login : String, password : String) {
		Sys.println("AccountHandler.doSubscribeFail");
	}

	public function doSubscribePage() {
        var subscribeBox : Widget = acc.getWidget("subscribe");
        var html : String = subscribeBox.render();
        Sys.print(html);
	}

}