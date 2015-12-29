<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.MachineDetail>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Edit</h2>    
    <% using (Html.BeginForm()) {%>
        <fieldset>
            <legend>Fields</legend>            
            <p>
                <%= this.TextBox(model => model.Date).Label("Date:") %>
                <%= this.ValidationMessage(model => model.Date) %>
            </p>
            <p>
                <%= this.TextBox(model => model.StartNumber).Label("Start Number:") %>
                <%= this.ValidationMessage(model => model.StartNumber) %>
            </p>
            <p>
                <%= this.TextBox(model => model.ColectedAmount).Label("Collected Amount:").Disabled(true) %>
                <%= this.ValidationMessage(model => model.ColectedAmount) %>
            </p>            
            <p>
                <label>&nbsp;</label>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ClientSideValidation<TheBookies.Model.MachineDetail>(HtmlNamePrefix)%>
		<%=Html.ActionLink("Return to listing", "Index", new {}, new { @class = "navPrev" })%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>
</asp:Content>

