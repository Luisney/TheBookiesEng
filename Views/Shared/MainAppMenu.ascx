<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Gambling.Helpers" %>

<script type="text/javascript">
    $(document).ready(function() {
        $('#jsddm').find('a').click(function() {
            // 35 is the charcode for "#", if the link is not an anchor then it's a url
            if ($(this).attr('href').charCodeAt(0) == 35) {

                $('#jsddm').find('li.selected').removeClass('selected')

                $(this).parent('li').addClass('selected');

                elementId = $(this).attr('href');

                $('.ddm-wrapper').hide();

                var positionLeft = ($(this).position().left + $(this).outerWidth() / 2) - $(elementId).outerWidth() / 2;

                $(elementId).css('left', positionLeft + 'px')

                $(elementId).fadeIn('normal').hover(function() { },
                function() {
                    $(this).fadeOut('normal');
                    $('#jsddm').find('li.selected').removeClass('selected')
                });

                return false;
            }
        });

        $('.ddm-wrapper').hide();

        // Hide unused menu sections
        $('.dropdown-items').each(function(index, domElement) {
            if ($(domElement).find('li').length == 0)
                $(domElement).hide();
        });

        // Hide not used categories
        visibilityFilter = function() {
            return !( $(this).css('visibility') == 'hidden' || $(this).css('display') == 'none' );
        }
        $('.ddm-wrapper').each(function(index, domElement) {
            var element = $(domElement);
            if ( element.find('.dropdown-items')
                 .filter(visibilityFilter)
                 .length == 0)
                $('#jsddm a[href="#' + element.attr('id') + '"]').parent().hide();
        });
    });
</script>

<div class="mainNav">
    <div class="rightCorner">
        <div class="leftCorner">
            <ul id="jsddm">
                <li style="border-left: none"><a href="<%=Url.Action("Index", "Home", new { @area="root" })%>">Dashboard</a></li>
                <li><a href="#dropdown-general">General</a></li>
                <li><a href="#dropdown-accounting">Contabilidad</a></li>
                <li><a href="#dropdown-lottery">Lotería</a></li>
                <li><a href="#dropdown-recharges">Recargas</a></li>
                <li><a href="<%=Url.Action("Index", "Report", new { @area="Accounting" })%>">Reportes</a></li>

            </ul>
        </div>
        <!--End leftCorner-->
    </div>
    <!--End rightCorner-->
