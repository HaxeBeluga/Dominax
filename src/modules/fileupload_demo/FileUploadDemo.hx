package modules.fileupload_demo;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.fileupload.Fileupload;

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
        var fileUploadWidget = file_upload.getWidget("browse");
        // ticketWidget.context = file_upload.getBrowseContext();
        var html = Renderer.renderDefault("page_fileupload_widget", "Browse files", {
            fileUploadWidget: fileUploadWidget.render()
        });
        Sys.print(html);
    }
}