<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<GamblerViewModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gamblers - Edit Gambler
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editing better:
        <%= Html.Encode(Model.Name)%></h2>
    <%= Html.ValidationSummary("Edit failed. Please try again.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Fields</legend>
        <p>
            <%= this.TextBox( c => c.Name ).Disabled( true ).Label("Name:") %>
            <%= this.Hidden( c => c.Name )%>
            <%= this.ValidationMessage(c => c.Name) %>
            <%= this.Hidden( c=>c.Status ) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Address).Label("Address:") %>
            <%= this.ValidationMessage(c => c.Address) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Phone).Label("Phone:") %>
            <%= this.ValidationMessage(c => c.Phone) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Email).Label("Email:") %>
            <%= this.ValidationMessage(c => c.Email) %>
        </p>
        <p>
            <%= this.TextBox(c => c.DocumentId).Label("ID:") %>
            <%= this.ValidationMessage(c => c.DocumentId) %>
        </p>
        <p>
            <label>
                DOB:</label>
            <%= this.Select(c=>c.BirthDay).Options(Model.DaysList) %>
            <%= this.Select(c=>c.BirthMonth).Options(Model.MonthsList) %>
            <%= this.Select(c=>c.BirthYear).Options(Model.YearsList) %>
        </p>
        <p>
            <input type="submit" value="Edit" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Gambler>() %>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
