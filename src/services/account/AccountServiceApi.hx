package services.account;

import haxe.Resource;
import haxe.web.Dispatch;
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.ESubscribeFailCause;
import beluga.module.account.Account;
import services.account.AccountService;
import main_view.Renderer;

#if php
import php.Web;
#end

class AccountServiceApi {
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
		subscribeWidget.context = {user : user, path : "/accountService/"};

		var html = Renderer.renderDefault("page_subscribe", "Information", {
			subscribeWidget: subscribeWidget.render()
		});
		Sys.print(html);
	}

	public function doLogout() {
		this.acc.logout();
	}

	public function doDefault(d : Dispatch) {
		var login = if (Beluga.getInstance().getModuleInstance(Account).isLogged()) {
			Beluga.getInstance().getModuleInstance(Account).getLoggedUser().login;
		} else {
			"unknown user";
		}
		var html = Renderer.renderDefault("page_accueil", "Accueil", {
			success : "",
			error : "",
			login: login
		});
		Sys.print(html);
	}

	public static function _doEdit() {
		new AccountServiceApi(Beluga.getInstance()).doEdit();
	}

	public function doEdit() {
		var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();

		if (user == null) {
			var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "", error : "Please log in"});
			Sys.print(html);
			return;
		}
		var subscribeWidget = acc.getWidget("edit");
		subscribeWidget.context = {email : user.email, path : "/accountService/"};

		var html = Renderer.renderDefault("page_subscribe", "Information", {
			subscribeWidget: subscribeWidget.render()
		});
		Sys.print(html);
	}

	public static function _doSave(args : {email : String}) {
		new AccountServiceApi(Beluga.getInstance()).doSave(args);
	}

	public function doSave(args : {email : String}) {
		this.acc.edit(args.email);
	}

	public static function _doEditSuccess() {
		new AccountServiceApi(Beluga.getInstance()).doEditSuccess();
	}

	public function doEditSuccess() {
		var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "Email address has been changed successfully", error : ""});
		Sys.print(html);
	}

	public static function _doEditFail() {
		new AccountServiceApi(Beluga.getInstance()).doEditSuccess();
	}

	public function doEditFail() {
		var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "", error : "Error occurred when trying to change email address"});
		Sys.print(html);
	}

}