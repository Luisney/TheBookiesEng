/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(function() {
    $('#sportNomialTabs').tabs();

    $('#SportNomialViewModel_Male').focus().select();

    $('#SportNomialViewModel_SportCode').change(function() {
        $.getJSON( ControllerActions.FilterDivisionsBySport, { SportCode: $(this).val() }, function(data) {
            $('#SportNomialViewModel_DivisionCode').empty();
            if (data.length > 0) {
                $.each(data, function(i, item) {
                    $('#SportNomialViewModel_DivisionCode').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                });
            }
        });
    });
});
