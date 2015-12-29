<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<GamePlayerResultViewModel>" %>
<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="Gambling.Models" %>
<% var PlayerPointDetail =
       Model.BaseModel.GameResults
        .Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.PlayerPoints &&
            ( G.GamePlayer ?? new GamePlayer( ) ).Id == Model.CurrentGamePlayer.Id )
           .SingleOrDefault( ) ?? new GameDetail( );

   var RunHitsAndErrorsDetail =
      Model.BaseModel.GameResults
       .Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.PlayerHitsRunsErrors &&
           ( G.GamePlayer ?? new GamePlayer( ) ).Id == Model.CurrentGamePlayer.Id )
          .SingleOrDefault( ) ?? new GameDetail( );

   var MatchupWasCancelled = Model.CurrentGamePlayer.Status == (Byte) Constants.GamePlayerStatus.Cancelled;

   var PlayerTotalPointsIndex = 0;
   if( !MatchupWasCancelled )
       PlayerTotalPointsIndex = Model.BaseModel.CurrentIndex++;
    
   var RunsHitsAndErrorsIndex = 0;
   if( Model.ShowRunsHitsAndErrors && !MatchupWasCancelled )
       RunsHitsAndErrorsIndex = Model.BaseModel.CurrentIndex++;

    var ElementStyles = String.Empty;
    if( MatchupWasCancelled )
        ElementStyles += " disabled-matchup";
%>
<table class="PlayersResults <%= ElementStyles %>">
   <thead>
    <tr>
        <th>
        </th>
        <%if( Model.CurrentGamePlayer.Status == ( Byte ) Constants.GamePlayerStatus.Cancelled )
          {%>
        <th>
        </th>
        <%}
          else
          {%>
        <th>
            Puntos
        </th>
        <% if( Model.ShowRunsHitsAndErrors )
           {%>
        <th>
            Suma Hits, Carreras y Errores
        </th>
        <%} %>
        <%}%>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="PlayerName">
            <%= Model.CurrentGamePlayer.LocalPlayer.Name %>
        </td>
        <%if( Model.CurrentGamePlayer.Status == ( Byte ) Constants.GamePlayerStatus.Cancelled )
          {%>
        <td rowspan="2">Cancelado</td>
        <%}
          else
          {%>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", PlayerTotalPointsIndex ), PlayerPointDetail.Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GamePlayerId", PlayerTotalPointsIndex ), Model.CurrentGamePlayer.Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", PlayerTotalPointsIndex ), ( Byte ) Constants.GameDetailType.PlayerPoints, new { @class = "score-serializable" } )%>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalPlayer", PlayerTotalPointsIndex ), PlayerPointDetail.ScoreLocalPlayer, new { @class = "score-serializable" } )%>
        </td>
        <% if( Model.ShowRunsHitsAndErrors )
           {%>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", RunsHitsAndErrorsIndex ), RunHitsAndErrorsDetail.Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GamePlayerId", RunsHitsAndErrorsIndex ), Model.CurrentGamePlayer.Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", RunsHitsAndErrorsIndex ), ( Byte ) Constants.GameDetailType.PlayerHitsRunsErrors, new { @class = "score-serializable" } )%>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalPlayer", RunsHitsAndErrorsIndex ), RunHitsAndErrorsDetail.ScoreLocalPlayer, new { @class = "score-serializable" } )%>
        </td>
        <%}%>
        <%} %>
    </tr>
    <tr>
        <td class="PlayerName">
            <%= Model.CurrentGamePlayer.ForeignPlayer.Name%>
        </td>
        <%if( Model.CurrentGamePlayer.Status != ( Byte ) Constants.GamePlayerStatus.Cancelled )
          {%>
            <td>
                <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignPlayer", PlayerTotalPointsIndex ), PlayerPointDetail.ScoreForeignPlayer, new { @class = "score-serializable" } )%>
            </td>
            <% if( Model.ShowRunsHitsAndErrors )
               {%>
            <td>
                <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignPlayer", RunsHitsAndErrorsIndex ), RunHitsAndErrorsDetail.ScoreForeignPlayer, new { @class = "score-serializable" } )%>
            </td>
            <%} %>
        <%} %>
    </tr>
    </tbody>
</table>
