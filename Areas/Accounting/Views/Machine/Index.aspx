<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Slot Machines - Slot Machine Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Slot Machine Listing</h2>
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create New</span></a>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>

    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            var actionUrl = '<%= Url.Action("GetDynamicMachineData") %>';
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Código', 'Banca', 'Tipo Máquina', 'Valor Monedas', 'Número de Inicio', '', ''],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'MachineCode', index: 'MachineCode', sortable: true, width: 150 },
               { name: 'Banca', index: 'Banca', sortable: true, width: 150 },
               { name: 'MachineType.Name', index: 'MachineType.Name', sortable: true, width: 150 },
               { name: 'ValueCoins', index: 'ValueCoins', sortable: true, align: 'center', width: 150 },
               { name: 'StartControlNumber', index: 'StartControlNumber', align: 'center', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80}],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'MachineCode',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Maquinas Traga Monedas',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"<%= Url.Action("Edit") %>/' + ids[i] + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
                    }

                    activateDelete();
                }
            });
        });

        function activateDelete() {
            $('.delete-link').click(function() {
                var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).MachineCode;
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: '<%= Url.Action("Delete") %>',
                    mtype: "POST",
                    width: 300,
                    // Workaround for bug: msg is not correctly updated after first rendering.
                    beforeShowForm: function(formid) {
                        $(".delmsg", formid).html("Desea eliminar esta maquina traga moneda:<br/> " + name + " ?");
                    }
                });
            });
        }
    </script>

</asp:Content>
