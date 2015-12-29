<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Helpers" %>
<div class="leftNavigation">
    <div class="menuSection">
        <h1 class="accounting">
            Contabilidad</h1>
        <ul>
            <%= Html.MenuItem("Cuentas de Gastos", "Index", "ExpenseCode", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Gastos", "Index", "Expense", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Cuentas de Ingresos", "Index", "IncomeCode", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Ingresos", "Index", "Income", new { @area = "Accounting" }, null )%>
        </ul>
    </div>
    <div class="menuSection">
        <h1>
            Máquinas</h1>
        <ul>
            <%= Html.MenuItem("Tipos de Máquina", "Index", "MachineType", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Máquinas", "Index", "Machine", new { @area = "Accounting" }, null )%>
        </ul>
    </div>
</div>
