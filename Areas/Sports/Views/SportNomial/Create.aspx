<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.ViewModels.SportNomialViewModel>" %>

<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ContentPlaceHolderID="Assets" ID="Content3" runat="server">

    <script type="text/javascript">
        var ControllerActions = {
            FilterDivisionsBySport: '<%= Url.Action("GetDivisionsBySport", "Division") %>/'
        }
    </script>

    <script type="text/javascript" src="/Content/js/sportnomial.create.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>

    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>

    <script src="/Content/js/latest-inserted-toogling.js" type="text/javascript" language="javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%
        this.HtmlNamePrefix = "SportNomialViewModel"; %>
    Precios - Crear Precio
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Creando Precios</h2>
    <%= Html.ValidationSummary("Creación fallida. por favor corrije los errores e intente de nuevo") %>
    <div id="sportNomialTabs">
        <ul>
            <li><a href="#create-form">Crear Precios</a></li>
            <li><a href="#recent">Creados Recientes</a></li>
        </ul>
        <div id="create-form">
            <% using( Html.BeginForm( ) )
               {%>
            <fieldset>
                <legend>Campos</legend>
                <p>
                    <%= this.Select( C => C.SportCode ).Options(Model.Sports).Label("Deporte:") %>
                    <%= Html.ValidationMessage( "Sport" )%>
                </p>
                <p>
                    <%= this.Select( C => C.DivisionCode ).Options(Model.Divisions).Label("Division:") %>
                    <%= Html.ValidationMessage( "Division" )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.Male ).Label("Macho:") %>
                    <%= this.ValidationMessage( C => C.Male ) %>
                </p>
                <p>
                    <%= this.TextBox( C => C.Female ).Label("Hembra:") %>
                    <%= this.ValidationMessage( C => C.Female )%>
                </p>
                <p>
                    <input type="submit" value="Guardar" />
                </p>
            </fieldset>
            <% } %>
        </div>
        <div id="recent">
            <fieldset id="latestInsertedDataTable">
                <%= Html.Grid( ViewData.Model.LatestInserted ).Attributes( @class => "dataTable" + ( ( Model.LatestInserted.Count > 0 ) ? "" : " empty" ) ).Empty( "No se encontro ningun registro" ).Columns( column =>
                                                                    {
                                                                        column.For( c => ( c.Division != null )? c.Division.Name: "Todas" ).Named( "División" );
                                                                        column.For( c => String.Format( "{0:+#;-#;0}", c.Male ) ).Named( "Macho" );
                                                                        column.For( c => String.Format( "{0:+#;-#;0}", c.Female ) ).Named( "Hembra" );
                                                                    } )%>
            </fieldset>
            <%= Html.ClientSideValidation<SportNomial>( this.htmlNamePrefix )%>
        </div>
        <div>
            <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
        </div>
</asp:Content>
