﻿/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByCommissionProfile");

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Perfil', 'Fecha de creación', '', '', '',''],
        colModel: [
               { name: 'Profile', index: 'Profile', sortable: true },
               { name: 'CreationDate', index: 'CreationDate', sortable: true, width: 120 },
               { name: 'StoringCenters', index: 'StoringCenters.Count', hidden: true, sortable: true, width: 100 },
               { name: 'Action', index: 'Action', sortable: false, width: 30 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 30 },
                { name: 'Action3', index: 'Action3', sortable: false, width: 30 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'CreationDate',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Comisiones',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                editLink = '<a href=\"' + ControllerActions.Editar + ids[i] + "\">Editar</a>";
                var deleteLink;
                if ($("#ajaxDataTable").jqGrid('getRowData', ids[i]).StoringCenters == 0)
                    deleteLink = "<a class='delete-link' id=\"" + ids[i] + "\">Eliminar</a>";
                else
                    deleteLink = 'Usado por centros de acopio';
                asignLink = '<a href=\"' + ControllerActions.Asignar + ids[i] + "\">Asignar</a>";                   
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