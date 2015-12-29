<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<CompanyViewModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Company - Create Company" )%>
    <%
        this.htmlNamePrefix = "company"; %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Create company" )%>
    </h2>
    <%= Html.ValidationSummary("Creation failed. Please try again.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <%= this.TextBox(c => c.Name).Label("Name:") %>
            <%= this.ValidationMessage(c => c.Name) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Address).Label("Address:") %>
            <%= this.ValidationMessage(c => c.Address) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Phone).Label("Phone") %>
            <%= this.ValidationMessage(c => c.Phone) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Email).Label("Email:") %>
            <%= this.ValidationMessage(c => c.Email) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Rnc).Label("RNC:") %>
            <%= this.ValidationMessage(c => c.Rnc) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Manager).Label("Manager:") %>
            <%= this.ValidationMessage(c => c.Manager) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Ceo).Label("President:") %>
            <%= this.ValidationMessage(c => c.Ceo) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Maximum).Label("Maximum sports sales:") %>
            <%= this.ValidationMessage(c => c.Maximum) %>
        </p>
        <p>
            <%= this.TextBox(c => c.LottoMaximum).Label("Maximum lottery sales:") %>
            <%= this.ValidationMessage( c => c.LottoMaximum )%>
        </p>
        <p>
            <%= this.TextBox(c => c.Surplus).Label("Maximum surplus sales:") %>
            <%= this.ValidationMessage(c => c.Surplus) %>
        </p>
        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>
    <%= Html.ClientSideValidation<Company>( this.htmlNamePrefix )%>
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
