<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Object>" %>
<%@ Import Namespace="Gambling.Helpers" %>
<%@ Import Namespace="Gambling.Models" %>
<%= Html.GetStyle( "ui.jqgrid" )%>
<%= Html.GetScript( "jqGrid/i18n/grid.locale-sp" ) %>
<%= Html.GetScript( "jqGrid/jquery.jqGrid.min" )%>
<%= Html.GetScript( "line.toogleVisibility" )%>
<%= Html.GetScript( "jqueryEditInPlace/jquery.editinplace" )%>

<script type="text/javascript">
    var ReduxListWidgetControllerActions = {
        ReduxList: '<%= Url.Action("ReduxList") %>',
        EditAvailableBet: '<%= Url.Action("EditAvailableBet") %>',
        GameEdit: '<%= Url.Action( "Index" )%>' + '/Edit' <%--- Workaround for malfunction in Url.Action("Edit") -> it was returning an url containing the current page id '/Game/Edit/3' ---%> 
    };

    var EditAvailableBetParamName = 'GameAvailableBet';
    if( ReduxListWidgetWidth == undefined )
        var ReduxListWidgetWidth = 430;
    $(function () {
        $("#ReduxListWidget").jqGrid({
            width: ReduxListWidgetWidth,
            height: "100%",
            url: ReduxListWidgetControllerActions.ReduxList,
            datatype: 'json',
            mtype: 'GET',
            colNames: ['Fecha', 'Hora', 'Equipos', 'Division', ''],
            colModel: [
                { name: 'StartDate', index: 'StartDate', width: 65, search: true, sortable: true,
                    searchoptions: {
                        sopt: ['eq', 'ne', 'gt', 'ge', 'lt', 'le'],
                        defaultValue: '<%= DateTime.Now.ToShortDateString( ) %>',
                        dataInit: createDatePicker
                    }
                },
                { name: 'StartTime', index: 'StartTime', sortable: true, width: 45, search: false, sortable: true },
                { name: 'Teams', index: 'TeamAsA.Code', sortable: true, width: 90, search: false, sortable: true, searchoptions: { sopt: ['eq', 'ne']} },
                { name: 'Division', index: 'TeamAsA.Team.Division.Name', width: 50, search: true, sortable: true, searchoptions: { sopt: ['eq', 'cn', 'ne']} },
                { name: 'Action', index: 'Action', sortable: false, width: 100 }
                ],
            pager: '#ReduxListWidgetPager',
            rowNum: 20,
            rowList: [10, 20, 50],
            sortname: 'StartTime',
            sortorder: 'desc',
            viewrecords: true,
            caption: 'Juegos',
            toolbar: [true, "bottom"],
            recordtext: '{0}-{1}/{2}',
            emptyrecords: "0-0/0",
            onSelectRow: itemSelected,
            gridComplete: function () {
                var ids = $("#ReduxListWidget").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var currentId = ids[i];

                    var actionLink = '<a title="Editar matchups" href=\"<%= Url.Action( "Index", "GamePlayer", new { area = "Sports" }, null)%>/' + '?GameCode=' + ids[i] + "\">Editar Matchups</a><br/>";
                    actionLink += '<a title="Editar apuesta base" href=\"' + ReduxListWidgetControllerActions.GameEdit + '/' + ids[i] + "#game-baseBet\">Editar apuesta base</a><br/>";
                    actionLink += '<a title="Editar linea" href=\"' + ReduxListWidgetControllerActions.GameEdit + '/' + ids[i] + "#game-lines\">Editar linea</a><br/>";
                    actionLink += '<a title="Editar resultados" href=\"<%= Url.Action( "Results", "Game", new { area = "Sports" }, null)%>/' + '?Id=' + ids[i] + "\">Editar Resultados</a>";
                    $("#ReduxListWidget").jqGrid('setRowData', ids[i], { Action: actionLink });
                }
            }
        })
        .navGrid(
            '#ReduxListWidgetPager',
            { view: false, del: false, add: false, edit: false },
            {}, // default settings for edit
            {}, // default settings for add
            {}, // delete instead that del:false we need this
            { closeOnEscape: true, multipleSearch: true, closeAfterSearch: true }, // search options
            {}); // view parameters

        // Hide line container button
        $('#ReduxListLineToolbar .ui-icon-closethick').click( closeLineContainer );
    });

    createDatePicker = function (elem) {
        $(elem).datepicker({
            dateFormat: 'dd/mm/yy'
        });
        // Workaround for z-index issue using modal and datepicker
        // http://code.google.com/p/jquery-datepicker/issues/detail?id=43
        $('#ui-datepicker-div').css('z-index', 32767);
    }

    // Refreshes the grid
    refreshGrid = function () {
        $("#ReduxListWidget").trigger("reloadGrid");
    }

    itemSelected = function ( rowId ) {
        var cellPosition = $('#ReduxListWidget').find('#' + rowId).position();
        $('#ReduxListLineContainer').show();
        $('#ReduxListLineContainer').css('top', cellPosition.top + $('#ReduxListWidget').find('#' + rowId).height());
        $('#ReduxListLineContainer').css('left', cellPosition.left );
        $('#ReduxListLineContent').html('<p>Procesando <img src="/Content/images/ajax-loader-small.gif" alt="..." /></p>')
        $('#ReduxListLineContent').load('<%= Url.Action("ShowBetLine") %>/', { GameId: rowId }, lineLoaded);
    }

    lineLoaded = function (data) {
        $('#ReduxListLineContent .line-odd-value').editInPlace({
            url: ReduxListWidgetControllerActions.EditAvailableBet,
            paramsCallback: getAvailableBetData,
            value_required: true,
            update_value: 'UpdatedValue'
        });
    }

    getAvailableBetData = function (domElement) {
        // Get element Id
        var AvailableBetId = /\b<%= Constants.LineAvailableBetKey %>([\S]*)\b/.exec($(domElement).attr('class'))[1];
        // Get availableBet fields
        var relatedFields = $('.<%= Constants.LineAvailableBetKey %>' + AvailableBetId + '[class*="<%=Constants.LineAvailableBetFieldKey%>"]');

        // Game available bet id
        var result = EditAvailableBetParamName + '.Id=' + AvailableBetId;
        var fieldName = "";
        $.each(relatedFields,
            function (indexInArray, currentElement) {
                var matches = /\b<%=Constants.LineAvailableBetFieldKey%>([\S]*)\b/.exec($(currentElement).attr('class'));
                fieldName = matches[1];
                result +=  "&" + EditAvailableBetParamName +'.' + fieldName + "=" + escape($.trim($(currentElement).html()));
            }
        );

        return result;
    }

    closeLineContainer = function () {
        $('#ReduxListLineContainer').hide();
        $('#ReduxListLineContent').html('<p>Procesando <img src="/Content/images/ajax-loader-small.gif" alt="..." /></p>');
    }   
</script>
<div id="ReduxListWidgetContainer">
    <table id="ReduxListWidget">
    </table>
    <div id="ReduxListWidgetPager">
    </div>
    <div id="ReduxListLineContainer">
    <div id="ReduxListLineToolbar">
        <span class="ui-icon ui-icon-closethick">close</span>
    </div>
    <div id="ReduxListLineContent">
    </div>
    </div>
</div>

