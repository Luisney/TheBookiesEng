<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Gambling.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Reports - Reports Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Reports</h2>
    <%= Html.RenderReportsList("Detail","Report") %>  
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
</asp:Content>
