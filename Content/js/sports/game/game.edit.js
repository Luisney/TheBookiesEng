/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function () {
    $("#StartDate").datepicker({
        dateFormat: 'dd/mm/yy',
        onSelect: function (dateText) { FillFauxDate(); }
    });
});

$(function () {
    $("#tabs").tabs();

    $('#gameSearch').autocomplete(ControllerActions.SearchGameByTeams, {
        dataType: 'json',
        parse: function (data) {
            var rows = new Array();
            for (var i = 0; i < data.length; i++) {
                rows.push({ data: { ResultTitle: data[i].label, gameId: data[i].gameId }, value: data[i].label, result: data[i].label });
            }
            return rows;
        },
        formatItem: function (row, i, n) {
            return row.ResultTitle;
        },
        formatResult: function (row) {
            return row;
        },
        selectFirst: false
    }).result(function (event, item) {
        var selected = $("#tabs").tabs("option", "selected");
        var tabLink = $($("#tabs-links li").get(selected)).find('a').attr('href');
        location.href = ControllerActions.Edit + item.gameId + tabLink;
    });

    updateVisitorLabels(ModelProperties.Visitor);
    updateLocalLabels(ModelProperties.Local);
});