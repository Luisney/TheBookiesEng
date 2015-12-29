/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/BySportAndDivision");

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Liga', 'Mes Inicio Temporada', 'Mes Final Temporada', 'Deporte', '', ''],
        colModel: [
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'SeasonStartMonth', index: 'MonthStartSeason', sortable: true, width: 150 },
               { name: 'SeasonEndMonth', index: 'MonthEndSeason', sortable: true, width: 150 },
               { name: 'Sport', index: 'Sport.Name', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Name',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Ligas',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = '<a href=\"' + ControllerActions.Edit + '' + ids[i] + "\">Editar</a>";
                deleteLink = "<a onclick=\"deleteRow( " + ids[i] + " );\">Eliminar</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
            }
        }
    });

    deleteRow = function(code) {
        var name = $("#ajaxDataTable").jqGrid('getRowData', code).Name;
        $("#ajaxDataTable").jqGrid(
            'delGridRow',
            code,
            {
                reloadAfterSubmit: true,
                msg: "Desea eliminar esta división?",
                caption: "Eliminar registro",
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: ControllerActions.JsonDelete,
                mtype: "POST",
                width: 300,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar esta división:<br/> " + name + " ?");
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