</div>
<div id="dropdown-wrapper" class="dropdown-wrapper ddm-wrapper">
    <div class="dropdown-items">
        <h1>
            Ticket</h1>
        <ul>
            <%=Html.MenuItem("Tickets", "Index", "Bet", new { @area = "Sports" }, null)%>
            <%=Html.MenuItem("Tipos de Ticket", "Index", "TicketType", new { @area = "Sports" }, null)%>
        </ul>
    </div>
    <div class="dropdown-items">
        <h1>
            Juego</h1>
        <ul>
            <%=Html.MenuItem("Juegos", "Index", "Game", new { @area = "Sports" }, null)%>
            <%=Html.MenuItem("Matchups", "ShowAllMatchups", "GamePlayer", new { @area = "Sports" }, null)%>
            <%=Html.MenuItem("Lineas", "AvailableGames", "Game", new { @area = "Sports" }, null)%>
        </ul>
    </div>
    <div class="dropdown-items">
        <h1>
            Deporte</h1>
        <ul>
            <%= Html.MenuItem("Deportes", "Index", "Sport", new { @area = "Sports" }, null )%>
            <%= Html.MenuItem("Ligas", "Index", "Division", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Equipos", "Index", "Team", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Alias de Equipos", "Index", "TeamAlias", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Jugadores", "Index", "Player", new { @area = "Sports" }, null)%>
        </ul>
    </div>
    <div class="dropdown-items">
        <h1>
            Cálculo Automático</h1>
        <ul>
            <%= Html.MenuItem("Precios", "Index", "SportNomial", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Plantillas Apuesta - Juego", "Index", "BetTemplate", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Plantillas Apuesta - Totales", "Index", "BetTemplateForTotals", new { @area = "Sports" }, null)%>
        </ul>
    </div>
    <div class="dropdown-items">
        <h1>
            Configuración de apuestas</h1>
        <ul>
            <%= Html.MenuItem("Tipos de Apuesta", "Index", "BetType", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Compatibilidad", "Index", "BetCompatibility", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Compra de Puntos - Juego", "Index", "BoughtPointGame", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Compra de Puntos - Totales", "Index", "BoughtPointTotal", new { @area = "Sports" }, null)%>
            <%= Html.MenuItem("Teasers", "Index", "SetupTeaser", new { @area = "Sports" }, null)%>
        </ul>
    </div>
</div>
<div id="dropdown-lottery" class="dropdown-lottery ddm-wrapper">
    <div class="dropdown-items">
        <h1>Lotería</h1>
        <ul>
            <%= Html.MenuItem("Loterías", "Index", "Lotto", new{ @area="Lottery"}, null )%>
            <%= Html.MenuItem("Tipos de apuesta", "Index", "PlayType", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Apuestas Incompatibles", "Index", "IncompatibleBet", new{ @area="Lottery"}, null )%>
            <%= Html.MenuItem("Resultados", "Index", "Result", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Números Restringidos", "Index", "RestrictedNumber", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Perfiles de Comisión", "Index", "Commission", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Perfiles de Valores a Pagar", "Index", "ValuePayment", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Perfiles de Limites", "Index", "LimitBetType", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Tickets", "Index", "LottoBet", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Botes", "Index", "Surplus", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Escrutinio", "Index", "BetScrutiny", new { @area = "Lottery" }, null)%>
            <%= Html.MenuItem("Limpiar Escrutinio", "Clean", "Scrutiny", new { @area = "Lottery" }, null)%>
        </ul>
    </div>
</div>
<div id="dropdown-tools" class = "dropdown-lottery ddm-wrapper">
    <div class="dropdown-items">
        <h1>Herramientas</h1>
        <ul>
            <%= Html.MenuItem("Cambio de Serial", "ChangeSerial", "Tools", new { @area = "Lotto" }, null)%>
        </ul>
    </div>
</div>
<div id="dropdown-general" class="dropdown-general ddm-wrapper">
    <div class="dropdown-items">
        <ul>
            <h1>
                General</h1>
            <%= Html.MenuItem("Usuarios", "Index", "Account", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Apostadores", "Index", "Gambler", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Consorcios", "Index", "Company", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Centros de acopio", "Index", "StoringCenter", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Rutas", "Index", "Route", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Bancas", "Index", "SportBook", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Terminales", "Index", "Terminal", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Registro Rapido de Banca", "RegisterSportBook", "Quick", new { @area = "root" }, null)%>
            <%= Html.MenuItem("Configuración general", "Edit", "Settings", new { @area = "root" }, null)%>
        </ul>
    </div>
</div>
<div id="dropdown-accounting" class="dropdown-accounting ddm-wrapper">
    <div class="dropdown-items">
        <h1>
            Contabilidad</h1>
        <ul>
            <%= Html.MenuItem("Cuentas de Gastos", "Index", "ExpenseCode", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Gastos", "Index", "Expense", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Cuentas de Ingresos", "Index", "IncomeCode", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Ingresos", "Index", "Income", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Rendimiento", "Chart", "Chart", new { @area = "Accounting" }, null )%>
        </ul>
    </div>
    <div class="dropdown-items">
        <h1>
            Máquinas</h1>
        <ul>
            <%= Html.MenuItem("Tipos de Máquina", "Index", "MachineType", new { @area = "Accounting" }, null )%>
            <%= Html.MenuItem("Máquinas", "Index", "Machine", new { @area = "Accounting" }, null )%>
        </ul>
    </div>
</div>
<div id="dropdown-recharges" class="dropdown-accounting ddm-wrapper">
    <div class="dropdown-items">
        <h1>
            Recargas</h1>
        <ul>
            <%= Html.MenuItem("Balances", "Index", "Recarga", new { @area = "Recargas" }, null )%>
            <%= Html.MenuItem("Cuentas", "Index", "Cuenta", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Grupo de Bancas", "Index", "GrupoBanca", new{ @area="Recargas"}, null )%>
            <%= Html.MenuItem("Ventas", "Ventas", "Recarga", new { @area = "Recargas" }, null )%>
            <%= Html.MenuItem("Anular Recarga", "Anular", "Recarga", new { @area = "Recargas" }, null )%>
            <%= Html.MenuItem("Perfiles de Comisión", "Index", "Comision", new { @area = "Recargas" }, null )%>
        </ul>
    </div>
</div>

