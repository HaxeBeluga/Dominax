package ;

import beluga.core.Beluga;
import beluga.core.api.BelugaApi;
import beluga.core.Widget;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import haxe.Resource;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import services.account.AccountService;
import services.ticket.TicketService;
import services.notification.NotificationService;
import services.survey.SurveyService;
import services.wallet.WalletService;
import services.market.MarketService;
import services.account.AccountServiceApi;
import services.news.NewsService;
import game.Game;
import main_view.Renderer;

#if php
import php.Web;
#elseif neko
import neko.Web;
#end

class Main {
    public static var beluga : Beluga;


    static function main()
    {
		try {
			beluga = Beluga.getInstance();
			//Is it an async request or a user who navigate through the website ?
			trace("<pre>" + Web.getClientHeaders() + "</pre>");
			if (Web.getClientHeader("X_HAXE_REMOTING") == "1")
			{
				var ctx = new haxe.remoting.Context();
				ctx.addObject("Server",new Server());
				if( haxe.remoting.HttpConnection.handleRequest(ctx) )
					return;
			}
			else
			{
				Assets.build();
				Dispatch.run(beluga.getDispatchUri(), Web.getParams(), new Main());
			}
		} catch (e : BelugaException) {
			trace(e);
		}
		beluga.cleanup();
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

    public function doNewsService(d : Dispatch) {
        d.dispatch(new NewsService(beluga));
    }

    public function doPlayGame(d : Dispatch) {
        d.dispatch(new Game(beluga));
    }

    public function doAccueil(d : Dispatch) {
        var account_service = new AccountServiceApi(beluga);
        account_service.doDefault(d);
    }

}