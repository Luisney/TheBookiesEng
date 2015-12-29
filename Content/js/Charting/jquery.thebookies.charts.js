/// <reference path="jquery-1.4.1-vsdoc.js"/>
jQuery.fn.theBookiesChart = function (chartType, options) {
    arguments = jQuery.extend({
        url: "",
        params: {},
        chartParams: {}
    }, options);

    arguments.chartParams = jQuery.extend({
        is3D: true,
        title: "",
        width: 600,
        height: 420,
        legend: 'right',
        titleX: "",
        titleY: "",
        enableTooltip: true
    }, arguments.chartParams);

    var div = $(this).get(0);
    var outerArguments = arguments;

    $.post(outerArguments.url,
        outerArguments.params,
        function (result) {

            // Motion chart data is not a valid JSON, so we need to translate it from JSON
            if (chartType == 'MotionChart')
                JSONtoMotionChartData(result);

            //Loading datasource
            var data = new google.visualization.DataTable(result, 0.5);

            //Loading chart
            var chart = new google.visualization[chartType](div);

            //Draws chart
            chart.draw(
                data,
                outerArguments.chartParams
                );
        },
        "json");
}

function JSONtoMotionChartData(data) {
    $.each(data["rows"], function (index, item) {
        item["c"][1]["v"] = new Date(item["c"][1]["v"]);
    });
}