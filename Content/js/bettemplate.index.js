/// <reference path="jquery-1.4.1-vsdoc.js"/>

var currentEditField = 0;

$(document).ready(function() {
    InitAutoCompleteUtil('#SearchText', "/AutoComplete/BySportAndDivision");
    // Init Series dialog
    $("#series-dialog .loading").hide();

    // Copy dialog
    $("#copy-dialog .loading").hide();
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

    // View series - dialog sport dropdown
    $('#SportForSeries').prepend('<option value="-1" selected="true">Cargando...</option>');
    $.getJSON(ControllerActions.GetSports, {}, function(data) {
        $('#SportForSeries').empty();
        $('#SportForSeries').prepend('<option value="-1" selected="true">Seleccione un deporte</option>');
        if (data.length > 0) {
            $.each(data, function(i, item) {
                $('#SportForSeries').append('<option value="' + item.Id + '">' + item.Label + '</option>');
            });
        }
    });

    // View series - division and bet type dropdown
    $('#SportForSeries').change(function() {
        var selectedSportCode = $(this).val();

        // Updates available divisions
        $.getJSON(ControllerActions.GetDivisionsBySport, { SportCode: selectedSportCode }, function(data) {
            $('#DivisionForSeries').empty();
            if (data.length > 0) {
                $.each(data, function(i, item) {
                    $('#DivisionForSeries').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                });
            }
        });

        // Updates default bet type
        $.getJSON(ControllerActions.GetDefaultBetTypeForSport, { SportCode: selectedSportCode, BetTemplateType: BetTemplateType }, function (outerData) {
            $('#BaseBetTypeForSeries').html(outerData.Label);
            $('#BaseBetTypeForSeriesId').val(outerData.Code);

            // Updates available bet types
            $.getJSON(ControllerActions.GetBetTypesWithPeriodAppendedBySport, { SportCode: selectedSportCode, AppliesToTotals: false }, function(data) {
                $('#BetTypeForSeries').empty();
                if (data.length > 0) {
                    $.each(data, function(i, item) {
                        if (item.Code != outerData.Code)
                            $('#BetTypeForSeries').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                    });
                }
            });
        });
    })

    // View series - dialog
    $("#series-dialog").dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        width: 920,
        buttons: {
            "Salir": function() {
                $("#series-dialog").dialog('close');
            },
            "Buscar": function() {
                $("#BetTemplateDetailAjaxDataTable").jqGrid('setGridParam',
                    {
                        url: ControllerActions.AdvancedGetBetTemplateDetails + "?" +
                                "BetTypeCode=" + $('#BetTypeForSeries').val() +
                                "&SportCode=" + $('#SportForSeries').val() +
                                "&DivisionCode=" + $('#DivisionForSeries').val(),
                        page: 1
                    })
                    .trigger("reloadGrid");
                // updates columns for default bet type
                $.getJSON(ControllerActions.GetBetTypeInfo, { betTypeId: $('#BaseBetTypeForSeriesId').val() }, function(data) {
                    // Hide/show individual 'score' column
                    var showIndividualScore = data.UseIndividualScore ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualScore, 'MaleScore');
                    
                    // Hide/show individual 'spread' column
                    var showIndividualSpread = data.UseIndividualSpread ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualSpread, 'MaleValue');
                    
                    // Hide/show individual 'price' column
                    var showIndividualPrice = data.UseIndividualPrice ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPrice, 'MalePrice');

                    // Hide/show individual 'over price' column
                    var showIndividualPriceOver = data.UseIndividualPriceOver ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceOver, 'MaleOverPrice');
                    
                    // Hide/show individual 'under price' column
                    var showIndividualPriceUnder = data.UseIndividualPriceUnder ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceUnder, 'MaleUnderPrice');

                    // Hide/show global 'score' column
                    var showGlobalScore = data.UseGlobalScore ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showGlobalScore, 'MaleGlobalScore');

                    // Hide/show global 'over price' column
                    var showGlobalPriceOver = data.UseGlobalPriceOver ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showGlobalPriceOver, 'MaleGlobalPriceOver');

                    // Hide/show global 'under price' column
                    var showGlobalPriceUnder = data.UseGlobalPriceUnder ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showGlobalPriceUnder, 'MaleGlobalPriceUnder');

                    // Hide/show 'Proposition price' column
                    var showPropositionPrice = data.UsePropositionPrice ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showPropositionPrice, 'MalePropositionPrice');

                    // Refresh grid columns width
                    var gwdth = $("#BetTemplateDetailAjaxDataTable").jqGrid("getGridParam", "width");
                    $("#BetTemplateDetailAjaxDataTable").jqGrid("setGridWidth", gwdth);
                });

                // Updates shown columns for series bet type
                $.getJSON(ControllerActions.GetBetTypeInfo, { betTypeId: $('#BetTypeForSeries').val() }, function(data) {
                    // Hide/show individual 'score' column
                    var showIndividualScore = data.UseIndividualScore ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualScore, 'VisitorFemaleScore');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualScore, 'LocalMaleScore');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualScore, 'LocalFemaleScore');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualScore, 'VisitorMaleScore');

                    // Hide/show individual 'spread' column
                    var showIndividualSpread = data.UseIndividualSpread ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualSpread, 'ForeignFemaleValue');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualSpread, 'LocalMaleValue');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualSpread, 'LocalFemaleValue');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualSpread, 'ForeignMaleValue');

                    // Hide/show 'Proposition price' column
                    var showPropositionPrice = data.UsePropositionPrice ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showPropositionPrice, 'PropositionPrice');
                    
                    // Hide/show individual 'price' column
                    var showIndividualPrice = data.UseIndividualPrice ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPrice, 'ForeignFemalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPrice, 'LocalMalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPrice, 'LocalFemalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPrice, 'ForeignMalePrice');

                    // Hide/show individual 'over price' column
                    var showIndividualPriceOver = data.UseIndividualPriceOver ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceOver, 'VisitorOverFemalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceOver, 'LocalOverMalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceOver, 'LocalOverFemalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceOver, 'VisitorOverMalePrice');

                    // Hide/show individual 'under price' column
                    var showIndividualPriceUnder = data.UseIndividualPriceUnder ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceUnder, 'LocalUnderMalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceUnder, 'VisitorUnderFemalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceUnder, 'LocalUnderFemalePrice');
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showIndividualPriceUnder, 'VisitorUnderMalePrice');

                    // Hide/show global 'score' column
                    var showGlobalScore = data.UseGlobalScore ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showGlobalScore, 'GlobalScore');

                    // Hide/show global 'over price' column
                    var showGlobalPriceOver = data.UseGlobalPriceOver ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showGlobalPriceOver, 'PriceOver');

                    // Hide/show global 'under price' column
                    var showGlobalPriceUnder = data.UseGlobalPriceUnder ? 'showCol' : 'hideCol';
                    $("#BetTemplateDetailAjaxDataTable").jqGrid(showGlobalPriceUnder, 'PriceUnder');

                    // Refresh grid columns width
                    var gwdth = $("#BetTemplateDetailAjaxDataTable").jqGrid("getGridParam", "width");
                    $("#BetTemplateDetailAjaxDataTable").jqGrid("setGridWidth", gwdth);
                });
            }
        }
    });

    // View series - button
    $('#viewseries-btn').click(function() {
        $('#series-dialog').dialog('open');
    });

    $('#infoDialog').dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        buttons: {
            "Ok": function() {
                $("#infoDialog").dialog('close');
            }
        }
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
                $.post(ControllerActions.CopyBetTemplatesToDivision,
                { DivisionFrom: function() { return $('#CopyFromDivision').val(); }, DivisionTo: function() { return $('#CopyToDivision').val(); } },
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


    // Main datagrid
    $("#ajaxDataTable").jqGrid({
        width: 700,
        height: '100%',
        url: ControllerActions.JsonSearch,
        datatype: 'json',
        mtype: 'GET',
        colNames: ['Deporte', 'Liga', 'Apuesta Base', 'Macho Base', '', ''],
        colModel: [
               { name: 'Sport', index: 'BetTemplate.Sport.Name', sortable: true, width: 150 },
               { name: 'Division', index: 'BetTemplate.Division.Name', sortable: true, width: 150 },
               { name: 'DefaultBetType', index: 'BetTemplate.Sport.DefaultBetType.Name', sortable: true, width: 150 },
               { name: 'DefaultBetTypeMales', index: 'DefaultBetTemplate.LocalMale', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
        pager: '#Pager',
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'BetTemplate.Id',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Plantillas de apuesta',
        gridComplete: function() {
            var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = '<a href=\"' + ControllerActions.Edit + '' + ids[i] + "\">Editar</a>";
                deleteLink = "<a onclick=\"deleteRow( " + ids[i] + " );\">Eliminar</a>";
                $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
            }
        }
    });

    deleteRow = function(code) {
        var name = $("#ajaxDataTable").jqGrid('getRowData', code).Division + " " + $("#ajaxDataTable").jqGrid('getRowData', code).DefaultBetTypeMales;

        $("#ajaxDataTable").jqGrid(
            'delGridRow',
            code,
            {
                reloadAfterSubmit: true,
                caption: "Eliminar registro",
                bSubmit: "Eliminar",
                bCancel: "Cancelar",
                url: ControllerActions.JsonDelete,
                mtype: "POST",
                width: 300,
                // Workaround for bug: msg is not correctly updated after first rendering.
                beforeShowForm: function(formid) {
                    $(".delmsg", formid).html("Desea eliminar esta plantilla:<br/> " + name + " ?");
                }
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

    // Series datagrid
    $("#BetTemplateDetailAjaxDataTable").jqGrid({
        width: 900,
        height: '100%',
        url: ControllerActions.AdvancedGetBetTemplateDetails,
        datatype: 'json',
        mtype: 'GET',
        colNames: [
            'FieldId',
            'Carrer. Macho base',
            'Gavela Macho base',
            'Macho base', 'Macho base', 'Macho base', 'Macho base',
            'Carreraje Macho', 'Precio (+) Macho.', 'Precio (-) Macho',

            'Carrer. hembra vis.', 'Carrer. macho loc.',
            'Gavela hembra vis.', 'Gavela macho loc.',
            'Precio hembra vis.', 'Precio (+) hembra vis.', 'Precio (-) hembra vis.',
            'Precio macho loc.', 'Precio (+) macho loc.', 'Precio (-) macho loc.',

            'Carrer. hembra loc.', 'Carrer. macho vis.',
            'Gavela hembra loc.', 'Gavela macho vis.',
            'Precio hembra loc.', 'Precio (+) hembra loc.', 'Precio (-) hembra loc.',
            'Precio macho vis.', 'Precio (+) macho vis.', 'Precio (-) macho vis.',

            'Carreraje', 'Precio a mas', 'Precio a menos', 'Precio',

            ''
            ],
        colModel: [
                { name: 'FieldId', index: 'FieldId', hidden: true },
                // Default bet
                { name: 'MaleScore', index: 'DefaultBetTemplateDetail.LocalMaleScore', sortable: true, width: 100 },
                { name: 'MaleValue', index: 'DefaultBetTemplateDetail.LocalMaleValue', sortable: true, width: 100 },
                { name: 'MalePropositionPrice', index: 'DefaultBetTemplateDetail.PropositionPrice', sortable: true, width: 100 },
                { name: 'MalePrice', index: 'DefaultBetTemplateDetail.LocalMale', sortable: true, width: 100 },
                { name: 'MaleOverPrice', index: 'DefaultBetTemplateDetail.LocalOverMale', sortable: true, width: 130 },
                { name: 'MaleUnderPrice', index: 'DefaultBetTemplateDetail.LocalUnderMale', sortable: true, width: 130 },
                { name: 'MaleGlobalScore', index: 'DefaultBetTemplateDetail.GlobalScore', sortable: true, width: 100 },
                { name: 'MaleGlobalPriceOver', index: 'DefaultBetTemplateDetail.PriceOver', sortable: true, width: 100 },
                { name: 'MaleGlobalPriceUnder', index: 'DefaultBetTemplateDetail.PriceUnder', sortable: true, width: 100 },

                // Local male
                { name: 'VisitorFemaleScore', index: 'BetTemplateDetail.VisitorFemaleScore', sortable: true, width: 100 },
                { name: 'LocalMaleScore', index: 'BetTemplateDetail.LocalMaleScore', sortable: true, width: 100 },
                { name: 'ForeignFemaleValue', index: 'BetTemplateDetail.ForeignValueFemale', sortable: true, width: 100 },
                { name: 'LocalMaleValue', index: 'BetTemplateDetail.LocalValueMale', sortable: true, width: 100 },
                { name: 'ForeignFemalePrice', index: 'BetTemplateDetail.ForeignFemale', sortable: true, width: 130 },
                { name: 'VisitorOverFemalePrice', index: 'BetTemplateDetail.VisitorOverFemale', sortable: true, width: 130 },
                { name: 'VisitorUnderFemalePrice', index: 'BetTemplateDetail.VisitorUnderFemale', sortable: true, width: 130 },
                { name: 'LocalMalePrice', index: 'BetTemplateDetail.LocalMale', sortable: true, width: 130 },
                { name: 'LocalOverMalePrice', index: 'BetTemplateDetail.LocalOverMale', sortable: true, width: 130 },
                { name: 'LocalUnderMalePrice', index: 'BetTemplateDetail.LocalUnderMale', sortable: true, width: 130 },

                // Foreign male
                { name: 'LocalFemaleScore', index: 'BetTemplateDetail.LocalFemaleScore', sortable: true, width: 100 },
                { name: 'VisitorMaleScore', index: 'BetTemplateDetail.VisitorMaleScore', sortable: true, width: 100 },
                { name: 'LocalFemaleValue', index: 'BetTemplateDetail.LocalValueFemale', sortable: true, width: 100 },
                { name: 'ForeignMaleValue', index: 'BetTemplateDetail.ForeignValueMale', sortable: true, width: 100 },
                { name: 'LocalFemalePrice', index: 'BetTemplateDetail.LocalFemale', sortable: true, width: 130 },
                { name: 'LocalOverFemalePrice', index: 'BetTemplateDetail.LocalOverFemale', sortable: true, width: 130 },
                { name: 'LocalUnderFemalePrice', index: 'BetTemplateDetail.LocalUnderFemale', sortable: true, width: 130 },
                { name: 'ForeignMalePrice', index: 'BetTemplateDetail.ForeignMale', sortable: true, width: 130 },
                { name: 'VisitorOverMalePrice', index: 'BetTemplateDetail.VisitorOverMale', sortable: true, width: 130 },
                { name: 'VisitorUnderMalePrice', index: 'BetTemplateDetail.VisitorUnderMale', sortable: true, width: 130 },

                // Global
                { name: 'GlobalScore', index: 'BetTemplateDetail.GlobalScore', sortable: true, width: 100 },
                { name: 'PriceOver', index: 'BetTemplateDetail.PriceOver', sortable: true, width: 100 },
                { name: 'PriceUnder', index: 'BetTemplateDetail.PriceUnder', sortable: true, width: 100 },
                { name: 'PropositionPrice', index: 'BetTemplateDetail.PropositionPrice', sortable: true, width: 100 },
                
                { name: 'Action', index: 'Action', sortable: false, width: 80 }
                ],
        pager: '#BetTemplateDetailPager',
        rowNum: 20,
        rowList: [10, 20, 50],
        sortname: 'DefaultBetTemplateDetail.LocalMale',
        sortorder: 'desc',
        viewrecords: true,
        caption: 'Precios',
        gridComplete: function() {
            var ids = $("#BetTemplateDetailAjaxDataTable").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var currentId = ids[i];
                editLink = "<a class='series-edit-link' id='series-edit-" + ids[i] + "'>Editar</a>";
                $("#BetTemplateDetailAjaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink });
            }

            ActivateSeriesEdit();
        }
    });

    //Quick Add Functionality
    $('#SportId').change(function() {
        $('#DefaultBet').load(ControllerActions.ShowDefaultBetTemplateField, { SportCode: $(this).val() }, function() {
            //FixTabIndex();

            $('.default-female').blur(function() {
                ValidateDefaultFemale(this.id);
            });

            $('.default-male').blur(function() {
                $(this).next().empty();
                var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(this).next());

                var currentField = this;
                $.getJSON(ControllerActions.GetNomialValue, { BaseNomial: $(this).val(), SportCode: $('#SportId').val() }, function(data) {

                    $('.default-female').val(data);

                    loader.fadeOut('fast', function() {
                        loader.remove();
                    });
                });
            });
        });
    });

    // Setting up the depending lists

    $('#SportId').cascade({
        source: ControllerActions.FilterDivisionsBySport,
        cascaded: "DivisionId",
        dependentNothingFoundLabel: "No hay elementos",
        dependentStartingLabel: "Selecciona una",
        dependentLoadingLabel: "Cargando opciones"
    });

    $('#SportId').cascade({
        source: ControllerActions.GetGameBetPeriodsBySport,
        cascaded: "PeriodId",
        dependentNothingFoundLabel: "No hay elementos",
        dependentStartingLabel: "Selecciona una",
        dependentLoadingLabel: "Cargando opciones",
        firstOptionLabel: "Selecciona una",
        extraParams: { appliesToTotals: false }
    });

    $('#PeriodId').cascade({
        source: ControllerActions.FilterGameTypesByPeriodAndSport,
        cascaded: "BetTypeId",
        dependentNothingFoundLabel: "No hay elementos",
        dependentStartingLabel: "Selecciona una",
        dependentLoadingLabel: "Cargando opciones",
        extraParams: { SportId: function() { return $('#SportId').val(); }, AppliestoTotals: false },
        firstOptionLabel: "Selecciona una"
    });

    $('#BetTypeId').change(function() {

        $('#BetToModify').hide().load(ControllerActions.ShowBetTemplateField,
            {   
                BetTypeId: $('#BetTypeId').val(),
                DivisionId: $('#DivisionId').val(),
                'Parent.GlobalScore': $('.default-score').val(),
                'Parent.LocalMaleScore': $('.default-male-score').val(),
                'Parent.LocalFemaleScore': $('.default-female-score').val(),
                'Parent.LocalValueMale': $('.default-male-spread').val(),
                'Parent.LocalValueFemale': $('.default-female-spread').val(),
                'Parent.LocalMale': $('.default-male').val(),
                'Parent.LocalFemale': $('.default-female').val(),
                'Parent.PriceOver': $('.default-global-over').val(),
                'Parent.LocalOverMale': $('.default-male-over').val(),
                'Parent.LocalOverFemale': $('.default-female-over').val(),
                'Parent.PriceUnder': $('.default-global-under').val(),
                'Parent.LocalUnderMale': $('.default-male-under').val(),
                'Parent.LocalUnderFemale': $('.default-female-under').val(),
            }, function() {
            
            $('#navFw').parent('p').removeClass('ui-hide');

            $('.female').blur(function() {
                ValidateFemale(this.id);
            });

            // Hiding the BetType dropdown
            $('#BetTypeId').parent('p').toggleClass("ui-hide");

            // Hiding the previous data header
            $('#previous-step-data').toggleClass("ui-hide");

            $('#quickadd-step1').hide("slow");
            $('#BetToModify').show("slow");

            $('#quickadd-step2').find('.base-bet-name').html(
                $("#DefaultBet").find('.base-bet-name').html()
            );

            $('#base-bet-male').html($('.default-male').val());
            $('#base-bet-female').html($('.default-female').val());
            $('#base-bet-score').html(
                $('.default-value').val() != undefined && $('.default-value').val().length > 0 ? $('.default-value').val() : "n/a"
            );

            // Fields (male/female) autocompletion

            $('.autocalculates-nomial').blur(function() {
                $(this).parents('tr').find('span').empty();
                var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(this).parents('tr').find('span'));

                var currentField = this;

                $.getJSON(ControllerActions.GetNomialValue, { BaseNomial: $(this).val(), SportCode: $('#SportId').val() }, function(data) {

                    //$(currentField).next('span').html($(currentField).next('span').hasClass("foreign") ? "Hembra visitante: " + data : "Hembra local: " + data);
                    $(currentField).parents('tr').find('.female').val(data);
                    loader.fadeOut('fast', function() {
                        loader.remove();
                    });
                });
            });

            $('.autocalculates-value').blur(function() {
                var data = Math.abs($(this).val());
                //$(this).next('span').html($(this).next('span').hasClass("foreign") ? "Gavela hembra visitante: " + data : "Gavela hembra local: " + data);
                $(this).parents('tr').find('.female').val(data);
                $(this).val(-data);
            });

            //alert($('.default-value').val() != undefined ? $('.default-value').val() : "n/a")
        })
    });

    $('#navPrev').click(function() {
        $('#previous-step-data').toggleClass("ui-hide");
        $('#BetTypeId').parent('p').toggleClass("ui-hide");

        $('#quickadd-step1').show("slow");
        $('#BetToModify').hide("slow");
    })

    $('#navFw').click(function() {
        // Trigger the change even on the bettype ddl 
        $('#BetTypeId').change();
    })

    // Firing the dialog box
    $('#quickadd-btn').click(function() {
        $('#quickadd-dialog').dialog('open');
    });

    // Setting up the quick add dialog box
    $("#quickadd-dialog").dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        width: 453,
        buttons: {
            "Cerrar": function() {
                $("#quickadd-dialog").dialog('close');
            },
            "Guardar": function() {
                $('#loading-wrapper').removeClass().fadeIn('slow').html('guardando ...');

                $("#copy-dialog .loading").show();
                $("#copy-dialog .dialog-content").hide();

                var sendData = [{ name: "SportId", value: $('#SportId').val() }, { name: "DivisionId", value: $('#DivisionId').val()}];

                sendData = sendData.concat(SerializeFields());

                $.post(ControllerActions.QuickSaveBetTemplate, sendData, function(data) {

                    if (data == true) {
                        $('#loading-wrapper').addClass('ui-state-highlight').html('<span class="ui-icon ui-icon-info"></span> Guardado exitoso');


                    } else {
                        $('#loading-wrapper').addClass('ui-state-error').html('<span class="ui-icon ui-icon-alert"></span> Error al intentar guardar cambios');
                    }

                    setTimeout(function() {
                        $('#loading-wrapper').fadeOut("slow");
                    }, 3000);

                    $("#copy-dialog .loading").hide();
                    $("#copy-dialog .dialog-content").show();
                    $("#copy-dialog").dialog('close');

                    $("#ajaxDataTable").trigger("reloadGrid");

                }, "json");
            }

        }
    });

    // EditSeries dialog
    $("#series-edit-dialog").dialog({
        bgiframe: true,
        modal: true,
        autoOpen: false,
        width: 453,
        buttons: {
            "Cerrar": function() {
                $("#series-edit-dialog").dialog('close');
            },
            "Guardar": function() {
                $('#series-loading-wrapper').removeClass().fadeIn('slow').html('guardando ...');

                var sendData = [{ name: "fieldId", value: currentEditField}];

                sendData = sendData.concat(SerializeSeriesEditFields());

                $.post(ControllerActions.QuickSaveBetTemplateField, sendData, function(data) {

                    if (data == true) {
                        $('#series-loading-wrapper').addClass('ui-state-highlight').html('<span class="ui-icon ui-icon-info"></span> Guardado exitoso');


                    } else {
                        $('#series-loading-wrapper').addClass('ui-state-error').html('<span class="ui-icon ui-icon-alert"></span> Error al intentar guardar cambios');
                    }

                    setTimeout(function() {
                        $('#series-loading-wrapper').fadeOut("slow");
                    }, 3000);

                    $("#BetTemplateDetailAjaxDataTable").trigger("reloadGrid");

                    $("#series-edit-dialog").dialog('close');

                }, "json");
            }

        }
    });
});

