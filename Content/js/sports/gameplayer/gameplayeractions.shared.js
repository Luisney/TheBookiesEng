/// <reference path="jquery-1.4.1-vsdoc.js"/>
blockCancelledMatchups = function (selector) {
    $(selector).block({
        message: '<p><span class="LightTitle">Cancelado</span></p>',
        css: {
            cursor: 'auto',
            border: 'none',
            padding: '15px',
            backgroundColor: '#000',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px',
            opacity: 0.7,
            color: '#fff'
        },
        overlayCSS: {
            cursor: 'auto',
            backgroundColor: '#000', 
            opacity: 0.3
        }
    });
}

$(function () {
    blockCancelledMatchups('.disabled-matchup');

    $('.matchup-delete').live('click', function () {
        var matchupId = this.id;
        var id = matchupId.substring(matchupId.lastIndexOf("-") + 1);

        // Add a loader
        var loader = $('<img />').attr('src', LoaderImgUrl);
        $(this).parent().append(loader);

        $.post(ControllerActions.Delete, { Code: matchupId.substring(matchupId.lastIndexOf("-") + 1) }, function () {
            $('#divMatchUp' + id).remove();
        });
    });

    $('.matchup-cancel').live('click', function () {
        var matchupId = this.id;
        var id = matchupId.substring(matchupId.lastIndexOf("-") + 1);

        // Add a loader
        var loader = $('<img />').attr('src', LoaderImgUrl);
        $(this).parent().append(loader);

        $.post(ControllerActions.Cancel, { matchupId: matchupId.substring(matchupId.lastIndexOf("-") + 1) }, function () {
            $('#divMatchUp' + id).addClass('disabled-matchup');
            blockCancelledMatchups('#divMatchUp' + id);
            $('#divMatchUp' + id).find('.links').remove();
        });
    });
});