<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Income Account - Income Account Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Income Account Listing</h2>
    <table id="ajaxDataTable"></table>
    <div id="Pager"></div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create New</span></a>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
<script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>    
    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            var actionUrl = '<%= Url.Action("GetDynamicIncomeCodeData") %>';
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Detalle', '',''],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Details', index: 'Name', sortable: true, width: 400 },               
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80}],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Detail',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Códigos Ingresos',
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
        
        function activateDelete() {
            $('.delete-link').click(function() {
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    msg: "Desea eliminar este código de ingreso?",
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: "<%= Url.Action("Delete") %>",
                    mtype: "POST"
                });
            });
        }
    </script>
</asp:Content>

