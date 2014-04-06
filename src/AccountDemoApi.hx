package ;

import php.Web;
import haxe.Resource;
import haxe.web.Dispatch;
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.ESubscribeFailCause;
import beluga.module.account.Account;
import src.view.Renderer;


/**
 * ...
 * @author brissa_A
 */

class AccountDemoApi
{

	public var beluga(default, null) : Beluga;
	public var acc(default, null) : Account;

	public function new(beluga : Beluga) {
		this.beluga = beluga;
		this.acc = beluga.getModuleInstance(Account);
	}

	public function doLoginPage() {
        var loginWidget = acc.getWidget("login").render();
		var html = Renderer.renderDefault("page_login", "Authentification", {
			loginWidget: loginWidget
		});
		Sys.print(html);
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
		Sys.println("loginPage");	
	}

}