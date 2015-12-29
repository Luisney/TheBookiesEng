<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    
    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>
    
    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Editar: '<%= Url.Action("Editar") %>/',
            Asignar: '<%= Url.Action("Asignar") %>/'
        }

        $(document).ready(function () {

            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: '100%',
                url: ControllerActions.JsonSearch,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['ID', 'Nombre', 'Centro de acopio','Fecha Creación', '',''],
                colModel: [
               { name: 'Id', index: 'Id', sortable: true, width: 30, align: 'center' },
               { name: 'Name', index: 'Name', width: 180, sortable: false },
               { name: 'StoringCenterId', index: 'StoringCenterId', sortable: true, width: 80, align: 'center' },
               { name: 'CreationDate', index: 'CreationDate', sortable: false, width: 80, align: 'center' },
               { name: 'Action', index: 'Action', sortable: false, width: 30 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 30 }
                ],
                pager: '#Pager',
                rowNum: 50,
                rowList: [50, 100, 150],
                sortname: 'CreationDate',
                sortorder: 'desc',
                viewrecords: true,
                caption: 'Grupo de Bancas',
                gridComplete: function () {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var editLink   = '<a href=\"' + ControllerActions.Editar + ids[i] + "\">Detalles</a>";
                        var deleteLink = "<a class='delete-link' id=\"" + ids[i] + "\">Eliminar</a>";
   
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
                    }
                    activateDelete();
                }
            });

            $('#submitButton').click(
            function () {
                var searchText = jQuery("#SearchText").val();
                $("#ajaxDataTable").jqGrid('setGridParam',
                    {
                        url: ControllerActions.JsonSearch + "?SearchText=" + escape(searchText),
                        page: 1
                    })
                    .trigger("reloadGrid");
            });
        });

        function activateDelete() {
            $('.delete-link').click(function () {
                // Build message string
                var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Name;

                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar Grupo de Bancas",
                    reloadAfterSubmit: true,
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: ControllerActions.JsonDelete,
                    mtype: "POST",
                    width: 350,
                    afterSubmit: function (response, postada) { if (response.responseText.toLowerCase() == "false") alert("La cuenta no puede ser eliminada, esta asociada a una o más cuenta de Recargas."); return [response, '']; },
                    // Workaround for bug: msg is not correctly updated after first rendering.
                    beforeShowForm: function (formid) {
                        $(".delmsg", formid).html("¿Desea eliminar este Grupo de Bancas?<br/> " + name);
                    }
                });
            });
        }
    </script>
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Grupo de Bancas" ) %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Grupo de Bancas" ) %>
    </h2>
        <% Html.RenderPartial( "SearchBox" ); %>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Crear") %>"><span>Crear nuevo</span></a>
    </p>
</asp:Content>
