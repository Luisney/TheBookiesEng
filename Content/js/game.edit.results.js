/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    $('.score-serializable').keyup(function() {
        CalculateTotals(this);
    });

    $('#save-btn').click(function() {
        SendResults();
    });

    $('.total').each(function() {
        CalculateTotals(this);
    });

    $('#partialResultsDiv').hide();

    $('#partialResultsLink').click(function() {
        $('#partialResultsDiv').toggle();
    });
});

function CalculateTotals(element) {
    // Compute total scores
    var score = 0;
    $(element).parents("tr")
               .find('.score-serializable').each(function(i, item) {
                   if (!isNaN($(item).val())) {
                       score += Number($(item).val());
                   }
               });
    $(element).parents("tr").find('.total').html(score);


    // Compute partial period scores
    updatePartialTotals('Foreign');
    updatePartialTotals('Local');
}

// Compute partial totals for periods
// @param target target team ('Foreign' or 'Local')
function updatePartialTotals(target) {
    // Computes partial period scores
    $('.gamePartialResult.gamePartialResult' + target).each(function(i, item) {
        var tokens = item.id.split("_");
        var periodScore = 0;

        $("[id$='Score" + target + "Team'].score-serializable.score")
            .each(function(i, item) {
                var index = new RegExp("[0-9]+");
                var id = index.exec(item.id);
                if (!isNaN($(item).val()) && belongsToPeriodRange(tokens[1], tokens[2], model.totalPeriods, id, false)) {
                    periodScore += Number($(item).val());
                }
            });

        $(item).html(periodScore);
    });
}

// Determines if a period belongs to a period range
// @param rangeFrequence number of ocurrences of range in the game (e.g. Mid = 2, Third = 3, Complete game = 1)
// @param rangeIndex range index inside the game (e.g. first mid = 1, seconde mid = 2, third quarter = 3 )
// @param totalPeriods total periods of the game
// @param period evaluated period zero based
// @param countExtraTime true if game has a extra time period
belongsToPeriodRange = function(rangeFrequence, rangeIndex, totalPeriods, period, countExtraTime) {
    return (period >= Math.ceil(((totalPeriods - ((countExtraTime == true) ? 0 : 1)) / rangeFrequence) * (rangeIndex - 1))) &&
    (period < Math.ceil(((totalPeriods - ((countExtraTime == true) ? 0 : 1)) / rangeFrequence) * rangeIndex));
}

function SendResults() {
    var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($('#save-btn').next()).css('position', 'absolute');

    var gameDetails = $('.score-serializable').serializeArray();
    gameDetails.push({ name: 'Code', value: $GAMECODE });
    gameDetails.push({ name: 'GameStatus', value: $('#GameStatus').val() });

    $.post(ControllerActions.SaveResult, gameDetails, function(data) {
        if (data) {
            $("#dialog").remove();

            $("<div id=\"dialog\" title=\"Notificación\"><p>Resultados insertados satisfactoriamente</p></div>").appendTo('body');

            $("#dialog").dialog({
                bgiframe: true,
                modal: true,
                buttons: {
                    Ok: function() {
                        $(this).dialog('close');
                    }
                }
            });
        }

        loader.fadeOut('fast', function() {
            loader.remove();
        });
    }, 'json');
}
