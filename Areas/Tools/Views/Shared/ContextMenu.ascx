<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Helpers" %>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="lottery">
            Loterías</h1>
        <ul>
            <%= Html.MenuItem("Cambiar serial de Terminal", "ChangeSerial", "Tools", new{ @area="Tools"}, null )%>
        </ul>
    </div>
</div>
