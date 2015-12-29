<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Lottery.IncompatibleBetViewModel>" %>

<%@ Import Namespace="TheBookies.Model.Lotto.Extensions" %>
<%@ Import Namespace="Gambling.Extensions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Incompatible Bets - Edit Incompatible Blets
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Incompatible Bets for:
        <%= Model.BetName %></h2>
    <br />
    <% using( Html.BeginForm( "Edit", "IncompatibleBet" ) )
       {  %>
    <% foreach( var betType in Model.BetTypes )
       {
           if( Model.IncompatibleBetTypes.Any( incompatibleId => incompatibleId == betType.Id ) )
           {%>
    <input type="checkbox" name="selectedObjects" value="<%=betType.Id%>" checked="checked" />
    <%}
           else
           { %>
    <input type="checkbox" name="selectedObjects" value="<%=betType.Id%>" />
    <%}%>
    <%= betType.Name %><br />
    <%}%>
    <br />
    <p>
        <input type="submit" value="Guardar" />
    </p>
    <%}%>
    <br />
    <div>
        <a class="navPrev" href="<%= Url.Action("Index") %>">Volver al listado</a>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
</asp:Content>
