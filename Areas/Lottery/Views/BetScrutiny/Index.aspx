<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master"  %>
<%@ Import Namespace="TheBookies.Model" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Loteries - Scrutiny
</asp:Content>
<asp:Content ID="Conten6" ContentPlaceHolderID="ExtraSideBar" runat="server">
    <br/><br/><br />
    <div class="leftNavigation" style="margin-top: 30px;">
    <div class="menuSection">
        <h3 class="lottery" style="color: darkslategrey; text-align: center">Loteries in the system</h3>
        <ul>
            <%
                var _loteries = ViewData["Lottos"];
                
                foreach (Lottery _lotto in (IList<Lottery>) _loteries)
                   {%>
                   <li style="color: darkslategrey; margin-left: 10px;"><%= _lotto.Id %> - <%= _lotto.Name %></li>
                   <%} %>
            
        </ul>
    </div>
</div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jQueryBlockUI/jquery.blockUI.2.33.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ControllerActions = {
            MakeBetScrutinyByDate: '<%= Url.Action("MakeBetScrutinyByDate") %>/'
        }

        $(function () {
            // Info dialog
            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                buttons: { "Cerrar": function () {
                          $("#infoDialog").dialog('close');
                    }
                }
            });

            $('#ShowPendingTicketsDay').live('click', function () {
                $.blockUI({ message: $('#ticketsP'), css: { width: '600px'} });
                $('.blockOverlay').attr('title', 'Cerrar').click($.unblockUI);
            }); 

            showModal();

            $('#NonScrutinizedDays').load('<%= Url.Action("DaysNotScrutedYet") %>/',
                function () {
                    hideModal();
                }
            );

            $('div.eventStampo').live('click', function () {
                showModal();
                $(this).parent().fadeOut();
                $.post(ControllerActions.MakeBetScrutinyByDate,
                        {
                            ScrutinyDate: $(this).find('.eventDate').html()
                        },
                        function (data) {
                            hideModal();
                            $('#infoDialogMessage').text(data);
                            $('#infoDialog').dialog('open');
                            $('#NonScrutinizedDays').load('<%= Url.Action("DaysNotScrutedYet") %>/');
                        },
                        "json");
            });

        });

        showModal = function () {
            $.blockUI({ theme: true,
                title: 'Procesando',
                message: '<p><img src="/Content/images/ajax-loader-small.gif" alt="..." /></p>'
            });
        }

        hideModal = function () {
            $.unblockUI();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
    <br />
    <div id="NonScrutinizedDays">
    </div>

    <div id="ticketsP" style="display:none; cursor: default">
        <h1>Mostrando tickets pendientes del día X</h1>
    </div>
</asp:Content>
