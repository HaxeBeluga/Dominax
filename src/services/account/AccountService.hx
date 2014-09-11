package services.account;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;
import beluga.module.account.model.User;
import beluga.module.account.ESubscribeFailCause;
import beluga.module.account.Account;
import haxe.Resource;
import main_view.Renderer;

#if php
import php.Web;
#end

class AccountService implements MetadataReader {

    public var beluga(default, null) : Beluga;
    public var acc(default, null) : Account;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.acc = beluga.getModuleInstance(Account);
		
		//Setting triggers
		acc.triggers.loginSuccess.add(this.loginSuccess);
		acc.triggers.loginFail.add(this.loginFail);
		acc.triggers.afterLogout.add(this.logout);
		acc.triggers.subscribeSuccess.add(this.subscribeSuccess);
		acc.triggers.subscribeFail.add(this.subscribeFail);
		acc.triggers.showUser.add(this.printCustomUserInfo);
    }

    /*
     * Login
     */
    public function loginSuccess() {
        var html = Renderer.renderDefault("page_accueil", "Home", {
            success : "Authentification succeeded !",
            login: Beluga.getInstance().getModuleInstance(Account).getLoggedUser().login
        });
        Sys.print(html);
    }

    public function loginFail(_ : {err : String}) {
        var widget = acc.getWidget("login");
        widget.context = {error : "Invalid login and/or password"};
        var loginWidget = widget.render();
        var html = Renderer.renderDefault("page_login", "Authentification", {
            loginWidget: loginWidget
        });
        Sys.print(html);
    }

    public function logout() {
        var html = Renderer.renderDefault("page_accueil", "Home", {
            success : "You're disconnected !",
            login: "unknow user"
        });
        Sys.print(html);
    }

    public function subscribeSuccess(user : {user : User}) {
        var html = Renderer.renderDefault("page_accueil", "Home", {
            success : "Subscribe succeeded !",
            login: user.user.login
        });
		//Autologin
		Beluga.getInstance().getModuleInstance(Account).loggedUser = user.user;
        Sys.print(html);
    }

    public function subscribeFail(error : {err : String}) {
        var subscribeWidget = acc.getWidget("subscribe");

        subscribeWidget.context = {error : error.err};
        var html = Renderer.renderDefault("page_subscribe", "Inscription", {
            subscribeWidget: subscribeWidget.render(), error : error.err
        });
        Sys.print(html);
    }

    public function printCustomUserInfo(args: { id: Int }) {
        var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();

        if (user == null) {
            var html = Renderer.renderDefault("page_accueil", "Home", {success : "", error : ""});
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
}