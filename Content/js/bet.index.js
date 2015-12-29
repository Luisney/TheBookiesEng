/// <reference path="jquery-1.4.1-vsdoc.js"/>
var totalsChartTimer;

function reloadDailyLimitsGrids() {
    reloadCashTotals();
    reloadQuantityTotals();
    if (totalsChartTimer) { clearTimeout(totalsChartTimer) };
    totalsChartTimer = setTimeout(reloadDailyLimitsGrids, 150000);
};

function reloadCashTotals() {
    $('#pendingRiskLabel').html('Riesgo pendiente: Cargando...');
    $('#betTotalLabel').html('Total apostado: Cargando...');
    $('#winnersTotalLabel').html('Total ganadores: Cargando...');
    $('#voidedTotalLabel').html('Total anulados: Cargando...');
    $('#differenceTotalLabel').html('Total diferencia: Cargando...');
                
    $.post(getTicketCashTotalsUrl,
            {
                date: $("#totalsDate").val(),
                sportBookId: $("#totalsSportBookId").val()
            },
            function(data) {
                if (data) {
                    $('#pendingRiskLabel').html('Riesgo pendiente: ' + data.pendingRisk);
                    $('#betTotalLabel').html('Total apostado: ' + data.betTotal);
                    $('#winnersTotalLabel').html('Total ganadores: ' + data.winnersTotal);
                    $('#voidedTotalLabel').html('Total anulados: ' + data.voidedTotal);
                    $('#differenceTotalLabel').html('Total diferencia: ' + data.differenceTotal);
                }
            },
            'json');
}

function reloadQuantityTotals() {
    $('#totalsChart').html('Cargando...');
    $('#totalsChart').theBookiesChart('ColumnChart',
            {
                url: getTicketQuantityTotalsUrl,
                is3D: true,
                width: 550,
                height: 300,
                params:
                {
                    date: $("#totalsDate").val(),
                    sportBookId: $("#totalsSportBookId").val()
                }
            }
    );
}

$(function() {
    // Gets available sportbooks
    $('#totalsSportBookId').append('<option value="null">Cargando...</option>');
    $.getJSON(getSportBooksUrl, null, function(data) {
        $('#totalsSportBookId').empty();
        if (data.length > 0) {
            $('#totalsSportBookId').append('<option value="null">-Todos-</option>');
            $.each(data, function(i, item) {
                $('#totalsSportBookId').append('<option value="' + item.id + '">' + item.label + '</option>');
            });
        }
    });

    $("#TicketsTabs").tabs({
        show: function(event, ui) {
            reloadDailyLimitsGrids();
        }
    });

    $("#TicketDetailsLoader").fadeOut();

    $("#TicketDetail").dialog(
        {
            autoOpen: false,
            modal: true,
            bgiframe: true,
            width: 600,
            heigth: 400
        });

    $("#totalsDate").datepicker({
        dateFormat: 'dd/mm/yy',
        onSelect: function(dateText, inst) {
            reloadDailyLimitsGrids();
        }
    }).datepicker('setDate', new Date());

    // TODO: Fix null total reload
    $("#totalsSportBookId").change(function() {
        reloadDailyLimitsGrids();
    });

    $("#ajaxDataTable").jqGrid({
        width: 635,
        height: "100%",
        url: actionUrl,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Id', 'Banca', 'Fecha', 'Hora', 'Monto apostado', 'Monto pagado', 'Estado', ''],
        colModel: [
               { name: 'FormattedId', index: 'Id', sortable: true, width: 130, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'SportBook', index: 'Terminal.SportBook.Name', sortable: true, width: 130, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'Date', index: 'Date', sortable: true, width: 120, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'Time', index: 'Time', sortable: true, width: 100, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'BetAmmount', index: 'BetAmmount', sortable: true, width: 150, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'PayAmmount', index: 'PayAmmount', sortable: true, width: 150, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'Status', index: 'Status', sortable: true, width: 100, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'Action', index: 'Action', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Id',
        sortorder: 'asc',
        viewrecords: true,
        caption: 'Tickets',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                detailsLink = "<a onclick='showTicketDetails(" + ids[i] + ")' class='details-link'>Detalle</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: detailsLink });
            }
        }
    })
    .navGrid('#Pager', { view: false, del: false, add: false, edit: false },
       {}, // default settings for edit
       {}, // default settings for add
       {}, // delete instead that del:false we need this
       {closeOnEscape: true, multipleSearch: true, closeAfterSearch: true }, // search options
       {} /* view parameters*/
     );

    showTicketDetails = function(id) {
        var currentCell = $("#ajaxDataTable").jqGrid('getRowData', id);

        $('#TicketDetails').empty();
        $("#TicketDetailsLoader").fadeIn();

        var ticketCodeLabel = currentCell.FormattedId;
        $("#TicketCode").val(ticketCodeLabel);

        var ticketDateTimeLabel = currentCell.Date + ' ' + currentCell.Time;
        $("#TicketDateTime").val(ticketDateTimeLabel);

        var ticketBetAmountlabel = currentCell.BetAmmount;
        $("#TicketBetAmount").val(ticketBetAmountlabel);

        var ticketAmountToWinlabel = currentCell.PayAmmount;
        $("#TicketAmountToWin").val(ticketAmountToWinlabel);
        $("#TeaserDetailLabel").html('');

        $.getJSON(getBetDetailsUrl,
                        { BetCode: id },
                        function(data) {
                            $('#TicketDetails').empty();
                            $('#TicketDetails').append('<tr><th>Código</th><th>Nombre</th><th>Jugada</th><th></th><th>Periodo</th><th>Precio</th></tr>');
                            if (data.details.length > 0) {
                                $.each(data.details, function(i, item) {
                                    var teaserHighlight = "";

                                    if (data.isTeaser == "True") {
                                        teaserHighlight = ((Math.floor(i / data.teaserPick)) % 2) == 1 ? " even" : "";
                                        $("#TeaserDetailLabel").html('Teaser Pick ' + data.teaserPick);
                                    }

                                    $('#TicketDetails').append('<tr class="TicketDetailRow_Status' + item.Status + teaserHighlight + '">' +
                                        '<td>' + item.EntityCode + '</td>' +
                                        '<td>' + item.EntityName + '</td>' +
                                        '<td>' + item.BetTypeName + '</td>' +
                                        '<td>' + (item.BetExtraValue != null && item.BetExtraValue != 0 ? item.BetExtraValue : '') + '</td>' +
                                        '<td>' + item.PeriodName + '</td>' +
                                        '<td>' + item.Nomial + '</td>' +
                                        '</tr>');
                                });
                            }

                            $("#TicketDetailsLoader").fadeOut();
                        });
        $("#TicketDetail").dialog('open');
    }

    reloadDailyLimitsGrids();
});