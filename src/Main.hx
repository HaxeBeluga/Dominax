package ;

import beluga.core.Beluga;
import beluga.core.api.BelugaApi;
import beluga.core.Widget;
import beluga.core.BelugaException;
import beluga.module.account.Account;
import haxe.web.Dispatch;
import haxe.Resource;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import modules.account_service.AccountService;
import modules.ticket_service.TicketService;
import modules.notification_service.NotificationService;
import modules.survey_service.SurveyService;
import modules.wallet_service.WalletService;
import modules.market_service.MarketService;
import modules.account_service.AccountServiceApi;
import main_view.Renderer;

#if php
import php.Web;
#elseif neko
import neko.Web;
#end

class Main
{
    public static var beluga : Beluga;

    static function main()
    {
        Assets.build();

        try {
            beluga = Beluga.getInstance();
            Dispatch.run(beluga.getDispatchUri(), Web.getParams(), new Main());
            beluga.cleanup();
        } catch (e : BelugaException) {
            trace(e);
        }
    }

    public function new() {

    }

    public function doBeluga(d : Dispatch) {
        d.dispatch(beluga.api);
    }

    public function doDebug(d : Dispatch) {
        Web.setHeader("Content-Type", "text/plain");
        trace(Web.getParamsString());
    }

    public function doDefault(d : Dispatch) {
        if (d.parts[0] != "" ) {
            d.dispatch(beluga.api);
        } else {
            doAccueil(d);
        }
    }

    public function doAccountService(d : Dispatch) {
        d.dispatch(new AccountServiceApi(beluga));
    }

    public function doTicketService(d : Dispatch) {
        d.dispatch(new TicketService(beluga));
    }

    public function doSurveyService(d : Dispatch) {
        d.dispatch(new SurveyService(beluga));
    }

    public function doNotificationService(d : Dispatch) {
        d.dispatch(new NotificationService(beluga));
    }

    public function doWalletService(d : Dispatch) {
        d.dispatch(new WalletService(beluga));
    }

    public function doMarketService(d : Dispatch) {
        d.dispatch(new MarketService(beluga));
    }

    public function doAccueil(d : Dispatch) {
        var account_service = new AccountServiceApi(beluga);
        account_service.doDefault(d);
    }

	public function doGame() {
		var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();
		var html = "";
		if (user != null)
			html = Renderer.renderDefault("game.mtt", "Play Dominax", { user: user } );
		else
			html = Renderer.renderDefault("game_forbid.mtt", "Play Dominax", {});
		Sys.print(html);
	}

}