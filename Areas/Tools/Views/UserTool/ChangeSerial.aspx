<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage"%>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Herramientas
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cambio de Serial</h2>
    <%= Html.ValidationSummary("Edición fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm( ) ) {%>
    <% } %>


</asp:Content>
