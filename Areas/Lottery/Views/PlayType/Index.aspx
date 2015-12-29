<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Bet types - Bet types listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Bet type listing</h2>
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create new</span></a>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            GetDynamicBetTypeData: '<%= Url.Action("GetDynamicBetTypeData") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/',
            EditCompatibleLotteries: '<%= Url.Action("EditCompatibleLotteries") %>/'   
        }
        $(document).ready(function() {
            var actionUrl = ControllerActions.GetDynamicBetTypeData;
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Nombre', 'Ganador', 'Segundo', 'Tercero', '', '', ''],
                colModel: [
                { name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'Winner', index: 'Winner', formatter: booleanFormatter, align: 'center', sortable: false, width: 150 },
               { name: 'Second', index: 'Second', formatter: booleanFormatter, align: 'center', sortable: false, width: 150 },
               { name: 'Third', index: 'Third', formatter: booleanFormatter, align: 'center', sortable: false, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action', sortable: false, width: 80 },
               { name: 'Action3', index: 'Action3', sortable: false, width: 80}],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Resultados',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"' + ControllerActions.Edit + '' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Editar</a>";
                        lotteryCompatibilityLink = '<a href=\"' + ControllerActions.EditCompatibleLotteries + '' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Loterias</a>";
                        deleteLink = "<a class='delete-link' id='" + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "'>Eliminar</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: lotteryCompatibilityLink, Action3: deleteLink });
                    }

                    activateDelete();
                }
            });
        });

        function booleanFormatter(cellvalue, options, rowObject) {
            if (String(cellvalue).toUpperCase() == 'TRUE')
                return "<img src=\"/Content/images/true.png\"/>";
            else
                return "<img src=\"/Content/images/false.png\"/>";
        }

        function activateDelete() {
            $('.delete-link').click(function() {
                // Build message string
                var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Name;

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
                        $(".delmsg", formid).html("Desea eliminar este tipo de apuesta?<br/>" + name);
                    }
                });
            });
        }
    </script>

</asp:Content>
