<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<SetupTeaser>" %>

<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/',
            FilterTypesByPeriodAndSportForTeasers: '<%= Url.Action("FilterTypesByPeriodAndSportForTeasers", "SetupTeaser") %>/'
        }
        
        $(function() {
            $('#setupTeasersTabs').tabs()

            $('#SetupTeaser_PickItems').focus();

            $('#SportId').cascade({
                source: ControllerActions.FilterDivisionsBySport,
                cascaded: "DivisionId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $('#PeriodId').cascade({
                source: ControllerActions.FilterTypesByPeriodAndSportForTeasers,
                cascaded: "BetTypeId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones",
                extraParams: { SportId: function() { return $('#SportId').val(); } }
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <% htmlNamePrefix = "SetupTeaser"; %>
    Teasers- Creando Teasers
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Creando Teasers</h2>
    <%= Html.ValidationSummary("Creación fallida. Por favor corrija los errores e intente de nuevo.") %>
    <div id="setupTeasersTabs">
        <ul>
            <li><a href="#create-form">Crear Teaser</a></li>
            <li><a href="#recent">Creados Recientes</a></li>
        </ul>
        <div id="create-form">
            <% using( Html.BeginForm( ) )
               {%>
            <fieldset>
                <legend>Campos</legend>
                <p>
                    <%= this.Select( "SportId" ).Options((Dictionary<string, string>)ViewData["Sports"]).Label("Deporte:").FirstOption("Selecciona uno") %>
                </p>
                <p>
                    <%= this.Select( "DivisionId" ).Options((Dictionary<string, string>)ViewData["Divisions"]).Label("División:") %>
                    <%= this.ValidationMessage( C => C.Division ) %>
                </p>
                <p>
                    <%= this.Select( "PeriodId" ).Options((Dictionary<string, string>)ViewData["Periods"]).Label("Periodos:").FirstOption("Selecciona uno") %>
                </p>
                <p>
                    <%= this.Select( "BetTypeId" ).Options((Dictionary<string, string>)ViewData["BetTypes"]).Label("Tipo de apuesta:") %>
                    <%= this.ValidationMessage( C => C.BetType ) %>
                </p>
                <p>
                    <%= this.TextBox( C => C.PickItems ).Label("Teaser pick:") %>
                    <%= this.ValidationMessage( C => C.PickItems )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.Points ).Label("Puntos a dar:") %>
                    <%= this.ValidationMessage( C => C.Points )%>
                </p>
                <p>
                    <input type="submit" value="Crear" />
                </p>
            </fieldset>
            <% } %>
        </div>
        <div id="recent">
            <%= Html.Grid( ( List<SetupTeaser> ) ViewData [ "LastInserted" ] ).Columns( column =>
           {
               column.For( C => C.Division.Sport.Name ).Named( "Deporte" );
               column.For( C => C.Division.Name ).Named( "División" );
               column.For( C => C.BetType.Period.Name ).Named( "Periodo" );
               column.For( C => C.BetType.Name ).Named( "Tipo de apuesta" );
               column.For( C => C.PickItems ).Named( "Teaser pick" );
               column.For( C => C.Points ).Named( "Puntos a dar" );
           }).Attributes( @class => "dataTable")
            %>
        </div>
    </div>
    <%= Html.ClientSideValidation<SetupTeaser>( htmlNamePrefix )%>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
