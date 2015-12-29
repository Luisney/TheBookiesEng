var SelectedSportId;
openCompatibilityDialogForSport = function(SportId) {
    SelectedSportId = SportId;
    $('#compatibility-dialog').dialog('open');
    $('#Periods').empty();
    $('#Periods').append('<option value="-1">Seleccione un periodo</option>');
    $('#BetTypesForSport').empty();
    $.getJSON(ControllerActions.GetBetTypePeriods,
            {},
            function(data) {
                if (data) {
                    if (data.length > 0) {
                        $.each(data, function(i, item) {
                            $('#Periods').append('<option value="' + item.Code + '">' + item.Label + '</option>');
                        });
                    }
                }
            });
}

$(document).ready(function() {
    // Search datagrid textbox
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/BySport");

    $('#Periods').cascade({
        source: ControllerActions.GetBetTypesByPeriodAndSport,
        cascaded: "BetTypesForSport",
        dependentNothingFoundLabel: "No hay elementos",
        dependentStartingLabel: "Selecciona una apuesta",
        dependentLoadingLabel: "Cargando opciones",
        extraParams: { SportCode: function() { return SelectedSportId; }, PeriodCode: function() { return $('#Periods').val(); } },
        spinnerImg: "/Content/Images/ajax-loader-small.gif"
    });

    // View compatibility dialog
    $("#compatibility-dialog").dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        width: 400,
        buttons: {
            "Salir": function() {
                $("#compatibility-dialog").dialog('close');
            },
            "Ver": function() {
                window.location.href = ControllerActions.EditCompatibility + "?SportCode=" + SelectedSportId + "&BetTypeCode=" + $('#BetTypesForSport').val();
            }
        }
    });

    // Search datagrid
    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Nombre', 'Maxima Apuesta', 'Periodos', 'Código Inicial', 'Código Final', '', '', ''],
        colModel: [
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'Maximum', index: 'Maximum', sortable: true, width: 150 },
               { name: 'Periods', index: 'Periods', sortable: true, width: 100 },
               { name: 'StartCode', index: 'StartCode', sortable: true, width: 80 },
               { name: 'FinalCode', index: 'FinalCode', sortable: true, width: 80 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 },
               { name: 'Action3', index: 'Action3', sortable: false, width: 120 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Name',
        sortorder: 'asc',
        viewrecords: true,
        caption: 'Deportes',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = '<a href=\"' + ControllerActions.Edit + ids[i] + "\">Editar</a>";
                deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
                compatibilityLink = "<a onclick=\"openCompatibilityDialogForSport(" + ids[i] + ")\">Compatibilidad</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink, Action3: compatibilityLink });
            }

            activateDelete();
        }
    });

    // Search datagrid button
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

    // Search datagrid delete popup
    function activateDelete() {
        $('.delete-link').click(function() {
            var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Name;
            $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                caption: "Eliminar registro",
                reloadAfterSubmit: true,
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: ControllerActions.Delete,
                mtype: "POST",
                width: 300,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar este deporte:<br/> " + name + " ?");
                }
            });
        });
    }

});