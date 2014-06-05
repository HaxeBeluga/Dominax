package modules.ticket_service;

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
    }

    @btrigger("beluga_ticket_show_browse")
    public static function _doBrowsePage() {
       new TicketService(Beluga.getInstance()).doBrowsePage();
    }

    public function doBrowsePage() {
        var ticketWidget = ticket.getWidget("browse");
        ticketWidget.context = ticket.getBrowseContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Browse tickets", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    @btrigger("beluga_ticket_show_create")
    public static function _doCreatePage() {
       new TicketService(Beluga.getInstance()).doCreatePage();
    }

    public function doCreatePage() {
        var ticketWidget = ticket.getWidget("create");
        ticketWidget.context = ticket.getCreateContext();

        var html = Renderer.renderDefault("page_ticket_widget", "Create tickets", {
            ticketWidget: ticketWidget.render()
        });
        Sys.print(html);
    }

    @btrigger("beluga_ticket_show_show")
    public static function _doShowPage() {
       new TicketService(Beluga.getInstance()).doShowPage();
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
        TicketService._doBrowsePage();
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

    @btrigger("beluga_ticket_assign_notify")
    public function _doNotifyAssign(args : {title : String, text : String, user_id: Int}) {
        var notification = Beluga.getInstance().getModuleInstance(Notification);
        notification.create(args);
    }
}