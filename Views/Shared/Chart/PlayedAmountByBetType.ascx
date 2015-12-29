<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<h2>
    Loterias Ventas por Tipo de Producto</h2>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ["motionchart"], language: 'es' });
    $(function() {
        loadchart_PlayedAmountByBetType();
        $('#chart_PlayedAmountByBetTypeSearch').click(loadchart_PlayedAmountByBetType);

        // Date pickers
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy'
        });
    });

    loadchart_PlayedAmountByBetType = function() {
        $('#chart_PlayedAmountByBetType')
        .theBookiesChart('MotionChart',
            {
                url: '<%= Url.Action("GetPlayedAmountByBetType","Chart",new { @area = "root"})%>',
                is3D: true,
                width: 650,
                heigth: 420,
                params:
                    {
                        StartDate: $('#chart_PlayedAmountByBetTypeStartDate').val(),
                        EndDate: $('#chart_PlayedAmountByBetTypeEndDate').val()
                    }
            });
    }
</script>

<div>
    <div>
        <label title="Desde">
            Desde:</label>
        <input id="chart_PlayedAmountByBetTypeStartDate" type="text" class="datePicker" value="<%= DateTime.Now.AddDays( -30 ).ToShortDateString( ) %>" />
        <label title="Hasta">
            Hasta:</label>
        <input id="chart_PlayedAmountByBetTypeEndDate" type="text" class="datePicker" value="<%= DateTime.Now.ToShortDateString( ) %>" />
        <button id="chart_PlayedAmountByBetTypeSearch">
            Refrescar</button>
    </div>
    <div id="chart_PlayedAmountByBetType">
    </div>
</div>
