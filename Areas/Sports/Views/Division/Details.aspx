<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Division>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Ligas - Detalles de la Liga") %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode("Detalles de la Liga")%>
    </h2>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <%= Html.Encode( "Código: " ) + Html.Encode(Model.Id) %>
        </p>
        <p>
            Nombre:
            <%= Html.Encode(Model.Name) %>
        </p>
        <p>
            Inicio de temporada:
            <%= Html.Encode(Model.MonthStartSeason) %>
        </p>
        <p>
            Fin de temporada:
            <%= Html.Encode(Model.MonthEndSeason) %>
        </p>
        <p>
            <%= Html.Encode( "Máximo puntaje: " ) + Html.Encode(Model.TopScore) %>
        </p>
        <p>
            <%= Html.Encode("Deporte: ") + Html.Encode((Model.Sport != null) ? Model.Sport.Name : "Ninguno")%>
        </p>
         <p>
            <%= Html.Encode( "Picking por defecto: " + Model.DefaultPicking )%>
        </p>
    </fieldset>
    <p>
        <%=Html.ActionLink("Editar", "Edit", new { Code=Model.Id }) %>
        |
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
</asp:Content>
