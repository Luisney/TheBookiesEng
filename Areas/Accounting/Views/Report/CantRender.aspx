<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Reports - View Reports
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>View Report</h2>
    <p>You don't have access to view this report.</p>
    <br/>
    <p>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
</asp:Content>
