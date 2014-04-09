package modules.ticket_demo;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.module.ticket.Ticket;

// BelugaDemo
import main_view.Renderer;

// haxe web
import haxe.web.Dispatch;
import haxe.Resource;

// Haxe PHP specific resource
import php.Web;

class TicketDemo {
    public var beluga(default, null) : Beluga;
    public var ticket(default, null) : Ticket;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.ticket = beluga.getModuleInstance(Ticket);
    }

    public static function _doBrowsePage() {
       new TicketDemo(Beluga.getInstance()).doBrowsePage();
    }

    public function doBrowsePage() {
        var ticketWidget = ticket.getWidget("browse");
        ticketWidget.context = ticket.getBrowseContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Browse tickets", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    public static function _doCreatePage() {
       new TicketDemo(Beluga.getInstance()).doCreatePage();
    }

    public function doCreatePage() {
        var ticketWidget = ticket.getWidget("create");
        ticketWidget.context = ticket.getCreateContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Create tickets", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    public static function _doShowPage() {
       new TicketDemo(Beluga.getInstance()).doShowPage();
    }

    public function doShowPage() {
        var ticketWidget = ticket.getWidget("show");
        ticketWidget.context = ticket.getShowContext();
        
        var html = Renderer.renderDefault("page_ticket_widget", "Show ticket", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    public function doDefault(d : Dispatch) {
        Web.setHeader("Content-Type", "text/plain");
        Sys.println("No action available for: " + d.parts[0]);  
        Sys.println("Available actions are:");  
        Sys.println("browsePage");  
        Sys.println("createPage");  
        Sys.println("showPage");    
    }

    public static function _doAdminPage() {        
       new TicketDemo(Beluga.getInstance()).doAdminPage();
    }

    public function doAdminPage() {
        var ticketWidget = ticket.getWidget("admin");

        ticketWidget.context = ticket.getAdminContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Admin page", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);

    }
}