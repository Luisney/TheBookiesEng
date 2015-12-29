<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.TicketType>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Tipos de Ticket - Editar Tipo de Ticket
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "ticketTypeToEdit";  %>
    <h2>Editar Tipo de Ticket</h2>    
    <% using (Html.BeginForm()) {%>
        <fieldset>
            <legend>Información General</legend>
            <p>
                <%= this.TextBox(model => model.Id).Disabled(true).Label("Cantidad de Items:") %>
                <%= this.ValidationMessage(model => model.Id) %>
            </p>
            <p>
                <%= this.TextBox(model => model.Name).Label("Nombre:") %>
                <%= this.ValidationMessage(model => model.Name) %>
            </p>
            <p>
                <%= this.TextBox(model => model.Maximum).Value(Model.Maximum.ToString("F2")).Label("Monto Máximo:")%>
                <%= this.ValidationMessage(model => model.Maximum) %>
            </p>
            <p>
                <label>&nbsp;</label>
                <input type="submit" value="Guardar" />
            </p>
        </fieldset>

    <% } %>
    <div>
        <%=Html.ClientSideValidation<Gambling.Models.TicketType>(HtmlNamePrefix)%>
		<%=Html.ActionLink("Volver al listado", "Index", new {}, new { @class = "navPrev" })%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
</asp:Content>

