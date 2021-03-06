<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Accounting.ExpenseViewModel>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Expenses - Create expense
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "expenseToCreate";  %>
    <h2>Create expense</h2>    
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <%= this.TextBox(c => c.Date).Value(DateTime.Now.ToShortDateString()).Label("Date:") %>
            <%= this.ValidationMessage( c => c.Date ) %>
        </p>
        <p>
            <label>Bench:</label>
            <%= Html.DropDownList("expenseToCreate.SportBookId")%>
        </p>
        <p>
            <label>Account:</label>
            <%= Html.DropDownList("expenseToCreate.ExpenseCode")%>
        </p>
        <p>
            <%= this.TextBox(c => c.Expense.Amount ).Label("Amount:") %>
            <%= this.ValidationMessage( c => c.Expense.Amount ) %>
        </p>
        <p>
            <%= this.TextArea(c => c.Expense.Detail).Label("Detail:") %>
            <%= this.ValidationMessage(c => c.Expense.Detail) %>
        </p>
        <p>
            <label>Common Expense:</label>
            <%= this.CheckBox(c => c.Expense.IsCommon) %>
        </p>
        <p>
            <label>Recurrent:</label>
            <%= this.CheckBox(c => c.Expense.IsAppellants) %>
        </p>
        <p>
            <label>&nbsp;</label>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%=Html.ActionLink( "Return to list", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.ExpenseDetail>(HtmlNamePrefix + ".Expense")%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("#expenseToCreate_Date").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });
    </script>
</asp:Content>
