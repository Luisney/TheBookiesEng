<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
 <% if (Request.IsAuthenticated)
    {
        var WebConfigFile = new System.Xml.XmlDocument( );
        WebConfigFile.Load( Server.MapPath( "/web.config" ) );
        var FormsNode = WebConfigFile.SelectSingleNode( "/configuration/system.web/authentication/forms" );
        var Timeout = int.Parse( FormsNode.Attributes [ "timeout" ].Value, System.Globalization.CultureInfo.InvariantCulture.NumberFormat );
        
        var SessionDialogWait = ( 60 * 750 ); // ms = 0.75 minutes
        var SessionTimeout = ( Timeout * 60 * 1000 ) - SessionDialogWait; // ms = Authentication timeout - 0.75 minutes
%>  
<script type="text/javascript">
    var logoutTimer = null;
    var sessionTimer = null;
    var sessionTimeout = Number('<%= SessionTimeout %>');
    var sessionDialogWait = Number('<%= SessionDialogWait %>');

    $(document).ready(function () {
        $('#sessionEndDialog').dialog({
            autoOpen: false,
            bgiframe: true,
            modal: true,
            buttons: {
                OK: function () {
                    $(this).dialog('close');
                    $.get('<%= Url.Action( "Now", "Home" ) %>', scheduleSessionPrompt, 'html');
                },
                Salir: logoutOnSessionExpires
            }
        }).ajaxStart(function () { scheduleSessionPrompt(); });
        scheduleSessionPrompt();
    });

    function scheduleSessionPrompt() {
        if (logoutTimer) clearTimeout(logoutTimer);
        if (sessionTimer) clearTimeout(sessionTimer);

        sessionTimer = setTimeout(sessionExpiring, sessionTimeout);
    }

    function sessionExpiring() {
        logoutTimer = setTimeout(logoutOnSessionExpires, sessionDialogWait);
        $('#sessionEndDialog').dialog('open');
    }

    function logoutOnSessionExpires() {
        window.location.href = '<%=Url.Action("LogOff", "Account", new { @area = "root" }, null)%>';
    }       

    </script>
<% } %>

<div id="sessionEndDialog" title="La sesión va a expirar" style="display: none;">
    <p>Tu sesión esta apunto de expirar. Presiona 'OK' para renovar tu sesión ó 'Salir' para salir de la aplicación.</p>
</div>
