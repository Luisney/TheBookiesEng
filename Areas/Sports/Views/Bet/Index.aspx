<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/bet.index.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <script src="/Content/js/Charting/jquery.thebookies.charts.js" type="text/javascript"></script>

    <script type="text/javascript">
        var actionUrl = '<%= Url.Action("JsonSearch", "Bet", new { @area = "Sports" }, null ) %>';
        var getTicketCashTotalsUrl = '<%= Url.Action("GetTicketCashTotals", "Bet", new { @area = "Sports" }, null ) %>';
        var getTicketQuantityTotalsUrl = '<%= Url.Action("GetTicketQuantityTotals", "Bet", new { @area = "Sports" }, null ) %>';
        var getBetDetailsUrl = '<%= Url.Action("GetBetDetails", "Bet", new { @area = "Sports" }, null ) %>';
        var getSportBooksUrl = '<%= Url.Action("GetSportBooks", "SportBook", new { @area = "root" }, null ) %>';

        google.load("visualization", "1", { packages: ["columnchart"], language: 'es' }); 
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Tickets - Listado de Tickets
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Tickets
    </h2>
    <div id="TicketsTabs">
        <ul>
            <li><a linkindex="40" href="#TicketsTabs_Index">Listado</a> </li>
            <li><a linkindex="41" href="#TicketsTabs_Totals">Totales del dia</a> </li>
        </ul>
        <div id="TicketsTabs_Index" class="centered">
            <table id="ajaxDataTable">
            </table>
            <div id="Pager">
            </div>
            <br />
        </div>
        <div id="TicketsTabs_Totals">
            <h2>
                Resumen de Tickets</h2>
            <table>
                <tr>
                    <td>
                        Seleccione una banca:
                    </td>
                    <td>
                        <select id="totalsSportBookId">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Seleccione una fecha:
                    </td>
                    <td>
                        <input id="totalsDate" type="text" />
                    </td>
                </tr>
            </table>
            <br />
            <h3 class="centered">
                Numero de tickets</h3>
            <br />
            <div id="totalsChart" class="centered">
            </div>
            <br />
            <div>
                <h3>
                    Totales financieros</h3>
                <p id="pendingRiskLabel" class="right-aligned">
                </p>
                <p id="betTotalLabel" class="right-aligned">
                </p>
                <p id="winnersTotalLabel" class="right-aligned">
                </p>
                <p id="voidedTotalLabel" class="right-aligned">
                </p>
                <p id="differenceTotalLabel" class="right-aligned">
                </p>
            </div>
            <div id="TicketDetail" title="Detalle del ticket">
                <fieldset>
                    <table>
                        <th>
                            <p class="right-aligned">
                                <label for="TicketCode">
                                    Serial:
                                </label>
                                <input id="TicketCode" type="text" name="name" disabled="disabled" class="ui-widget-content ui-corner-all" />
                            </p>
                            <p class="right-aligned">
                                <label for="TicketDateTime">
                                    Fecha y hora:
                                </label>
                                <input id="TicketDateTime" type="text" name="name" disabled="disabled" class="ui-widget-content ui-corner-all" />
                            </p>
                            <p class="right-aligned">
                                <label for="TicketBetAmount">
                                    Monto Apostado:
                                </label>
                                <input id="TicketBetAmount" type="text" name="name" disabled="disabled" class="ui-widget-content ui-corner-all" />
                            </p>
                            <p id="TeaserDetailLabel" class="right-aligned">
                            </p>
                        </th>
                    </table>
                </fieldset>
                <table id="TicketDetails" class="dataTableTickets">
                    <tr>
                        <th>
                            <%= Html.Encode( "Código" )%>
                        </th>
                        <th>
                            Nombre
                        </th>
                        <th>
                            Jugada
                        </th>
                        <th>
                        </th>
                        <th>
                            Periodo
                        </th>
                        <th>
                            Precio
                        </th>
                    </tr>
                </table>
                <br />
                <fieldset>
                    <table>
                        <th>
                            <p class="right-aligned">
                                <label for="TicketAmountToWin">
                                    Monto a Pagar:
                                </label>
                                <input id="TicketAmountToWin" type="text" name="name" disabled="disabled" class="ui-widget-content ui-corner-all" />
                            </p>
                        </th>
                    </table>
                </fieldset>
                <img alt="Cargando..." style="border: 5px;" id="TicketDetailsLoader" src="/Content/images/ajax-loader-small.gif" />
            </div>
        </div>
    </div>
</asp:Content>
