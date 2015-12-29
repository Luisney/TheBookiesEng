<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.Player>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/uploadify.css" />
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/token-input.css" />

    <script type="text/javascript" src="/Content/js/swfobject.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.uploadify.v2.1.0.min.js"></script>

    <script type="text/javascript" src="/Content/js/utils.upload.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.tokeninput.js"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            GetTeamsBySport: '<%= Url.Action("GetTeamsBySport", "Team") %>/'
        }
        
        $(document).ready(function() {

            InitUploadUtil('#fileInput', '#LogoURL', '#logo-img');

            $('#teams-token').tokenInput(ControllerActions.GetTeamsBySport , {
                hintText: "Escribe el nombre del equipo",
                noResultsText: "No se encontro ningun equipo, confirma que no has seleccionado otro equipo para esta division",
                searchingText: "Buscando...",
                prePopulate: <%= ViewData["TeamsList"] ?? "[]" %>,
                // Amazingly ugly hack
                extraParams: { DivisionCode: function() { return $('#DivisionId').val() }, TeamCodes: function() { return $('#teams-token').val() } }
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Jugadores - Editar Jugador
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editar Jugador
    </h2>
    <%= Html.ValidationSummary("Edición fallida. Por favor corrije los errores e intenta de nuevo.") %>
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>Campos</legend>
        <%= Html.Hidden( "Id", Model.Id ) %>
        <%= Html.Hidden( "Code", Model.Code ) %>
        <%= Html.Hidden( "Status", Model.Status ) %>
        <p>
            <label for="Name">
                Nombre:
            </label>
            <%= Html.TextBox("Name", Model.Name) %>
            <%= Html.ValidationMessage("Name", "*") %>
        </p>
        <p>
            <label for="DisplayName">
                Nombre mostrado:
            </label>
            <%= Html.TextBox("DisplayName", Model.DisplayName) %>
            <%= Html.ValidationMessage("DisplayName", "*") %>
        </p>
        <p>
            <label for="PrintName">
                Nombre impreso:
            </label>
            <%= Html.TextBox("PrintName", Model.PrintName) %>
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
            <img width="65" height="90" alt="Logo <%= Model.Name %>" src="<%= Model.LogoURL %>" id="logo-img" />
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
            <input type="submit" value="Guardar" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Player>( )%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
