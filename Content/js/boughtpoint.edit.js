/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(function() {
    $('#SportCode').cascadingDdl({
        source: ControllerActions.FilterDivisionsBySport,
        cascaded: "DivisionCode",
        dependentNothingFoundLabel: "No hay elementos",
        dependentStartingLabel: "Selecciona una",
        dependentLoadingLabel: "Cargando opciones"
    });
});