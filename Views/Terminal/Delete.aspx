<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Terminal>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Terminals - Remove terminales
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%if( this.ViewData [ "ErrorMsg" ] == null )
      { %>
    <h2>
        Remove terminal
    </h2>
    <p>
        Do you wish to remove this entry?
    </p>
    <p>
        Code:
        <%= Model.Id%><br />
        Mac:
        <%= Model.Mac%>
    </p>
    <br />
    <% using( Html.BeginForm( ) )
       {
    %>
    <input type="submit" value="Delete" />
    <% } %>
    <br />
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new { }, new { @class = "navPrev" } )%>
    </div>
    <%
        }
      else
      {
          Response.Write( "<h2>" );
          Response.Write( ViewData [ "ErrorMsg" ] );
          Response.Write( "</h2><br/>" );
          Response.Write( Html.ActionLink( "Volver al listado", "Index", new
          {
          }, new
          {
              @class = "navPrev"
          } ) );
      } %>
</asp:Content>
