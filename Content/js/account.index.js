/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', ControllerActions.AutoComplete);
    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Usuario', 'Terminal', 'Banca', 'Centro de Acopio', 'Bloquear', 'Ingresos fallidos', '', '', ''],
        colModel: [
               { name: 'Username', index: 'Username', sortable: false, width: 150 },
               { name: 'Terminal', index: 'Terminal.TerminalId', sortable: false, width: 150 },
               { name: 'SportBook', index: 'SportBook.SportBookId', sortable: false, width: 150 },
               { name: 'StoringCenter', index: 'StoringCenter.Name', sortable: false, width: 150 },
               { name: 'Lock', index: 'Action', sortable: false, formatter: lockFormatter, align: 'center', width: 80 },
               { name: 'PasswordAttempsLock', index: 'IsLockedOut', sortable: false, formatter: passwordLockFormatter, align: 'center', width: 80 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 },
               { name: 'Action3', index: 'Action3', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'Username',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Usuarios',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                detailsLink = "<a href=\"" + ControllerActions.Details + ids[i] + "\">Detalles</a>";
                editLink = "<a href=\"" + ControllerActions.Edit + ids[i] + "\">Editar</a>";
                deleteLink = "<a onclick=\"deleteRow( '" + ids[i] + "' );\">Eliminar</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: detailsLink, Action2: editLink, Action3: deleteLink });
            }
        }
    });

    deleteRow = function(code) {
        var name = $("#ajaxDataTable").jqGrid('getRowData', code).Username;

        $("#ajaxDataTable").jqGrid(
            'delGridRow',
            code,
            {
                reloadAfterSubmit: true,
                caption: "Eliminar registro",
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: "/Account/JsonDelete",
                mtype: "POST",
                width: 300,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar este usuario: " + name + " ?");
                }
            });
    }
    
    function lockFormatter(cellvalue, options, rowObject) {
        if (String(cellvalue).toUpperCase() == 'TRUE')
            return "<img class=\"lockSign\" src=\"/Content/images/lock_unlock.png\" onclick=\"setUserLock( '" + options.rowId + "', 'false' );\"/>";
        else
            return "<img class=\"lockSign\" src=\"/Content/images/lock.png\" onclick=\"setUserLock( '" + options.rowId + "', 'true' );\"/>";
    }

    function passwordLockFormatter(cellvalue, options, rowObject) {
        if (String(cellvalue).toUpperCase() == 'TRUE')
            return "<img class=\"lockSign\" src=\"/Content/images/lock.png\" onclick=\"setPasswordUserLock( '" + options.rowId + "' );\"/>";
        return "<img src=\"/Content/images/true.png\"/>";
    }

    setPasswordUserLock = function(Id) {
        $.getJSON(ControllerActions.JsonRemoveUserPasswordLock, { Username: Id }, function(data) {
            $('#ajaxDataTable').trigger('reloadGrid');
        });
    }

    setUserLock = function(Id, IsApproved) {
        $.getJSON(ControllerActions.JsonSetUserLock, { Username: Id, IsApproved: IsApproved }, function(data) {
            $('#ajaxDataTable').trigger('reloadGrid');
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
