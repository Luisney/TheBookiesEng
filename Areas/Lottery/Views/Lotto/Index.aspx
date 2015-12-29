<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<TheBookies.Model.Lottery>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Lotteries - Lottery Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Lottery Listing</h2>
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
        var ControllerActions = {
            GetDynamicLottoData: '<%= Url.Action("GetDynamicLottoData") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/'
        }

        $(document).ready(function() {
            var actionUrl = ControllerActions.GetDynamicLottoData;
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Nombre', 'Desplegado en ticket', 'Desplegado en pantalla', '', '', '', ''],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'PrintName', index: 'PrintName', sortable: true, width: 150 },
               { name: 'DisplayName', index: 'DisplayName', sortable: true, width: 150 },
               { name: 'CloseStatus', index: 'CloseStatus', sortable: false, width: 250 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 },
               { name: 'Action3', index: 'Action3', sortable: false, width: 80}],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Loterias',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"<%= Url.Action("Edit") %>/' + ids[i] + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
                        resultsLink = '<a href=\"<%= Url.Action("Lotto", "Result") %>/' + ids[i] + "\">Resultados</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink, Action3: resultsLink });
                    }

                    activateDelete();
                }
            });
        });

        function activateDelete() {
            $('.delete-link').click(function() {
                // Build message string
                var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Name;
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    msg: "Desea eliminar esta lotería?",
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: ControllerActions.Delete,
                    mtype: "POST",
                    width: 350,
                    // Workaround for bug: msg is not correctly updated after first rendering.
                    beforeShowForm: function(formid) {
                        $(".delmsg", formid).html("Desea eliminar esta lotería?<br/>" + name);
                    }
                });
            });
        }
    </script>

</asp:Content>
