/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    FilterSportNomialsList();

    $('#BetTemplateViewModel_SportNomialSportCode').change(function() {
        FilterSportNomialsList();
    });

    $('#BetTemplateViewModel_SportNomialCode').change(function() {
        FilterBetTypesList();
    });

    $('#BetTemplateViewModel_BetTypeCode').change(function() {
        FilterBetTypeFields();
    });

    // Automated Fields
    $('#BetTemplateViewModel_LocalMale').blur(function() {
        GetFemaleNomialForMale($(this).val(), '#BetTemplateViewModel_ForeignFemale', '#' + this.id);
    });

    $('#BetTemplateViewModel_ForeignMale').blur(function() {
        GetFemaleNomialForMale($(this).val(), '#BetTemplateViewModel_LocalFemale', '#' + this.id);
    });

    $('#BetTemplateViewModel_LocalValueMale').blur(function() {
        SetFemaleSpread($(this).val(), '#BetTemplateViewModel_ForeignValueFemale', '#' + this.id);
    });

    $('#BetTemplateViewModel_ForeignValueMale').blur(function() {
        SetFemaleSpread($(this).val(), '#BetTemplateViewModel_LocalValueFemale', '#' + this.id);
    });

    setTimeout(function() {
        $('#validation-summary-errors').hide('slow');
    }, 3000);

    $('#BetTemplateViewModel_LocalValueMale').focus().select();
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

GetFemaleNomialForMale = function(maleValue, fieldId, maleFieldId) {
    if (!isNaN(maleValue)) {
        var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(fieldId).parent()).css('position', 'absolute');

        $.getJSON('/SportNomial/GetNomialValue', { BaseNomial: maleValue, SportCode: $('#BetTemplateViewModel_SportNomialSportCode').val() }, function(data) {
            $(fieldId).val(data);
            loader.fadeOut('fast', function() {
                loader.remove();
            });
        });
    } else {
        $("#dialog").remove();

        $("<div id=\"dialog\" title=\"Advertencia\"><p>" + maleValue + " es un valor inválido, debe ser un número</p></div>").appendTo('body');

        $("#dialog").dialog({
            bgiframe: true,
            modal: true,
            buttons: {
                Ok: function() {
                    $(this).dialog('close');
                }
            }
        });

        $(maleFieldId).val(0).focus().select();
    }
}

SetFemaleSpread = function(maleSpread, fieldId, maleFieldId) {
    if (!isNaN(maleSpread)) {
        $(fieldId).val(Math.abs(maleSpread));
    } else {
        $("#dialog").remove();

        $("<div id=\"dialog\" title=\"Advertencia\"><p>" + maleSpread + " es un valor inválido, debe ser un número</p></div>").appendTo('body');

        $("#dialog").dialog({
            bgiframe: true,
            modal: true,
            buttons: {
                Ok: function() {
                    $(this).dialog('close');
                }
            }
        });

        $(maleFieldId).val(0).focus().select();
    }
}