package modules.account_service;

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

/**
 * Beluga #1
 * @author Masadow
 */

class AccountService implements MetadataReader {

    public var beluga(default, null) : Beluga;
    public var acc(default, null) : Account;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.acc = beluga.getModuleInstance(Account);
    }

    /*
     * Logination
     */
    @btrigger("beluga_account_login_success")
    public static function _loginSuccess(u:User) {
        new AccountService(Beluga.getInstance()).loginSuccess();
    }

    public function loginSuccess() {
        var html = Renderer.renderDefault("page_accueil", "Home", {
            success : "Authentification succeeded !",
            login: Beluga.getInstance().getModuleInstance(Account).getLoggedUser().login
        });
        Sys.print(html);
    }

    @btrigger("beluga_account_login_fail")
    public static function _loginFail() {
        new AccountService(Beluga.getInstance()).loginFail();
    }

    public function loginFail() {
        var widget = acc.getWidget("login");
        widget.context = {error : "Invalid login and/or password"};
        var loginWidget = widget.render();
        var html = Renderer.renderDefault("page_login", "Authentification", {
            loginWidget: loginWidget
        });
        Sys.print(html);
    }

    @btrigger("beluga_account_logout")
    public static function _logout() {
        new AccountService(Beluga.getInstance()).logout();
    }

    public function logout() {
        var html = Renderer.renderDefault("page_accueil", "Home", {
            success : "You're disconnected !",
            login: "unknow user"
        });
        Sys.print(html);
    }

    /*
     *  Subscription
     */
    @btrigger("beluga_account_subscribe_success")
    public static function _subscribeSuccess(user : User) {
        new AccountService(Beluga.getInstance()).subscribeSuccess(user);
    }

    public function subscribeSuccess(user : User) {
        var html = Renderer.renderDefault("page_accueil", "Home", {
            success : "Subscribe succeeded !",
            login: Beluga.getInstance().getModuleInstance(Account).getLoggedUser().login
        });
        Sys.print(html);
    }

    @btrigger("beluga_account_subscribe_fail")
    public static function _subscribeFail(error : String) {
        new AccountService(Beluga.getInstance()).subscribeFail(error);
    }

    public function subscribeFail(error : String) {
        var subscribeWidget = acc.getWidget("subscribe");

        subscribeWidget.context = {error : error};
        var html = Renderer.renderDefault("page_subscribe", "Inscription", {
            subscribeWidget: subscribeWidget.render(), error : error
        });
        Sys.print(html);
    }

    @btrigger("beluga_account_show_user")
    public function _printCustomUserInfo(args: { id: Int }) {
        new AccountService(Beluga.getInstance()).printCustomUserInfo(args);
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