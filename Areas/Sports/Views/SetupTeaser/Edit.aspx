<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<SetupTeaser>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="xVal.Html" %>
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
    <% HtmlNamePrefix = "SetupTeaser"; %>
    Teasers - Editando Teaser
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editando Teaser</h2>
    <%= Html.ValidationSummary("Edición fallida. Por favor corrija los errores e intente de nuevo.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <%= this.Hidden( C => C.Id ) %>
        <%= this.Hidden( B => B.Status ) %>
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
            <input type="submit" value="Guardar" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<SetupTeaser>( HtmlNamePrefix )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
