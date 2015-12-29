<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Sport>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Deportes - Detalles del Deporte
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Detalles del Deporte
    </h2>
    <fieldset>
        <legend>Campos</legend>
        <p>
            Código:
            <%= Html.Encode(Model.Id) %>
        </p>
        <p>
            Nombre:
            <%= Html.Encode(Model.Name) %>
        </p>
        <p>
            Maximo:
            <%= Html.Encode(String.Format("{0:F}", Model.Maximum)) %>
        </p>
        <p>
            Periodos:
            <%= Html.Encode(Model.Periods) %>
        </p>
        <p>
            <%= Html.Encode( "Tipo de anotación:" ) %>
            <%= Html.Encode((Model.GoalType != null) ? Model.GoalType.Type: "Ninguno") %>
        </p>
        <p>
            Apuesta por defecto:
            <%= Html.Encode(Model.DefaultBetType.Name) %>
        </p>
    </fieldset>
    <p>
        <%=Html.ActionLink("Editar", "Edit", new { Code=Model.Id }) %>
        |
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
</asp:Content>
