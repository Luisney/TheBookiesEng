<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Helpers" %>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="lottery">
            Recargas</h1>
        <ul>
            <%= Html.MenuItem("Balances", "Index", "Recarga", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Cuentas", "Index", "Cuenta", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Grupos de Bancas", "Index", "GrupoBanca", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Ventas", "Ventas", "Recarga", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Anular Recarga", "Anular", "Recarga", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Perfiles de Comisión", "Index", "Comision", new { @area = "Recargas" }, null)%>
        </ul>
    </div>
</div>
