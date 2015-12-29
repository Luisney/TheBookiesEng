/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/BySportAndDivision");

    $("#copy-dialog .loading").hide();
    $("#range-dialog .loading").hide();

    $("#copy-dialog").dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        width: 450,
        buttons: {
            "Cancelar": function() {
                $("#copy-dialog").dialog('close');
            },
            Ok: function() {
                $("#copy-dialog .loading").show();
                $("#copy-dialog .dialog-content").hide();
                $.post(ControllerActions.CopyNomialsToSport, { SportCodeA: $('#SportA').val(), SportCodeB: $('#SportB').val(), DivisionA: $('#DivisionA').val(), DivisionB: $('#DivisionB').val() }, function(data) {
                    $("#copy-dialog .loading").hide();
                    $("#copy-dialog .dialog-content").show();
                    $("#copy-dialog").dialog('close');

                    $("#ajaxDataTable").trigger("reloadGrid");

                }, "json");
            }

        }
    });


    $('#SportA').prepend('<option value="-1" selected="true">Deporte</option>');
    //$('#DivisionA').append('<option value="-1">Ninguna</option>');
    $('#SportA').change(function() {
        $.getJSON(ControllerActions.GetDivisionsBySport, { SportCode: $(this).val() }, function(data) {
            $('#DivisionA').empty();
            //$('#DivisionA').append('<option value="-1">Ninguna</option>');
            if (data.length > 0) {
                $.each(data, function(i, item) {
                    $('#DivisionA').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                });
            } else {
                //$('#DivisionA').append('<option value=-1>No hay ligas disponibles</option>');
            }
        });
    })

    $('#SportB').prepend('<option value="-1" selected="true">Deporte</option>');
    //$('#DivisionB').append('<option value="-1">Ninguna</option>');
    $('#SportB').change(function() {
        $.getJSON(ControllerActions.GetDivisionsBySport, { SportCode: $(this).val() }, function(data) {
            $('#DivisionB').empty();
            //$('#DivisionB').append('<option value="-1">Ninguna</option>');
            if (data.length > 0) {
                $.each(data, function(i, item) {
                    $('#DivisionB').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                });
            } else {
                //$('#DivisionA').append('<option value=-1>No hay ligas disponibles</option>');
            }
        });
    })


    $('#SportForRange').prepend('<option value="-1" selected="true">Deporte</option>');
    $('#SportForRange').change(function() {
        $.getJSON(ControllerActions.GetDivisionsBySport, { SportCode: $(this).val() }, function(data) {
            $('#DivisionForRange').empty();
            if (data.length > 0) {
                $.each(data, function(i, item) {
                    $('#DivisionForRange').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                });
            }
        });
    })

    $("#range-dialog").dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        buttons: {
            "Cancelar": function() {
                $("#range-dialog").dialog('close');
            },
            Ok: function() {
                if ($('#ranges-form').validate().form()) {
                    $("#range-dialog .loading").show();
                    $("#range-dialog .dialog-content").hide();

                    $.post(ControllerActions.AddNomialsByRange, { Min: $('#RangeMin').val(), Max: $('#RangeMax').val(), IncrementMale: $('#IncrementMale').val(), IncrementFemale: $('#IncrementFemale').val(), StartingFemale: $('#StartingFemale').val(), SportCode: $('#SportForRange').val(), DivisionCode: $('#DivisionForRange').val() }, function(data) {
                        $("#range-dialog .loading").hide();
                        $("#range-dialog .dialog-content").show();
                        $("#range-dialog").dialog('close');

                        $("#ajaxDataTable").trigger("reloadGrid");

                    }, "json");
                }
            }
        }
    });

    // Missing: localization, validation of range ie.: min has to be less than max and displaying of error messages in a friendlier way

    $('#ranges-form').validate({ focusCleanup: true });

    $('#copy-btn').click(function() {
        //$("#dialog").remove();
        $('#copy-dialog').dialog('open');
    });

    $('#range-btn').click(function() {
        //$("#dialog").remove();
        $('#range-dialog').dialog('open');
    });

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['', 'Deporte', 'Liga', 'Macho', 'Hembra', '', ''],
        colModel: [
                { name: 'Id', index: 'Id', hidden: true },
                { name: 'Sport', index: 'Sport.Name', sortable: true, width: 150 },
                { name: 'Division', index: 'Division.Name', sortable: true, width: 150 },
                { name: 'Male', index: 'Male', sortable: true, width: 100 },
                { name: 'Female', index: 'Female', sortable: true, width: 100 },
                { name: 'Action', index: 'Action', sortable: false, width: 80 },
                { name: 'Action2', index: 'Action2', sortable: false, width: 80 },
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Sport.Name',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Precios',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = '<a href=\"' + ControllerActions.Edit + ids[i] + "\">Editar</a>";
                deleteLink = "<a class='delete-link' id=\"" + ids[i] + "\">Eliminar</a>";
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
                        url: ControllerActions.JsonSearch + "?SearchText=" + escape(searchText),
                        page: 1
                    })
                    .trigger("reloadGrid");
            });
});

function activateDelete() {
    $('.delete-link').click(function() {
        // Build message string
        var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Sport + '<br/>' + 
        'División: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Division + '<br/>' + 
        'Macho: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Male;
                
        $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
            caption: "Eliminar registro",
            reloadAfterSubmit: true,
            bSubmit: "Eliminar",
            bCancel: "Cancelar",
            url: ControllerActions.JsonDelete,
            mtype: "POST",
            width: 350,
            // Workaround for bug: msg is not correctly updated after first rendering.
            beforeShowForm: function(formid) {
                $(".delmsg", formid).html("Desea eliminar este precio?<br/> " + name);
            }
        });
    });
}