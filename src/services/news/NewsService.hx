package services.news;

import haxe.web.Dispatch;
import haxe.Resource;
import sys.db.Types;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;

import beluga.module.account.model.User;
import beluga.module.account.Account;
import beluga.module.news.News;
import beluga.module.news.model.NewsModel;
import beluga.module.news.model.CommentModel;

import main_view.Renderer;

#if php
import php.Web;
#end

class NewsData implements MetadataReader {
    public var text : String;
    public var login : String;
    public var date : SDateTime;
    public var com_id : Int;

    public function new (t : String, l : String, d : SDateTime, c : Int) {
        text = t;
        login = l;
        date = d;
        com_id = c;
    }
}

class NewsList {
    public var title : String;
    public var text : String;
    public var id : Int;
    public var pos : Int;

    public function new(t : String, te : String, i : Int, p : Int) {
        title = t;
        text = te;
        id = i;
        pos = p;
        if (text.length > 200) {
            text = text.substr(0, 200) + "...";
        }
    }
}

class NewsService  implements MetadataReader {
    public var beluga(default, null) : Beluga;
    public var news(default, null) : News;
    private var error_msg : String;
    private var success_msg : String;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.news = beluga.getModuleInstance(News);
        this.error_msg = "";
        this.success_msg = "";
		
		//Attach triggers
		news.triggers.defaultNews.add(this.doDefault);
		news.triggers.print.add(this.doPrint);
		news.triggers.redirect.add(this.doRedirect);
		news.triggers.redirectEdit.add(this.doRedirectEdit);
		news.triggers.createFail.add(this.doCreateFail);
		news.triggers.createSuccess.add(this.doCreateSuccess);
		news.triggers.deleteFail.add(this.doDeleteFail);
		news.triggers.deleteSuccess.add(this.doDeleteSuccess);
		news.triggers.deleteCommentFail.add(this.doDeleteCommentFail);
		news.triggers.deleteCommentSuccess.add(this.doDeleteCommentSuccess);
		news.triggers.editFail.add(this.doEditFail);
		news.triggers.editSuccess.add(this.doEditSuccess);
		news.triggers.addCommentFail.add(this.doAddCommentFail);
		news.triggers.addCommentSuccess.add(this.doAddCommentSuccess);
		news.triggers.deleteFail.add(this.doDeleteFail);
		news.triggers.deleteSuccess.add(this.doDeleteSuccess);
    }

    public function doDefault() {
        var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();

        var widget = news.getWidget("news");
        var t_news = this.news.getAllNews();
        var news = new Array<NewsList>();
        var pos = 0;

        for (tmp in t_news) {
            news.push(new NewsList(tmp.title, tmp.text, tmp.id, pos));
            if (pos == 0)
                pos = 1;
            else
                pos = 0;
        }
        widget.context = {news : news, error : error_msg, success : success_msg, path : "/newsService/", user: user};

        var newsWidget = widget.render();

        var html = Renderer.renderDefault("page_news", "News list", {
            newsWidget: newsWidget
        });
        Sys.print(html);
    }

    public function doPrint(args : {news_id : Int}) {
        var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();
        var news = NewsModel.manager.get(args.news_id);

        if (news == null) {
            error_msg = "News hasn't been found...";
            doDefault();
            return;
        }
        var widget = this.news.getWidget("print");
        var t_comments = this.news.getComments(args);
        var comments = new Array<NewsData>();

        for (tmp in t_comments) {
            comments.push(new NewsData(tmp.text, tmp.user.login, tmp.creationDate, tmp.id));
        }
        widget.context = {news : news, comments : comments, path : "/newsService/",
                            user : user, error : error_msg, success : success_msg};

        var newsWidget = widget.render();

        var html = Renderer.renderDefault("page_news", "News", {
            newsWidget: newsWidget
        });
        Sys.print(html);
    }

    public function doRedirect() {
        if (Beluga.getInstance().getModuleInstance(Account).getLoggedUser() == null) {
            error_msg = "Please log in !";
            doDefault();
            return;
        }
        var widget = news.getWidget("create");
        widget.context = {path : "/newsService/"};

        var newsWidget = widget.render();

        var html = Renderer.renderDefault("page_news", "Create news", {
            newsWidget: newsWidget
        });
        Sys.print(html);
    }

    public function doRedirectEdit(args : {news_id : Int}) {
        var user = Beluga.getInstance().getModuleInstance(Account).getLoggedUser();
        if (user == null) {
            error_msg = "Please log in !";
            doDefault();
            return;
        }
        var n = NewsModel.manager.get(args.news_id);
        if (n == null || n.user_id != user.id) {
            error_msg = "You can't edit this news";
            doDefault();
            return;
        }
        var widget = news.getWidget("edit");
        widget.context = {path : "/newsService/", news : n, error : error_msg};

        var newsWidget = widget.render();

        var html = Renderer.renderDefault("page_news", "Create news", {
            newsWidget: newsWidget
        });
        Sys.print(html);
    }

    public function doDeleteCommentFail(args : {news_id : Int, error : String}) {
        error_msg = args.error;
        this.doPrint({news_id : args.news_id});
    }

    public function doDeleteCommentSuccess(args : {news_id : Int}) {
        success_msg = "Comment has been deleted successfully";
        this.doPrint({news_id : args.news_id});
    }

    public function doCreateFail(args : {title : String, data : String, error : String}) {
        error_msg = "Error ! News has not been created...";
        var widget = news.getWidget("create");
        widget.context = {path : "/newsService/", title : args.title, error : args.error, data : args.data};

        var newsWidget = widget.render();

        var html = Renderer.renderDefault("page_news", "Create news", {
            newsWidget: newsWidget
        });
        Sys.print(html);
    }

    public function doCreateSuccess() {
        success_msg = "News has been successfully created !";
        this.doDefault();
    }

    public function doEditFail(args : {news_id : Int, error : String}) {
        error_msg = args.error;
        this.doRedirectEdit({news_id : args.news_id});
    }

    public function doEditSuccess(args : {news_id : Int}) {
        success_msg = "News has been successfully edited !";
        this.doPrint(args);
    }

    public function doAddCommentSuccess(args : {news_id : Int}) {
        success_msg = "Comment has been successfully added !";
        this.doPrint(args);
    }

    public function doAddCommentFail(args : {news_id : Int}) {
        error_msg = "Error ! Comment hasn't been added...";
        this.doPrint(args);
    }

    public function doDeleteSuccess() {
        success_msg = "News has been successfully deleted !";
        this.doDefault();
    }

    public function doDeleteFail() {
        error_msg = "Error: News hasn't been deleted...";
        this.doDefault();
    }

}