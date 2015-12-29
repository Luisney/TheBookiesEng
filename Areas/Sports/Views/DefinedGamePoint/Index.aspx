<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/'
        }

        $(document).ready(function() {
            var actionUrl = ControllerActions.JsonSearch;

            InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByPeriod");

            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['División', 'Carreraje base', 'Precio base', 'Tipo', 'Periodo', 'Puntos conv.', 'Precio Over', 'Precio Under', '', ''],
                colModel: [
                   { name: 'Division', index: 'Division.Name', sortable: true, width: 110 },
                   { name: 'BasePoints', index: 'BasePoints', sortable: true, width: 110 },
                   { name: 'BasePrice', index: 'BasePrice', sortable: true, width: 90 },
                   { name: 'Type', index: 'Type', sortable: true, width: 50 },
                   { name: 'BetTypePeriod', index: 'BetTypePeriod.Name', sortable: true, width: 140 },
                   { name: 'PointsTotal', index: 'PointsTotal', sortable: true, width: 100 },
                   { name: 'PriceOver', index: 'PriceOver', sortable: true, width: 90 },
                   { name: 'PriceUnder', index: 'PriceUnder', sortable: true, width: 95 },
                   { name: 'Action', index: 'Action', sortable: false, width: 60 },
                   { name: 'Action2', index: 'Action2', sortable: false, width: 60 }
                ],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'BetTypePeriod.Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Diferencia de puntos',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"' + ControllerActions.Edit + '' + ids[i] + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
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
                // Build message string
                var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).BetTypePeriod + "<br/>" +
                    'Puntos base: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).BasePoints + '<br/>' +
                    'Precio base: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).BasePrice + '<br/>' +
                    $("#ajaxDataTable").jqGrid('getRowData', this.id).Type;

                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: ControllerActions.Delete,
                    mtype: "POST",
                    width: 350,
                    // Workaround for bug: msg is not correctly updated after first rendering.
                    beforeShowForm: function(formid) {
                        $(".delmsg", formid).html("Desea eliminar este total por periodo?<br/>" + name);
                    }
                });
            });
        }

        function isFavoriteFormatter(cellvalue, options, rowObject) {
            if (String(cellvalue).toUpperCase() == 'TRUE')
                return "Si";
            else
                return "No";
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Totales por periodo - Listado
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Listado de totales por periodo
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
