<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.Models.GamePlayer>" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>
<%-- You must include the jqBlockUI package in your page when using this control --%>
<%
    var ElementStyles = String.Empty;
    if( Model.Status == ( Byte ) Constants.GamePlayerStatus.Cancelled )
        ElementStyles += " disabled-matchup";
%>

<div id="divMatchUp<%=Model.Id %>" class="matchups <%= ElementStyles %>">
    <%= Html.Hidden( "GameCode" ) %>
    <% if( Model.Status != ( Byte ) Constants.GamePlayerStatus.Cancelled )
       {%>
    <div class="links">
        <a href="<%= Url.Action("Edit", "GamePlayer", new { @area = "Sports", @Code = Model.Id } ) %>" class="edit">Editar</a>
        <a id="cancel-<%= Model.Id %>" class="matchup-cancel">Cancelar</a>
        <a id="delete-<%= Model.Id %>" name="closeIcon" class="matchup-delete">Eliminar</a>
    </div>
    <%}%>
    <div class="clear">
    </div>
        <div class="lines">
        <%
            foreach( var CurrentBet in Model.GameAvailableBets )
            {
                // Closure protection preventing future use of delegates http://blogs.msdn.com/b/abhinaba/archive/2005/10/18/482180.aspx
                var Bet = CurrentBet;
                const string betFieldKeyFormat = Constants.LineAvailableBetKey + "{0} " + Constants.LineAvailableBetFieldKey;
                var PeriodDefaultAvailableBetFieldKey = String.Format( betFieldKeyFormat, Bet.Id );
                
                %>
        <div class="line-wrapper">
            <h5>
                <%= Bet.BetType.Name %></h5>
            <table width="100%" class="standard-line" cellspacing="0">
                <tr>
                    <th>
                        Código
                    </th>
                    <th>
                        Jugador
                    </th>
                    <%  if( Bet.BetType.UseGlobalScore )
                        {%>
                    <th>
                        Carreraje
                    </th>
                    <%} %>
                    <%  if( Bet.BetType.UseIndividualScore )
                        {%>
                    <th>
                        Carreraje
                    </th>
                    <%} %>
                    <%  if( Bet.BetType.UseIndividualSpread )
                        {%>
                    <th>
                        Gavela
                    </th>
                      <%} %>
                    <%  if( Bet.BetType.UseIndividualPrice )
                        {%>
                    <th>
                        Precios
                    </th>
                      <%} %>
                    <%  if( Bet.BetType.UseGlobalPriceOver )
                        {%>
                    <th>
                        Precio a más de
                    </th>
                      <%} %>
                      <%  if( Bet.BetType.UseIndividualPriceOver )
                        {%>
                    <th>
                        Precio a más de
                    </th>
                      <%} %>
                    <%  if( Bet.BetType.UseGlobalPriceUnder )
                        {%>
                    <th>
                        Precio a menos de
                    </th>
                    <%} %>
                     <%  if( Bet.BetType.UseIndividualPriceUnder )
                        {%>
                    <th>
                        Precio a menos de
                    </th>
                    <%} %>
                     <%  if( Bet.BetType.UsePropositionPrice )
                        {%>
                    <th>
                        Precio
                    </th>
                    <%} %>
                </tr>
                <tr>
                    <td>
                        <%= Model.ForeignPlayer.Code %>
                    </td>
                    <td>
                        <%= Model.ForeignPlayer.Name %>
                    </td>
                    <%  if( Bet.BetType.UseGlobalScore )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.Score ) %>" rowspan="2">
                        <%= Bet.Score %>
                    </td>
                    <%} %>
                    <%  if( Bet.BetType.UseIndividualScore )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.ScoreVisitor ) %>">
                         <%= Bet.ScoreVisitor %>
                    </td>
                    <%} %>
                    <%  if( Bet.BetType.UseIndividualSpread )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.SpreadVisitor ) %>">
                        <%= Bet.SpreadVisitor %>
                    </td>
                      <%} %>
                    <%  if( Bet.BetType.UseIndividualPrice )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceVisitor ) %>">
                        <%= Bet.PriceVisitor %>
                    </td>
                      <%} %>
                    <%  if( Bet.BetType.UseGlobalPriceOver )
                        {%>
                    <td rowspan="2" class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceOver ) %>">
                        <%= Bet.PriceOver %>
                    </td>
                      <%} %>
                      <%  if( Bet.BetType.UseIndividualPriceOver )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceVisitorOver ) %>">
                        <%= Bet.PriceVisitorOver %>
                    </td>
                      <%} %>
                    <%  if( Bet.BetType.UseGlobalPriceUnder )
                        {%>
                    <td rowspan="2" class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceUnder ) %>">
                        <%= Bet.PriceUnder %>
                    </td>
                    <%} %>
                     <%  if( Bet.BetType.UseIndividualPriceUnder )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceVisitorUnder ) %>">
                        <%= Bet.PriceVisitorUnder %>
                    </td>
                    <%} %>
                    <%  if( Bet.BetType.UsePropositionPrice )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PropositionPrice ) %>" rowspan="2">
                        <%= Bet.PropositionPrice%>
                    </td>
                    <%} %>
                </tr>
                <tr>
                    <td>
                        <%= Model.LocalPlayer.Code %>
                    </td>
                    <td>
                        <%= Model.LocalPlayer.Name %>
                    </td>
                    <%  if( Bet.BetType.UseIndividualScore )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.ScoreLocal ) %>">
                         <%= Bet.ScoreLocal %>
                    </td>
                    <%} %>
                    <%  if( Bet.BetType.UseIndividualSpread )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.SpreadLocal ) %>">
                        <%= Bet.SpreadLocal%>
                    </td>
                      <%} %>
                    <%  if( Bet.BetType.UseIndividualPrice )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceLocal ) %>">
                        <%= Bet.PriceLocal%>
                    </td>
                      <%} %>
                      <%  if( Bet.BetType.UseIndividualPriceOver )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceLocalOver ) %>">
                        <%= Bet.PriceLocalOver%>
                    </td>
                      <%} %>
                     <%  if( Bet.BetType.UseIndividualPriceUnder )
                        {%>
                    <td class="line-odd-value <%= PeriodDefaultAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => Bet.PriceLocalUnder ) %>">
                        <%= Bet.PriceLocalUnder %>
                    </td>
                    <%} %>
                </tr>
            </table>
        </div>
        <%} %>
    </div>
</div>
<div class="clear">
</div>
