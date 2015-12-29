<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Machine Types - Machine Type Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">    
    <h2>Machin Type Listing</h2>
    <table id="ajaxDataTable"></table>
    <div id="Pager"></div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nueva</span></a>
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
            var actionUrl = '<%= Url.Action("GetDynamicMachineTypeData") %>';
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Nombre', 'Jackpot', '', ''],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 150 },               
               { name: 'Jackpot', index: 'Jackpot', formatter: booleanFormatter, align: 'center', sortable: false, width: 150 },               
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80}],               
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Tipos Máquinas',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"<%= Url.Action("Edit") %>/' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "'>Eliminar</a>";                        
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
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
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    msg: "Desea eliminar esta tipo de máquina?",
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: "<%= Url.Action("Delete") %>",
                    mtype: "POST"
                });
            });
        }
    </script>
</asp:Content>

