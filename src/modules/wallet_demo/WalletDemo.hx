package modules.wallet_demo;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.wallet.Wallet;
import beluga.module.notification.Notification;

// BelugaDemo
import main_view.Renderer;

// haxe web
import haxe.web.Dispatch;
import haxe.Resource;

// Haxe PHP specific resource
import php.Web;

class WalletDemo {
    public var beluga(default, null) : Beluga;
    public var wallet(default, null) : Wallet;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.wallet = beluga.getModuleInstance(Wallet);
    }

    public static function _doDemoPage() {
       new WalletDemo(Beluga.getInstance()).doDemoPage();
    }

    public function doDemoPage() {
        var walletWidget = this.wallet.getWidget("display");
        walletWidget.context = this.wallet.getDisplayWalletContext();
        var walletAdminWidget = this.wallet.getWidget("display_admin");
        walletAdminWidget.context = this.wallet.getDisplayWalletAdminContext();

        var html = Renderer.renderDefault("page_wallet_widget", "Show your wallet", {
            walletWidget: walletWidget.render(),
            walletAdminWidget: walletAdminWidget.render()
        });
        Sys.print(html);
    }

    public function doDefault(d : Dispatch) {
        Web.setHeader("Content-Type", "text/plain");
        Sys.println("No action available for: " + d.parts[0]);
        Sys.println("Available actions are:");
        Sys.println("demoPage");
    }
}