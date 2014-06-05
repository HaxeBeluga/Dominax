package modules.wallet_service;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;
import beluga.module.wallet.Wallet;
import beluga.module.account.Account;

// BelugaDemo
import main_view.Renderer;

// haxe web
import haxe.web.Dispatch;
import haxe.Resource;

// Haxe PHP specific resource
#if php
import php.Web;
#elseif neko
import neko.Web;
#end

class WalletService implements MetadataReader {
    public var beluga(default, null) : Beluga;
    public var wallet(default, null) : Wallet;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.wallet = beluga.getModuleInstance(Wallet);
    }

    @bTrigger("beluga_wallet_create_success",
             "beluga_wallet_create_fail")
    public static function _doDemoPage() {
       new WalletService(Beluga.getInstance()).doDemoPage();
    }

    public function doDemoPage() {
        var walletWidget = this.wallet.getWidget("display");
        walletWidget.context = this.wallet.getDisplayContext();
        var has_wallet = if (Beluga.getInstance().getModuleInstance(Account).isLogged()) {
            1;
        } else {
            0;
        };

        var html = Renderer.renderDefault("page_wallet_widget", "Your wallet", {
            walletWidget: walletWidget.render(),
            has_wallet: has_wallet,
            site_currency: this.wallet.getSiteCurrencyOrDefault().cu_name
        });
        Sys.print(html);
    }

    public function doBuyCurrency() {
        if (Beluga.getInstance().getModuleInstance(Account).isLogged()) {
            this.wallet.addRealFunds(Beluga.getInstance().getModuleInstance(Account).getLoggedUser(), 10.);
        }

        this.doDemoPage();
    }

    public function doDefault(d : Dispatch) { WalletService._doDemoPage(); }
}