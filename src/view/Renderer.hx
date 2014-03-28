package src.view;
import haxe.macro.Context;
import haxe.Resource;

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
	public static function renderDefault(page : String, title:String,ctx : Dynamic) {
		var accueil = (new haxe.Template(Resource.getString(page))).execute(ctx);
		var templateheader = (new haxe.Template(Resource.getString("template_default_header"))).execute({});
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