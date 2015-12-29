/*
* jQuery imclock plugin with server time synchronization
* Go to http://imlog.pl/2010/01/23/imclock-server-synchronized.html
* for more info and docummentation.
*
* Copyright (c) 2010 Ignacy Moryc  <imoryc@gmail.com>
* Licensed under the MIT License:
*   http://www.opensource.org/licenses/mit-license.php
* 
* History
*  24/02/2010 Sergio Reyes - Added server refresh timeout (default: 10 min)
*/

(function ($) {

    $.fn.imclock = function (options) {
        var settings = jQuery.extend({
            name: "defaultName",
            size: 5
        }, options);
        var version = '1.4.0';
        return $.fn.imclock.start($(this), null);
    };

    var time = null;
    var date = "";

    // TODO 2: sepparate time setting interval and clock starting
    $.fn.imclock.start = function (element, lastServerTime) {
        // TODO: Add serverRefreshTimeout as a plugin option
        var serverRefreshTimeout = 600; // Server refresh timeout (default: 5 min)

        if (time == null) {
            var result = $.fn.imclock.getServerTime(element);
            time = result.time;
            date = result.date;
            var lastServerTime = new Date();
            lastServerTime.setSeconds(time.getSeconds());
        }
        else {
            // Updates time from server if serverRefreshTimeout was reached
            if (time.getSeconds() - lastServerTime.getSeconds() > serverRefreshTimeout) {
                result = $.fn.imclock.getServerTime(element);
                time = result.time;
                date = result.date;
                lastServerTime.setSeconds(time.getSeconds());
            }

            time.setSeconds(time.getSeconds() + 1);
        }

        var hours = time.getHours() + 4;
        var minutes = time.getMinutes();
        var seconds = time.getSeconds();

        if (minutes < 10) {
            minutes = '0' + minutes;
        }
        if (seconds < 10) {
            seconds = '0' + seconds;
        }

        element.html(date + ' ' + hours + ":" + minutes + ":" + seconds);
        element.timerID = setTimeout(function () { $.fn.imclock.start(element, lastServerTime); }, 1000);
    };

    // This is the function that gets the actual time from the server
    // time is expected to be returned as JSON data in field named "time"
    // For example the request could look like this:
    // {
    //  some_data: "lorem",
    //  time : 2010-12-12T12:23
    // }
    $.fn.imclock.getServerTime = function (element) {
        if ($("#time_href").length) {
            var url = $("#time_href")[0].innerHTML;
            $.getJSON(url, function (data) {
                if (data) {
                    time = new Date(Date.parse(data.time));
                    date = data.date;
                }
            });
        }
        if (time == null) {
            time = new Date();
        }

        //var newDate = calcTime('-4');
        //time = newDate.time;
        //date = newDate.date;

        return { time: time, date: date };
    };

    function calcTime(offset) {

        // create Date object for current location
        d = new Date();

        // convert to msec
        // add local time zone offset 
        // get UTC time in msec
        utc = d.getTime() + (d.getTimezoneOffset() * 60000);

        // create new Date object for different city
        // using supplied offset
        nd = new Date(utc + (3600000 * offset));

        // return time as a string
        return nd;

    }

})(jQuery);
