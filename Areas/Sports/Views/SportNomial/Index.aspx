<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.SportNomial>" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/sportnomial.index.js" type="text/javascript" language="javascript"></script>

    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            GetDivisionsBySport: '<%= Url.Action("GetDivisionsBySport", "Division") %>/',
            AddNomialsByRange: '<%= Url.Action("AddNomialsByRange", "SportNomial") %>/',
            CopyNomialsToSport: '<%= Url.Action("CopyNomialsToSport", "SportNomial") %>/'
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Precios - Listado de Precios
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        Listado de Precios
    </h1>
    <div class="searchbox">
        Buscar :
        <%= Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
        <button id="submitButton" class="searchbox_btn">
            Buscar</button>
    </div>
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a> <a class="button" id="range-btn"><span>Agregar por rango</span></a> <a class="button" id="copy-btn"><span>Copiar entre deportes</span></a>
    <div id="copy-dialog" title="Copiar precios">
        <div class="dialog-content">
            <table>
                <tr>
                    <td>
                        De
                    </td>
                    <td>
                        <%= this.Select("SportA").Options(ViewData["Sports"] as Dictionary<string, string>) %>
                    </td>
                    <td>
                        a
                    </td>
                    <td>
                        <%= this.Select("SportB").Options(ViewData["Sports"] as Dictionary<string, string>) %>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <select id="DivisionA">
                        </select>
                    </td>
                    <td>
                    </td>
                    <td>
                        <select id="DivisionB">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." /></div>
    </div>
    <div id="range-dialog" title="Agregar precios por rango">
        <div class="dialog-content">
            <form id="ranges-form">
            <p>
                <label>
                    Deporte:</label>
                <%= this.Select("SportForRange").Options(ViewData["Sports"] as Dictionary<string, string>) %></p>
            <p>
                <label>
                    Division:</label>
                <%= this.Select("DivisionForRange") %></p>
            <p>
                <label>
                    Rango (Inicio macho):</label>
                <%=this.TextBox("RangeMin").Class("range-input required number") %>
                -
                <%=this.TextBox("RangeMax").Class("range-input required number") %></p>
            <p>
                <label>
                    Inicio Hembra:</label>
                <%= this.TextBox("StartingFemale").Class("required number")%></p>
            <p>
                <label>
                    Incremento Macho:</label>
                <%= this.TextBox("IncrementMale").Class("required number")%></p>
            <p>
                <label>
                    Incremento Hembra:</label>
                <%= this.TextBox("IncrementFemale").Class("required number")%></p>
            </form>
        </div>
        <div class="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." /></div>
    </div>
</asp:Content>
