<%@ Page Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Users -
    <%= Html.Encode( "Cambiar contraseña" ) %>
</asp:Content>
<asp:Content ID="changePasswordContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Change password" ) %>
    </h2>
    <p>
        <%= Html.Encode("Use the following form to change the password")%>
    </p>
    <p>
        <%= Html.Encode("The new password must have a minumum of ") + Html.Encode(ViewData["PasswordLength"]) + Html.Encode(" characters") %>
    </p>
    <%= Html.ValidationSummary("Change failed. Please try again.")%>
    <% using( Html.BeginForm( ) )
       { %>
    <div>
        <fieldset>
            <legend>
                <%= Html.Encode("Account information") %></legend>
            <p>
                <label for="currentPassword">
                    <%= Html.Encode("Current password:") %></label>
                <%= Html.Password("currentPassword") %>
                <%= Html.ValidationMessage("currentPassword") %>
            </p>
            <p>
                <label for="newPassword">
                    <%= Html.Encode("New password:") %></label>
                <%= Html.Password("newPassword") %>
                <%= Html.ValidationMessage("newPassword") %>
            </p>
            <p>
                <label for="confirmPassword">
                    <%= Html.Encode("Confirm new password:") %></label>
                <%= Html.Password("confirmPassword") %>
                <%= Html.ValidationMessage("confirmPassword") %>
            </p>
            <p>
                <input type="submit" value="<%= Html.Encode("Change password") %>" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>
