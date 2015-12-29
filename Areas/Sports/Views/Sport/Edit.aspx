<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Sport>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script type="text/javascript">
        var ControllerActions = {
            BetTypePeriods: '<%= Url.Action("GetBetTypePeriods", "BetTypePeriod") %>/'
        }
    </script>

    <script type="text/javascript" src="/Content/js/sport.edit.js"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Deportes
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <% HtmlNamePrefix = "Sport"; %>
        Editar Deporte
    </h2>
    <%= Html.ValidationSummary("Edición fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <%= this.Hidden(c => c.Status) %>
        <p>
            <%= this.TextBox(c => c.Name).Label("Nombre") %>
            <%= this.ValidationMessage(c => c.Name) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Maximum).Label("Maximo") %>
            <%= this.ValidationMessage(c => c.Maximum) %>
        </p>
        <p>
            <%= this.TextBox(c => c.Periods).Label("Periodos") %>
            <%= this.ValidationMessage(c => c.Periods) %>
        </p>
        <p>
            <label for="GoalType">
                <%= Html.Encode("Tipo de anotación:")%></label>
            <%= Html.DropDownList("GoalTypeId") %>
            <%= Html.ValidationMessage("GoalTypeId", "*") %>
        </p>
        <p>
            <label for="DefaultBetType">
                <%= Html.Encode("Anotación por defecto juego:")%></label>
            <%= Html.DropDownList("DefaultBetTypeId") %>
            <%= Html.ValidationMessage("DefaultBetTypeId", "*")%>
        </p>
        <p>
            <label for="DefaultBetTypeForTotals">
                <%= Html.Encode("Anotación por defecto totales:")%></label>
            <%= Html.DropDownList("DefaultBetTypeForTotalsId") %>
            <%= Html.ValidationMessage("DefaultBetTypeForTotalsId", "*")%>
        </p>
        <p>
            <%= this.TextBox(c => c.StartCode).Label("Código Inicial") %>
            <%= this.ValidationMessage(c => c.StartCode) %>
        </p>
        <p>
            <%= this.TextBox(c => c.FinalCode).Label("Código Final") %>
            <%= this.ValidationMessage(c => c.FinalCode) %>
        </p>
        <p>
            <%= this.TextBox(c => c.SubstituteForPicking).Label("Sustituto para pickings") %>
            <%= this.ValidationMessage(c => c.SubstituteForPicking) %>
        </p>
         <p>
            <%= this.CheckBox(c => c.AllowsTeasers).Label("Permitir teasers") %>
            <%= this.ValidationMessage( c => c.AllowsTeasers )%>
        </p>
        <p>
            <%= this.CheckBox( c => c.CalcPointsFromTable ).Label( "Usar tabla de calculo de totales" )%>
            <%= this.ValidationMessage( c => c.CalcPointsFromTable )%>
        </p>
        <br />
        <h3>
            Apuestas habilitadas</h3>
        <p>
            <%= this.Select( "period-select" )
            .Options( ( ( List<BetTypePeriod> ) ViewData [ "BetTypePeriods" ] )
            .ToDictionary( c => c.Id, c => c.Name ) ).Label( "Ver periodo:" )%>
        </p>
        <br />
        <div id="BetTypeTabs">
            <% foreach( BetTypePeriod period in ( List<BetTypePeriod> ) ViewData [ "BetTypePeriods" ] )
               {%>
            <div id="BetTypeTabs_<%= period.Frequency %>_<%= period.PeriodIndex %>_<%= period.Id %>">
                <p>
                    <a class="checkBetTypes">Seleccionar todos</a>/ <a class="uncheckBetTypes">Deseleccionar
                        todos</a>
                </p>
                <br />
                <h4>
                    A Juego:</h4>
                <% foreach( BetType type in ( ( List<BetType> ) ViewData [ "BetTypes" ] )
               .Where( BT => BT.Period.Name.Equals( period.Name ) && !BT.AppliestoTotals ).OrderBy( type => type.Name ).ToList( ) )
                   {%>
                <p>
                    <input type="checkbox" <%= ( ( IEnumerable<Int32> ) ViewData [ "SelectedBetTypes" ] ).Any( selectedType => selectedType.Equals( type.Id )  )? "checked=\"checked\"":"" %>
                        value="<%=type.Id%>" name="EnabledBetTypes">
                        <%=type.Name%></input>
                </p>
                <%} %>
                <h4>
                    A Totales:</h4>
                <% foreach( BetType type in ( ( List<BetType> ) ViewData [ "BetTypes" ] )
               .Where( BT => BT.Period.Name.Equals( period.Name ) && BT.AppliestoTotals ).OrderBy( type => type.Name ).ToList( ) )
                   {%>
                <p>
                    <input type="checkbox" <%= ( ( IEnumerable<Int32> ) ViewData [ "SelectedBetTypes" ] ).Any( selectedType => selectedType.Equals( type.Id )  )? "checked=\"checked\"":"" %>
                        value="<%=type.Id%>" name="EnabledBetTypes">
                        <%=type.Name%></input>
                </p>
                <%} %>
                <br />
                <p>
                    <a class="checkBetTypes">Seleccionar todos</a>/ <a class="uncheckBetTypes">Deseleccionar
                        todos</a>
                </p>
            </div>
            <%} %>
        </div>
        <br />
        <p>
            <input type="submit" value="Guardar" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Sport>( HtmlNamePrefix ) %>
        <%= Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
