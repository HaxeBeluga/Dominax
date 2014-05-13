package main_view;

import haxe.macro.Context;
import haxe.Resource;
import beluga.module.account.Account;
import beluga.core.Beluga;

/**
 * ...
 * @author brissa_A
 */
class Renderer
{

	public function new() 
	{
		
	}

	/*
	 * Render a page with the default template
	 */
	public static function renderDefault(page : String, title: String, ctx : Dynamic) {
		var accueil = (new haxe.Template(Resource.getString(page))).execute(ctx);
		var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();
		var login = "";

		if (user != null) {
			login = "Logged as " + Beluga.getInstance().getModuleInstance(Account).getLoggedUser().login;
		}
		var templateheader = (new haxe.Template(Resource.getString("template_default_header"))).execute({
			login: login, user : user
		});
		var templatefooter = (new haxe.Template(Resource.getString("template_default_footer"))).execute({});
		var templatelayout = (new haxe.Template(Resource.getString("template_default_layout"))).execute( {
			header: templateheader,
			footer: templatefooter,
			content: accueil
		});
		var bodyhtml = (new haxe.Template(Resource.getString("html_body"))).execute({
			content: templatelayout,
			title: title
		});
		return bodyhtml;
	}
	
}