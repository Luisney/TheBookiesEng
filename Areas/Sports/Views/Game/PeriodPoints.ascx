<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<List<PeriodPointsPricesViewModel>>" %>
<%@ Import Namespace="Gambling.Models.ViewModels"%>
<%@ Import Namespace="Gambling.Models"%>

    <% 
    foreach (PeriodPointsPricesViewModel periodPoints in Model)
    {%>
        <fieldset id="period_fields_<%= periodPoints.PeriodPointsId %>">
        <h4><%= periodPoints.BetTypePeriodName %></h4>
        
        <%= Html.Hidden(string.Format("periodPointsPrices[{0}].PeriodPointsId", Model.IndexOf(periodPoints)), periodPoints.PeriodPointsId)%>
        
        <%= Html.Hidden(string.Format("periodPointsPrices[{0}].BetTypePeriodId", Model.IndexOf(periodPoints)), periodPoints.BetTypePeriodId)%>
        
        <table>
            <tr>
                <td></td>
                <td>Totales</td>
                <td>Over</td>
                <td>Under</td>
            </tr>
            <tr>
                <td>
                    <label for="<%= string.Format("periodPointsPrices_{0}__TotalPoints", Model.IndexOf(periodPoints)) %>">Juego:</label>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].TotalPoints", Model.IndexOf(periodPoints))).Value(periodPoints.TotalPoints)%>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].TotalOver", Model.IndexOf(periodPoints))).Value(periodPoints.TotalOver)%>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].TotalUnder", Model.IndexOf(periodPoints))).Value(periodPoints.TotalUnder)%>
                </td>
            </tr>
            
            <tr>
                <td>
                    <label for = "<%=string.Format("periodPointsPrices_{0}__VisitorPoints", Model.IndexOf(periodPoints)) %>">Visitante:</label>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].VisitorPoints", Model.IndexOf(periodPoints))).Class("visitor").Value(periodPoints.VisitorPoints)%>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].VisitorOver", Model.IndexOf(periodPoints))).Value(periodPoints.VisitorOver)%>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].VisitorUnder", Model.IndexOf(periodPoints))).Value(periodPoints.VisitorUnder)%>
                </td>
            </tr>
            
            <tr>
                <td>
                    <label for="<%= string.Format("periodPointsPrices_{0}__LocalPoints", Model.IndexOf(periodPoints)) %>">Local:</label>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].LocalPoints", Model.IndexOf(periodPoints))).Class("local").Value(periodPoints.LocalPoints)%>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].LocalOver", Model.IndexOf(periodPoints))).Value(periodPoints.LocalOver)%>
                </td>
                <td>
                    <%= this.TextBox(string.Format("periodPointsPrices[{0}].LocalUnder", Model.IndexOf(periodPoints))).Value(periodPoints.LocalUnder)%>
                </td>
            </tr>
        </table>
        
        </fieldset>
    <%
    } %>