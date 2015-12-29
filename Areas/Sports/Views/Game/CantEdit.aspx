<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Juegos - Editar
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Editar Juego</h2>
    <p>Los Juegos que ya han comenzado no pueden ser editados.</p>
    <br/>
    <p>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
    

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
</asp:Content>
