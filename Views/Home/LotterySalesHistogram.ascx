<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ["corechart"], language: 'es' });

    $(function() {
        loadHistogramsLottery();
        $('#dashboardHistogramsLotterySearch').click(loadHistogramsLottery);

        // Date pickers
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy'
        });
    });

    loadHistogramsLottery = function() {
        $('#chart_SalesHistogramLottery')
        .theBookiesChart('LineChart',
            {
                url: '<%= Url.Action("GetDailySalesForLottery","Chart",new { @area = "root"})%>',
                params:
                {
                    StartDate: $('#dashboardHistogramsLotteryStartDate').val(),
                    EndDate: $('#dashboardHistogramsLotteryEndDate').val()
                },
                chartParams:
                {
                    is3D: false,
                    width: 960,
                    height: 315,
                    colors: ['#4684EE', '#DC3912', '#40C012']
                }
            });
    }

    function toggleHistograms(histogramToShow) {
        $('.histogram').css('margin-left', -2000).hide();
        $(histogramToShow).css('margin-left', 0).show();
    }
</script>

<div class="dashboard-histograms" style="overflow: hidden; border: 1px solid #E4E4E4;
    padding: 10px">
    <div>
        <label title="Desde">
            From:</label>
        <input id="dashboardHistogramsLotteryStartDate" type="text" class="datePicker" value="<%= DateTime.Now.AddDays( -30 ).ToShortDateString( ) %>" />
        <label title="Hasta">
            To:</label>
        <input id="dashboardHistogramsLotteryEndDate" type="text" class="datePicker" value="<%= DateTime.Now.ToShortDateString( ) %>" />
        <button id="dashboardHistogramsLotterySearch">
            Refresh</button>
    </div>
    <div id="chart_SalesHistogramLottery" class="histogram" style="float: left">
    </div>
</div>
