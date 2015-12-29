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
            Revert: '<%= Url.Action("JsonRevertBalance") %>/',
            Asignar: '<%= Url.Action("Asignar") %>/'
        }
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Cuentas de Recargas" ) %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Cuentas de Recargas" ) %>
    </h2>
    <% Html.RenderPartial("SearchBox"); %>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <div id="changeDialog" title="Cambiar Manejo de Balance">
        <p id="changeDialogMessage">
        </p>
        <br />
        <form id="frmChange" onsubmit="return false">
        <fieldset>
            <p>
                <label>
                    Usuario Administrativo:</label>
                <input id="adminUser" name="adminUser" type="text" value="" />
            </p>
            <p>
                <label>
                    Contraseña de autorización:</label>
                <input id="authPassword" name="authPassword" type="password" value="" />
            </p>
        </fieldset>
        <input id="accountId" name="id" type="hidden" />
        <input id="option" name="option" type="hidden" />
        </form>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: '100%',
                url: ControllerActions.JsonSearch,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Número', 'Cuenta', 'Tipo', 'ID', 'Producto', 'Balance', ''],
                colModel: [
               { name: 'id', index: 'id', sortable: true, width: 40, align: 'center' },
               { name: 'AccountName', index: 'AccountName', sortable: true },
               { name: 'AccountType', index: 'AccountType', width: 80, sortable: true },
               { name: 'AccountId', index: 'AccountId', sortable: true, width: 40, align: 'right' },
               { name: 'Product', index: 'Product', sortable: true, width: 40 },
               { name: 'Balance', index: 'Balance', sortable: true, width: 60, align: 'right' },
               { name: 'Action', index: 'Action', sortable: false, width: 45, align: 'center' }
                ],
                pager: '#Pager',
                rowNum: 100,
                rowList: [100, 150, 200],
                sortname: 'AccountType',
                sortorder: 'desc',
                viewrecords: true,
                caption: 'Cuentas de Recargas',
                gridComplete: function () {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var changeLink = "";

                        var data = $("#ajaxDataTable").jqGrid('getRowData', ids[i]);
                        if (data.AccountType != "Consorcio") {

                            changeLink = data.AccountType == "Consorcio" ? "" : "<a href='javascript:anular(" + ids[i] + ")'>Cambiar</a>";
                        }
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: changeLink });
                    }
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

        function anular(id) {
            $("#accountId").val(id);
            var data = $("#ajaxDataTable").jqGrid('getRowData', id);
            $('#changeDialog').dialog('open');
            var msg = "<b>" + data.AccountType + ": " + data.AccountName + "<br/>Cuenta " + data.Product.toUpperCase() + ": $" + data.Balance + "</b>";
            $('#changeDialogMessage').html(msg);

            $('#resultToDeleteId').val(id);
        }

        function changeDialog_Block() {
            $("#option").val("1");

            var elements = $("#frmChange").serialize();
            blockScreen();

            $.ajax({
                type: "POST",
                url: "/Recargas/Cuenta/CambiarBalance",
                data: elements,
                dataType: "text",
                success: function (msg) {
                    if (msg == 'OK') {
                        $("#changeDialog").dialog('close');
                        unBlockScreen();
                        $('#submitButton').click();
                    }
                    else {
                        alert(msg);
                        unBlockScreen();
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(xhr.responseText);
                    unBlockScreen();
                }
            });
        }

        function changeDialog_Transfer() {
            $("#option").val("2");

            var elements = $("#frmChange").serialize();
            blockScreen();

            $.ajax({
                type: "POST",
                url: "/Recargas/Cuenta/CambiarBalance",
                data: elements,
                dataType: "text",
                success: function (msg) {
                    if (msg == 'OK') {
                        $("#changeDialog").dialog('close');
                        unBlockScreen();
                        $('#submitButton').click();
                    }
                    else {
                        alert(msg);
                        unBlockScreen();
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(xhr.responseText);
                    unBlockScreen();
                }
            });
        }

        $('#changeDialog').dialog({
            bgiframe: true,
            modal: true,
            autoOpen: false,
            width: 400,
            buttons: {
                "Deshabilitar": changeDialog_Block,
                "Transferir": changeDialog_Transfer,
                "Cancelar": function () {
                    $("#changeDialog").dialog('close');
                }
            }
        });    
    </script>
</asp:Content>
