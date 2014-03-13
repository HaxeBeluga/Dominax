package ;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.SubscribeFailCause;
import beluga.module.account.Account;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;

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
		var accueil = (new haxe.Template(Resource.getString("page_subscribe"))).execute( {
			subscribeWidget: subscribeWidget
		});
		var templatelayout = (new haxe.Template(Resource.getString("template_default_layout"))).execute( {
			content: accueil
		});
		var bodyhtml = (new haxe.Template(Resource.getString("html_body"))).execute( {
			content: templatelayout,
			title: "Accueil"
		});
		Sys.print(bodyhtml);
	}

	public function doDefault(d : Dispatch) {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("No action available for: " + d.parts[0]);	
		Sys.println("Available actions are:");	
		Sys.println("subscribePage");	
	}
	
}