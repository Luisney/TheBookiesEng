<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<DefinedGamePointViewModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <% HtmlNamePrefix = "DefinedGamePoint"; %>
    Totales por Periodo - Crear Totales por Periodo
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>
    
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $('#defineGamePointsTabs').tabs()
            $('#DefinedGamePoint_BasePoints').focus();

            $('#SportsSelect').cascade({
                source: '/Sports/Division/FilterDivisionsBySport',
                cascaded: "DefinedGamePoint_DivisionId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Crear totales por periodo</h2>
    <%= Html.ValidationSummary("Creación fallida. Por favor corrija los errores e intente de nuevo.") %>
    <div id="defineGamePointsTabs">
        <ul>
            <li><a href="#create-form">Crear Compra de Puntos</a></li>
            <li><a href="#recent">Creados Recientes</a></li>
        </ul>
        <div id="create-form">
            <% using( Html.BeginForm( ) )
               {%>
            <fieldset>
                <legend>Para estos valores en período Completo</legend>
                <p>
                    <%= this.TextBox( C => C.BasePoints ).Label( "Puntos base:" )%>
                    <%= this.ValidationMessage( C => C.BasePoints )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.BasePrice ).Label( "Precio base:" )%>
                    <%= this.ValidationMessage( C => C.BasePrice )%>
                </p>
                <p>
                    <%= this.Select( "DefinedGamePoint.Type" ).Options( ( Dictionary<string, string> ) ViewData [ "DefineGamePointTypes" ] ).Label( "Tipo:" )%>
                </p>
            </fieldset>
            
            <fieldset>
                <legend>Convertir para este período</legend>
                
                <p>
                    <%= this.Select( "DefinedGamePoint.BetTypePeriodId" ).Options( ( Dictionary<string, string> ) ViewData [ "Periods" ] ).Label( "Periodo a convertir:" )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.PointsTotal ).Label( "Puntos convertidos:" )%>
                    <%= this.ValidationMessage( C => C.PointsTotal )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.PriceOver ).Label( "Precio a más de:" )%>
                    <%= this.ValidationMessage( C => C.PriceOver )%>
                </p>
                <p>
                    <%= this.TextBox( C => C.PriceUnder ).Label( "Precio a menos de:" )%>
                    <%= this.ValidationMessage( C => C.PriceUnder )%>
                </p>
                
            </fieldset>
            
            <fieldset>
                <legend>Para esta división</legend>
                
                <p>
                    <%= this.Select("SportsSelect").Options((Dictionary<int, string>)ViewData["SportsList"]).Label("Deporte:").FirstOption("Selecciona uno") %>
                </p>
                
                <p>
                    <%= this.Select("DefinedGamePoint.DivisionId").Label("División:") %>
                </p>
                
            </fieldset>
            
            <p>
                <input type="submit" value="Crear" />
            </p>
            
            <% } %>
        </div>
        <div id="recent">
            <%= Html.Grid( ( List<DefinedGamePoint> ) ViewData [ "LastInserted" ] ).Columns( column =>
           {
               column.For( C => C.BetTypePeriod.Name ).Named( "Periodo" );
               column.For( C => C.BasePoints ).Named( "Carreraje base" );
               column.For( C => C.BasePrice ).Named( "Precio base" );
               column.For( C => Constants.GetPointDirectionDescription( C.Type ) ).Named( "Tipo" );
               column.For( C => C.PointsTotal ).Named( "Puntos a convertir" );
               column.For( C => C.PriceOver ).Named( "Precio Over" );
               column.For( C => C.PriceUnder ).Named( "Precio Under" );

           }).Attributes( @class => "dataTable")
            %>
        </div>
    </div>
    <div>
        <%= Html.ClientSideValidation<DefinedGamePoint>( HtmlNamePrefix )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
