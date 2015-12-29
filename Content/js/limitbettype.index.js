/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function () {
    InitAutoCompleteUtil('#SearchText', ControllerActions.AutocompleteByLimitBetType);

    $("#ajaxDataTable").jqGrid({
        stateOptions: "limitBTpTable",
        width: 480,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Perfil', 'Fecha de creación', '', '', ''],
        colModel: [
               { name: 'Profile', index: 'Profile', sortable: true, width: 130 },
               { name: 'CreationDate', index: 'CreationDate', sortable: true, width: 90 },
               { name: 'StoringCenters', hidden: true, sortable: false, width: 10 },
               { name: 'Action', index: 'Action', sortable: false, width: 60 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 100 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'CreationDate',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Limites',
        gridComplete: function () {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                editLink = '<a href=\"' + ControllerActions.Edit + ids[i] + "\">Editar Perfil</a>";
                var deleteLink;
                if ($("#ajaxDataTable").jqGrid('getRowData', ids[i]).StoringCenters == 0)
                    deleteLink = "<a class='delete-link' id=\"" + ids[i] + "\">Eliminar</a>";
                else
                    deleteLink = 'Actualmente en uso';
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
            }
            activateDelete();
        },
        onSelectRow: function (rowId) {
            if (rowId == null) {
                rowId = 0;
                $('#rightColumnLoader').hide();
                $('#rightColumnContent').html('');
            }
            else {
                $('#rightColumnLoader').show();
                $('#rightColumnContent').html('');
                 $.post(ControllerActions.Associations + rowId,
                    {},
                    function (html) {
                        $('#rightColumnLoader').hide();
                        $('#rightColumnContent').html(html);
                        return;
                    });
            }
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

