<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Gambling.ViewModels.GameResultsViewModel>" %>
<%@ Import Namespace="Gambling.Models" %>
<%  // Totals for complete game are ignored
    foreach( IGrouping<byte, BetTypePeriod> PeriodGroup in Model.BetTypePeriods.Where( G => G.Key != 1 ).OrderBy( Group => Group.Key ) )
    {%>
<table class="gamePartialResults">
    <thead>
        <tr>
            <td>
            </td>
            <%  foreach( BetTypePeriod Period in PeriodGroup )
                {%>
            <td>
                <%= Period.Name %>
            </td>
            <%  }%>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <%= Model.Local.Team.Name %>
            </td>
            <%  foreach( BetTypePeriod Period in PeriodGroup )
                {%>
            <td>
                <span id="gamePartialResults_<%= Period.Frequency %>_<%= Period.PeriodIndex %>" class="gamePartialResult gamePartialResultLocal">
                </span>
            </td>
            <%  }%>
        </tr>
        <tr>
            <td>
                <%= Model.Foreign.Team.Name %>
            </td>
            <%  foreach( BetTypePeriod Period in PeriodGroup )
                {%>
            <td>
                <span id="gamePartialResults_<%= Period.Frequency %>_<%= Period.PeriodIndex %>" class="gamePartialResult gamePartialResultForeign">
                </span>
            </td>
            <%  }%>
        </tr>
    </tbody>
</table>
<%  }%>
