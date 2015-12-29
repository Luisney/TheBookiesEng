<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<Gambling.Models.Game>>" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers" %>

<%    foreach( var game in Model )
      { %>
<div style="width: 700px; position: relative; margin-bottom:20px; padding-bottom:15px; overflow: auto; float: left;">
    <table id="lineas">
        <tbody>
            <tr class="lineas_tittle" style="background:#4b75aa url(/content/images/bg-table-title.gif) repeat-x left top;">
                <th>
                </th>
                <th>
                </th>
                <th>
                </th>
                <% foreach( var period in game.GetCurrentGameAvailableBetsGroupedByPeriod( ) )
                   { %>
                <th colspan="<%= period.Value.Count + ( period.Value.Where( AB => AB.BetType.UseIndividualSpread ).Count() ) %>">
                    <%= Html.Encode( period.Key ) %>
                </th>
                <% }%>
            </tr>
            <tr class="lineas_tittle">
                <th>
                    Hora
                </th>
                <th>
                    Codigo
                </th>
                <th style=" display:block; width:100px !important; padding-top:18px; border:none !important;">
                    Equipo
                </th>
                <% foreach( var period in game.GetCurrentGameAvailableBetsGroupedByPeriod( ) )
                   {
                       foreach( var availableBetType in period.Value )
                       { %>
                <%=         "<th" +
                            ( ( availableBetType.BetType.UseIndividualSpread )?  " colspan=\"2\">": ">" ) +
                            availableBetType.BetType.Shortcut +
                            "</th>" %>
                <%      }
               } %>
            </tr>
            <tr>
                <td>
                    <%= game.StartTime %>
                </td>
                <td>
                    <%= game.TeamAsA.Code %>
                    <br />
                    <%= game.TeamAsB.Code %>
                </td>
                <td>
                    <%= game.TeamAsA.PrintName %>
                    <br />
                    <%= game.TeamAsB.PrintName %>
                </td>
                <% foreach( var period in game.GetCurrentGameAvailableBetsGroupedByPeriod( ) )
                   {
                       foreach( var availableBetType in period.Value )
                       { %>
                <td>
                    <%= String.Format( "{0:+#;-#;0}", availableBetType.PriceVisitor ) %>
                    <br />
                    <%= String.Format( "{0:+#;-#;0}", availableBetType.PriceLocal )%>
                </td>
                <%  if( availableBetType.BetType.UseIndividualSpread )
                    {%>
                <td>
                    <%=  String.Format( "{0:+#;-#;0}", availableBetType.SpreadVisitor )%>
                <br/>
                    <%=  String.Format( "{0:+#;-#;0}", availableBetType.SpreadLocal )%>
                </td>
                <%}%>
                <%  }
               } %>
            </tr>
        </tbody>
    </table>
</div>

<div class="line-wrapper">
    <table>
    </table>
</div>

<div class="clear"></div>
<%  }%>