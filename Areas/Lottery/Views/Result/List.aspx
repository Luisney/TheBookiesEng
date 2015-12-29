<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.ViewModels.ResultViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Results - Results listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Resultados de <%= Model.Lottery.Name %></h2>    
    <table id="ajaxDataTable"></table>
    <div id="Pager"></div>
    <br />
    <p>
        <a class="navPrev" href="<%= Url.Action("Index","Lotto") %>">Volver al listado</a>
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
            GetDynamicResultDataByLotto: '<%= Url.Action("GetDynamicResultDataByLotto", new { id = Model.Lottery.Id }) %>',            
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/'
        }
        
        $(document).ready(function() {
            var actionUrl = ControllerActions.GetDynamicResultDataByLotto;
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Fecha', 'Premios', ''],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },               
               { name: 'Date', index: 'Date', sortable: true, width: 150 },
               { name: 'Prizes', index: 'Prizes', align: 'center', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80}],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Date',
                sortorder: 'desc',
                viewrecords: true,
                caption: 'Resultados',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        deleteLink = "<a class='delete-link' id='" + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "'>Eliminar</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: deleteLink });
                    }
                    activateDelete();
                }
            });
        });

        function activateDelete() {
            $('.delete-link').click(function() {
                // Build message string
                var name = 'Fecha: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Date;

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
                        $(".delmsg", formid).html("Desea eliminar este resultado?<br/>" + name);
                    }
                });
            });
        }
    </script>
</asp:Content>
