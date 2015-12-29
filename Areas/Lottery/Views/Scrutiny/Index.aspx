<%@ Page Title="Procesando Escrutinio" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="TitleContent">
    Scrutiny in process, please wait 
</asp:Content>

<asp:content runat="server" ContentPlaceHolderID="MainContent">
    <h1>Scrutiny in process, please wait </h1>
    <img src="/Content/images/coganim.gif" />
</asp:content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaRefresher" runat="server">
    <meta http-equiv="refresh" content="3; url=/Lottery/Scrutiny/Scrutiny/?date=<%= ViewData["ScrutinyDate"] %>" />
</asp:Content>
