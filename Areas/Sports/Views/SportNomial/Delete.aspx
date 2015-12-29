<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.SportNomial>" %>

<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Precios - Eliminar Precio
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%if( ViewData [ "ErrorMsg" ] == null )
  { %>
    <h2>
        Eliminar Precio
    </h2>
    <p>
        &iquest;Desea eliminar el precio?
    </p>
    <p>
        Deporte:
        <%= Model.Sport.Name%><br />
        Precio:
        <%= Model.Male + "/" + Model.Female %>
    </p>
    <% using( Html.BeginForm( ) )
       {
    %>
        <%= this.Hidden( S => S.Id ) %>
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
