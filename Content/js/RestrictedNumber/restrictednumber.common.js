/// <reference path="..\jquery-1.4.1-vsdoc.js" />
var ticketNumbersHeaders = new Array('Lotería', '', '');
var entityAssociationHeaders = new Array('Centro de Acopio', 'Banca', 'Terminal', '');

$(function() {
    // Info dialog
    $('#infoDialog').dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        buttons: {
            "Ok": function() {
                $("#infoDialog").dialog('close');
            }
        }
    });
    
    //Adding the date picker
    $(".calendar").datepicker({
        dateFormat: 'dd/mm/yy'
    });

    // Bind previous values
    BindPreviousTicketNumbers();
    // Adds a restricted number to the collection
    $("#AddNumber").click(AddTicketNumber);

    // Bind previous values
    BindPreviousAssociations('#associations', '#EntityAssociations');
    // Adds a entity association to the collection
    $("#AddEntityRelationship").click(function() { AddEntityAssociation('#EntityAssociations') });

    var storingCenterListIdSelector = '#StoringCenterId';
    var sportBookListId = 'SportBookId';
    var sportBookListIdSelector = '#SportBookId';
    var terminalListId = 'TerminalId';
    var terminalListIdSelector = '#TerminalId';
    
    // Cascading dropdowns
    $(storingCenterListIdSelector).change(function() {
        if ($(storingCenterListIdSelector).val() == 0) {
            $(sportBookListIdSelector).empty();
            $(sportBookListIdSelector).append('<option value="0">Todos</option>');
            return;
        }
        $(sportBookListIdSelector).empty();
        $(sportBookListIdSelector).append('<option value="-1">Cargando...</option>');
        $(terminalListIdSelector).empty();
        $(terminalListIdSelector).append('<option value="0">Todas</option>');

        $.getJSON(ControllerActions.FilterSportBooksByStoringCenter,
                    { storingCenterId: $(storingCenterListIdSelector).val() },
                    function(data) {
                        $(sportBookListIdSelector).empty();
                        $(sportBookListIdSelector).append('<option value="0">Todos</option>');
                        if (data.length > 0) {
                            $.each(data, function(i, item) {
                                $(sportBookListIdSelector).append('<option value="' + item.value + '">' + item.label + '</option>');
                            });
                        }
                    }
                );
    });

    $(sportBookListIdSelector).change(function() {
        if ($(sportBookListIdSelector).val() == 0) {
            $(terminalListIdSelector).empty();
            $(terminalListIdSelector).append('<option value="0">Todos</option>');
            return;
        }
        $(terminalListIdSelector).empty();
        $(terminalListIdSelector).append('<option value="-1">Cargando...</option>');

        $.getJSON(ControllerActions.FilterTerminalsBySportBook,
                    { SportBookId: $(sportBookListIdSelector).val() },
                    function(data) {
                        $(terminalListIdSelector).empty();
                        $(terminalListIdSelector).append('<option value="0">Todas</option>');
                        if (data.length > 0) {
                            $.each(data, function(i, item) {
                                $(terminalListIdSelector).append('<option value="' + item.value + '">' + item.label + '</option>');
                            });
                        }
                    }
                );
    });
});

// Build table headers
function BuildTicketNumbersTableHeader(selector, columns) {
    var header = '<tr>';
    $.each(columns, function(i, item) {
        header += '<th>' + item + '</th>';
    });
    header += '</tr>';
    $(selector).append(header);
}

// Add number to the table
AddTicketNumber = function() {
    //Retrieving info
    var rowCount = $('#RestrictedNumbers tr').length;
    var lottoID = $("#LottoId option:selected").val();
    var lottoTitle = $("#LottoId option:selected").text();
    var regex = /^\d*$/;

    if (!ValidateLotteryToAdd()) {
        // Info message
        $('#infoDialog').dialog('open');
        $('#infoDialogMessage').text('La loteria ' + lottoTitle + ' ya fue agregada');
        return;
    }

    //Verifying if the table header needs to be added
    if (rowCount == 0)
        BuildTicketNumbersTableHeader('#RestrictedNumbers', ticketNumbersHeaders);

    //Adding the number to the table
    $('#RestrictedNumbers').append('<tr id="' + lottoID + '" lottoID="' + lottoID + '" dataValue="' + lottoID + '"><td>' + lottoTitle + '</td><td style="width:8%"><a onclick=javascript:RemoveTicketNumberRow(' + lottoID + ');>Remover</a></td></tr>');

    //Binding the new row actions.
    BindTicketNumbersActions();

    //Binding data values
    BindData('#RestrictedNumbers', '#numbers');
}

