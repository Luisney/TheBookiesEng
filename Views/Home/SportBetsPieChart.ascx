<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ["piechart"], language: 'es' });
    $(function() {
        $('#chart_SportBets')
            .theBookiesChart(
                'PieChart',
                {
                    url: '<%= Url.Action("GetSportBetShares","Chart",new { @area = "root"})%>',
                    chartParams:
                    {
                        is3D: true,
                        width: 445,
                        height: 215
                    }
                });
    }); 
</script>

<div class="statistics-Box">
    <h4>Sports bets</h4>
    <div id="chart_SportBets"></div>
</div>


