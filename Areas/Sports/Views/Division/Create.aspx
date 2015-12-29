<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Division>" %>

<%@ Import Namespace="xVal.Html" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Ligas - Crear Liga") %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode("Crear Liga") %>
    </h2>
    <%= Html.ValidationSummary("Creación fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <label for="Sport">
                <%= Html.Encode("Deporte:")%>
            </label>
            <%= Html.DropDownList("SportId") %>
            <%= Html.ValidationMessage("SportId", "*")%>
        </p>
        <p>
            <%= this.TextBox(c => c.Name).Label("Nombre:") %>
            <%= this.ValidationMessage(c => c.Name) %>
        </p>
        <p>
            <%= this.TextBox(c => c.ShortName).Label("Nombre corto:") %>
            <%= this.ValidationMessage(c => c.ShortName) %>
        </p>
        <p>
            <label for="MonthStartSeason">
                Inicio de temporada:</label>
            <%= Html.DropDownList("MonthStartSeason")%>
            <%= Html.ValidationMessage("MonthStartSeason", "*") %>
        </p>
        <p>
            <label for="MonthEndSeason">
                Fin de temporada:
            </label>
            <%= Html.DropDownList("MonthEndSeason")%>
            <%= Html.ValidationMessage("MonthEndSeason", "*") %>
        </p>
        <p>
            <label for="MinimumScore">
                <%= Html.Encode( "Puntaje minimo:" ) %>
            </label>
            <%= Html.TextBox( "MinimumScore" )%>
            <%= Html.ValidationMessage( "MinimumScore", "*" )%>
        </p>
        <p>
            <label for="TopScore">
                <%= Html.Encode( "Puntaje máximo :" )%>
            </label>
            <%= Html.TextBox("TopScore" ) %>
            <%= Html.ValidationMessage("TopScore", "*") %>
        </p>
        <p>
            <label for="MinBoughtPoints">
                <%= Html.Encode( "Minimo carreraje comprado:" )%>
            </label>
            <%= Html.TextBox( "MinBoughtPoints" )%>
            <%= Html.ValidationMessage( "MinBoughtPoints", "*" )%>
        </p>
        <p>
            <label for="MaxBoughtPoints">
                <%= Html.Encode( "Máximo carreraje comprado:" )%>
            </label>
            <%= Html.TextBox( "MaxBoughtPoints" )%>
            <%= Html.ValidationMessage( "MaxBoughtPoints", "*" )%>
        </p>
        <p>
            <label for="DefaultPicking">
                <%= Html.Encode( "Precio por defecto:" )%>
            </label>
            <%= Html.TextBox( "DefaultPicking" )%>
            <%= Html.ValidationMessage( "DefaultPicking", "*" )%>
        </p>
        <p>
            <input type="submit" value="Crear" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Division>(HtmlNamePrefix)%>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
