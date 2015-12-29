<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.BetType>" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

	<script type="text/javascript">
		var ControllerActions = {
			JsonSearch: '<%= Url.Action("JsonSearch") %>/',
			JsonDelete: '<%= Url.Action("JsonDelete") %>/',
			Edit: '<%= Url.Action("Edit") %>/',
			Delete: '<%= Url.Action("Delete") %>/',
			CopyBetTypesToPeriod: '<%= Url.Action("CopyBetTypesToPeriod") %>/',
            GetBetTypePeriods: '<%= Url.Action("GetBetTypePeriods", "BetTypePeriod") %>/'
		}
        
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/bettype.index.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Delete: '<%= Url.Action("Delete") %>/',
            CopyBetTypesToPeriod: '<%= Url.Action("CopyBetTypesToPeriod") %>/',
            GetBetTypePeriods: '<%= Url.Action("GetBetTypePeriods", "BetTypePeriod") %>/'
        }

        $(document).ready(function() {
            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false
            });
            
            // Copy dialog
            $("#copy-dialog .loading").hide();

            $('#CopyFromPeriod, #CopyToPeriod').prepend('<option value="-1" selected="true">Cargando...</option>');

            $.getJSON(ControllerActions.GetBetTypePeriods, {}, function(data) {
                $('#CopyFromPeriod, #CopyToPeriod').empty();
                $('#CopyFromPeriod, #CopyToPeriod').prepend('<option value="-1" selected="true">Seleccione un periodo</option>');
                if (data.length > 0) {
                    $.each(data, function(i, item) {
                        $('#CopyFromPeriod, #CopyToPeriod').append('<option value="' + item.Code + '">' + item.Label + '</option>');
                    });
                }
            });

            // Copy bet template - dialog
            $("#copy-dialog").dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 420,
                buttons: {
                    "Cancelar": function() {
                        $("#copy-dialog").dialog('close');
                    },
                    Ok: function() {
                        // Validate selected values
                        if (!($('#CopyFromPeriod').val() > 0 && $('#CopyToPeriod').val() > 0))
                            return;

                        $("#copy-dialog .loading").show();
                        $("#copy-dialog .dialog-content").hide();
                        $.post(
                            ControllerActions.CopyBetTypesToPeriod,
                            {
                                PeriodFrom: $('#CopyFromPeriod').val(),
                                PeriodTo: $('#CopyToPeriod').val()
                            },
                            function(data) {
                                // Hide dialog
                                $("#copy-dialog .loading").hide();
                                $("#copy-dialog .dialog-content").show();
                                $("#copy-dialog").dialog('close');
                                // Reload datagrid
                                $("#ajaxDataTable").trigger("reloadGrid");
                                // Info message
                                $('#infoDialog').dialog('open');
                                $('#infoDialogMessage').text(data.ReturnMessage);

                            },
                            "json");
                    }
                }
            });

            $('#copy-btn').click(function() {
                $('#copy-dialog').dialog('open');
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Tipos de Apuesta - Listado
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Listado de Tipos de Apuestas</h2>
    <% Html.RenderPartial( "SearchBox" ); %>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <div id="copy-dialog" title="Copiar tipos de apuesta">
        <div class="dialog-content">
            <table>
                <tr>
                    <td>
                        De
                    </td>
                    <td>
                        <select id="CopyFromPeriod">
                        </select>
                    </td>
                    <td>
                        a
                    </td>
                    <td>
                        <select id="CopyToPeriod">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." /></div>
    </div>
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a>
        <a class="button" id="copy-btn"><span>Copiar entre periodos</span></a>
    </p>
</asp:Content>
