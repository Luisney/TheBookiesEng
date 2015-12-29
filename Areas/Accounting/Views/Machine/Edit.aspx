<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.Machine>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Slot Machines - Edit Slot Machine
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "machineToEdit";  %>
    <h2>Edit Slot Machine</h2>
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <%= this.TextBox(c => c.MachineCode).Label("Code:") %>
            <%= this.ValidationMessage(c => c.MachineCode) %>
        </p>
        <p>
            <label>Bench:</label>
            <%= Html.DropDownList("machineToEdit.SportBookId")%>
        </p>
        <p>
            <label>Machine Type:</label>
            <%= Html.DropDownList("machineToEdit.MachineType.Id")%>
        </p>
        <p>
            <%= this.TextBox(c => c.ValueCoins).Value(Model.ValueCoins.ToString("F2")).Label("Coin Value:") %>
            <%= this.ValidationMessage(c => c.ValueCoins) %>
        </p>
        <p>
            <%= this.TextBox(c => c.StartControlNumber).Label("Start Number:") %>
            <%= this.ValidationMessage(c => c.StartControlNumber) %>
        </p>
        <p>
            <label>&nbsp;</label>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>
    <div>        
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.Machine>(HtmlNamePrefix)%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>
</asp:Content>
