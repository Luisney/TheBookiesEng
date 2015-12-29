<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Graphs
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Graphs</h2>
    <%foreach( var Chart in ( List<String> ) ViewData [ "AvailableCharts" ] )
      {%>
        <% Html.RenderPartial( Chart ); %>
    <br />
    <%}%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <script type="text/javascript" src="/Content/js/Charting/jquery.thebookies.charts.js"></script>

</asp:Content>
