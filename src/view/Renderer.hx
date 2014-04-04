package src.view;
import beluga.core.Beluga;
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
	public static function renderDefault(page : String, title:String, ctx : Dynamic) {
		ctx.base_url = Beluga.getInstance().url.base;
		var accueil = (new haxe.Template(Resource.getString(page))).execute(ctx);
		var templateheader = (new haxe.Template(Resource.getString("template_default_header"))).execute({base_url: ctx.base_url});
		var templatefooter = (new haxe.Template(Resource.getString("template_default_footer"))).execute({base_url: ctx.base_url});
		var templatelayout = (new haxe.Template(Resource.getString("template_default_layout"))).execute( {
			header: templateheader,
			footer: templatefooter,
			content: accueil,
			base_url: ctx.base_url
		});
		var bodyhtml = (new haxe.Template(Resource.getString("html_body"))).execute({
			content: templatelayout,
			title: title,
			base_url: ctx.base_url
		});
		return bodyhtml;
	}
	
}