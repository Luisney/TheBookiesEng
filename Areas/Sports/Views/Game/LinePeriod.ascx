<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.ViewModels.LinePeriodViewModel>" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers" %>
<%@ Import Namespace="Gambling.Helpers" %>
<%@ Import Namespace="Gambling.Models" %>
<h5>
    <%=Model.Period.Name%></h5>
<table class="standard-line" cellspacing="0">
    <tbody>
        <tr>
            <th class="first">
                Código
            </th>
            <th>
                Equipos
            </th>
            <%
                if (Model.PeriodDefaultBet != null)
                {%>
            <th colspan="<%=Model.PeriodDefaultBetType.GetNumberOfLineColumnsUsed()%>">
                <%=Model.PeriodDefaultBetType.Shortcut%>
            </th>
            <%
                }%>
            <%
                foreach (var AvailableBet in Model.PeriodGameBets)
                {
                    var ColumnSpan = AvailableBet.BetType.GetNumberOfLineColumnsUsed();
                    if (ColumnSpan > 0)
                    {%>
            <th colspan="<%=ColumnSpan%>">
                <%=AvailableBet.BetType.Shortcut%>
            </th>
            <%
                    }
                }%>
        </tr>
        <tr class="visitor">
            <td>
                <%=Model.TeamAsA.Code%>
            </td>
            <td>
                <%=Model.TeamAsA.PrintName%>
            </td>
            <%
                const string betFieldKeyFormat =
                    Constants.LineAvailableBetKey + "{0} " + Constants.LineAvailableBetFieldKey;
                
                if (Model.PeriodDefaultBet != null)
                {
                    var PeriodDefaultAvailableBetFieldKey = String.Format( betFieldKeyFormat, Model.PeriodDefaultBet.Id );
                    if( Model.PeriodDefaultBetType.UseGlobalScore )
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.Score)%>"
                        rowspan="2">
                        <%=Model.PeriodDefaultBet.Score%>
                    </td>
                    <%
                    }%>
                    <%
                    if (Model.PeriodDefaultBetType.UseIndividualScore)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.ScoreVisitor)%>">
                        <%=Model.PeriodDefaultBet.ScoreVisitor%>
                    </td>
                    <%
                    }%>
                    <%
                    if (Model.PeriodDefaultBetType.UseIndividualSpread)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.SpreadVisitor)%>">
                        <%=Model.PeriodDefaultBet.SpreadVisitor%>
                    </td>
                    <%
                    }%>

                     <%if( Model.PeriodDefaultBetType.UsePropositionPrice )
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PropositionPrice)%>"
                        rowspan="2">
                        <%=Model.PeriodDefaultBet.PropositionPrice%>
                    </td>
                    <%
                    }%>

                    <%
                    if (Model.PeriodDefaultBetType.UseIndividualPrice)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceVisitor)%>">
                        <%=Model.PeriodDefaultBet.PriceVisitor%>
                    </td>
                    <%
                    }%>
                    <%
                    if (Model.PeriodDefaultBetType.UseIndividualPriceOver)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceVisitorOver)%>">
                        <%=Model.PeriodDefaultBet.PriceVisitorOver%>
                    </td>
                    <%
                    }%>
                    <%
                    if (Model.PeriodDefaultBetType.UseGlobalPriceOver)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceOver)%>"
                        rowspan="2">
                        <%=Model.PeriodDefaultBet.PriceOver%>
                    </td>
                    <%
                    }%>
                    <%
                    if (Model.PeriodDefaultBetType.UseIndividualPriceUnder)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceVisitorUnder)%>">
                        <%=Model.PeriodDefaultBet.PriceVisitorUnder%>
                    </td>
                    <%
                    }%>
                    <%
                    if (Model.PeriodDefaultBetType.UseGlobalPriceUnder)
                    {%>
                    <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceUnder)%>"
                        rowspan="2">
                        <%=Model.PeriodDefaultBet.PriceUnder%>
                    </td>
                    <%
                    }
                }%>
            <%  // Non default bet types
                foreach( var CurrentBet in Model.PeriodGameBets )
                {
                    // Closure protection preventing future use of delegates http://blogs.msdn.com/b/abhinaba/archive/2005/10/18/482180.aspx
                    var AvailableBet = CurrentBet;
                    var PeriodAvailableBetFieldKey = String.Format( betFieldKeyFormat, AvailableBet.Id );
            %>
            <%  if( AvailableBet.BetType.UseGlobalScore )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.Score ) %>"
                rowspan="2">
                <%= AvailableBet.Score%>
            </td>
            <%  }%>
            <%  if( AvailableBet.BetType.UseIndividualScore )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.ScoreVisitor ) %>">
                <%= AvailableBet.ScoreVisitor%>
            </td>
            <%  }%>
            <%  if( AvailableBet.BetType.UseIndividualSpread )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.SpreadVisitor ) %>">
                <%= AvailableBet.SpreadVisitor %>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UsePropositionPrice )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PropositionPrice ) %>"
                rowspan="2">
                <%= AvailableBet.PropositionPrice%>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseIndividualPrice )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceVisitor ) %>">
                <%= AvailableBet.PriceVisitor %>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseIndividualPriceOver )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceVisitorOver ) %>">
                <%= AvailableBet.PriceVisitorOver%>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseGlobalPriceOver )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceOver ) %>"
                rowspan="2">
                <%= AvailableBet.PriceOver%>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseIndividualPriceUnder )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceVisitorUnder ) %>">
                <%= AvailableBet.PriceVisitorUnder%>
            </td>
            <%  }%>
            <%  if( AvailableBet.BetType.UseGlobalPriceUnder )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceUnder ) %>"
                rowspan="2">
                <%= AvailableBet.PriceUnder%>
            </td>
            <%   } %>
            <%}%>
        </tr>
        <tr class="local">
            <td>
                <%= Model.TeamAsB.Code %>
            </td>
            <td>
                <%= Model.TeamAsB.PrintName %>
            </td>
            <%if( Model.PeriodDefaultBet != null )
              {
                  var PeriodDefaultAvailableBetFieldKey = String.Format( betFieldKeyFormat, Model.PeriodDefaultBet.Id );
                  if( Model.PeriodDefaultBetType.UseIndividualScore )
                  {%>
                <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.ScoreLocal)%>">
                    <%=Model.PeriodDefaultBet.ScoreLocal%>
                </td>
                <%
                  }%>
                <%
                  if (Model.PeriodDefaultBetType.UseIndividualSpread)
                  {%>
                <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.SpreadLocal)%>">
                    <%=Model.PeriodDefaultBet.SpreadLocal%>
                </td>
                <%
                  }%>
                <%
                  if (Model.PeriodDefaultBetType.UseIndividualPrice)
                  {%>
                <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceLocal)%>">
                    <%=Model.PeriodDefaultBet.PriceLocal%>
                </td>
                <%
                  }%>
                <%
                  if (Model.PeriodDefaultBetType.UseIndividualPriceOver)
                  {%>
                <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceLocalOver)%>">
                    <%=Model.PeriodDefaultBet.PriceLocalOver%>
                </td>
                <%
                  }%>
                <%
                  if (Model.PeriodDefaultBetType.UseIndividualPriceUnder)
                  {%>
                <td class="line-odd-value <%=PeriodDefaultAvailableBetFieldKey%><%=this.MemberNameFor(PageModel => Model.PeriodDefaultBet.PriceLocalUnder)%>">
                    <%=Model.PeriodDefaultBet.PriceLocalUnder%>
                </td>
                <%
                  }
              }%>
            <%  // Non default bet types
                foreach( var CurrentBet in Model.PeriodGameBets )
                {
                    // Closure protection preventing future use of delegates http://blogs.msdn.com/b/abhinaba/archive/2005/10/18/482180.aspx
                    var AvailableBet = CurrentBet;
                    var PeriodAvailableBetFieldKey = String.Format( betFieldKeyFormat, AvailableBet.Id );
            %>
            <%  if( AvailableBet.BetType.UseIndividualScore )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.ScoreLocal ) %>">
                <%= AvailableBet.ScoreLocal%>
            </td>
            <%  }%>
            <%  if( AvailableBet.BetType.UseIndividualSpread )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.SpreadLocal ) %>">
                <%= AvailableBet.SpreadLocal%>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseIndividualPrice )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceLocal ) %>">
                <%= AvailableBet.PriceLocal%>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseIndividualPriceOver )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceLocalOver ) %>">
                <%= AvailableBet.PriceLocalOver%>
            </td>
            <%   } %>
            <%  if( AvailableBet.BetType.UseIndividualPriceUnder )
                {%>
            <td class="line-odd-value <%= PeriodAvailableBetFieldKey %><%= this.MemberNameFor( PageModel => AvailableBet.PriceLocalUnder ) %>">
                <%= AvailableBet.PriceLocalUnder%>
            </td>
            <%  }%>
            <%}%>
        </tr>
    </tbody>
</table>
