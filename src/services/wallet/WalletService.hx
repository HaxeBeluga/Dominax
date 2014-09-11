package services.wallet;

// haxe web
import haxe.web.Dispatch;
import haxe.Resource;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;

import beluga.module.wallet.Wallet;
import beluga.module.account.Account;

// Dominax
import main_view.Renderer;

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
		
		this.wallet.triggers.creationSuccess.add(this.doDemoPage);
		this.wallet.triggers.creationFail.add(this.doDemoPage);
    }

    public function doDemoPage() {
        var walletWidget = this.wallet.getWidget("display");
        walletWidget.context = this.wallet.getShowContext();
        var has_wallet = if (Beluga.getInstance().getModuleInstance(Account).isLogged) {
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
        if (Beluga.getInstance().getModuleInstance(Account).isLogged) {
            this.wallet.addRealFunds(Beluga.getInstance().getModuleInstance(Account).getLoggedUser(), 10.);
        }

        this.doDemoPage();
    }

    public function doDefault(d : Dispatch) { doDemoPage(); }
}