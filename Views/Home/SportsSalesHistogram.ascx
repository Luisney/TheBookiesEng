<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ["corechart"], language: 'es' });

    $(function() {
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
    });    
</script>

<div class="dashboard-histograms" style="overflow: hidden; border: 1px solid #E4E4E4;
    padding: 10px">
    <div id="chart_SalesHistogramSports" class="histogram" style="float: left">
    </div>
</div>
