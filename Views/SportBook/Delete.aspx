<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.SportBook>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Benches - Delete Benches
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%if( ViewData [ "ErrorMsg" ] == null )
  { %>
    <h2>
        Delete Benches
    </h2>
    <p>
        Do you wish to remove this entry?
    </p>
    <p>
        Code:
        <%= Model.Id%><br />
        Name:
        <%= Model.Name%>
    </p>
    <% using( Html.BeginForm( ) )
       {
    %>
    <input type="submit" value="Delete" />
    <% } %>
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
<%
    }
    else
    {
        Response.Write( "<h2>" );
        Response.Write( ViewData [ "ErrorMsg" ] );
        Response.Write( "</h2>" );
        Response.Write( Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } ) );
    } %>
</asp:Content>
