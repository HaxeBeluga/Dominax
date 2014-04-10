package modules.notification_demo;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.account.model.User;
import beluga.module.account.Account;
import beluga.module.notification.Notification;
import beluga.module.notification.model.NotificationModel;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;
import main_view.Renderer;

/**
 * Beluga #1
 * @author Guillaume Gomez
 */

class NotificationDemo
{
	public var beluga(default, null) : Beluga;
	public var notif(default, null) : Notification;
	private var error_msg : String;
	private var success_msg : String;

	public function new(beluga : Beluga) {
		this.beluga = beluga;
		this.notif = beluga.getModuleInstance(Notification);
		this.error_msg = "";
		this.success_msg = "";
	}

	public static function _doDefault() {
		new NotificationDemo(Beluga.getInstance()).doDefault();
	}

	public function doDefault() {
		var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();
		if (user == null) {
			Web.setHeader("Content-Type", "text/plain");
			Sys.println("Please log in !");
			return;
		}
		var widget = notif.getWidget("notification");
		widget.context = {notifs : notif.getNotifications(), user : user, error : error_msg, success : success_msg, path : "/beluga/notification/"};

		var notifWidget = widget.render();

		var html = Renderer.renderDefault("page_notification", "Notifications list", {
			notificationWidget: notifWidget
		});
		Sys.print(html);
	}

	public static function _doPrint(args : {notif : NotificationModel}) {
		new NotificationDemo(Beluga.getInstance()).doPrint(args);
	}

	public function doPrint(args : {notif : NotificationModel}) {
		var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();
		if (user == null) {
			doDefault();
			return;
		}
		if (args.notif == null) {
			error_msg = "Notification hasn't been found...";
			doDefault();
			return;
		}
		var widget = notif.getWidget("print_notif");
		widget.context = {notif : args.notif, path : "/beluga/notification/"};

		var notifWidget = widget.render();

		var html = Renderer.renderDefault("page_notification", "Notification", {
			notificationWidget: notifWidget
		});
		Sys.print(html);
	}

	public static function _doCreateFail() {
		new NotificationDemo(Beluga.getInstance()).doCreateFail();
	}
	
	public function doCreateFail() {
		error_msg = "Error ! Notification has not been created...";
		this.doDefault();
	}
	
	public static function _doCreateSuccess() {
		new NotificationDemo(Beluga.getInstance()).doCreateSuccess();
	}

	public function doCreateSuccess() {
		// success_msg = "Notification has been successfully created !";
		// this.doDefault();
	}
	
	public static function _doDeleteSuccess() {
		new NotificationDemo(Beluga.getInstance()).doDeleteSuccess();
	}

	public function doDeleteSuccess() {
		success_msg = "Notification has been successfully deleted !";
		this.doDefault();
	}

	public static function _doDeleteFail() {
		new NotificationDemo(Beluga.getInstance()).doDeleteFail();
	}

	public function doDeleteFail() {
		error_msg = "Error when trying to delete notification...";
		this.doDefault();
	}
}