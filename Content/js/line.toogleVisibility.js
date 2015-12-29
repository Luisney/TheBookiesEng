/// <reference path="jquery-1.4.1-vsdoc.js"/>
$('.periods-btn').live( 'click', function () {
    $(this).parent().find('.lines').toggle();
});