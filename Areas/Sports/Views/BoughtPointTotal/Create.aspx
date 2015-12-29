<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<BoughtPointTotal>" %>

<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.cascadingddl.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/'
        }
        
        $(function() {
            $('#boughtPointsTabs').tabs()

            $('#BoughtPointTotal_BoughtPoints').focus();

            $('#SportCode').cascadingDdl({
                source: ControllerActions.FilterDivisionsBySport,
                cascaded: "DivisionCode",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <% this.htmlNamePrefix = "BoughtPointTotal"; %>
    Compra de Puntos - Creando Compra de Puntos para Totales
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Creando Compra de Puntos para Totales</h2>
    <%= Html.ValidationSummary("Creación fallida. Por favor corrija los errores e intente de nuevo.") %>
    <div id="boughtPointsTabs">
        <ul>
            <li><a href="#create-form">Crear Compra de Puntos</a></li>
            <li><a href="#recent">Creados Recientes</a></li>
        </ul>
        <div id="create-form">
            <% using( Html.BeginForm( ) )
               {%>
            <fieldset>
                <legend>Campos</legend>
                <p>
                    <%= this.Select( "SportCode" ).Options((Dictionary<string, string>)ViewData["Sports"]).Label("Deporte:").FirstOption("Selecciona uno") %>
                    <%= this.ValidationMessage( C => C.Division ) %>
                </p>
                <p>
                    <%= this.Select( "DivisionCode" ).Options((Dictionary<string, string>)ViewData["Divisions"]).Label("División:") %>
                </p>
                <p>
                    <%= this.TextBox(C => C.BoughtPoints).Label("Puntos comprados:") %>
                    <%= this.ValidationMessage(C => C.BoughtPoints) %>
                </p>
                <p>
                    <%= this.TextBox( C => C.UnderTop ).Label("Desde carreraje:") %>
                    <%= this.ValidationMessage( C => C.UnderTop )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.UpperTop ).Label( "Hasta carreraje:" )%>
                    <%= this.ValidationMessage( C => C.UpperTop )%>
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
                    <input type="submit" value="Crear" />
                </p>
            </fieldset>
            <% } %>
        </div>
        <div id="recent">
            <%= Html.Grid( ( List<BoughtPointTotal> ) ViewData [ "LastInserted" ] ).Columns( column =>
           {
               column.For( C => C.Division.Sport.Name ).Named( "Deporte" );
               column.For( C => C.Division.Name ).Named( "División" );
               column.For( C => C.UnderTop ).Named( "Desde carreraje" );
               column.For( C => C.UpperTop ).Named( "Hasta carreraje" );
               column.For( C => C.Male ).Named( "Precio macho" );
               column.For( C => C.Female ).Named( "Precio hembra" );
           }).Attributes( @class => "dataTable")
            %>
        </div>
    </div>
    <%= Html.ClientSideValidation<BoughtPointTotal>( this.htmlNamePrefix )%>
    <br/>
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
