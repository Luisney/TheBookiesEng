<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Centro de Acopio no Definido" ) %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Centro de Acopio no Definido" ) %>
    </h2>
    <p>Debe asignar un Centro de Acopio a este usuario para poder utilizar este Rol.</p>
    <br />

    <br />
</asp:Content>
