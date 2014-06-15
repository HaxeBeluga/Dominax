package game;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;

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

class Game implements MetadataReader {
    public var beluga(default, null) : Beluga;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
    }

    public function doDefault(d: Dispatch) {
        var html = Renderer.renderDefault("game_page", "Dominax", {});
        Sys.print(html);
    }
}