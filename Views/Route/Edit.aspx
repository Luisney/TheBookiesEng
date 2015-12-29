<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.Route>" %>

<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Routes - Edit Routes
    <%
        HtmlNamePrefix = "RouteToEdit";
    %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Edit Route
    </h2>
    <%= Html.ValidationSummary("Edición fallida. por favor corrije los errores e intenta de nuevo.")%>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <%= this.Hidden( R => R.Id ) %>
        <%= this.Hidden( R => R.Status ) %>
        <p>
            <%= this.TextBox( R => R.Name ).Label("Name:") %>
            <%= this.ValidationMessage( R => R.Name )%>
        </p>
        <p>
            <%= this.TextBox( R => R.Person1 ).Label( "First in charge:" )%>
            <%= this.ValidationMessage( R => R.Person1 )%>
        </p>
        <p>
            <%= this.TextBox( R => R.Person2 ).Label( "Second in charge:" )%>
            <%= this.ValidationMessage( R => R.Person2 )%>
        </p>
        <p>
            <%= this.Select( "CompanyId" )
                .Options( ( SelectList ) ViewData [ "CompanyId" ] )
                .Selected( ( ( SelectList ) ViewData [ "CompanyId" ] ).SelectedValue ).Label( "Consorcio:" )%>
            <%= this.ValidationMessage( R => R.Company )%>
        </p>
        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Gambling.Models.Route>( HtmlNamePrefix ) %>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
