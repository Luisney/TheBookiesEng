<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.TicketType>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Tipos de Ticket - Crear Tipo de Ticket
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "ticketTypeToCreate";  %>
    <h2>Crear Tipo de Ticket</h2>
    <% using (Html.BeginForm()) {%>
        <fieldset>
            <legend>Información General</legend>
            <p>
                <%= this.TextBox(model => model.Id).Label("Cantidad de Items:")%>
                <%= this.ValidationMessage(model => model.Id) %>
            </p>
            <p>
                <%= this.TextBox(model => model.Name).Label("Nombre:")%>
                <%= this.ValidationMessage(model => model.Name) %>
            </p>
            <p>
                <%= this.TextBox(model => model.Maximum).Label("Monto Máximo:")%>
                <%= this.ValidationMessage(model => model.Maximum) %>
            </p>
            <p>
                <label>&nbsp;</label>
                <input type="submit" value="Crear" />
            </p>
        </fieldset>
    <% } %>
    <div>
		<%=Html.ClientSideValidation<Gambling.Models.ViewModels.TicketTypeViewModel>(HtmlNamePrefix)%>
		<%=Html.ActionLink("Volver al listado", "Index", new {}, new { @class = "navPrev" })%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
</asp:Content>

