<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            Delete: '<%= Url.Action("Delete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
        }
        
        $(document).ready(function() {
            InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByCompanyName");
        
            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false
            });
            
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: ControllerActions.JsonSearch,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Nombre', 'Dirección', 'Telefono', 'Gerente general', 'Presidente', '', ''],
                colModel: [
                    { name: 'Name', index: 'Name', sortable: true, width: 100 },
                    { name: 'Address', index: 'Address', sortable: true, width: 80 },
                    { name: 'Phone', index: 'Phone', sortable: true, width: 80 },
                    { name: 'Manager', index: 'Manager', sortable: true, width: 70 },
                    { name: 'Ceo', index: 'Ceo', sortable: true, width: 70 },
                    { name: 'Action', index: 'Action', sortable: false, width: 40 },
                    { name: 'Action2', index: 'Action2', sortable: false, width: 40 }
                ],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Consorcios',
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
                            $(".delmsg", formid).html("Desea eliminar este consorcio?<br/> " + name);
                        }
                    });
                });
            }
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Companies - Companies list" )%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Companies list" )%>
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
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create new</span></a>
    </p>
</asp:Content>
