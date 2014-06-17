package ;

import haxe.io.BufferInput;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Compiler;
import haxe.Resource;
import sys.FileSystem;
import sys.io.File;
using StringTools;

class Assets {
    private static function deepCopy(src : String, dest : String)
    {
        for (file in FileSystem.readDirectory(src))
        {
            if (file.charAt(0) == ".") //Ignore every hidden files
                continue ;
            var path = src + file;
            if (FileSystem.isDirectory(path))
            {
                var newdest = dest + file + "/";
                FileSystem.createDirectory(newdest);
                deepCopy(path + "/", newdest);
            }
            else
                File.copy(path, dest + file);
        }
    }

    private static function deepDelete(src : String)
    {
        for (file in FileSystem.readDirectory(src))
        {
            if (file.charAt(0) == ".")
                continue ;
            var path = src + "/" + file;
            if (FileSystem.isDirectory(path))
                deepDelete(path);
            else
                FileSystem.deleteFile(path);
        }
        FileSystem.deleteDirectory(src);
    }

    macro public static function build() : Expr
    {
        var dest = Compiler.getOutput();
        var src = "assets/";

        //Remove file from output if neko
        if (dest.endsWith(".n"))
            dest = dest.substr(0, dest.lastIndexOf("/"));

        //Create the output folder, if it does not exists
        var currentFolder = "";
        for (folder in dest.split("/"))
        {
            currentFolder += folder + "/";
            if (!FileSystem.exists(currentFolder))
                FileSystem.createDirectory(currentFolder);
        }

        //Clean assets
        for (file in FileSystem.readDirectory(dest))
        {
            if (file.charAt(0) == "." || ["dominax", "lib", "res", "temp", "game"].indexOf(file) >= 0)
                continue ;
            if (FileSystem.isDirectory(dest + "/" + file))
                deepDelete(dest + "/" + file);
        }

        //Copy new files
        deepCopy(src, dest + "/");

        //Embed resources
        Context.addResource("html_body", File.getBytes("src/main_view/tpl/htmlbody.mtt"));

        //#----Template----#
        Context.addResource("template_default_layout", File.getBytes("src/main_view/tpl/layout.mtt"));
        Context.addResource("template_default_header", File.getBytes("src/main_view/tpl/header.mtt"));
        Context.addResource("template_default_footer", File.getBytes("src/main_view/tpl/footer.mtt"));

        //#----AccountService Pages----#
        Context.addResource("page_accueil", File.getBytes("src/services/account/tpl/accueil.mtt"));
        Context.addResource("page_subscribe", File.getBytes("src/services/account/tpl/subscribe.mtt"));
        Context.addResource("page_login", File.getBytes("src/services/account/tpl/login.mtt"));
        //#----TicketService Pages----#
        Context.addResource("page_ticket_widget", File.getBytes("src/services/ticket/tpl/ticket_widget.mtt"));
        //#----SurveyService Pages----#
        Context.addResource("page_survey", File.getBytes("src/services/survey/tpl/survey_page.mtt"));
        //#----NotificationService Pages----#
        Context.addResource("page_notification", File.getBytes("src/services/notification/tpl/notification_page.mtt"));
        //#----WalletService Pages----#
        Context.addResource("page_wallet_widget", File.getBytes("src/services/wallet/tpl/wallet_widget.mtt"));
        //#----MarketServie Pages----#
        Context.addResource("page_market_widget", File.getBytes("src/services/market/tpl/market_widget.mtt"));
        //#----NewsService Pages----#
        Context.addResource("page_news", File.getBytes("src/services/news/tpl/news_page.mtt"));

        //#----The game page----#
        Context.addResource("game_page", File.getBytes("src/game/tpl/game_widget.mtt"));

        return macro "Done";
    }

}