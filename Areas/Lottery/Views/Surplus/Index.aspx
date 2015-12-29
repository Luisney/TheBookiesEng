<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Surplus - Surplus Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Surplus Listing</h2>
    <table id="ajaxDataTable"></table>
    <div id="Pager"></div>
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
        var ControllerActions = {
            GetDynamicSurplusData: '<%= Url.Action("GetDynamicSurplusData") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/'
        }

        $(document).ready(function() {
            var actionUrl = ControllerActions.GetDynamicSurplusData;
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id','Consorcio', 'Fecha', 'Orden', 'Máximo', '', ''],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Name', index: 'Name', align: 'center', sortable: true, width: 150 },
               { name: 'LottoDate', index: 'LottoDate', align: 'center', sortable: true, width: 150 },
               { name: 'Order', index: 'Order', align: 'center', sortable: false, width: 150 },
               { name: 'Maximum', index: 'Maximum', align: 'center', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80}],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'LottoDate',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Botes',
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
            var name = 'Consorcio: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Name + '<br/>' + 
                'Fecha: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).LottoDate + '<br/>' +
                'Orden: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Order;

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
                        $(".delmsg", formid).html("Desea eliminar este bote?<br/>" + name);
                    }
                });
            });
        }
    </script>
</asp:Content>
