/// <reference path="jquery-1.4.1-vsdoc.js" />

/*
* jQuery Cascading Select Lists plug-in 0.1
*
* http://www.uiwork.net/jquery-plugins/cascading-select-lists
* 
*
*
* Licensed under the "do whatever you want with it" licence.
*/

(function($) {
    $.extend($.fn, {
        cascadingDdl: function(options) {
            var dependendentDdl = $('#' + options.cascaded);

            var options = $.extend({}, $.fn.cascadingDdl.defaults, {
                source: options.source, // Source's url
                cascaded: options.cascaded // The ddl element that depends on this list
            }, options);

            if (dependendentDdl.children().length == 0) {
                dependendentDdl.append('<option>' + options.dependentStartingLabel + '</option>');
                if (options.disableUntilLoaded) {
                    dependendentDdl.attr('disabled', 'disabled');
                }
            }

            return this.each(function() {
                var sourceDdl = $(this);

                sourceDdl.change(function() {
                    var extraParams = {
                        timestamp: +new Date()
                    };


                    var data = $.extend({ selected: $(this).val() }, extraParams);

                    dependendentDdl.empty()
                                    .attr('disabled', 'disabled')
                                    .append('<option>' + options.dependentLoadingLabel + '</option>');


                    if (options.spinnerImg) {
                        dependendentDdl.next('.' + options.spinnerClass).remove();

                        var spinner = $('<img />').attr('src', options.spinnerImg);
                        $('<span class="' + options.spinnerClass + '" />').append(spinner).insertAfter(dependendentDdl);
                    }

                    $.getJSON(options.source, data, function(response) {
                        dependendentDdl.empty().attr('disabled', null);
                        dependendentDdl.next('.' + options.spinnerClass).remove();
                        if (response.length > 0) {
                            $.each(response, function(i, item) {
                                dependendentDdl.append('<option value=' + item.value + '>' + item.label + '</option>');
                            });
                        } else {
                            dependendentDdl.empty()
                                    .attr('disabled', 'disabled')
                                    .append('<option>' + options.dependentNothingFoundLabel + '</option>');
                        }
                    })
                })
            })
        }
    });

    $.fn.cascadingDdl.defaults = {
        sourceStartingLabel: "Select one first",
        dependentNothingFoundLabel: "No elements found",
        dependentStartingLabel: "Select one",
        dependentLoadingLabel: "Loading options",
        disableUntilLoaded: true,
        spinnerClass: "cascading-select-spinner"
    }
})(jQuery);