/// <reference path="jquery-1.4.1-vsdoc.js"/>

$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByBetTypeName");

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Nombre', 'Periodo', 'Abrev.', 'Macho', 'Hembra', 'Gavela', 'Totales', 'Máximo', '', ''],
        colModel: [
               { name: 'Name', index: 'Name', sortable: true, width: 300 },
               { name: 'Period', index: 'Period.Name', sortable: true, width: 100 },
               { name: 'Shortcut', index: 'Shortcut', sortable: true, width: 80 },
               { name: 'Male', index: 'Male', formatter: booleanFormatter, align: 'center', sortable: true, width: 60 },
               { name: 'Female', index: 'Female', formatter: booleanFormatter, align: 'center', sortable: true, width: 60 },
               { name: 'Score', index: 'Score', formatter: booleanFormatter, align: 'center', sortable: true, width: 60 },
               { name: 'AppliesToTotals', formatter: booleanFormatter, align: 'center', index: 'AppliesToTotals', sortable: true, width: 60 },
               { name: 'Maximum', index: 'Maximum', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Name',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Plantillas de Apuesta',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = '<a href=\"'+ ControllerActions.Edit +'' + ids[i] + "\">Editar</a>";
                deleteLink = "<a onclick=\"deleteRow( " + ids[i] + " );\">Eliminar</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
            }
        }
    });

    function booleanFormatter(cellvalue, options, rowObject) {
        if (String(cellvalue).toUpperCase() == 'TRUE')
            return "<img src=\"/Content/images/true.png\"/>";
        else
            return "<img src=\"/Content/images/false.png\"/>";
    }

    deleteRow = function(code) {
        var name = $("#ajaxDataTable").jqGrid('getRowData', code).Name + " - " + $("#ajaxDataTable").jqGrid('getRowData', code).Shortcut;

        $("#ajaxDataTable").jqGrid(
            'delGridRow',
            code,
            {
                reloadAfterSubmit: true,
                caption: "Eliminar registro",
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: ControllerActions.JsonDelete,
                mtype: "POST",
                width: 350,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar este tipo de apuesta:<br/> " + name + " ?");
                }
            });
    }

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