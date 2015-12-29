<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.TeamAlias>" %>

<%@ Import Namespace="Gambling.Models" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.cascadingddl.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterTeamsBySport: '<%= Url.Action("FilterTeamsBySport", "Team") %>/'
        }
        $(document).ready(function() {
            $('#Sports').cascadingDdl({
                source: ControllerActions.FilterTeamsBySport,
                cascaded: "TeamCode",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Editando Alias
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "TeamAlias"; %>
    <h2>
        Editando Alias</h2>
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <%= this.Select("Sports").Options((Dictionary<string, string>)ViewData["Sports"]).Selected(ViewData["SportCode"]).Label("Deporte:")%>
        </p>
        <p>
            <%= this.Select( "TeamCode" ).Options( ( Dictionary<string, string> ) ViewData [ "Teams" ] ).Selected( ViewData [ "TeamCode" ] ).Label( "Equipo:" )%>
        </p>
        <p>
            <%= this.TextBox( C => C.DisplayName ).Label( "Nombre mostrado:" )%>
            <%= this.ValidationMessage( C => C.DisplayName )%>
        </p>
        <p>
            <%= this.TextBox( C => C.PrintName ).Label( "Nombre impreso:" )%>
            <%= this.ValidationMessage( C => C.PrintName )%>
        </p>
        <p>
            <input type="submit" value="Guardar" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TeamAlias>( this.htmlNamePrefix )%>
</asp:Content>
