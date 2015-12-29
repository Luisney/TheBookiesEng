<%@  Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
    USers -
    <%= Html.Encode( "Your password has been successfully changed" ) %>
</asp:Content>
<asp:Content ID="changePasswordSuccessContent" ContentPlaceHolderID="MainContent"
    runat="server">
    <h2>
        <%= Html.Encode( "Change password" ) %>
    </h2>
    <p>
        <%= Html.Encode( "Your password has been successfully changed" ) %>
    </p>
</asp:Content>
