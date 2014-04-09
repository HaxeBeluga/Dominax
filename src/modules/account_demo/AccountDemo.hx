package modules.account_demo;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.ESubscribeFailCause;
import beluga.module.account.Account;
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
	public static function _loginSuccess() {
		new AccountDemo(Beluga.getInstance()).loginSuccess();
	}

	public function loginSuccess() {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.doLoginSuccess");	
		Sys.println("Logged as " + acc.getLoggedUser().login);	
	}

	public static function _loginFail() {
		new AccountDemo(Beluga.getInstance()).loginFail();
	}
	
	public function loginFail() {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.loginFail");
	}
	
	/*
	 *  Subscription
	 */
	public static function _subscribeSuccess(user : User) {
		new AccountDemo(Beluga.getInstance()).subscribeSuccess(user);
	}
	 
	 public function subscribeSuccess(user : User) {
		Web.setHeader("Content-Type", "text/plain");
		Sys.println("AccountDemo.subscribeSuccess");	
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
		Sys.println("AccountDemo.subscribeFail ");
	}

}