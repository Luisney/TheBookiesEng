<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Gambling.ViewModels.GameResultsViewModel>" %>
<%@ Import Namespace="Gambling.Models" %>
<%
    GameDetail HomerunsDetail = Model.GameResults.Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.GameHomeruns ).FirstOrDefault( );
    Int32 HomerunsIndex = Model.CurrentIndex++;
    GameDetail HitsDetail = Model.GameResults.Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.GameHits ).FirstOrDefault( );
    Int32 HitsIndex = Model.CurrentIndex++;
    GameDetail RunsDetail = Model.GameResults.Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.GameRuns ).FirstOrDefault( );
    Int32 RunsIndex = Model.CurrentIndex++;
    GameDetail ErrorsDetail = Model.GameResults.Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.GameErrors ).FirstOrDefault( );
    Int32 ErrorsIndex = Model.CurrentIndex++;
        
%>
<table class="gameHitsRunsErrors">
    <tr>
        <td>
        </td>
        <td class="hitRunsErrorsRowHeader">
            Home Runs
        </td>
        <td class="hitRunsErrorsRowHeader">
            Hits
        </td>
        <td class="hitRunsErrorsRowHeader">
            Carreras
        </td>
        <td class="hitRunsErrorsRowHeader">
            Errores
        </td>
    </tr>
    <tr>
        <td>
            <%= Model.Local.Team.Name %>
        </td>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", HomerunsIndex ), ( HomerunsDetail ?? new GameDetail( ) ).Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", HomerunsIndex ), ( Byte ) Constants.GameDetailType.GameHits, new { @class = "score-serializable" } )%>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalTeam", HomerunsIndex ), ( HomerunsDetail ?? new GameDetail( ) ).ScoreLocalTeam, new { @class = "score-serializable" } )%>
        </td>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", HitsIndex ), ( HitsDetail ?? new GameDetail( ) ).Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", HitsIndex ), ( Byte ) Constants.GameDetailType.GameHits, new { @class = "score-serializable" } )%>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalTeam", HitsIndex ), ( HitsDetail ?? new GameDetail( ) ).ScoreLocalTeam, new { @class = "score-serializable" } )%>
        </td>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", RunsIndex ), ( RunsDetail ?? new GameDetail( ) ).Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", RunsIndex ), ( Byte ) Constants.GameDetailType.GameRuns, new { @class = "score-serializable" } )%>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalTeam", RunsIndex ), ( RunsDetail ?? new GameDetail( ) ).ScoreLocalTeam, new { @class = "score-serializable" } )%>
        </td>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", ErrorsIndex ), ( ErrorsDetail ?? new GameDetail( ) ).Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", ErrorsIndex ), ( Byte ) Constants.GameDetailType.GameErrors, new { @class = "score-serializable" } )%>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalTeam", ErrorsIndex ), ( ErrorsDetail ?? new GameDetail( ) ).ScoreLocalTeam, new { @class = "score-serializable" } )%>
        </td>
    </tr>
    <tr>
        <td>
            <%= Model.Foreign.Team.Name %>
        </td>
        <td>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignTeam", HomerunsIndex ), ( HomerunsDetail ?? new GameDetail( ) ).ScoreForeignTeam, new { @class = "score-serializable" } )%>
        </td>
        <td>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignTeam", HitsIndex ), ( HitsDetail ?? new GameDetail( ) ).ScoreForeignTeam, new { @class = "score-serializable" } )%>
        </td>
        <td>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignTeam", RunsIndex ), ( RunsDetail ?? new GameDetail( ) ).ScoreForeignTeam, new { @class = "score-serializable" } )%>
        </td>
        <td>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignTeam", ErrorsIndex ), ( ErrorsDetail ?? new GameDetail( ) ).ScoreForeignTeam, new { @class = "score-serializable" } )%>
        </td>
    </tr>
</table>