// Validate the lottery being added
ValidateLotteryToAdd = function() {
    var lottoID = $("#LottoId option:selected").val();
    if ($('#RestrictedNumbers').find('tr[lottoID="' + lottoID + '"]').size() == 0)
        return true;
    return false;
}

function BindPreviousTicketNumbers() {
    var numbers = $("#numbers").val().split(";");
    if (numbers.length > 0) {
        //Builds table header
        BuildTicketNumbersTableHeader('#RestrictedNumbers', ticketNumbersHeaders);

        //Adds the table rows
        for (var i = 0; i < numbers.length; i++) {
            if (numbers[i]) {
                var value = numbers[i].split(",");
                if (value.length > 0) {
                    var lottoID = value[0];
                    var lottoTitle = $('#LottoId').find("option[value=" + lottoID + "]").text();

                    $('#RestrictedNumbers').append('<tr id="' + lottoID + '"' +
                        ' lottoID="' + lottoID + '" dataValue="' + lottoID + '">' +
                        '<td>' + lottoTitle + '</td>' +
                        '<td style="width:8%"><a onclick=javascript:RemoveTicketNumberRow(' + lottoID + ');>Remover</a></td></tr>');
                }
            }
        }

        //Binding the new row actions.
        BindTicketNumbersActions();

        //Binding data values
        BindData('#RestrictedNumbers', '#numbers');
    }
}

// Removes a row
function RemoveTicketNumberRow(rowID) {
    var rowCount = $('#RestrictedNumbers tr').length;
    if (rowCount == 2) {
        $('#RestrictedNumbers tr').remove();
    }
    else {
        $("#" + rowID).remove();
    }

    //Binding data values
    BindData('#RestrictedNumbers', '#numbers');
}

// Cancels the form edit view
function CancelTicketNumbersEdit(rowID) {
    // Retrieving row
    var row = $("#" + rowID);

    // Retrieving values
    var lottoID = row.attr('lottoID');
    var lottoText = $("#ddl" + rowID).find("option[value=" + lottoID + "]").text();

    // Replacing editable content
    row.find('.field').removeClass('focused').val(number);
    row.find('#ddl' + rowID).parent().html(lottoText);
    row.find('a').parent().html('<a onclick=javascript:RemoveTicketNumberRow(' + lottoID + ');>Remover</a>');
}

//Saves the changes made to the number
function SaveTicketNumbersEdit(rowID) {
    //Retrieving row
    var row = $('#' + rowID);

    //Retrieving values
    var newLottoID = $('#ddl' + rowID + ' option:selected').val();
    var newLottoText = $('#ddl' + rowID + ' option:selected').text();

    //Replacing editable content            
    row.find('#ddl' + rowID).parent().html(newLottoText);
    row.find('a').parent().html('<a onclick=javascript:RemoveTicketNumberRow(' + newLottoID + ');>Remover</a>');

    //Changing the table row attributes
    row.attr('id', newLottoID );
    row.attr('lottoID', newLottoID);
    row.attr('dataValue', newLottoID);

    //Binding data values
    BindData('#RestrictedNumbers', '#numbers');
}

// Binds the click event upon the rows (makes them editable on focus)
function BindTicketNumbersActions() {
    $('.field').focus(function() {
        // Adding focused css class
        $(this).addClass('focused');

        // Setting the selected row Id
        var rowID = $(this).parent().parent().attr('id');

        // Clonning lottos ddl
        var clone = $('#LottoId').clone();
        clone.attr('id', 'ddl' + rowID);

        // Retrieving selected value
        var value = $(this).parent().parent().attr('lottoID');

        // Setting up the lotteries drowpdown in the next space
        $(this).parent().next().html(clone);

        // Selecting value
        clone.find('option[value=' + value + ']').attr('selected', 'selected');

        // Showing up the drop down with the lotteries
        clone.parent().next().html('<a onclick="javascript:SaveTicketNumbersEdit(' + rowID + ')">Salvar</a>&nbsp;<a onclick="javascript:CancelTicketNumbersEdit(' + rowID + ')">Cancelar</a>');
    });
}

