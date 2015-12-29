<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Accounting.IncomeViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Income - Create Income
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "incomeToCreate";  %>
    <h2>Create Income</h2>    
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>Información General</legend>
        <p>
            <%= this.TextBox( c => c.Date ).Value(DateTime.Now.ToShortDateString()).Label("Date:") %>
            <%= this.ValidationMessage( c => c.Date ) %>
        </p>
        <p>
            <label>Bench:</label>
            <%= Html.DropDownList("incomeToCreate.SportBookId")%>
        </p>
        <p>
            <label>Account:</label>
            <%= Html.DropDownList("incomeToCreate.IncomeCode")%>
        </p>
        <p>
            <%= this.TextBox( c => c.Income.Amount ).Label("Monto:") %>
            <%= this.ValidationMessage(c => c.Income.Amount)%>
        </p>        
        <p>
            <label>&nbsp;</label>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>
    <div>        
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.IncomeDetail>(HtmlNamePrefix + ".Income")%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("#incomeToCreate_Date").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });
    </script>
</asp:Content>
