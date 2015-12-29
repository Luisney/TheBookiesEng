<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Accounting.IncomeViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Income - Edit Income
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "incomeToEdit";  %>
    <h2>Editar Ingreso</h2>   
    <% using (Html.BeginForm()) {%>
        <fieldset>
            <legend>General Information</legend>
            <p>
                <%= this.TextBox( c => c.Date ).Value(Model.Date.ToShortDateString()).Label("Date:") %>
                <%= this.ValidationMessage( c => c.Date ) %>
            </p>
            <p>
                 <label>Bench:</label>
                 <%= Html.DropDownList("incomeToEdit.SportBookId")%>
            </p>
            <p>
                <label>Account:</label>
                <%= Html.DropDownList("incomeToEdit.IncomeCode")%>
            </p>
            <p>
                <%= this.TextBox(c => c.Income.Amount).Value(Model.Income.Amount.ToString("F2")).Label("Amount:")%>
                <%= this.ValidationMessage(c => c.Income.Amount)%>
            </p>            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>
    <% } %>    
    <div>
        <%= Html.ClientSideValidation<TheBookies.Model.IncomeDetail>(HtmlNamePrefix + ".Income")%>
		<%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>    
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>        
    <script type="text/javascript">        
        $(function() {
            $("#incomeToEdit_Date").datepicker({
                dateFormat: 'dd/mm/yy'
            });            
        });
    </script>
</asp:Content>

