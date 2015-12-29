<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Gambling.ViewModels.GameResultsViewModel>" %>
<%@ Import Namespace="Gambling.Models" %>
<table class="gameResults">
    <tr>
        <td>
            Periodos
        </td>
        <%
            for( int PeriodIndex = 1; PeriodIndex <= Model.TotalPeriods; PeriodIndex++, Model.CurrentIndex++ )
            {
                GameDetail CurrentDetail = Model.GameResults.Where( G => G.Period == PeriodIndex && G.GameDetailType == ( Byte ) Constants.GameDetailType.PeriodPoints ).FirstOrDefault( );
        %>
        <td>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Id", PeriodIndex - 1 ), ( CurrentDetail ?? new GameDetail( ) ).Id, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", PeriodIndex - 1 ), ( Byte ) Constants.GameDetailType.PeriodPoints, new { @class = "score-serializable" } )%>
            <%= Html.Hidden( string.Format( "GameDetails[{0}].Period", PeriodIndex - 1 ), PeriodIndex, new { @class = "score-serializable" } )%>
            <%= PeriodIndex == Model.TotalPeriods ? "x" : PeriodIndex.ToString()%>
        </td>
        <%} %>
        <td>
            Total
        </td>
    </tr>
    <tr>
        <td>
            <%= Model.Local.Team.Name %>
        </td>
        <%
            for( int PeriodIndex = 1; PeriodIndex <= Model.TotalPeriods; PeriodIndex++ )
            {
                GameDetail CurrentDetail = Model.GameResults.Where( G => G.Period == PeriodIndex && G.GameDetailType == ( Byte ) Constants.GameDetailType.PeriodPoints ).FirstOrDefault( );
        %>
        <td>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreLocalTeam", PeriodIndex - 1 ), ( CurrentDetail ?? new GameDetail( ) ).ScoreLocalTeam, new
                {
                    @class = "score-serializable score",
                    tabIndex = 50 + ( PeriodIndex * 2 )
                } )%>
        </td>
        <%} %>
        <td class="total">
        </td>
    </tr>
    <tr>
        <td>
            <%= Model.Foreign.Team.Name %>
        </td>
        <%
            for( int PeriodIndex = 1; PeriodIndex <= Model.TotalPeriods; PeriodIndex++ )
            {
                GameDetail CurrentDetail = Model.GameResults.Where( G => G.Period == PeriodIndex && G.GameDetailType == ( Byte ) Constants.GameDetailType.PeriodPoints ).FirstOrDefault( );
        %>
        <td>
            <%= Html.TextBox( string.Format( "GameDetails[{0}].ScoreForeignTeam", PeriodIndex - 1 ), ( CurrentDetail ?? new GameDetail( ) ).ScoreForeignTeam, new
                {
                    @class = "score-serializable score",
                    tabIndex = 50 + ( PeriodIndex * 2 ) + 1
                } )%>
        </td>
        <%} %>
        <td class="total">
        </td>
    </tr>
</table>