validateNewEntityAssociation = function() {
    var storingCenterId = $("#StoringCenterId").val();
    var sportBookId = $("#SportBookId").val();
    var terminalId = $("#TerminalId").val();

    // Do not to add elements when dropdown contains no data
    if (sportBookId == -1 || sportBookId == undefined) {
        alert("Seleccione una banca por favor");
        return false;
    }
    if (terminalId == -1 || terminalId == undefined) {
        alert("Seleccione una terminal");
        return false;
    }
    // Validate existence
    var newId = buildEntityAssociationId(storingCenterId, sportBookId, terminalId);
    if ($('#' + newId).size() > 0) {
        alert("Este numero restringido ya aplica para esta condición");
        return false;
    }

    return true;
}

// Add entity association to the table
AddEntityAssociation = function(targetSelector) {
    //Retrieving info
    var rowCount = $(targetSelector + ' tr').length;
    var storingCenterId = $("#StoringCenterId").val();
    var storingCenterLabel = $("#StoringCenterId option:selected").text();
    var sportBookId = $("#SportBookId").val();
    var sportBookLabel = $("#SportBookId option:selected").text();
    var terminalId = $("#TerminalId").val();
    var terminalLabel = $("#TerminalId option:selected").text();

    if (!validateNewEntityAssociation())
        return;

    //Verifying if the table header needs to be added
    if (rowCount == 0) {
        BuildTicketNumbersTableHeader(targetSelector, entityAssociationHeaders);
    }

    //Adding the number to the table
    AddEntityAssociationRow(targetSelector, storingCenterId, storingCenterLabel, sportBookId, sportBookLabel, terminalId, terminalLabel);

    //Binding data values
    BindData('#EntityAssociations', '#associations');
}

AddEntityAssociationRow = function(targetSelector, storingCenterId, storingCenterLabel, sportBookId, sportBookLabel, terminalId, terminalLabel) {

    var elementId = buildEntityAssociationId(storingCenterId, sportBookId, terminalId);
    $(targetSelector).append('<tr id="EntityAssociation_' + storingCenterId + '_' + sportBookId + '_' + terminalId + '"' +
            ' storingCenterId="' + storingCenterId + '"' +
            ' sportBookId="' + sportBookId + '"' +
            ' dataValue="' + storingCenterId + ',' + sportBookId + ',' + terminalId + ',' + storingCenterLabel + ',' + sportBookLabel + ',' + terminalLabel + '">' +
            '<td>' + storingCenterLabel + '</td>' +
            '<td>' + sportBookLabel + '</td>' +
            '<td>' + terminalLabel + '</td>' +
            '<td style="width:8%"><a onclick="RemoveEntityAssociation( \'' + elementId + '\' );">Remover</a></td></tr>');
}

buildEntityAssociationId = function(storingCenterId, sportBookId, terminalId) {
    return 'EntityAssociation_' + storingCenterId + '_' + sportBookId + '_' + terminalId;
}

function BindPreviousAssociations(sourceFieldSelector, targetSelector) {
    var elements = $(sourceFieldSelector).val().split(";");
    if (elements.length > 0) {
        //Builds table header
        BuildTicketNumbersTableHeader(targetSelector, entityAssociationHeaders);

        //Adds the table rows
        $.each(elements, function(i, item) {
            cells = item.split(",");
            if (cells.length >= 6) {
                storingCenterId = cells[0];
                sportBookId = cells[1];
                terminalId = cells[2];
                storingCenterLabel = cells[3];
                sportBookLabel = cells[4];
                terminalLabel = cells[5];

                AddEntityAssociationRow(targetSelector, storingCenterId, storingCenterLabel, sportBookId, sportBookLabel, terminalId, terminalLabel);
            }
        });

        //Binding data values
        BindData(targetSelector, sourceFieldSelector);
    }
}

// Removes a row
function RemoveEntityAssociation(rowID) {
    var rowCount = $('#EntityAssociations tr').length;
    if (rowCount == 2) {
        $('#EntityAssociations tr').remove();
    }
    else {
        $("#" + rowID).remove();
    }

    //Binding data values
    BindData('#EntityAssociations', '#associations');
}



// Binds the row value to the hidden field
function BindData(sourceTableSelector, targetFieldSelector) {
    var dataValues = new Array();

    // Get and concatenate each row's datavalue
    $(sourceTableSelector).find('tr').each(function() {
        var row = $(this);
        if (row.attr('datavalue')) {
            dataValues[dataValues.length] = row.attr('dataValue');
        }
    });

    //Setting the restricted numbers values
    $(targetFieldSelector).val(dataValues.join(';'));
}