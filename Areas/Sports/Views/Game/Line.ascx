<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Gambling.Models.Game>" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers" %>
<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="Gambling.Models.Specifications" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="TheBookies.Model" %>
<div class="line-wrapper">
    <h5>
        Hora:
        <%= Model.StartTime %>
    </h5>
    <% 
        // Default bet type
        var DefaultBet = Model.GetDefaultBet( );
    %>
    <%
        var FullPeriodSpec = new AvailableBetBelongsToFullPeriodSpecification( );
        var DefaultBetSpec = new AvailableBetIsDefaultBetForGameSpecification( Model.TeamAsA.Team.Sport );

        Html.RenderPartial( "LinePeriod",
                           new LinePeriodViewModel
                           {
                               Period = DefaultBet.BetType.Period,
                               PeriodDefaultBet = DefaultBet.Status == ( Byte ) Enumerations.AvailableBetStatus.Active ? DefaultBet : null,
                               PeriodDefaultBetType = DefaultBet.BetType,
                               PeriodGameBets = Model.AvailableBets
                                   .Where( AvailableBet => FullPeriodSpec.IsSatisfiedBy( AvailableBet ) &&
                                                           !DefaultBetSpec.IsSatisfiedBy( AvailableBet ) &&
                                                           AvailableBet.Status == ( Byte ) Enumerations.AvailableBetStatus.Active )
                                   .OrderBy( Bet => Bet.BetType.AppliestoTotals )
                                   .ThenBy( Bet => Bet.BetType.DisplayOrder ),
                               TeamAsA = Model.TeamAsA,
                               TeamAsB = Model.TeamAsB
                           } ); %>
    <div class="period-line">
        <a class="periods-btn">[Mostrar/Ocultar períodos]</a>
        <br><br>
        <div class="lines ui-hide">
            <%
                foreach( var BetGroup in Model.GetStandardBetsGroupedByPeriod( false ) )
                {
                    var Period = BetGroup.Key;
                    var PeriodDefaultBet = Model.GetDefaultBet( Period.Frequency, Period.PeriodIndex );
            %>
            <% Html.RenderPartial( "LinePeriod",
                           new LinePeriodViewModel
                           {
                               Period = BetGroup.Key,
                               PeriodDefaultBet = PeriodDefaultBet.Status == ( Byte ) Enumerations.AvailableBetStatus.Active ? PeriodDefaultBet : null,
                               PeriodDefaultBetType = PeriodDefaultBet.BetType,
                               PeriodGameBets = BetGroup.Where( AvailableBet => !DefaultBetSpec.IsSatisfiedBy( AvailableBet ) &&
                                   AvailableBet.Status == ( Byte ) Enumerations.AvailableBetStatus.Active ),
                               TeamAsA = Model.TeamAsA,
                               TeamAsB = Model.TeamAsB
                           } ); %>
            <br>
            <%} %>
        </div>
    </div>
</div>
