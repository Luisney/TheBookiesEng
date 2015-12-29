<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Team>" %>
<%@ Import Namespace="Gambling.Models" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/uploadify.css" />

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/swfobject.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.uploadify.v2.1.0.min.js" type="text/javascript"></script>
    <script src="/Content/js/utils.upload.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterDivisionBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/',
            UpdateAliasNames: '<%= Url.Action("UpdateAliasNames", "TeamAlias") %>/',
            GetTeamAlias: '<%= Url.Action("GetTeamAlias", "TeamAlias") %>'
        };

        $(document).ready(function() {
            var $CURRENTALIASCODE;

            InitUploadUtil('#fileInput', '#LogoURL', '#logo-img');

            $('#Team_SportId').cascade({
                source: ControllerActions.FilterDivisionBySport,
                cascaded: "Team_DivisionId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $("#edit-alias-dialog").dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 400,
                buttons: {
                    "Cancelar": function() {
                        $("#edit-alias-dialog").dialog('close');
                    },
                    Ok: function() {
                        if ($('#edit-alias-form').validate().form()) {
                            $("#edit-alias-dialog .loading").show();
                            $("#edit-alias-dialog .dialog-content").hide();


                            var data = $('#edit-alias-dialog input:text').serializeArray();

                            $.post(ControllerActions.UpdateAliasNames + $CURRENTALIASCODE, data, function(response) {

                                $('#alias-label-' + $CURRENTALIASCODE).html('[' + $CURRENTALIASCODE + '] ' + $('#TeamAlias_PrintName').val());

                                $("#edit-alias-dialog .loading").hide();
                                $("#edit-alias-dialog .dialog-content").show();
                                $("#edit-alias-dialog").dialog('close');

                            }, "json");
                        }

                    }

                }
            });

            $('.edit-alias').click(function() {
                $("#edit-alias-dialog .loading").show();
                $("#edit-alias-dialog .dialog-content").hide();

                $CURRENTALIASCODE = $(this).attr('id');

                $.getJSON(ControllerActions.GetTeamAlias, { AliasCode: $(this).attr('id') }, function(response) {
                    $("#edit-alias-dialog .loading").hide();
                    $("#edit-alias-dialog .dialog-content").show();

                    $('#TeamAlias_PrintName').val(response.PrintName);
                    $('#TeamAlias_DisplayName').val(response.DisplayName);
                });
                $('#edit-alias-dialog').dialog('open');
            });


        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Equipos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editar Equipo
    </h2>
    <%= Html.ValidationSummary("Edición fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <%= Html.Hidden( "Team.Id", Model.Id ) %>
        <%= Html.Hidden( "Team.Status", Model.Status ) %>
        <p>
            <label for="Name">
                Nombre:
            </label>
            <%= Html.TextBox("Team.Name", Model.Name) %>
            <%= Html.ValidationMessage("Team.Name")%>
        </p>
        <p>
            <label for="Sport">
                Deporte:
            </label>
            <%= this.Select("Team.SportId").Options((SelectList)ViewData["SportId"]) %>
            <%= Html.ValidationMessage("Team.SportId")%>
        </p>
        <p>
            <label for="Division">
                <%= Html.Encode("División:")%>
            </label>
            <%= this.Select("Team.DivisionId").Options((SelectList)ViewData["DivisionId"]) %>
            <%= Html.ValidationMessage("Team.DivisionId")%>
        </p>
        <p>
            <label>
                Aliases:</label>
            <%
                foreach( var Alias in ( List<TeamAlias> ) ViewData [ "Aliases" ] )
                {%>
            <span id="alias-label-<%= Alias.Code %>">[<%= Alias.Code %>]
                <%= Alias.PrintName %></span> [<a id="<%= Alias.Id %>" class="edit-alias">editar</a>]
            <%} %>
        </p>
        <p>
            <label for="uploadify">
                Logo:</label>
            <%= Html.Hidden("Team.LogoURL", Model.LogoURL, new{@id = "LogoURL"})%>
            <img width="79" height="76" alt="Logo <%= Model.Name %>" src="<%= Model.LogoURL %>"
                id="logo-img" />
            <br />
            <input id="fileInput" name="fileInput" type="file" />
        </p>
        <div id="fileQueue">
        </div>
        <p>
            <input type="submit" value="Guardar" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <div id="edit-alias-dialog" title="Editar Alias">
        <div class="dialog-content">
            <form id="edit-alias-form">
            <p>
                <%= this.TextBox( "TeamAlias_DisplayName" ).Attr( "Name", "TeamAlias.DisplayName" ).Label( "Nombre mostrado:" ).Class( "required" ).Attr( "maxlength", 8 )%>
            </p>
            <p>
                <%= this.TextBox( "TeamAlias_PrintName" ).Attr( "Name", "TeamAlias.PrintName" ).Label( "Nombre impreso:" ).Class("required").Attr("maxlength", 14)%>
            </p>
            </form>
        </div>
        <div class="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." />
        </div>
        <%= Html.ClientSideValidation<Team>("Team") %>
    </div>
</asp:Content>
