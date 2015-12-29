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

        $('#chart_SalesHistogramSports')
            .theBookiesChart('LineChart',
                {
                    url: '<%= Url.Action("GetDailySalesForSportbooks","Chart",new { @area = "root"})%>',
                    chartParams:
                    {
                        is3D: false,
                        width: 960,
                        height: 315,
                        colors: ['#4684EE', '#DC3912', '#40C012']
                    }
                });

        $('.dashboard-toggle').click(function() {

            $('.dashboard-toggle').css('font-weight', 'normal');
            $(this).css('font-weight', 'bold');
            toggleHistograms($(this).attr('href'));

            return false;
        })

        $('#SalesHistogramLottery').css('margin-left', -2000);
    });

    function toggleHistograms(histogramToShow) {
        $('.histogram').css('margin-left', -2000).hide();
        $(histogramToShow).css('margin-left', 0).show();
    }

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
</script>

<p>
    <a href="#chart_SalesHistogramSports" class="dashboard-toggle" style="text-decoration: none;
        font-weight: bold">Sports sales</a> | <a style="text-decoration: none" class="dashboard-toggle"
            href="#SalesHistogramLottery">Lottery sales</a></p>
<div class="dashboard-histograms" style="overflow: hidden; border: 1px solid #E4E4E4;
    padding: 10px">
    <div id="chart_SalesHistogramSports" class="histogram" style="float: left">
    </div>
    <div id="SalesHistogramLottery" class="histogram" style="float: left">
        <div id="controls_SalesHistogramLottery">
            <label title="Desde">
                From:</label>
            <input id="dashboardHistogramsLotteryStartDate" type="text" class="datePicker" value="<%= DateTime.Now.AddDays( -30 ).ToShortDateString( ) %>" />
            <label title="Hasta">
                To:</label>
            <input id="dashboardHistogramsLotteryEndDate" type="text" class="datePicker" value="<%= DateTime.Now.ToShortDateString( ) %>" />
            <button id="dashboardHistogramsLotterySearch">
                Refresh</button>
        </div>
        <div id="chart_SalesHistogramLottery">
        </div>
    </div>
</div>
