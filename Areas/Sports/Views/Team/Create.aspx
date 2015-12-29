<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Team>" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="Gambling.Models" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/uploadify.css" />

    <script type="text/javascript" src="/Content/js/swfobject.js"></script>
    <script type="text/javascript" src="/Content/js/jquery.uploadify.v2.1.0.min.js"></script>
    <script type="text/javascript" src="/Content/js/utils.upload.js"></script>
    <script type="text/javascript" src="/Content/js/jquery.cascade-select.0.8.js"></script>
    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>
    <script type="text/javascript">
        var ControllerActions = {
            FilterDivisionBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/'
        };

        $(document).ready(function() {
            $('#Team_Name').focus();

            InitUploadUtil('#fileInput', '#LogoURL', '#logo-img');

            $('#Team_SportId').cascade({
                source: ControllerActions.FilterDivisionBySport,
                cascaded: "Team_DivisionId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $('#tabs').tabs()

        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Equipos - Crear Equipo
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%
        if (ViewData.ContainsKey("SuccessMsg"))
        {%>
    <div>
        <%=ViewData["SuccessMsg"] %></div>
    <%} %>
    <h2>
        Crear Equipo
    </h2>
    <%= Html.ValidationSummary("Creación fallida. por favor corrije los errores e intenta de nuevo") %>
    <div id="tabs">
        <ul>
            <li><a href="#create-form">Crear Equipo</a></li>
            <li><a href="#recent-teams">Creados recientes</a></li>
        </ul>
        <div id="create-form">
            <% using (Html.BeginForm())
               {%>
            <fieldset>
                <p>
                    <input type="submit" value="Crear" />
                </p>
                <p>
                    <label for="Name">
                        Nombre:</label>
                    <%= Html.TextBox("Team.Name") %>
                    <%= Html.ValidationMessage("Team.Name") %>
                </p>
                <p>
                    <label for="DisplayName">
                        Nombre mostrado:</label>
                    <%= Html.TextBox("TeamAlias.DisplayName") %>
                    <%= Html.ValidationMessage("Team.DisplayName")%>
                </p>
                <p>
                    <label for="PrintName">
                        Nombre impreso:</label>
                    <%= Html.TextBox("TeamAlias.PrintName") %>
                    <%= Html.ValidationMessage("Team.PrintName")%>
                </p>
                <p>
                    <label for="Sport">
                        Deporte:
                    </label>
                    <%= this.Select("Team.SportId").Options((SelectList)ViewData["SportId"])
                    .FirstOption("Selecciona uno")
                    .HideFirstOptionWhen(ViewData.ContainsKey("DivisionId") && ((SelectList)ViewData["DivisionId"]).Any())%>
                    <%= Html.ValidationMessage("Team.Sport")%>
                </p>
                <p>
                    <label for="Division">
                        <%= Html.Encode("División:")%>
                    </label>
                    <%= this.Select("Team.DivisionId").Options((SelectList)ViewData["DivisionId"])%>
                    <%= Html.ValidationMessage("Team.Division")%>
                </p>
                <p>
                    <label for="uploadify">
                        Logo:</label>
                    <%= Html.Hidden("Team.LogoURL", Constants.DefaultTeamImgUrl, new{ @id = "LogoURL"})%>
                    <img width="79" height="76" alt="Logo Equipo" src="/Content/images/no-image.jpg" id="logo-img" />
                    <br />
                    <input id="fileInput" name="fileInput" type="file" />
                </p>
                <div id="fileQueue">
                </div>
                <p>
                    <input type="submit" value="Crear" />
                </p>
            </fieldset>
            <% } %>
        </div>
        <div id="recent-teams">
            <%= Html.Grid((List<Team>)ViewData["RecentTeams"]).Columns(column =>
           {
               column.For( C => C.Name ).Named( "Nombre" );
               column.For( C => C.Sport.Name ).Named( "Deporte" );
               column.For( C => C.Division.Name ).Named( "División" );
               column.For( C => C.TeamAliases.FirstOrDefault( ) != null ? C.TeamAliases.First( ).PrintName : "n/a" ).Named( "Nombre Impreso" );
           }).Attributes(@class => "dataTable")
            %>
        </div>
    </div>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
        <%= Html.ClientSideValidation<Team>("Team") %>
        <%= Html.ClientSideValidation<TeamAlias>("TeamAlias") %>
    </div>
</asp:Content>
