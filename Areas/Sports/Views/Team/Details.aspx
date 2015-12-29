<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Team>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Equipos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Detalles del Equipo
    </h2>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <%= Html.Encode( "Código:" ) + Html.Encode(Model.Id) %>
        </p>
        <p>
            <%= Html.Encode( "Nombre:" ) + Html.Encode(Model.Name) %>
        </p>
        <p>
            <%=Html.Encode("Deporte:") + Html.Encode((Model.Sport != null) ? Model.Sport.Name : "Ninguno") %>
        </p>
        <p>
            <%=Html.Encode("División:") + Html.Encode((Model.Division != null) ? Model.Division.Name : "Ninguno")%>
        </p>
    </fieldset>
    <p>
        <%=Html.ActionLink("Editar", "Edit", new { Code=Model.Id }) %>
        |
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
</asp:Content>
