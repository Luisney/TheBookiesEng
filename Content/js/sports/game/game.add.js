/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function () {
    // Division dropdown
    $('#Sport').change(function () {
        $.getJSON(ControllerActions.FilterDivisionsBySport,
            { selected: $('#Sport').val() },
            function (data) {
                $('#DivisionCode').empty();
                if (data.length > 0) {
                    $.each(data, function (i, item) {
                        $('#DivisionCode').append('<option value="' + item.value + '">' + item.label + '</option>');
                    });
                }
                $('#DivisionCode').change();
            });
    });

    // Reload available bets
    LoadAvailableBets();

    // Refresh team codes, show/hide spread for base periods
    $('#DivisionCode').change(function () {
        LoadAvailableBets();

        $.getJSON('/Sports/Game/GetTeamsByDivision', { DivisionCode: $(this).val() }, function (data) {
            $('#TeamCodeAId').empty();
            $('#TeamCodeBId').empty();

            if (data.length > 0) {
                $.each(data, function (i, item) {
                    $('#TeamCodeAId').append('<option value="' + item.Code + '">' + item.Label + '</option>');
                    $('#TeamCodeBId').append('<option value="' + item.Code + '">' + item.Label + '</option>');
                });
            }
        });
    });

    // Triggers divisioncode change event
    if ($('#DivisionCode').val())
        $('#DivisionCode').change();

    // TODO: revise for deletion as this is no longer needed after we started using tokeninput to select the teams
    $('#TeamCodeAId').change(function () {
        var val = $('TeamCodeBId').val();
        var TeamCode;
        $('TeamCodeAId').html('');
        $.getJSON('/Sports/Game/GetTeamsByDivision', { DivisionCode: $('#DivisionCode').val() }, function (data) {
            $('#TeamCodeBId').html('');

            if (data.length > 0) {
                $.each(data, function (i, item) {
                    if (item.Code == $('#TeamCodeAId').val()) {
                        TeamCode = item.TeamCode
                    }
                });

                $.each(data, function (i, item) {
                    if (item.TeamCode != TeamCode) {
                        $('#TeamCodeBId').append('<option value="' + item.Code + '">' + item.Label + '</option>');
                    }
                });
            }
        })
    });

    // Start date DatePicker
    $("#StartDate").datepicker({
        dateFormat: 'dd/mm/yy',
        onSelect: function (dateText) { FillFauxDate(); }
    });
});

LoadAvailableBets = function () {
    // Loading the available bet fields
    $('#DefaultBetType').load(ControllerActions.ShowDefaultAvailableBetField,
        { SportId: $('#Sport').val(), DivisionId: $('#DivisionCode').val() },
        function () {
            triggerAutoDisableAvailableBets();
        }
    );

    $('#DefaultBetTypeForTotals').load(ControllerActions.ShowDefaultAvailableBetFieldForTotals,
        { SportId: $('#Sport').val(), DivisionId: $('#DivisionCode').val() },
        function () {
            triggerAutoDisableAvailableBets();
        }
    );

    $('#BetTypes').load(ControllerActions.ShowAvailableBetsFields,
        { SportId: $('#Sport').val() },
        function () {
            triggerAutoDisableAvailableBets();
        });
}

$(function () {
    setTimeout(function () {
        $('.validation-summary-errors').hide('normal');
    }, 5000);

    FillFauxDate();

    $("#tabs").tabs();

    $('#TeamCodeAId').tokenInput(ControllerActions.GetTeamAliasesByDivision, {
        url: ControllerActions.GetTeamAliasesByDivision,
        hintText: "Escribe el nombre del Equipo",
        noResultsText: "No se encontró un equipo",
        searchingText: "Buscando...",
        tokenLimit: 1,
        searchDelay: 500,
        extraParams: {
            divisionId: function () { return $('#DivisionCode').val() },
            oppositeAliasId: function () { return $('#TeamCodeBId').val().replace(",", "") },
            date: function () { return $('#StartDate').val() }
        },
        selectCallback: function (selected) {
            $.getJSON(ControllerActions.GetTeamAlias, { AliasCode: selected }, function (alias) {
                updateVisitorLabels(alias);
            });
        }
    });

    $('#TeamCodeBId').tokenInput(ControllerActions.GetTeamAliasesByDivision, {
        url: ControllerActions.GetTeamAliasesByDivision,
        hintText: "Escribe el nombre del Equipo",
        noResultsText: "No se encontró un equipo",
        searchingText: "Buscando...",
        tokenLimit: 1,
        searchDelay: 500,
        extraParams: {
            divisionId: function () { return $('#DivisionCode').val() },
            oppositeAliasId: function () { return $('#TeamCodeAId').val().replace(",", "") },
            date: function () { return $('#StartDate').val() }
        },
        selectCallback: function (selected) {
            $.getJSON(ControllerActions.GetTeamAlias, { AliasCode: selected }, function (alias) {
                updateLocalLabels(alias);
            });
        }
    });

    $('#Hours, #Minutes, #Meridian').change(function () {
        FillFauxDate();
        return true;
    });
});

startDateValidation = function (value, element, params) {
    var wrappedElement = $(element);

    if (wrappedElement.rules()["remote"] === undefined) {
        //create a new remote rule
        var remoteRule = {
            remote: {
                url: ControllerActions.DateIsValid
            },
            messages: {
                remote: "La hora de inicio no puede ser anterior a la actual"
            }
        };

        //add the new remote validation rule to the element
        wrappedElement.rules("add", remoteRule);

        //validate element again to trigger the new rule(s)
        RevalidateElement(wrappedElement);
    }

    return true;
}

function divisionLimitsValidation(value, element, params) {
    var wrappedElement = $(element);

    if (wrappedElement.rules()["remote"] === undefined) {
        //create a new remote rule
        var remoteRule = {
            remote: {
                url: ControllerActions.DateIsValid,
                type: "post",

                data: {
                    divisionId: function () {
                        return $("#DivisionCode").val()
                    }
                }
            },

            messages: {
                remote: "Este límite no corresponde con la liga"
            }
        };

        //add the new remote validation rule to the element
        wrappedElement.rules("add", remoteRule);

        //validate element again to trigger the new rule(s)
        RevalidateElement(wrappedElement);
    }

    return true;
}

function RevalidateElement(wrappedElement) {
    if (wrappedElement.val() != "" && wrappedElement.val() != undefined) {
        //remove previous value to enforce remote validation
        wrappedElement.removeData("previousValue");
        //trigger remote validation
        $(wrappedElement[0]).closest("form").validate().element(wrappedElement[0]);
    }
}

function FillFauxDate() {
    $('#FauxDateInput').val($('#StartDate').val() + " " + $('#Hours').val() + ":" + $('#Minutes').val() + ":00 " + $('#Meridian').val());
}