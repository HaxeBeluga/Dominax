package modules.fileupload_demo;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.fileupload.Fileupload;
import beluga.module.account.Account;

// BelugaDemo
import main_view.Renderer;

// haxe web
import haxe.web.Dispatch;
import haxe.Resource;

// Haxe PHP specific resource
import php.Web;

class FileUploadDemo {
    public var beluga(default, null) : Beluga;
    public var file_upload(default, null) : Fileupload;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.file_upload = beluga.getModuleInstance(Fileupload);
    }

    public static function _doBrowsePage() {        
       new FileUploadDemo(Beluga.getInstance()).doBrowsePage();
    }

    public function doBrowsePage() {
        var browseWidget = file_upload.getWidget("browse");
        browseWidget.context = file_upload.getBrowseContext();
        var html = Renderer.renderDefault("page_fileupload_widget", "Browse files", {
            context_message: "",
            browseWidget: browseWidget.render(),
            fileUploadWidget: ""
        });
        Sys.print(html);
    }

    public static function _doSendPage() {            
       new FileUploadDemo(Beluga.getInstance()).doSendPage();
    }

    public function doSendPage() {
        var fileUploadWidget = file_upload.getWidget("send");
        fileUploadWidget.context = file_upload.getSendContext();
        var html = Renderer.renderDefault("page_fileupload_widget", "Send file", {
            context_message: "",
            browseWidget: "",
            fileUploadWidget: fileUploadWidget.render()
        });
        Sys.print(html);        
    }

    private function notLoggedErrorMsg() {
        return "<div class=\"alert alert-danger alert-dismissable ticket-alert-error\">
                <strong>Error!</strong> Vous devez vous logger pour acceder a cette page !
                </div>";
    }

    public static function _doFailRemovePage(args: { reason: String }) {
        new FileUploadDemo(Beluga.getInstance()).doFailRemovePage(args);
    }

    public function doFailRemovePage(args: { reason: String}) {
        var contextMsg = args.reason;
        var browseWidget = "";
        var fileUploadWidget = "";
        var html = Renderer.renderDefault("page_fileupload_widget", "Default page Fail", {
            context_message: contextMsg,
            browseWidget: browseWidget,
            fileUploadWidget: fileUploadWidget
        });
        Sys.print(html);
    }

    public static function _doAllPage() {
        new FileUploadDemo(Beluga.getInstance()).doAllPage();
    }

    public function doAllPage() {
        var contextMsg = this.notLoggedErrorMsg();
        var browseWidget = "";
        var fileUploadWidget = "";
        if (this.beluga.getModuleInstance(Account).isLogged()) {
            contextMsg = "<h2>Gestion des fichiers de <strong>" + this.beluga.getModuleInstance(Account).getLoggedUser().login + "</strong></h2>";
            var tmpBrowse = file_upload.getWidget("browse");
            tmpBrowse.context = file_upload.getBrowseContext();
            browseWidget = tmpBrowse.render();
            fileUploadWidget = file_upload.getWidget("send").render();
        }
        var html = Renderer.renderDefault("page_fileupload_widget", "Default page", {
            context_message: contextMsg,
            browseWidget: browseWidget,
            fileUploadWidget: fileUploadWidget
        });
        Sys.print(html);
    }


    public static function _doDefault() {
        new FileUploadDemo(Beluga.getInstance()).doDefault();
    }

    public function doDefault() {
        var contextMsg = this.notLoggedErrorMsg();
        var browseWidget = "";
        var fileUploadWidget = "";
        if (this.beluga.getModuleInstance(Account).isLogged()) {
            contextMsg = "<h2>Gestion des fichiers de <strong>" + this.beluga.getModuleInstance(Account).getLoggedUser().login + "</strong></h2>";
            var tmpBrowse = file_upload.getWidget("browse");
            tmpBrowse.context = file_upload.getBrowseContext();
            browseWidget = tmpBrowse.render();
            fileUploadWidget = file_upload.getWidget("send").render();
        }
        var html = Renderer.renderDefault("page_fileupload_widget", "Default page", {
            context_message: contextMsg,
            browseWidget: browseWidget,
            fileUploadWidget: fileUploadWidget
        });
        Sys.print(html);
    }

    public static function _doAdminPage() {        
       new FileUploadDemo(Beluga.getInstance()).doSendPage();
    }

    public function doAdminPage() {
        var html = Renderer.renderDefault("page_fileupload_widget", "Admin page", {
            browseWidget: "world",
            fileUploadWidget: "hello"
        });
        Sys.print(html);
    }
}