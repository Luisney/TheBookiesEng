<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.IncomeCode>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Income Accounts - Edit Income Account
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "incomeCodeToEdit";  %>
    <h2>Edit Income Account</h2>    
    <% using (Html.BeginForm()) {%>
        <fieldset>
            <legend>General Information</legend>
            <p>
                <%= this.TextBox(c => c.Detail).Label("Nombre:") %>
                <%= this.ValidationMessage(c => c.Detail) %>
            </p>
            <p>
                <label>&nbsp;</label>
                <input type="submit" value="Save" />
            </p>
        </fieldset>
    <% } %>
    <div>        
		<%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.ExpenseCode>( HtmlNamePrefix )%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
</asp:Content>

