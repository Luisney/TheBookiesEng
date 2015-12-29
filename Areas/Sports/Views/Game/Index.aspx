<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>
<%@ Import Namespace="Gambling.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Juegos - Listado de juegos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        Listado de juegos
    </h1>
    <script type="text/javascript">
        <%-- Overrides default grid width--%>
        var ReduxListWidgetWidth = 700;
    </script>
    <% Html.RenderPartial( "ReduxListWidget" ); %>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a>
    </p>
</asp:Content>
