<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MainOneColumn.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<TheBookies.Model.Bet>>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Lotteries - Tickets
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jqGridUtils.js" type="text/javascript"></script>
    <script src="/Scripts/format.20110630-1100.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var ControllerActions = {
            GetDynamicBetLottoData: '<%= Url.Action("JsonSearch") %>/',
            GetBetStatuses: '<%= Url.Action("GetBetStatuses") %>/',
            GetAdditionalInfos: '<%= Url.Action("GetAdditionalInfos") %>/',
            VoidBet: '<%= Url.Action("VoidBet") %>/',
            PayBet: '<%= Url.Action("PayBet") %>/',
            GetDynamicBetDetailLottoData: '<%= Url.Action("GetDynamicBetDetailLottoData") %>/'
        }

        // Auto-refresh grid interval
        var autoRefreshResults = null;

        $(function () {
            GetBets();
            buildDetailDataTable();

            // Auto refresh checkbox
            $('#autoRefreshCheckbox').click(function () {
                // Clear the previous setted interval
                if (autoRefreshResults)
                    clearInterval(autoRefreshResults);

                // Set the refresh interval
                if ($('#autoRefreshCheckbox').attr('checked'))
                    autoRefreshResults = setInterval(refreshGrid, 120000);
            });

            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                buttons: {
                    "Ok": function () {
                        $("#infoDialog").dialog('close');
                    }
                }
            });

            $('#voidTicketDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                buttons: {
                    "Anular": function () {
                        $.getJSON(ControllerActions.VoidBet,
                        {
                            betId: $('#ticketToVoidId').val(),
                            adminUser: $('#voidTicketDialog input[name=adminUser]').val(),
                            authPassword: $('#voidTicketDialog input[name=authPassword]').val()
                        },
                        function (data) {
                            $('#voidTicketDialog').dialog('close');
                            // Info message
                            $('#infoDialog').dialog('open');
                            $('#infoDialogMessage').text(data);
                            $('#ajaxDataTable').trigger('reloadGrid');
                        });
                    },
                    "Cancelar": function () {
                        $("#voidTicketDialog").dialog('close');
                    }
                }
            });

            $('#payTicketDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 400,
                buttons: {
                    "Pagar": function () {
                        $.getJSON(ControllerActions.PayBet,
                        { 
                            betId: $('#ticketToPayId').val(),
                            adminUser: $('#payTicketDialog input[name=adminUser]').val(),
                            authPassword: $('#payTicketDialog input[name=authPassword]').val()
                        },
                        function (data) {
                            $('#payTicketDialog').dialog('close');
                            // Info message
                            $('#infoDialog').dialog('open');
                            $('#infoDialogMessage').text(data);
                            $('#ajaxDataTable').trigger('reloadGrid');
                        });
                    },
                    "Cancelar": function () {
                        $("#payTicketDialog").dialog('close');
                    }
                }
            });
        });

        var rowsToColor = [];

        function GetBets() {
            var actionUrl = ControllerActions.GetDynamicBetLottoData;

            $("#ajaxDataTable").jqGrid({
                width: 920,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Audit Number', 'En linea', 'Banca', 'Terminal', 'Usuario', 'Fecha',
                    'Hora', 'Fecha del sorteo', 'Status', 'Info', 'Anular', 'Auto anulada', 'Monto', 'Premios',
                    'Jugadas', 'Pagar'],
                colModel: [
                    { name: 'Id', index: 'Id', width: 100, searchoptions: { sopt: ['eq', 'ne']} },
                    { name: 'AuditNumber', index: 'AuditNumber', width: 70, searchoptions: { sopt: ['eq', 'ne']} },
                    { name: 'IsOffLine', index: 'IsOffLine', width: 70,
                        formatter: booleanFormatter,
                        searchoptions:
                        {
                            sopt: ['eq', 'ne'],
                            dataUrl: ControllerActions.GetBetStatuses,
                            buildSelect: createBooleanDropDownList
                        }
                    },
                    { name: 'SportBookName', index: 'SportBook.Name', width: 150,
                        searchoptions: {
                            sopt: ['eq', 'ne', 'cn']
                        }
                    },
                    { name: 'TerminalId', index: 'Terminal.TerminalId', width: 120,
                        searchoptions: {
                            sopt: ['eq', 'ne']
                        }
                    },
                    { name: 'User', index: 'User.Name', width: 150,
                        searchoptions: {
                            sopt: ['eq', 'ne', 'cn']
                        }
                    },
                    { name: 'Date', index: 'Date', sortable: true, search: false, width: 90,
                        searchoptions: {
                            sopt: ['eq', 'ne', 'gt', 'ge', 'lt', 'le'],
                            defaultValue: '<%= DateTime.Now.ToShortDateString( ) %>',
                            dataInit: createDatePicker
                        }
                    },
                    { name: 'Time', index: 'Time', sortable: true, search: false, width: 90 },
                    { name: 'DateDrawing', index: 'DateDrawing', sortable: true, width: 110,
                        searchoptions: {
                            sopt: ['eq', 'ne', 'gt', 'ge', 'lt', 'le'],
                            dataInit: createDatePicker
                        }
                    },
                    { name: 'Status', index: 'Status', sortable: true, width: 100, formatter: rowColorFormatter,
                        searchoptions: {
                            sopt: ['eq', 'ne'],
                            dataUrl: ControllerActions.GetBetStatuses,
                            buildSelect: createDropDownList
                        }
                    },
                    { name: 'AdditionalInfoId', index: 'AdditionalInfoId', sortable: true, width: 100,
                        searchoptions: {
                            sopt: ['eq', 'ne'],
                            dataUrl: ControllerActions.GetAdditionalInfos,
                            buildSelect: createDropDownList
                        }
                    },
                    { name: 'IsVoidable', index: 'IsVoidable', width: 70, formatter: voidableFormatter, sortable: false, search: false },
                    { name: 'AutoVoid', index: 'AutoVoid', width: 70,
                        formatter: booleanFormatter2,
                        sortable: true,
                        search: false
                    },
                    { name: 'TotalAmount', index: 'TotalAmount', sortable: true, width: 110, searchoptions: { sopt: ['eq', 'ne', 'gt', 'lt']} },
                    { name: 'WinnerAmount', index: 'WinnerAmount', sortable: true, width: 110, searchoptions: { sopt: ['eq', 'ne', 'gt', 'lt']} },
                    { name: 'BetDetails.Count', index: 'BetDetails.Count', sortable: true, width: 100, searchoptions: { sopt: ['eq', 'ne', 'gt', 'lt']} },
                    { name: 'IsPayable', index: 'IsPayable', width: 90, formatter: payFormatter, sortable: false, search: false }
                    ],
                    pager: '#Pager',
                    rowNum: 10,
                    rowList: [10, 20, 50],
                    sortname: 'DateDrawing',
                    sortorder: 'desc',
                    viewrecords: true,
                    caption: 'Tickets',
                    toolbar: [true, "bottom"],
                    gridComplete: function () {
                        var udata = $("#ajaxDataTable").jqGrid('getUserData');
                        $("#t_ajaxDataTable").css("text-align", "right").html("Total vendido: $" + format("#,###,##0.00", udata.totalAmount) + " Total ganadores: $" + format("#,###,##0.00", udata.totalWinnnersAmount) + "&nbsp;&nbsp;&nbsp;");

                        for (var i = 0; i < rowsToColor.length; i++) {
                            var status = $("#" + rowsToColor[i]).find("td").eq(9).html();
                            if (status == "Ganador") {
                                $("#" + rowsToColor[i]).find("td").css("background-color", "lightgreen");
                                $("#" + rowsToColor[i]).find("td").css("color", "black");
                            }

                            if (status == "Anulada") {
                                $("#" + rowsToColor[i]).find("td").css("background-color", "silver");
                                $("#" + rowsToColor[i]).find("td").css("color", "black");
                            }
                        }

                    },
                onSelectRow: function (rowId) {
                    if (rowId == null) {
                        rowId = 0;
                        if ($("#ticketDetailsTable").jqGrid('getGridParam', 'records') > 0) {
                            $("#ticketDetailsTable").jqGrid('setGridParam', { url: ControllerActions.GetDynamicBetDetailLottoData + '?code=' + rowId, page: 1 });
                            $("#ticketDetailsTable").jqGrid('setCaption', "Ticket No.: " + rowId).trigger('reloadGrid');
                        }
                    }
                    else {
                        $("#ticketDetailsTable").jqGrid('setGridParam', { url: ControllerActions.GetDynamicBetDetailLottoData + '?code=' + rowId, page: 1 });
                        $("#ticketDetailsTable").jqGrid('setCaption', "Ticket No.: " + rowId).trigger('reloadGrid');
                    }
                }
            })
            .navGrid(
                '#Pager',
                { view: false, del: false, add: false, edit: false },
                {}, // default settings for edit
                {}, // default settings for add
                {}, // delete instead that del:false we need this
                {closeOnEscape: true, multipleSearch: true, closeAfterSearch: true }, // search options
                {});  // view parameters
        }

        function buildDetailDataTable() {
            $("#ticketDetailsTable").jqGrid({
                width: 920,
                height: "100%",
                url: ControllerActions.GetDynamicBetDetailLottoData,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Tipo Apuesta', 'Detalle', 'Monto Apostado', 'Monto Ganador', 'Status'],
                colModel: [{ name: 'Id', index: 'Id', hidden: true, width: 150 },
                   { name: 'BetType.Name', index: 'BetType.Name', sortable: true, width: 150 },
                   { name: 'ItemsDetail', index: 'Id', sortable: false, width: 150 },
                   { name: 'Amount', index: 'Amount', sortable: true, width: 150 },
                   { name: 'WinnerAmount', index: 'WinnerAmount', sortable: true, width: 150 },
                   { name: 'Status', index: 'Status', sortable: true, width: 150}],
                pager: '#ticketDetailsTablePager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'BetType.Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Detalle del Ticket',
                toolbar: [true, "bottom"],
                gridComplete: function () {
                    var udata = $("#ticketDetailsTable").jqGrid('getUserData');
                    $("#t_ticketDetailsTable").css("text-align", "right").html(udata.Message + "&nbsp;&nbsp;&nbsp;");
                
                    var ids = $("#ticketDetailsTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                    }
                }
            }); // view parameters
        }

        function formatCurrency(num) {
            num = isNaN(num) || num === '' || num === null ? 0.00 : num;
            return parseFloat(num).toFixed(2);
        }

        function rowColorFormatter(cellValue, options, rowObject) {
            if (cellValue == "Ganador" || cellValue == "Anulada")
                rowsToColor[rowsToColor.length] = options.rowId;
            return cellValue;
        }

        function voidableFormatter(cellvalue, options, rowObject) {
            if (String(cellvalue).toUpperCase() == 'TRUE')
                return '<img class="showPointer" src="<%= Html.GetImageURL("false.png") %>" onclick="voidTicket( ' + options.rowId + ' );"/>';
            return '<img src="<%= Html.GetImageURL("selection.png") %>"/>';
        }

        function payFormatter(cellvalue, options, rowObject) {
            if (String(cellvalue).toUpperCase() == 'TRUE')
                return '<img class="showPointer" src="<%= Html.GetImageURL("page_tick.gif") %>" onclick="payTicket( ' + options.rowId + ' );"/>';
            return '<img src="<%= Html.GetImageURL("selection.png") %>"/>';
        }

        voidTicket = function (Id) {
            $('#voidTicketDialog').dialog('open');
            $('#voidTicketDialogMessage').text('Desea anular el ticket No. ' + Id + '?');
            $('#ticketToVoidId').val(Id);
        }

        payTicket = function (Id) {
            $('#payTicketDialog').dialog('open');
            $('#payTicketDialogMessage').text('Desea pagar el ticket No. ' + Id + '?');
            $('#ticketToPayId').val(Id);
        }

        // Refreshes the grid
        refreshGrid = function () {
            $("#ajaxDataTable").trigger("reloadGrid");
        }    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Ticket Listing</h2>
    <input id="autoRefreshCheckbox" type="checkbox" title="Auto refresh" />Auto-refrescar
    resultados
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <table id="ticketDetailsTable">
    </table>
    <div id="ticketDetailsTablePager">
    </div>
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
    <div id="voidTicketDialog" title="Cancel Ticket">
        <p id="voidTicketDialogMessage">
        </p>
        <br />
        <form>
            <fieldset>
                <p>
                    <label>
                        Admin User:</label>
                    <%= this.TextBox( "adminUser" )%>
                </p>
                <p>
                    <label>
                        Authorization Password:</label>
                    <%= this.Password( "authPassword" )%>
                </p>
            </fieldset>
        </form>
    </div>
    <input id="ticketToVoidId" type="hidden" />
    <div id="payTicketDialog" title="Pay Ticket">
        <p id="payTicketDialogMessage">
        </p>
        <br />
        <form>
            <fieldset>
                <p>
                    <label>
                        Admin User:</label>
                    <%= this.TextBox("adminUser") %>
                </p>
                <p>
                    <label>
                        Authorization Password:</label>
                    <%= this.Password( "authPassword" )%>
                </p>
            </fieldset>
        </form>
    </div>
    <input id="ticketToPayId" type="hidden" />
    <br />
</asp:Content>
