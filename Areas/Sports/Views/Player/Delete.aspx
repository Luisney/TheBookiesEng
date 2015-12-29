<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Player>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Jugadores - Eliminar Jugador
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%if( ViewData [ "ErrorMsg" ] == null )
  { %>
    <h2>
        Eliminar Jugadores
    </h2>
    <p>
        &iquest;Desea eliminar el registro?
    </p>
    <p>
        Código:
        <%= Model.Id%><br />
        Nombre:
        <%= Model.Name%>
    </p>
    <% using( Html.BeginForm( ) )
       {
    %>
    <input type="submit" value="Eliminar" />
    <% } %>
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
<%
    }
    else
    {
        Response.Write( "<h2>" );
        Response.Write( ViewData [ "ErrorMsg" ] );
        Response.Write( "</h2>" );
        Response.Write( Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } ) );
    } %>
</asp:Content>
