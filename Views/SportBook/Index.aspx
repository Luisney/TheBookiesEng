<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.ViewModels.SportBookListViewModel>" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/sportbook.index.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            CopyTicketLimits: '<%= Url.Action("CopyTicketLimits") %>/'
        }

        $(function() {
        
            // Copy dialog
            $("#copy-dialog .loading").hide();
            $('#copy-dialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 380,
                buttons: {
                    "Copiar": function() {
                        $("#copy-dialog .loading").show();
                        var sendData = [{ name: "sourceSportbookId", value: $('#SourceSportBookId').val()}];
                        sendData = sendData.concat($('#SelectedSportBooks').serializeArray());
                        $.post(ControllerActions.CopyTicketLimits,
                            sendData,
                            function(data) {
                                // Hide dialog
                                $("#copy-dialog .loading").hide();
                                $("#copy-dialog").dialog('close');
                                // Info message
                                $('#infoDialog').dialog('open');
                                $('#infoDialogMessage').text(data);
                            },
                            "json");
                    },
                    "Cancelar": function() {
                        $('#copy-dialog').dialog('close');
                    }
                }
            });

            // View series - button
            $('#copy-btn').click(function() {
                $('#copy-dialog').dialog('open');
            });

            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                buttons: {
                    "Ok": function() {
                        $("#infoDialog").dialog('close');
                    }
                }
            });

            $('#selectAllSportBooks').click(function() {
                $('#SelectedSportBooks option').attr("selected", "selected");
            });

            $('#deselectAllSportBooks').click(function() {
                $('#SelectedSportBooks option').removeAttr("selected");
            });
        });
       
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Benches - Bench listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Bench Listings
    </h2>
    <% Html.RenderPartial( "SearchBox" ); %>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create new</span></a>
        <a class="button" id="copy-btn"><span>Copy limits for ticket type</span></a>
    </p>
    <div id="copy-dialog" title="Copy limits for ticket type">
        <p>
            From bench:<br />
            <%= this.Select( model => model.SourceSportBookId ).Options( Model.SportBookList )%>
        </p>
        <br />
        <p>
            To these benches:<br />
            <%= this.MultiSelect( "SelectedSportBooks" ).Size(15).Options( Model.SportBookList )%>
        </p>
        <p>
            <a id="selectAllSportBooks">Selecccionar todos</a> / <a id="deselectAllSportBooks">Deseleccionar
                todos</a>
        </p>
        <div class="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Waiting ..." />
        </div>
    </div>
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
</asp:Content>
