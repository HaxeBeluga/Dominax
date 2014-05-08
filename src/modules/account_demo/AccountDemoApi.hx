package modules.account_demo;

import php.Web;
import haxe.Resource;
import haxe.web.Dispatch;
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.ESubscribeFailCause;
import beluga.module.account.Account;
import modules.account_demo.AccountDemo;
import main_view.Renderer;


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
        var loginWidget = acc.getWidget("login");
        loginWidget.context = {error : ""};

		var html = Renderer.renderDefault("page_login", "Authentification", {
			loginWidget: loginWidget.render()
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

	public function doPrintInfo() {
		var user = this.acc.getLoggedUser();

		if (user == null) {
			var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "", error : ""});
			Sys.print(html);
			return;
		}
		var subscribeWidget = acc.getWidget("info");
		subscribeWidget.context = {user : user};

		var html = Renderer.renderDefault("page_subscribe", "Information", {
			subscribeWidget: subscribeWidget.render()
		});
		Sys.print(html);
	}

	public function doLogout() {
		this.acc.logout();
	}

	public function doDefault(d : Dispatch) {
		var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "", error : ""});
		Sys.print(html);
	}

}