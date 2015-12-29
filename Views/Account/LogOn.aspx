<%@ Page Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Login
</asp:Content>
<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Login
    </h2>
    <p>
        <%= Html.Encode("Login using your username and password. ") %>
    </p>
    <%= Html.ValidationSummary("Login Failed. Please try again.") %>
    <% using( Html.BeginForm( ) )
       { %>
    <div>
        <fieldset>
            <legend>
                <%= Html.Encode("Account information") %></legend>
            <p>
                <label for="username">
                    User:</label>
                <%= Html.TextBox("username") %>
                <%= Html.ValidationMessage("username") %>
            </p>
            <p>
                <label for="password">
                    <%= Html.Encode( "Password:" ) %></label>
                <%= Html.Password("password") %>
                <%= Html.ValidationMessage("password") %>
            </p>
            <p>
                <%= Html.CheckBox("rememberMe") %>
                <label class="inline" for="rememberMe">
                    Remember me</label>
            </p>
            <p>
                <input type="submit" value="Login" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>
