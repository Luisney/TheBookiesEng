<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<RechargeBalanceModel>" %>

<%@ Import Namespace="System.Security.Policy" %>
<%@ Import Namespace="Gambling.Areas.Recargas.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Recargas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (Model.CurrentBalance != null)
       {
    %>
    <h2>
        Balance de Recargas en Centro de Acopio <%=ViewData["StoringCenterName"].ToString()%></h2>
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
                    Tricom
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <%= Model.CurrentBalance.Claro.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.CurrentBalance.Orange.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.CurrentBalance.Viva.ToString("#,##0") %>
                </td>
                <td>
                    <%= Model.CurrentBalance.Tricom.ToString("#,##0") %>
                </td>
                <td>
                    <%= (Model.CurrentBalance.Claro + Model.CurrentBalance.Orange + Model.CurrentBalance.Viva + Model.CurrentBalance.Tricom).ToString("#,##0") %>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <a href="/Recargas/Recarga/TransferirBalanceBanca/">Transferir Balance a Bancas &raquo;</a><br />
    <br />
    <br />
    <% } %>
    <br />
    <br />
    <br />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

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
