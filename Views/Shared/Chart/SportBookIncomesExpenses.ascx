<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<h2>
    Ingresos y Gastos</h2>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ["motionchart"], language: 'es' });
    $(function() {
        loadchart_SportBookIncomesExpenses();
        $('#chart_SportBookIncomesExpensesSearch').click(loadchart_SportBookIncomesExpenses);

        // Date pickers
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy'
        });
    });

    loadchart_SportBookIncomesExpenses = function() {
        $('#chart_SportBookIncomesExpenses')
            .theBookiesChart('MotionChart',
                {
                    url: '<%= Url.Action("GetSportBookIncomesExpenses","Chart",new { @area = "root"})%>',
                    is3D: true,
                    width: 650,
                    heigth: 420,
                    params:
                    {
                        StartDate: $('#chart_SportBookIncomesExpensesStartDate').val(),
                        EndDate: $('#chart_SportBookIncomesExpensesEndDate').val()
                    }
                });
    }
</script>

<div>
    <div>
        <label title="Desde">
            Desde:</label>
        <input id="chart_SportBookIncomesExpensesStartDate" type="text" class="datePicker"
            value="<%= DateTime.Now.AddDays( -30 ).ToShortDateString( ) %>" />
        <label title="Hasta">
            Hasta:</label>
        <input id="chart_SportBookIncomesExpensesEndDate" type="text" class="datePicker"
            value="<%= DateTime.Now.ToShortDateString( ) %>" />
        <button id="chart_SportBookIncomesExpensesSearch">
            Refrescar</button>
    </div>
    <div id="chart_SportBookIncomesExpenses">
    </div>
</div>
