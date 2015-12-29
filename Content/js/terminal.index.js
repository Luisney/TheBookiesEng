/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function () {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByTerminal");

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Terminal Id', 'Coban', 'Serial', 'Maker', 'Model', 'Banca', 'Status', '', ''],
        colModel: [
               { name: 'TerminalId', index: 'TerminalId', sortable: true, width: 100 },
               { name: 'Coban', index: 'Mac', sortable: true, width: 170 },
               { name: 'Serial', index: 'Serial', sortable: true, width: 140 },
               { name: 'Maker', index: 'TerminalMaker.Name', sortable: true, width: 150 },
               { name: 'Model', index: 'TerminalModel.Name', sortable: true, width: 120 },
               { name: 'SportBook', index: 'SportBook.Name', sortable: true, width: 120 },
               { name: 'Status', index: 'Status', sortable: true, width: 100 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
                      { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
         ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'TerminalId',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Terminal',
        gridComplete: function () {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                editLink = '<a href=\"' + ControllerActions.Edit + ids[i] + "\">Editar</a>";
                deleteLink = "<a class='delete-link' id=\"" + ids[i] + "\">Eliminar</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
            }
            activateDelete();
        }
    });

    $('#submitButton').click(
            function () {
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
    $('.delete-link').click(function () {
        // Build message string
        var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).TerminalId;

        $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
            caption: "Eliminar registro",
            reloadAfterSubmit: true,
            bSubmit: "Eliminar",
            bCancel: "Cancelar",
            url: ControllerActions.JsonDelete,
            mtype: "POST",
            width: 350,
            // Workaround for bug: msg is not correctly updated after first rendering.
            beforeShowForm: function (formid) {
                $(".delmsg", formid).html("Desea eliminar esta terminal?<br/> " + name);
            }
        });
    });
}