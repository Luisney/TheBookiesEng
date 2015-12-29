<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<BoughtPointGame>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.cascadingddl.js" type="text/javascript"></script>

    <script src="/Content/js/boughtpoint.edit.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var ControllerActions = {
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/'
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <% HtmlNamePrefix = "BoughtPointGame"; %>
    Compra de Puntos - Editando Compra de Puntos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editando Compra de Puntos para Juego</h2>
    <%= Html.ValidationSummary("Edición fallida. Por favor corrija los errores e intente de nuevo.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <%= this.Hidden( C => C.Id ) %>
        <%= this.Hidden( B => B.Status ) %>
        <p>
            <%= this.Select("SportCode").Options((Dictionary<string, string>)ViewData["Sports"]).Label("Deporte:").FirstOption("Selecciona uno") %>
            <%= this.ValidationMessage(C => C.Division) %>
        </p>
        <p>
            <%= this.Select("DivisionCode").Options((Dictionary<string, string>)ViewData["Divisions"]).Label("División:") %>
        </p>
        <p>
            <%= this.TextBox(C => C.BoughtPoints).Label("Puntos comprados:") %>
            <%= this.ValidationMessage(C => C.BoughtPoints) %>
        </p>
        <p>
            <%= this.TextBox( C => C.InitialSpread ).Label("Desde gavela:") %>
            <%= this.ValidationMessage( C => C.InitialSpread )%>
        </p>
        <p>
            <%= this.TextBox( C => C.FinalSpread ).Label( "Hasta gavela:" )%>
            <%= this.ValidationMessage( C => C.FinalSpread )%>
        </p>
        <p>
            <%= this.TextBox(C => C.Male).Label("Precio macho:") %>
            <%= this.ValidationMessage(C => C.Male) %>
        </p>
        <p>
            <%= this.TextBox(C => C.Female).Label("Precio hembra:") %>
            <%= this.ValidationMessage(C => C.Female) %>
        </p>
        <p>
            <input type="submit" value="Guardar" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<BoughtPointGame>( HtmlNamePrefix )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
