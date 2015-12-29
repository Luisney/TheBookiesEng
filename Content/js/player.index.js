/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByPlayerName");

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Código', '', 'Nombre', 'Tipo de Jugador', 'Equipos', '', ''],
        colModel: [
               { name: 'Id', index: 'Id', align: 'center', sortable: true, width: 80 },
               { name: 'Image', index: 'Image', align: 'center', sortable: false, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'PlayerType', index: 'PlayerType', sortable: true, width: 150 },
               { name: 'Teams', index: 'Teams', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', align: 'center', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', align: 'center', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Name',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Jugadores',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = '<a href=\"' + ControllerActions.Edit + '' + ids[i] + "\">Editar</a>";
                deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
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

    function activateDelete() {
        $('.delete-link').click(function() {
            var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Name;

            $("#ajaxDataTable").delGridRow(this.id, {
                caption: "Eliminar registro",
                reloadAfterSubmit: true,
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: ControllerActions.Delete,
                mtype: "POST",
                width: 300,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar este jugador:<br/> " + name + " ?");
                }
            });

        });
    }
});
