<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/'
        };

        $(document).ready(function() {
            InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByTeamAliasOrTeamOrSportOrDivisionName");

            var actionUrl = ControllerActions.JsonSearch;

            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Código', 'Alias', 'Equipo', 'Division', 'Deporte', '', ''],
                colModel: [
               { name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Código', index: 'Code', sortable: true, width: 150 },
               { name: 'Alias', index: 'PrintName', sortable: true, width: 150 },
               { name: 'TeamName', index: 'Team.Name', sortable: true, width: 150 },
               { name: 'DivisionName', index: 'Team.Division.Name', sortable: true, width: 150 },
               { name: 'SportName', index: 'Team.Sport.Name', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'PrintName',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Equipos',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"' + ControllerActions.Edit + '' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "'>Eliminar</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
                    }

                    activateDelete();
                }
            });

            $('#submitButton').click(
            function() {
                var searchText = jQuery("#SearchText").val();
                $("#ajaxDataTable").jqGrid('setGridParam',
                    {
                        url: actionUrl + "?SearchText=" + escape(searchText),
                        page: 1
                    })
                    .trigger("reloadGrid");
            });
        });

        function activateDelete() {
            $('.delete-link').click(function() {
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    msg: "Desea eliminar este alias?",
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: ControllerActions.Delete,
                    mtype: "POST"
                });
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Alias de Equipos - Listado
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Listado de Aliases
    </h2>
    <div class="searchbox">
        Buscar :
        <%= Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
        <button id="submitButton" class="searchbox_btn">
            Buscar</button>
    </div>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a>
    </p>
</asp:Content>
