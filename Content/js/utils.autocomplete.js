/// <reference path="jquery-1.4.1-vsdoc.js"/>

// Action: /Controller/AutoComplete
InitAutoCompleteUtil = function(inputSearch, action) {
    $(inputSearch).autocomplete(action, {
        dataType: 'json',
        parse: function(data) {
            var rows = new Array();
            for (var i = 0; i < data.length; i++) {
                rows.push({ data: { ResultTitle: data[i] }, value: data[i], result: data[i] });
            }
            return rows;
        },
        formatItem: function(row, i, n) {
            //return row.ResultTitle + " | " + row.Type;
            return row.ResultTitle;

        },
        selectFirst: false
    });
}