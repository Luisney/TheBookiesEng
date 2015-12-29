<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>
<div class="leftNavigation">
    <div class="menuSection">
        <h1>
            Tickets</h1>
        <ul>
            <%=Html.MenuItem("Tickets", "Index", "Bet", new { @area = "Sports" }, null)%>
            <%=Html.MenuItem("Tipos Ticket", "Index", "TicketType", new { @area = "Sports" }, null)%>
        </ul>
    </div>
</div>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="juego">
            Juego</h1>
        <ul>
            <%=Html.MenuItem("Juegos", "Index", "Game", new { @area = "Sports" }, null)%>
            <%=Html.MenuItem("Matchups", "ShowAllMatchups", "GamePlayer", new { @area = "Sports" }, null)%>
            <%=Html.MenuItem("Lineas", "AvailableGames", "Game", new { @area = "Sports" }, null)%>
        </ul>
    </div>
</div>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="deporte">
            Deporte</h1>
        <ul>
            <%= Html.MenuItem( "Deportes", "Index", "Sport", new { @area = "Sports" }, null )%>
            <%= Html.MenuItem("Ligas", "Index", "Division", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Equipos", "Index", "Team", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Alias de Equipos", "Index", "TeamAlias", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Jugadores", "Index", "Player", new { @area = "Sports" }, null)%>
        </ul>
    </div>
</div>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="calculo">
            Cálculo Automático</h1>
        <ul>
            <%= Html.MenuItem("Precios", "Index", "SportNomial", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Plantillas Apuesta - Juego", "Index", "BetTemplate", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Plantillas Apuesta - Totales", "Index", "BetTemplateForTotals", new { @area = "Sports" }, null)%>
        </ul>
    </div>
</div>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="apuestas">
            Configuración de apuestas</h1>
        <ul>
            <%= Html.MenuItem("Tipos de Apuesta", "Index", "BetType", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Compatibilidad", "Index", "BetCompatibility", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Compra de Puntos - Juego", "Index", "BoughtPointGame", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Compra de Puntos - Totales", "Index", "BoughtPointTotal", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Teasers", "Index", "SetupTeaser", new { @area = "Sports" }, null)%>
        </ul>
    </div>
</div>
