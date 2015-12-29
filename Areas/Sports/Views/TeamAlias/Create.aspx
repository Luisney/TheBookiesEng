<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.TeamAlias>" %>

<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.cascadingddl.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterTeamsBySport: '<%= Url.Action("FilterTeamsBySport", "Team") %>/'
        }

        $(document).ready(function() {
            $('#SportCode').cascadingDdl({
                source: ControllerActions.FilterTeamsBySport,
                cascaded: "TeamCode",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $('#tabs').tabs()
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%
        this.HtmlNamePrefix = "TeamAlias"; %>
    Creando Alias
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Creando Alias</h2>
    <%= Html.ValidationSummary("Creación fallida. Por favor corrije los errores e intenta de nuevo.") %>
    <div id="tabs">
        <ul>
            <li><a href="#create-form">Crear Equipo</a></li>
            <li><a href="#recent-teams">Creados recientes</a></li>
        </ul>
        <div id="create-form">
            <% using( Html.BeginForm( ) )
               {%>
            <fieldset>
                <legend>Campos</legend>
                <p>
                    <%= this.Select("SportCode").Options((Dictionary<string, string>)ViewData["Sports"]).FirstOption("-1", "Selecciona un deporte").Label("Deporte:")%>
                </p>
                <p>
                    <%= this.Select( "TeamCode" ).Options( ( Dictionary<string, string> ) ViewData [ "Teams" ] ).Label( "Equipo:" )%>
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
                    <input type="submit" value="Crear" />
                </p>
            </fieldset>
        </div>
        <% } %>
        <div id="recent-teams">
            <%= Html.Grid( ( List<TeamAlias> ) ViewData [ "RecentTeamAliases" ] ).Columns( column =>
           {
               column.For( C => C.Code ).Named( "Código" );
               column.For( C => C.PrintName ).Named( "Nombre impreso" );
               column.For( C => C.Team.Name ).Named( "Equipo" );
               column.For( C => C.Team.Division.Name ).Named( "División" );
               column.For( C => C.Team.Sport.Name ).Named( "Deporte" );               
           }).Attributes(@class => "dataTable")
            %>
        </div>
    </div>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TeamAlias>( this.HtmlNamePrefix )%>
</asp:Content>
