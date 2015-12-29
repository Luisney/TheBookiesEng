<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.ViewModels.BetTypeViewModel>" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/tipsy.css" rel="stylesheet" type="text/css" />

    <script src="/Content/js/jquery.tipsy.js" type="text/javascript"></script>

    <script src="/Content/js/jqtooltip.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Tipos de Apuesta - Crear Tipo de Apuesta
    <%
        HtmlNamePrefix = "BetTypeViewModel";
    %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Creando tipo de apuesta</h2>
    <%= Html.ValidationSummary("Creación fallida. Por favor corrija los errores e intente de nuevo.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <%= this.TextBox(C => C.Name).Label("Nombre:") %>
            <%= this.ValidationMessage(C => C.Name) %>
        </p>
        <p>
            <%= this.Select(c => c.ParentBetTypeId).Options(Model.BetTypesList).FirstOption("Ninguna").Label("Tipo Base:") %>
        </p>
        <p>
            <%= this.TextBox(C => C.DisplayName).Label("Nombre mostrado:") %>
            <%= this.ValidationMessage(c => c.DisplayName) %>
        </p>
        <p>
            <%= this.TextBox( C => C.Shortcut ).Label("Nombre corto:") %>
            <%= this.ValidationMessage( C => C.Shortcut )%>
        </p>
        <p>
            <%= this.TextBox( C => C.POSCode ).Label( "Código en la terminal:" )%>
            <%= this.ValidationMessage( C => C.POSCode )%>
        </p>
        <p>
            <%= this.TextBox(c => c.Maximum).Label("Monto maximo permitido para apuestas:") %>
            <%= this.ValidationMessage(c => c.Maximum) %>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseIndividualScore ).Label( "Puntaje/Carreraje por equipo/jugador:" ).Attr( "title", "Activar si la apuesta requiere un puntaje/carreraje para cada equipo/jugador" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseIndividualSpread ).Label( "Gavelas por equipo/jugador:" ).Attr( "title", "Activar si la apuesta requiere una gavela para cada equipo/jugador" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseIndividualPrice ).Label( "Precios por equipo/jugador:" ).Attr( "title", "Activar si la apuesta requiere un precio para cada equipo/jugador" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseIndividualPriceOver ).Label( "Precios 'a más de' por equipo/jugador:" ).Attr( "title", "Activar si la apuesta requiere un precio 'a más de' para cada equipo/jugador" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseIndividualPriceUnder ).Label( "Precios 'a menos de' por equipo/jugador:" ).Attr( "title", "Activar si la apuesta requiere un precio 'a menos de' para cada equipo/jugador" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseGlobalScore ).Label( "Puntaje/Carreraje combinado:" ).Attr( "title", "Activar si la apuesta requiere un puntaje/carreraje combinado" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseGlobalPriceOver ).Label( "Precio 'a más de' combinado:" ).Attr( "title", "Activar si la apuesta requiere un precio 'a más de' combinado" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseGlobalPriceUnder ).Label( "Precio 'a menos de' combinado:" ).Attr( "title", "Activar si la apuesta requiere un precio 'a menos de' combinado" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UsePropositionPrice ).Label( "Precio unico:" ).Attr( "title", "Activar para apuestas proposición como 'Si anotaran' ó 'No anotaran'" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <br />
        <p>
            <%= this.RadioButton( c => c.EntityType ).Value( Enumerations.EntityType.Team ).Checked( Model.EntityType.Equals(Enumerations.EntityType.Team ) ).Label( "Equipo:" ).Attr( "title", "Elegir si la apuesta aplica a un equipo" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.RadioButton( c => c.EntityType ).Value( Enumerations.EntityType.Player ).Checked( Model.EntityType.Equals(Enumerations.EntityType.Player ) ).Label( "Jugador:" ).Attr( "title", "Activar si la apuesta aplica a un jugador" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <br />
        <%
            if( Model.PlayerTypesList.Count( ) > 0 )
            {
        %>
        <legend>Tipos de jugador asociados</legend>
        <%
            }

            foreach( var type in Model.PlayerTypesList )
            { %>
        <p>
            <label>
                <%=type.Value%></label>
            <input type="checkbox" <%= ( Model.SelectedPlayerTypes ?? new List<int>() ).Any( selectedType => Convert.ToInt32( type.Key ) == selectedType)? "checked=\"checked\"":"" %>
                value="<%=type.Key%>" class="jqtooltipWE" title="<%= "Activar si la apuesta esta activada para jugadores de tipo: " + type.Value %>"
                name="<%= "SelectedPlayerTypes" %>"></input>
        </p>
        <%} %>
        <br />
        <legend>Opcionales</legend>
        <p>
            <%= this.CheckBox( c => c.Teasers ).Label( "Teasers:" ).Attr( "title", "Activar si la apuesta esta activada para teasers" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( c => c.BoughtPoints ).Label( "Compra de puntos:" ).Attr( "title", "Activar si la compra de puntos está activada para la apuesta" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( c => c.AppliesToTotals ).Label( "Aplica a totales:" ).Attr( "title", "Activar si la apuesta aplica a totales -desactivar si pertenece a juego-" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.CheckBox( c => c.IsStandard ).Label( "Apuesta estandar:" ).Attr( "title", "Desactivar cuando la apuesta sea una apuesta no clásica. y requiera ser tratada en una sección propia en la linea. ej: apuestas proposición" ).Attr( "class", "jqtooltipWE" )%>
        </p>
        <p>
            <%= this.TextBox( c => c.DisplayOrder ).Label( "Orden en pantalla:" ).Attr( "title", "Ingresar un valor entre 1 y 100 para determinar en que orden se mostraran las apuestas (1 tiene más prioridad que 100)" ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( c => c.DisplayOrder )%>
        </p>
        <fieldset>
            <legend>Comportamiento</legend>
            <p>
                <%= this.Select(c => c.PeriodCode).Options(Model.PeriodsList).Label("Periodo:") %>
                <%= this.ValidationMessage( c => c.PeriodCode )%>
            </p>
            <p>
                <%= this.Select( C => C.CalcBaseScore).Options( Model.BaseScoreList ).Label( "Puntaje base:" ) %>
                <%= this.ValidationMessage( C => C.CalcBaseScore )%>
            </p>
            <p>
                <%= this.CheckBox( C => C.CalcBaseScoreBetModifier ).Label( "Añadir puntos:" ).Attr( "title", "Activar para añadir puntos del ticket al puntaje" ).Attr( "class", "jqtooltipWE" )%>
            </p>
            <p>
                <%= this.CheckBox( C => C.CalcBaseScoreOverScore ).Label( "Añadir gavela:" ).Attr( "title", "Activar para añadir gavela al puntaje" ).Attr( "class", "jqtooltipWE" )%>
            </p>
            <p>
                <%= this.Select( C => C.CalcOperator ).Options( Model.BetTypeOperatorList ).Label("Operador:") %>
                <%= this.ValidationMessage( C => C.CalcOperator )%>
            </p>
            <p>
                <%= this.Select( C => C.CalcTargetScore ).Options( Model.TargetScoreList ).Label("Puntaje contrario:") %>
                <%= this.ValidationMessage( C => C.CalcTargetScore )%>
            </p>
        </fieldset>
        <p>
            <input type="submit" value="Crear" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Gambling.Models.BetType>( HtmlNamePrefix )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
