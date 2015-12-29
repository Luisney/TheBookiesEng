<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Helpers" %>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="general">
            General</h1>
        <ul>
            <%= Html.MenuItem("Usuarios", "Index", "Account", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Apostadores", "Index", "Gambler", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Consorcios", "Index", "Company", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Centros de acopio", "Index", "StoringCenter", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Rutas", "Index", "Route", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Bancas", "Index", "SportBook", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Terminales", "Index", "Terminal", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Registro Rapido de Banca", "RegisterSportBook", "Quick", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Configuración general", "Edit", "Settings", new { @area = "root" }, null)%>
        </ul>
    </div>
</div>
