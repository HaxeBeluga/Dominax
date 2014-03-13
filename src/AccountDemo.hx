package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.SubscribeFailCause;
import beluga.module.account.Account;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;
import src.view.Renderer;

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
        var subscribeWidget = acc.getWidget("subscribe").render();
		var html = Renderer.renderDefault("page_subscribe", "Inscription", {
			subscribeWidget: subscribeWidget
		});
		Sys.print(html);
	}

	public function doDefault(d : Dispatch) {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("No action available for: " + d.parts[0]);	
		Sys.println("Available actions are:");	
		Sys.println("subscribePage");	
	}
	
}