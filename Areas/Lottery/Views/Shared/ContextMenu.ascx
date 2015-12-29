<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Helpers" %>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="lottery">
            Loterías</h1>
        <ul>
            <%= Html.MenuItem("Loterías", "Index", "Lotto", new{ @area="Lottery"}, null )%>
            <%= Html.MenuItem("Tipos de apuesta", "Index", "PlayType", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Apuestas Incompatibles", "Index", "IncompatibleBet", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Resultados", "Index", "Result", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Números Restringidos", "Index", "RestrictedNumber", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Perfiles de Comisión", "Index", "Commission", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Perfiles de Valores a Pagar", "Index", "ValuePayment", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Perfiles de Limites", "Index", "LimitBetType", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Tickets", "Index", "LottoBet", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Botes", "Index", "Surplus", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Escrutinio", "Index", "BetScrutiny", new { @area = "Lottery" }, null)%>
        </ul>
    </div>
</div>
