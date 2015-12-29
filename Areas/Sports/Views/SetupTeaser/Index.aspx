<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/',
            GetSports: '<%= Url.Action("GetSports", "Sport") %>/',
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/',
            CopySetupTeasersToDivision: '<%= Url.Action("CopySetupTeasersToDivision", "SetupTeaser") %>/'
        }

        $(document).ready(function() {
            InitAutoCompleteUtil('#SearchText', "/AutoComplete/BySportDivisionPeriodAndBetType");

            // Copy dialog
            $("#copy-dialog .loading").hide();

            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false
            });

            $('#CopyFromSport, #CopyToSport').prepend('<option value="-1" selected="true">Cargando...</option>');

            $.getJSON(ControllerActions.GetSports, {}, function(data) {
                $('#CopyFromSport, #CopyToSport').empty();
                $('#CopyFromSport, #CopyToSport').prepend('<option value="-1" selected="true">Seleccione un deporte</option>');
                if (data.length > 0) {
                    $.each(data, function(i, item) {
                        $('#CopyFromSport, #CopyToSport').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                    });
                }
            });

            // Cascadings
            $('#CopyFromSport').cascade({
                source: ControllerActions.FilterDivisionsBySport,
                cascaded: "CopyFromDivision",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una división",
                dependentLoadingLabel: "Cargando opciones",
                extraParams: { SportCode: function() { return $('#CopyFromSport').val(); } },
                spinnerImg: "/Content/Images/ajax-loader-small.gif"
            });

            $('#CopyToSport').cascade({
                source: ControllerActions.FilterDivisionsBySport,
                cascaded: "CopyToDivision",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una división",
                dependentLoadingLabel: "Cargando opciones",
                extraParams: { SportCode: function() { return $('#CopyToSport').val(); } },
                spinnerImg: "/Content/Images/ajax-loader-small.gif"
            });

            var actionUrl = ControllerActions.JsonSearch;

            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Deporte', 'Liga', 'Periodo', 'Tipo de Apuesta', 'Teaser Pick', 'Puntos a dar', '', ''],
                colModel: [
                    { name: 'SportName', index: 'Division.Sport.Name', sortable: true, width: 90 },
                    { name: 'DivisionName', index: 'Division.Name', sortable: true, width: 90 },
                    { name: 'Period', index: 'BetType.Period.Name', sortable: true, width: 90 },
                    { name: 'BetType', index: 'BetType.Name', sortable: true, width: 90 },
                    { name: 'PickItems', index: 'PickItems', sortable: true, width: 80 },
                    { name: 'Points', index: 'Points', sortable: true, width: 80 },
                    { name: 'Action', index: 'Action', sortable: false, width: 80 },
                    { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Division.Sport.Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Teasers',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"' + ControllerActions.Edit + '' + ids[i] + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
                    }

                    activateDelete();
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

            // Copy bet template - dialog
            $("#copy-dialog").dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 420,
                buttons: {
                    "Cancelar": function() {
                        $("#copy-dialog").dialog('close');
                    },
                    Ok: function() {
                        // Validate selected values
                        if (!($('#CopyFromDivision').val() > 0 && $('#CopyToDivision').val() > 0))
                            return;

                        $("#copy-dialog .loading").show();
                        $("#copy-dialog .dialog-content").hide();
                        $.post(ControllerActions.CopySetupTeasersToDivision,
                { divisionFrom: function() { return $('#CopyFromDivision').val(); }, divisionTo: function() { return $('#CopyToDivision').val(); } },
                function(data) {
                    // Hide dialog
                    $("#copy-dialog .loading").hide();
                    $("#copy-dialog .dialog-content").show();
                    $("#copy-dialog").dialog('close');
                    // Reload datagrid
                    $("#ajaxDataTable").trigger("reloadGrid");
                    // Info message
                    $('#infoDialog').dialog('open');
                    $('#infoDialogMessage').text(data.ReturnMessage);

                }, "json");

                    }
                }
            });

            $('#copy-btn').click(function() {
                $('#copy-dialog').dialog('open');
            });
        });

        function activateDelete() {
            $('.delete-link').click(function() {
            // Build message string
            var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).DivisionName + "<br/>" +
                    'Periodo: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Period + '<br/>' +
                    'Apuesta: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).BetType + '<br/>' +
                    'Pick: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).PickItems;                    
                
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: ControllerActions.Delete,
                    mtype: "POST",
                    width: 350,
                    // Workaround for bug: msg is not correctly updated after first rendering.
                    beforeShowForm: function(formid) {
                        $(".delmsg", formid).html("Desea eliminar este teaser?<br/>" + name);
                    }
                });
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Teasers - Listado
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Listado de Teasers
    </h2>
    <div class="searchbox">
        Buscar :
        <%= Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
        <button id="submitButton" class="searchbox_btn">
            Buscar</button>
    </div>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a> <a class="button" id="copy-btn"><span>Copiar entre deportes</span></a>
    </p>
    <div id="copy-dialog" title="Copiar Teasers">
        <div class="dialog-content">
            <table>
                <tr>
                    <td>
                        De
                    </td>
                    <td>
                        <select id="CopyFromSport">
                        </select>
                    </td>
                    <td>
                        a
                    </td>
                    <td>
                        <select id="CopyToSport">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <select id="CopyFromDivision">
                        </select>
                    </td>
                    <td>
                    </td>
                    <td>
                        <select id="CopyToDivision">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." /></div>
    </div>
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
</asp:Content>
