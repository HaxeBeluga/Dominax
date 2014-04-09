package modules.account_demo;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.SubscribeFailCause;
import beluga.module.account.Account;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;
import main_view.Renderer;

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

	/*
	 * Logination
	 */
	public static function _doLoginSuccess() {
		new AccountDemo(Beluga.getInstance()).doLoginSuccess();
	}

	public function doLoginSuccess() {
		var html = Renderer.renderDefault("page_accueil", "Accueil",{});
		Sys.print(html);
	}

	public static function _doLoginFail() {
		new AccountDemo(Beluga.getInstance()).doLoginFail();
	}
	
	public function doLoginFail() {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.doLoginFail");
	}
	
	public function doLoginPage() {
        var loginWidget = acc.getWidget("login").render();
		var html = Renderer.renderDefault("page_login", "Authentification", {
			loginWidget: loginWidget
		});
		Sys.print(html);
	}

	/*
	 *  Subscription
	 */
	public static function _doSubscribeSuccess(user : User) {
		new AccountDemo(Beluga.getInstance()).doSubscribeSuccess(user);
	}
	 
	 public function doSubscribeSuccess(user : User) {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.doSubscribeSuccess");	
	}

	public static function _subscribeFail(errorMap : Map < String, List<String> >, args : {
		login : String,
		password : String,
		password_conf : String
	}) {
		new AccountDemo(Beluga.getInstance()).subscribeFail(errorMap, args);
	}

	public function subscribeFail(errorMap : Map < String, List<String> >, args : {
		login : String,
		password : String,
		password_conf : String
	}) {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.doSubscribeFail ");
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