/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['ID','Número','Telefónica','Monto','Terminal','Fecha de creación'],
        colModel: [
               { name: 'Id', index: 'Id', sortable: true, width: 30, align: 'center' },
               { name: 'PhoneNumber', index: 'PhoneNumber', sortable: true, width: 80, align: 'center' },
               { name: 'Name', index: 'Name', width: 80, sortable: false },
               { name: 'RechargeAmount', index: 'Amount', sortable: true, width: 70, align: 'right' },
               { name: 'TerminalId', index: 'TerminalId', sortable: true, width: 70, align: 'right' },
               { name: 'CreationDate', index: 'CreationDate', sortable: true, width: 100, align: 'center' }
                ],
        pager: '#Pager',
        rowNum: 50,
        rowList: [50, 100, 150],
        sortname: 'CreationDate',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Recargas',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                editLink = '<a href=\"' + ControllerActions.Editar + ids[i] + "\">Editar comisiones de Recargas</a>";
                var deleteLink;
                if ($("#ajaxDataTable").jqGrid('getRowData', ids[i]).StoringCenters == 0)
                    deleteLink = "<a class='delete-link' id=\"" + ids[i] + "\">Eliminar</a>";
                else
                    deleteLink = 'Usado por centros de acopio';
                asignLink = '<a href=\"' + ControllerActions.Asignar + ids[i] + "\">Asignar Perfil</a>";                   
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink, Action3: asignLink });
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
        var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Profile;

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
                $(".delmsg", formid).html("Desea eliminar este perfil?<br/> " + name);
            }
        });
    });
}