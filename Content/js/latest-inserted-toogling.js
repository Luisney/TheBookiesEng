/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    var showLatestInserted = true;

    $('#latestInsertedTitle').click(function() {
        $(this).toggleClass("toogleLink-open").toggleClass("toogleLink-closed");
        $('#latestInsertedDataTable').toggle('blind', {}, 500);
        return false;
    });
});
