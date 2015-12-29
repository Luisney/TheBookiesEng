<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/sport.index.js" type="text/javascript" language="javascript"></script>
         
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/',
            GetBetTypePeriods: '<%= Url.Action("GetBetTypePeriods", "BetTypePeriod") %>/',
            GetBetTypesByPeriodAndSport: '<%= Url.Action("GetBetTypesByPeriodAndSport", "BetType") %>/',
            EditCompatibility: '<%= Url.Action("EditCompatibility", "BetCompatibility") %>/'
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Deportes - Listado de Deportes
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Listado de Deportes
    </h2>
    <div class="searchbox">
        Buscar :
        <%= Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
        <button id="submitButton" class="searchbox_btn">
            Buscar</button>
    </div>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a>
    </p>
    <div id="compatibility-dialog" title="Ver compatibilidad">
        <div class="dialog-content">
            <form id="series-form">
            <p>
                <label>
                    Periodo:
                </label>
                <%= this.Select("Periods") %>
            </p>
            <p>
                <label>
                    Tipo de apuesta:
                </label>
                <%= this.Select("BetTypesForSport") %>
            </p>
            </form>
        </div>
    </div>
</asp:Content>
