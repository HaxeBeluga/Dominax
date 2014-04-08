package ;

import beluga.core.Beluga;
import beluga.core.api.BelugaApi;
import beluga.core.Trigger;
import beluga.core.Widget;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import modules.account_demo.AccountDemo;
import modules.ticket_demo.TicketDemo;
import modules.survey_demo.SurveyDemo;
import modules.fileupload_demo.FileUploadDemo;
import main_view.Renderer;

/**
 * Beluga #1
 * Load the account class
 * Use it to generate login form, subscribe form, logged homepage
 * @author Masadow
 */

class Main 
{
	public static var beluga : Beluga;


	static function main()
	{
		try {
			beluga = Beluga.getInstance();
			Dispatch.run(Web.getURI(), Web.getParams(), new Main());
			beluga.cleanup();
		} catch (e : BelugaException) {
			trace(e);
		}
	}
	
	public function customTrigger()
	{
		Sys.println("<br />Custom non-static");
	}
	
	public function customTriggerStatic()
	{
		Sys.println("<br />Custom static");
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
			doAccueil();
		}
	}

	public function doAccountDemo(d : Dispatch) {
		d.dispatch(new AccountDemo(beluga));
	}

	public function doTicketDemo(d : Dispatch) {
		d.dispatch(new TicketDemo(beluga));
	}

	public function doSurveyDemo(d : Dispatch) {
		d.dispatch(new SurveyDemo(beluga));

	public function doFileUploadDemo(d : Dispatch) {
		d.dispatch(new FileUploadDemo(beluga));
	}

	public function doAccueil() {
			var html = Renderer.renderDefault("page_accueil", "Accueil",{});
			Sys.print(html);
	}
}