$(function() {
    //Binding the previous numbers
    BindPreviousNumbers();
    // TODO: remove the next line. it's used for test
    UpdateCompanyTicketLimitTotals();

    //Adds a restricted number to the collection
    $("#AddNumber").click(function() {
        //Retrieving info
        var rowCount = $('#TicketTypeLimits tr').length;
        var ticketTypeID = $("#TicketType option:selected").val();
        var ticketTypeTitle = $("#TicketType option:selected").text();
        var minimum = $("#minimumLimit").val();
        var maximum = $("#maximumLimit").val();
        var regex = /^[-+]?[0-9]+(\.[0-9]+)?$/;
        if (ticketTypeTitle != 'Seleccione un tipo de jugada' && minimum && maximum) {
            $('.field-validation-error').html('');

            if (!regex.test(minimum) || !regex.test(maximum)) {
                alert('Debe introducir valores válidos como los límites.');
            }
            else {
                //Verifying if the table header needs to be added
                if (rowCount == 0) {
                    BuildTableHeader();
                }

                //Verifying if the ticketTypeID was already added
                if (!ValidateNumber(ticketTypeID)) {
                    alert('Ya agregó un límite para esta jugada');
                }
                else {
                    // TODO: The id field is being misused for minimun and maximum cells (use name instead). it is not unique,
                    // is being repeated among rows
                    //Adding the limit to the table
                    UpdateRows(ticketTypeID, ticketTypeTitle, minimum, maximum);
                    $('img[name="loader"]').hide();
                    //Binding the new row actions.
                    BindActions();

                    //Binding data values
                    BindData();
                    
                    // Update totals
                    UpdateCompanyTicketLimitTotals();
                    
                    //Resetting the values
                    $("#TicketType").find("option[value='']").attr('selected', 'selected');
                    $("#minimumLimit").val('');
                    $("#maximumLimit").val('');
                }
            }
        }
        else {
            alert('Debe seleccionar un tipo de jugada & debe introducir valores válidos como límites.'); //Error msg
        }
    });
    
    $('#CompanyId').change(function() { UpdateCompanyTicketLimitTotals() });
});

function BuildTableHeader() {
    $('#TicketTypeLimits').append('<tr><th>Tipo Ticket</th><th>Venta Mínima</th><th>Venta Máxima</th><th>Ventas Máxima Consorcio</th><th></th></tr>');
}

function BindPreviousNumbers() {
    var ticketTypes = $("#TicketTypes").val().split(";");
    if (ticketTypes.length > 0) {
        //Builds table header
        BuildTableHeader();

        //Adds the table rows
        for (var i = 0; i < ticketTypes.length; i++) {
            if (ticketTypes[i]) {
                var value = ticketTypes[i].split(",");

                if (value.length > 0) {
                    var minimum = value[0];
                    var maximum = value[1];
                    var ticketTypeID = value[2];
                    var ticketTypeTitle = value[3];
                    UpdateRows(ticketTypeID, ticketTypeTitle, minimum, maximum);
                    $('img[name="loader"]').hide();
                }
            }
        }

        //Binding the new row actions.
        BindActions();

        //Binding data values
        BindData();
    }
}

//Validates if the number exists for a lotto
function ValidateNumber(rowID) {
    if ($("#" + rowID).size() > 0) {
        return false;
    }
    else {
        return true;
    }
}

//Removes a row
function RemoveRow(rowID) {
    var rowCount = $('#TicketTypeLimits tr').length;
    if (rowCount == 2) {
        $('#TicketTypeLimits tr').remove();
    }
    else {
        $("#" + rowID).remove();
    }

    //Binding data values
    BindData();
}

//Cancels the form edit view
function CancelEdit(rowID) {
    //Retrieving row
    var row = $("#" + rowID);

    //Retrieving values
    var ticketTypeID = row.attr('ticketTypeID');
    var minimum = row.attr('minimum');
    var maximum = row.attr('maximum');
    var ticketTypeTitle = $("#ddl" + rowID).find("option[value=" + ticketTypeID + "]").text();

    //Replacing editable content
    row.find('#minimum').removeClass('focused').val(minimum);
    row.find('#maximum').removeClass('focused').val(maximum);
    row.find('#ddl' + rowID).parent().html(ticketTypeTitle);
    row.find('a').parent().html('<a onclick=javascript:RemoveRow(' + ticketTypeID + ');>Remover</a>');
}

