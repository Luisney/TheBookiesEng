<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<SumarioRecargaModel>" %>

<%@ Import Namespace="System.Security.Policy" %>
<%@ Import Namespace="Gambling.Areas.Recargas.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Recargas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%
        if (Model.BalancePendiente != null)
        {
    %>
    <h2>
        Balance de Recargas Pendiente<%=ViewData["Usuario"] %></h2>
    <table class="table" style="width: 500px">
        <thead>
            <tr>
                <th style="width: 100px">
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <%= Model.BalancePendiente.Claro.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.BalancePendiente.Orange.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.BalancePendiente.Viva.ToString("#,##0") %>
                </td>
                <td>
                    <%= (Model.BalancePendiente.Claro + Model.BalancePendiente.Orange + Model.BalancePendiente.Viva).ToString("#,##0") %>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <input type="submit" value="Incluir en Balance Actual" />

    <br />
    <br />
    <br />
    <% }
        if (Model.BalanceConsorcio != null)
        {
    %>
    <h2>
        Balance de Recargas en Consorcio</h2>
    <table class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <%= Model.BalanceConsorcio.Claro.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.BalanceConsorcio.Orange.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.BalanceConsorcio.Viva.ToString("#,##0") %>
                </td>
                <td>
                    <%= (Model.BalanceConsorcio.Claro + Model.BalanceConsorcio.Orange + Model.BalanceConsorcio.Viva).ToString("#,##0") %>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <a href="/Recargas/Recarga/TransferirBalanceCentroAcopio/1">Transferir Balance a Centro
        de Acopio &raquo;</a><br />
    <br />
    <br />
    <% }
        if (Model.BalanceCentrosAcopio.Count > 0)
        {
    %>
    <h2>
        Balance de Recargas en Centros de Acopio</h2>
    <table class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Centro de Acopio
                </th>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <% foreach (BalanceRecarga balance in Model.BalanceCentrosAcopio)
               { %>
            <tr>
                <td>
                    <%= balance.Nombre %>
                </td>
                <td>
                    <%= balance.Claro.ToString("#,##0") %>
                </td>
                <td>
                    <%= balance.Orange.ToString("#,##0") %>
                </td>
                <td>
                    <%= balance.Viva.ToString("#,##0") %>
                </td>
                <td>
                    <%= (balance.Claro + balance.Orange + balance.Viva).ToString("#,##0") %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <br />
    <a href="/Recargas/Recarga/TransferirBalanceBanca/1">Transferir Balance a Banca &raquo;</a><br />
    <br />
    <% } %>
    <br />
    <h2>
        Balance de Recargas en Bancas</h2>
    <table class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Banca
                </th>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <% foreach (BalanceRecarga balance in Model.BalanceBancas)
               {
            %>
            <tr>
                <td>
                    <%=balance.Nombre %>
                </td>
                <td>
                    <%= balance.Claro.ToString("#,##0") %>
                </td>
                <td>
                    <%= balance.Orange.ToString("#,##0") %>
                </td>
                <td>
                    <%= balance.Viva.ToString("#,##0") %>
                </td>
                <td>
                    <%= (balance.Claro + balance.Orange + balance.Viva).ToString("#,##0") %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <br />
    <br />
    <br />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    <!-- <link href="/Content/CSS/table.css" rel="Stylesheet" type="text/css" /> -->
    <style type="text/css">
        .monto
        {
            text-align: right;
            width: 70px;
        }
        .table th
        {
            text-align: center;
        }
    </style>
</asp:Content>
