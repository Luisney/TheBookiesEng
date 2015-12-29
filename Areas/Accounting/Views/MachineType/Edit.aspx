<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.MachineType>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Machine Types - Edit Machine Types
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "machineTypeToEdit";  %>
    <h2>Edit Machine Type</h2>   
    <% using (Html.BeginForm()) {%>
        <fieldset>
            <legend>General Information</legend>            
            <p>
                <%= this.TextBox( model => model.Name ).Label("Name:") %>
                <%= this.ValidationMessage( model => model.Name ) %>
            </p>
            <p>
                <%= this.CheckBox( model => model.JackPot ).Label("JackPot:") %>
                <%= this.ValidationMessage( model => model.JackPot ) %>
            </p>                  
            <p>
                <label>&nbsp;</label>
                <input type="submit" value="Save" />
            </p>
        </fieldset>
    <% } %>
    <div>
        <%=Html.ClientSideValidation<TheBookies.Model.MachineType>(HtmlNamePrefix)%>
		<%=Html.ActionLink("Return to listing", "Index", new {}, new { @class = "navPrev" })%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
</asp:Content>

