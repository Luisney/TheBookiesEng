<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MainOneColumn.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Dashboard
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/css/jquery.accessible-news-slider.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="/Content/js/jquery.accessible-news-slider.js"></script>

</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.RenderPartial( "DashboardLotteryResult", ViewData [ "lotteryResults" ] ); %>
    <% Html.RenderPartial( "DashboardSportsResult", ViewData [ "sportsResults" ] ); %>
</asp:Content>
