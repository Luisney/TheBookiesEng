/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByTeamName");

    var actionUrl = "/TeamAlias/JsonSearch/";

    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: "100%",
        url: actionUrl,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Código', 'Alias', 'Equipo', '', ''],
        colModel: [
               { name: 'Id', index: 'Code', sortable: true, width: 150 },
               { name: 'Alias', index: 'PrintName', sortable: true, width: 150 },
               { name: 'TeamName', index: 'Team.Name', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'PrintName',
        sortorder: 'asc',
        viewrecords: true,
        caption: 'Equipos',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = "<a href=\"/TeamAlias/Edit/" + ids[i] + "\">Editar</a>";
                deleteLink = "<a href=\"/TeamAlias/Delete/" + ids[i] + "\">Eliminar</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
            }
        }
    });

    $('#submitButton').click(
            function() {
                var searchText = jQuery("#SearchText").val();
                $("#ajaxDataTable").jqGrid('setGridParam',
                    {
                        url: actionUrl + "?SearchText=" + escape(searchText),
                        page: 1
                    })
                    .trigger("reloadGrid");
            });
});