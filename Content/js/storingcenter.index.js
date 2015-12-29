/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {

    InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByStoringCenter");

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Id', 'Nombre', 'Dirección', 'Telefono', 'Contacto', 'Hora de Apertura', 'Hora de Cierre', '', ''],
        colModel: [
               { name: 'Id', index: 'StoringCenterId', sortable: true, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'Address', index: 'Address', sortable: true, width: 150 },
               { name: 'Phone', index: 'Phone', sortable: true, width: 150 },
               { name: 'Contact', index: 'Contact', sortable: true, width: 150 },
               { name: 'Hora de Apertura', index: 'OpenTime', sortable: true, width: 150 },
               { name: 'Hora de Cierre', index: 'CloseTime', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'StoringCenterId',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Centros de Acopio',
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
                reloadAfterSubmit: false,
                caption: "Eliminar registro",
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: ControllerActions.JsonDelete,
                mtype: "POST",
                width: 300,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar este centro de acopio:<br/> " + name + " ?");
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