//Saves the changes made to the number
function SaveEdit(rowID) {
    //Retrieving row
    var row = $('#' + rowID);

    //Retrieving values
    var newMinimum = row.find('#minimum').val();
    var newMaximum = row.find('#maximum').val();

    if (newMinimum && newMaximum) {
        var regex = /^[-+]?[0-9]+(\.[0-9]+)?$/;
        if (!regex.test(newMinimum) || !regex.test(newMaximum)) {
            alert('Debe introducir valores válidos como los límites.');
        }
        else {

            var newticketTypeID = $('#ddl' + rowID + ' option:selected').val();
            var newticketTypeTitle = $('#ddl' + rowID + ' option:selected').text();

            if (!ValidateNumber(newticketTypeID) && rowID != (newticketTypeID)) {
                alert('Ya agrego los límites para la jugada seleccionada');
            }
            else {
                //Replacing editable content
                row.find('#minimum').removeClass('focused').val(newMinimum);
                row.find('#maximum').removeClass('focused').val(newMaximum);
                row.find('#ddl' + rowID).parent().html(newticketTypeTitle);
                row.find('a').parent().html('<a onclick=javascript:RemoveRow(' + newticketTypeID + ');>Remover</a>');

                //Changing the table row attributes
                row.attr('id', newticketTypeID);
                row.attr('ticketTypeID', newticketTypeID);
                row.attr('minimum', newMinimum);
                row.attr('maximum', newMaximum);
                row.attr('dataValue', newMinimum + ',' + newMaximum + ',' + newticketTypeID);
            }
        }
    }
    else {
        alert('Debe introducir los límites correspondientes a la jugada.');
    }

    //Binding data values
    BindData();
    
    // Update totals
    UpdateCompanyTicketLimitTotals();
}

//Binds the form edit actions
function BindActions() {
    $('.field').focus(function() {
        var row = $(this).parent().parent();
        //Adding focused css class
        row.find('.field').addClass('focused');

        //Setting the selected row Id
        var rowID = $(this).parent().parent().attr('id');

        //Clonning lottos ddl
        var clone = $('#TicketType').clone();
        clone.attr('id', 'ddl' + rowID);

        //Retrieving selected value
        var value = row.attr('ticketTypeID');

        //Setting up the editable space for lottos
        row.find("td:first").html(clone);

        //Removing first option
        $("#" + clone.attr('id') + " option[value='']").remove();

        //selecting value
        clone.find('option[value=' + value + ']').attr('selected', 'selected');

        //Showing up the drop down with the lotteries
        row.find("td:last").html('<a onclick="javascript:SaveEdit(' + rowID + ')">Salvar</a>&nbsp;<a onclick="javascript:CancelEdit(' + rowID + ')">Cancelar</a>');
    });
}

function BindData() {
    var dataValues = new Array();

    //Getting the data values
    $('#TicketTypeLimits tr').each(function() {
        var row = $(this);
        if (row.attr('datavalue')) {
            dataValues[dataValues.length] = row.attr('dataValue');
        }
    });

    //Setting the restricted numbers values
    $('#TicketTypes').val(dataValues.join(';'));
}

function UpdateCompanyTicketLimitTotals() {
    // When you are editing a merchant, the merchant's maximums have to be ignored in the company totals computing
    var ignoredMerchantId = -1;
    if ($('#SportBookToEdit_Id').size() > 0)
        ignoredMerchantId = $('#SportBookToEdit_Id').val();

    // Validates if company was selected
    if ($('#CompanyId').val() == '') {
        $('span[name="companyComputedMaximumTotal"]').html('-');
        return;
    }
    
    // Get company ticket type limits totals
    $('img[name="loader"]').show();
    $.getJSON(ControllerActions.GetTicketLimitTotalsByDivision,
        { companyId: $('#CompanyId').val(), ignoreMerchantId: ignoredMerchantId },
        function(data) {
            if (data.length > 0) {
                $.each(data, function(i, item) {
                    var row = $("#" + item.TicketTypeId);

                    //Retrieving values
                    var maximum = row.attr('maximum');

                    //Replacing editable content
                    row.find('input[name="companyMaximumTotal"]').val( item.MaximumTotal );
                    row.find('span[name="companyComputedMaximumTotal"]').html(parseInt( item.MaximumTotal ) + parseInt( maximum ) );
                    row.find('img[name="loader"]').hide();
                });
            }
        });
}

function UpdateRows(ticketTypeID, ticketTypeTitle, minimum, maximum) {
    $('#TicketTypeLimits').
                        append('<tr id="' + ticketTypeID + '" ticketTypeID="' + ticketTypeID +
                            '" ticketTypeTitle="' + ticketTypeTitle + '" minimum="' + minimum + '" maximum="' + maximum +
                            '" dataValue="' + minimum + ',' + maximum + ',' + ticketTypeID + '">' +
                            '<td>' + ticketTypeTitle + '</td>' +
                            '<td><input name="name" id="minimum" class="field" type="text" value="' + minimum + '" /></td>' +
                            '<td><input name="name" id="maximum" class="field" type="text" value="' + maximum + '" /></td>' +
                            '<td><input name="companyMaximumTotal" type="hidden"></input>' +
                               '<img name="loader" src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." />' +
                               '<span name="companyComputedMaximumTotal" class="nonEditableField"></span></td>' +
                            '<td style="width:8%"><a onclick=javascript:RemoveRow(' + ticketTypeID + ');>Remover</a></td></tr>');
}