SerializeFields = function() {
    return $('#quick-form').serializeArray();
}

// TODO, join with the method above pass the id as a parameter
SerializeSeriesEditFields = function() {
    return $('#series-edit-form').serializeArray();
}

FixTabIndex = function() {
    $('.tabfix').each(function(i, item) {
        $(item).attr("tabindex", i + 1);
    });
}

ValidateFemale = function(fieldId) {
    var femaleValue = $('#' + fieldId).val();
    var maleValue = $('#' + fieldId).parents('tr').find('.male').val();

    if (femaleValue != maleValue) {
        //$('#' + fieldId).parents('tr').find('.female').val(data);
        //$('#' + fieldId).val(Math.abs($('#' + fieldId).val()));
    }
}

ValidateDefaultFemale = function(fieldId) {
    var femaleValue = $('#' + fieldId).val();
    var maleValue = $('.default-male').val();

    if (femaleValue != maleValue) {
        //$('#' + fieldId).parents('tr').find('.female').val(data);
        $('#' + fieldId).val(Math.abs($('#' + fieldId).val()));
    }
}

function ActivateSeriesEdit(){
    $('.series-edit-link').click(function() {
        //alert($(this).closest('tr').attr('id'));
        var recordId = $(this).closest('tr').attr('id');

        var rowData = $("#BetTemplateDetailAjaxDataTable").jqGrid('getRowData', recordId).FieldId;

        currentEditField = rowData;

        $('#series-field-container').empty().load('/Sports/BetTemplate/ShowQuickBetTemplateField', { id: rowData });

        $('#series-edit-dialog').dialog('open');

        //alert(rowData.FieldId);
    });
}