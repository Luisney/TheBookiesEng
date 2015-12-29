/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    // TODO: THIS works?
    $('#DefaultBetType_1_Male').focus().select();

    $('#BetTemplateViewModel_SportNomialSportCode').change(function() {
        FilterSportNomialsList();
    });

    $('#BetTemplateViewModel_SportNomialCode').change(function() {
        FilterBetTypesList();
    });

    $('#BetTemplateViewModel_BetTypeCode').change(function() {
        FilterBetTypeFields();
    });

    // Filtering input fields according to the bet type
    FilterBetTypeFields();

    setTimeout(function() {
        $('#validation-summary-errors').hide('slow');
    }, 3000);

    $('#BetTemplateViewModel_ForeignMale').focus();
});

FilterSportNomialsList = function() {
    $.getJSON('/SportNomial/GetNomialsBySport', { SportCode: $('#BetTemplateViewModel_SportNomialSportCode').val() }, function(data) {
        $('#BetTemplateViewModel_SportNomialCode').empty();
        if (data.length > 0) {
            $.each(data, function(i, item) {
                $('#BetTemplateViewModel_SportNomialCode').append('<option value="' + item.Code + '">' + item.Label + '</option>');
            });
        } else {
            $('#BetTemplateViewModel_SportNomialCode').append('<option value=-1>No tiene nomios</option>');
        }
        FilterBetTypesList();
    });
}

FilterBetTypesList = function() {
    $.getJSON('/BetType/GetAvailableBetTypes/', { SportCode: $('#BetTemplateViewModel_SportNomialSportCode').val(), SportNomialCode: $('#BetTemplateViewModel_SportNomialCode').val() }, function(data) {
        $('#BetTemplateViewModel_BetTypeCode').empty();
        if (data.length > 0) {
            $.each(data, function(i, item) {
                $('#BetTemplateViewModel_BetTypeCode').append('<option value="' + item.Code + '">' + item.Label + '</option>');
            });
        } else {
            $('#BetTemplateViewModel_BetTypeCode').append('<select value=-1>No hay tipos de apuestas disponibles</select>');
        }
        FilterBetTypeFields();
    });
}

FilterBetTypeFields = function() {
    $.getJSON('/BetType/HasScore', { BetTypeCode: $('#BetTemplateViewModel_BetTypeCode').val() }, function(data) {
        if (data) {
            $('#BetTemplateViewModel_LocalValue_Label').fadeIn('fast');
            $('#BetTemplateViewModel_LocalValue').fadeIn('fast');
            $('#BetTemplateViewModel_ForeignValue_Label').fadeIn('fast');
            $('#BetTemplateViewModel_ForeignValue').fadeIn('fast');
        } else {
            $('#BetTemplateViewModel_LocalValue_Label').fadeOut('fast');
            $('#BetTemplateViewModel_LocalValue').fadeOut('fast');
            $('#BetTemplateViewModel_ForeignValue_Label').fadeOut('fast');
            $('#BetTemplateViewModel_ForeignValue').fadeOut('fast');
        }
    });
}