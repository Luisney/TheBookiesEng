<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<DefinedGamePointViewModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%  HtmlNamePrefix = "DefinedGamePoint"; %>
    Totales por Periodo - Editar Totales por Periodo
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editar totales por periodo</h2>
    <%= Html.ValidationSummary("Edición fallida. Por favor corrija los errores e intente de nuevo.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <p>Completo</p>
        <%= this.Hidden( C => C.Id ) %>
        <%= this.Hidden( C => C.Status ) %>
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
        <p>
            <%= this.Select( "DefinedGamePoint.BetTypePeriodId" ).Options( ( Dictionary<string, string> ) ViewData [ "Periods" ] ).Label( "Periodo a convertir:" )%>
        </p>
        <p>
            <%= this.TextBox( C => C.PointsTotal ).Label( "Puntos convertidos:" )%>
            <%= this.ValidationMessage( C => C.PointsTotal )%>
        </p>
        <p>
            <%= this.TextBox( C => C.PriceOver ).Label( "Precio combinado a más:" )%>
            <%= this.ValidationMessage( C => C.PriceOver )%>
        </p>
        <p>
            <%= this.TextBox( C => C.PriceUnder ).Label( "Precio combinado a menos:" )%>
            <%= this.ValidationMessage( C => C.PriceUnder )%>
        </p>
        
    </fieldset>
    
    <fieldset>
        <legend>Para esta división</legend>
        
        <p>
            <%= this.Select("SportsSelect").Options((Dictionary<int, string>)ViewData["SportsList"]).Selected(ViewData["SportId"]).Label("Deporte:").FirstOption("Selecciona uno") %>
        </p>
        
        <p>
            <%= this.Select("DefinedGamePoint.DivisionId").Options((Dictionary<int, string>)ViewData["DivisionsList"]).Selected(ViewData["DivisionId"]).Label("División:")%>
        </p>
        
    </fieldset>
    
    <p>
        <input type="submit" value="Guardar" />
    </p>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<DefinedGamePoint>( HtmlNamePrefix )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
