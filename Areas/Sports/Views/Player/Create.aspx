<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Player>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/uploadify.css" />
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/token-input.css" />

    <script type="text/javascript" src="/Content/js/swfobject.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.uploadify.v2.1.0.min.js"></script>

    <script type="text/javascript" src="/Content/js/utils.upload.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.tokeninput.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>
    
    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>

    <script type="text/javascript">
        var ControllerActions = {
            GetTeamsBySport: '<%= Url.Action("GetTeamsBySport", "Team") %>/'
        }
        
        $( function() {
            $('#playerTabs').tabs()

            InitUploadUtil('#fileInput', '#LogoURL', '#logo-img');

            $('#teams-token').tokenInput(ControllerActions.GetTeamsBySport, {
                hintText: "Escribe el nombre del equipo",
                noResultsText: "No se encontro ningun equipo, confirma que no has seleccionado otro equipo para esta division",
                searchingText: "Buscando...",
                //prePopulate: <%= ViewData["TeamsList"] ?? "[]" %>,
                // Amazingly ugly hack
                extraParams: { DivisionCode: function() { return $('#DivisionId').val() }, TeamCodes: function() { return $('#teams-token').val() } }
            });

            $('#Name').focus();
        });

    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Jugadores - Crear Jugador
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Crear Jugador
    </h2>
    <%= Html.ValidationSummary("Creación no exitosa. Por favor corrije los errores e intenta de nuevo.") %>
    <div id="playerTabs">
        <ul>
            <li><a href="#create-form">Crear Jugador</a></li>
            <li><a href="#recent">Creados Recientes</a></li>
        </ul>
        <div id="create-form">
            <% using( Html.BeginForm( ) )
               {%>
            <fieldset>
                <legend>Campos</legend>
                <p>
                    <label for="Name">
                        Nombre:
                    </label>
                    <%= Html.TextBox("Name") %>
                    <%= Html.ValidationMessage("Name", "*") %>
                </p>
                <p>
                    <label for="DisplayName">
                        Nombre mostrado:
                    </label>
                    <%= Html.TextBox("DisplayName") %>
                    <%= Html.ValidationMessage("DisplayName", "*") %>
                </p>
                <p>
                    <label for="PrintName">
                        Nombre impreso:
                    </label>
                    <%= Html.TextBox("PrintName") %>
                    <%= Html.ValidationMessage("PrintName", "*") %>
                </p>
                <p>
                    <label for="PlayerType">
                        <%= Html.Encode("Tipo de jugador:")%>
                    </label>
                    <%= Html.DropDownList("PlayerTypeId") %>
                    <%= Html.ValidationMessage("PlayerTypeId", "*")%>
                </p>
                <p>
                    <label for="uploadify">
                        Logo:</label>
                    <%= Html.Hidden("LogoURL") %>
                    <img width="65" height="90" alt="Logo del jugador" src="/Content/images/no-image.jpg"
                        id="logo-img" />
                    <br />
                    <input id="fileInput" name="fileInput" type="file" />
                </p>
                <div id="fileQueue">
                </div>
                <p>
                    <label for="DivisionId">
                        <%= Html.Encode("Filtrar por deporte:")%>
                    </label>
                    <%= Html.DropDownList("DivisionId") %>
                    <%= Html.ValidationMessage("DivisionId", "*")%>
                </p>
                <p>
                    <label for="teams-token">
                        Equipos:</label>
                    <%= Html.TextBox("teams-token") %>
                </p>
                <p>
                    <input type="submit" value="Crear" />
                </p>
            </fieldset>
            <% } %>
        </div>
        <div id="recent">
            <%= Html.Grid( ( List<Player> ) ViewData [ "LastInserted" ] ).Columns( column =>
           {
               column.For( C => C.Id ).Named( "Id" );
               column.For( C => C.Name ).Named( "Nombre" );
               column.For( C => C.PlayerType.Type ).Named( "Tipo de jugador" );
               column.For( C => C.Teams.Select( T => T.Name ).ToHtmlString() ).DoNotEncode().Named( "Equipos" );
           }).Attributes(@class => "dataTable")
            %>
        </div>
    </div>
    <br/>
    <div>
        <%= Html.ClientSideValidation<Player>( )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
