<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<GameResultsViewModel>" %>

<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script type="text/javascript">
        var $GAMECODE = <%= Model.GameCode %>;
        var model = new Array();
        model.totalPeriods = <%= Model.TotalPeriods %>;
        var ControllerActions = {
            SaveResult: '<%= Url.Action("SaveResult") %>/'
        }
    </script>
    <%= Html.GetScript( "game.edit.results" )%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Juegos - Resultados
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        Resultados</h1>
    <h5>
        <%=Model.Local.Team.Name%>
        vs.
        <%=Model.Foreign.Team.Name%>
        - [<%=Model.StartTime%>]
    </h5>
    <br />
    <%=this.Select(C => C.GameStatus).Options(Model.GameStatuses).Label("Estado del juego: ")%>
    <br />
    <br />
    <%
        Html.RenderPartial( "PeriodPointsResults", Model );%>
    <a id="partialResultsLink">[Mostrar/Ocultar resultados parciales]</a>
    <div id="partialResultsDiv">
        <%
            Html.RenderPartial( "PartialResults", Model );%>
    </div>
    <br />
    <%
        if( Model.DisplayGameRunsHitsAndErrors )
        {%>
    <br />
    <%
        Html.RenderPartial( "HitsRunsErrorsResults", Model );%>
    <br />
    <%
        }%>
    <br />
    <%
        if( Model.GamePlayers.Count > 0 )
        {%>
    <h1>
        Jugadores</h1>
    <%
        }

        foreach( var gamePlayerGroup in Model.GamePlayers.GroupBy( gamePlayer => gamePlayer.LocalPlayer.PlayerType.Type ) )
        {
            %>
            <h5><%= gamePlayerGroup.Key %></h5>
            <%
            foreach( GamePlayer CurrentPlayer in gamePlayerGroup )
            {
                Html.RenderPartial( "GamePlayerResults", new GamePlayerResultViewModel
                                                            {
                                                                BaseModel = Model,
                                                                CurrentGamePlayer = CurrentPlayer,
                                                                ShowRunsHitsAndErrors =
                                                                    Model.PlayersUsingRunHitsAndErrors.Where(
                                                                    R => R == CurrentPlayer.Id ).Any( )
                                                            } );
    %>
    <br />
    <%      }
        }%>
    <br />
    <%if( Model.AvailableBets.Count( availableBet => availableBet.BetType.UsePropositionPrice ) > 0 )
      {%>
    <% Html.RenderPartial( "PropositionResults", Model ); %>
    <%}%>
    <br />
    <br />
    <a id="save-btn" class="button"><span>Guardar resultados</span></a>
</asp:Content>
