package services.ticket;

// Beluga
import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;
import beluga.module.ticket.Ticket;
import beluga.module.notification.Notification;

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

class TicketService implements MetadataReader {
    public var beluga(default, null) : Beluga;
    public var ticket(default, null) : Ticket;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.ticket = beluga.getModuleInstance(Ticket);

		this.ticket.triggers.browse.add(doBrowsePage);
		this.ticket.triggers.create.add(doCreatePage);
		this.ticket.triggers.show.add(doShowPage);
		this.ticket.triggers.assignNotify.add(doNotifyAssign);
    }

    public function doBrowsePage() {
        var ticketWidget = ticket.getWidget("browse");
        ticketWidget.context = ticket.getBrowseContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Browse tickets", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    public function doCreatePage() {
        var ticketWidget = ticket.getWidget("create");
        ticketWidget.context = ticket.getCreateContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Create tickets", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
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
        doBrowsePage();
    }

    public static function _doAdminPage() {
       new TicketService(Beluga.getInstance()).doAdminPage();
    }

    public function doAdminPage() {
        var ticketWidget = ticket.getWidget("admin");

        ticketWidget.context = ticket.getAdminContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Admin page", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    public function doNotifyAssign(args : {title : String, text : String, user_id: Int}) {
        var notification = Beluga.getInstance().getModuleInstance(Notification);
        notification.create(args);
    }
}