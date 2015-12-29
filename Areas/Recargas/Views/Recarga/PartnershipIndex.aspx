<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<RechargeBalanceModel>" %>

<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="System.Web.Mvc.Html" %>
<%@ Import Namespace="Gambling.Areas.Recargas.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Recargas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var pbal = Model.AvailableBalance;
        var cbal = Model.CurrentBalance;

        if (pbal != null)
        {
            using (Html.BeginForm("IncluirBalancePendiente", "Recarga", FormMethod.Post))
            {
    %>
    <h2>
        <%=ViewData["Usuario"] %>
        Balance de Recargas Pendiente</h2>
    <table class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Descripción
                </th>
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
                    Balance
                </td>
                <td>
                    <%= pbal.ClaroBalance.ToString("#,##0") %>
                </td>
                <td>
                    <%= pbal.OrangeBalance.ToString("#,##0") %>
                </td>
                <td>
                    <%= pbal.VivaBalance.ToString("#,##0") %>
                </td>
                <td>
                    <%= pbal.TricomBalance.ToString("#,##0") %>
                </td>
                <td>
                    <%= (pbal.ClaroBalance + pbal.OrangeBalance + pbal.VivaBalance + pbal.TricomBalance).ToString("#,##0") %>
                </td>
            </tr>
            <tr>
                <td>
                    % Comisión
                </td>
                <td>
                    %<%= pbal.ClaroCommissionPercent.ToString() %>
                </td>
                <td>
                    %<%= pbal.OrangeCommissionPercent.ToString() %>
                </td>
                <td>
                    %<%=pbal.VivaCommissionPercent.ToString() %>
                </td>
                <td>
                    %<%=pbal.TricomCommissionPercent.ToString() %>
                </td>
                <td>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <input type="submit" value="Incluir en Balance del Consorcio" />
    <br />
    <br />
    <br />
    <%
            }
        }

        if (cbal != null)
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
                    <%= cbal.Claro.ToString("#,##0") %>
                </td>
                <td>
                    <%= cbal.Orange.ToString("#,##0") %>
                </td>
                <td>
                    <%= cbal.Viva.ToString("#,##0") %>
                </td>
                <td>
                    <%= cbal.Tricom.ToString("#,##0") %>
                </td>
                <td>
                    <%= (cbal.Claro + cbal.Orange + cbal.Viva + cbal.Tricom).ToString("#,##0") %>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <a href="/Recargas/Recarga/TransferirBalanceCentroAcopio">Transferir Balance a Centro
        de Acopio &raquo;</a><br />
    <br />
    <% if (ViewData["storingCenterAccounts"] != null)
       {
           var storingCenters = (IDictionary<int, string>)ViewData["storingCenterAccounts"];
           if (storingCenters.Count > 0)
           {
    %>
    <u>Transferir Balance a Bancas desde Centros de Acopio con Balance</u>
    <ul>
        <%
               foreach (KeyValuePair<int, string> storingCenter in storingCenters)
               {%>
        <li><a href="/Recargas/Recarga/TransferirBalanceBancas/<%=storingCenter.Key %>">
            <%=storingCenter.Value%></a></li>
        <%
               }
        %>
    </ul>
    <% }
       }%>
    <br />

    <br />
    <% if (ViewData["storingCenterAccounts2"] != null)
       {
           var storingCenters = (IDictionary<int, string>)ViewData["storingCenterAccounts2"];
           if (storingCenters.Count > 0)
           {
    %>
    <u>Transferir Balance a Grupo de Bancas desde Centros de Acopio con Balance</u>
    <ul>
        <%
               foreach (KeyValuePair<int, string> storingCenter in storingCenters)
               {%>
        <li><a href="/Recargas/Recarga/TransferirBalanceGrupoBancas/<%=storingCenter.Key %>">
            <%=storingCenter.Value%></a></li>
        <%
               }
        %>
    </ul>
    <% }
       }%>
    <br />

    <% }
    %>
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
