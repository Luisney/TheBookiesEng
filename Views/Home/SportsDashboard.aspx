<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MainOneColumn.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="Assets" runat="server">
    
    <link href="/Content/css/jquery.accessible-news-slider.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="/Content/js/Charting/jquery.thebookies.charts.js"></script>
    
    <script type="text/javascript" src="/Content/js/jquery.accessible-news-slider.js"></script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Dashboard
</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <h2>Sales Histogram</h2>
    
    <% Html.RenderPartial("SportsSalesHistogram"); %>
    
    <h2 class="dashboard-heading">Bby play type</h2>
    
    <% Html.RenderPartial("SportBetsPieChart"); %>
    
    <div class="clear"></div>
        
    <% Html.RenderPartial("DashboardSportsResult", ViewData["sportsResults"]); %>
</asp:Content>
