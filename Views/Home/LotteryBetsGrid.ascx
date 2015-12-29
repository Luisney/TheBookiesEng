<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ["piechart"], language: 'es' });

    $(function() {
        //loadChartLotteryBets();
        //$('#chart_LotteryBetsSearch').click(loadChartLotteryBets);

        // Date pickers
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy'
        });
    });

    loadGridLotteryBets = function() {
        $('#grid_LotteryBets')
        .theBookiesChart(
            'PieChart',
            {
                url: '<%= Url.Action("GetLotteryBetShares","Chart",new { @area = "root"})%>',
                chartParams:
                {
                    is3D: true,
                    width: 445,
                    height: 215
                },
                params:
                {
                    StartDate: $('#grid_LotteryBetsStartDate').val(),
                    EndDate: $('#grid_LotteryBetsEndDate').val()
                }
            });
    }
</script>

<div class="statistics-Box noMarginRight" style="margin-left:10px">
    <h4>
        Lottery bets</h4>
    <label title="Desde">
        From:</label>
    <input id="grid_LotteryBetsStartDate" type="text" class="datePicker" value="<%= DateTime.Now.ToShortDateString( ) %>" />
    <label title="Hasta">
        To:</label>
    <input id="grid_LotteryBetsEndDate" type="text" class="datePicker" value="<%= DateTime.Now.ToShortDateString( ) %>" />
    <button id="grid_LotteryBetsSearch">
        Refresh</button>
    <div id="grid_LotteryBets">
    </div>
</div>
