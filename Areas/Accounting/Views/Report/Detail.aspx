<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.ViewModels.Accounting.ReportViewModel>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Reportes -
    <%= Model.Reportname %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Model.Reportname %></h2>
    <div class="filter-report">
        <%= Html.RenderReportParams(Model.ReportParameters) %>
        <div class="links">
            <strong>Exportar</strong> <a href="#" class="excel-Icon">Excel</a> <a href="#" class="pdf-Icon">
                PDF</a> <a href="#" class="orangeButton"><span>Mostrar Reporte</span></a>
            <div>
                <label>
                    Auto-refrescar resultados</label>
                <input id="autoRefreshCheckbox" type="checkbox" title="Auto refrescar" />
            </div>
        </div>
    </div>
    <div class="clear">
    </div>
    <div id="report">
    </div>
    <div class="clear">
    </div>
    <div>
        <br />
        <%=Html.ActionLink("Return to listing", "Index","Report", new {}, new { @class = "navPrev" } )%>
    </div>
    <input type="hidden" id="parameters" name="parameters" />
    <div id="detailDialog">
        <img class="loader" alt="Loading..." src="<%= Html.GetImageURL("loading-Horizontal.gif") %>" />
        <div id="detailDialogContent">
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetPackage( AssetPackage.JqGrid ) %>
    <script type="text/javascript">                        
        // Auto-refresh grid interval
        var autoRefreshResults = null;

        refreshReport = function(){
            $(".orangeButton").click();
        }
        
        $(function() {
            $('#detailDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 730,
                title: 'Detalle',
                buttons: {
                    "Ok": function() {
                        $("#detailDialog").dialog('close');
                    }
                }
            });
            $('#detailDialog').find('.loader').hide();

            // Auto refresh checkbox
            $('#autoRefreshCheckbox').click(function() {
                // Clear the previous setted interval
                if (autoRefreshResults)
                    clearInterval(autoRefreshResults);

                // Set the refresh interval
                if ($('#autoRefreshCheckbox').attr('checked'))
                    autoRefreshResults = setInterval(refreshReport, 60000);
            });
            
                                            
            var renderHtml = '<%= Model.RendersHtml %>';            
            if(renderHtml == 'False'){
                //Hiding the render report button
                $('.orangeButton').css('display','none');
                
                //Getting the selected params
                var params = GetParams();
                
                //Querying the routing engine to obtain the routes for exporting each report                        
                var exportActionExcel = '<%= Url.Action("Export","Report", new { reportName = Model.Reportname, reportFolder = Model.ReportFolder, format = "Excel" }) %>';
                var exportActionPDF = '<%= Url.Action("Export","Report", new { reportName = Model.Reportname, reportFolder = Model.ReportFolder, format = "PDF" }) %>';
                        
                //Assigning the export actions to the links
                $(".excel-Icon").attr("href", exportActionExcel + "?parameters=" + params);
                $(".pdf-Icon").attr("href", exportActionPDF + "?parameters=" + params);
                
                //Displaying the just available for download message
                $('#report').html('<div style="margin-top: 20px; padding: 0pt 0.7em;" class="ui-state-highlight ui-corner-all"><p><span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-info"></span>Este reporte solo está disponible para <strong>descarga</strong>. Seleccione el formato en que desea hacerlo del menú.</p></div>');
            }
            
            //Adding the calendar to the datepicker inputs
            $(".datePicker").datepicker({
                dateFormat: 'dd/mm/yy'
            });
            
            //Binding click event to the render button
            $(".orangeButton").click(function() {
                //Displays a message while loading the report
                $('#report').html('<div class=\"loading-report\"><img src=\"/Content/images/ajax-loader-2.gif\" alt=\"\" />Cargando Reporte...</div>');
                
                //Obtains the report params
                var params = GetParams();  
                
                //Renders the report                              
                $('#report').load("<%= Url.Action("RenderReport","Report") %>", { reportName: '<%= Model.Reportname %>', reportFolder: '<%= Model.ReportFolder %>', parameters: params }, function(responseText, textStatus, req) {                                    
                    if (textStatus == "error") {
                        //Removing the exporting options
                        $(".excel-Icon").attr("href","");
                        $(".pdf-Icon").attr("href","");
                        
                        //Rebdering the error message
                        $('#report').html('<div class="ui-state-error ui-corner-all" style="margin-top: 20px; padding: 0pt 0.7em;"><p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: 0.3em;"></span>El reporte no pudo ser generado. Por favor intente más tarde.</p></div>');
                    }
                    else{
                        //Getting the selected params
                        var params = GetParams();
                        
                        //Querying the routing engine to obtain the routes for exporting each report                        
                        var exportActionExcel = '<%= Url.Action("Export","Report", new { reportName = Model.Reportname, reportFolder = Model.ReportFolder, format = "Excel" }) %>';
                        var exportActionPDF = '<%= Url.Action("Export","Report", new { reportName = Model.Reportname, reportFolder = Model.ReportFolder, format = "PDF" }) %>';
                        
                        //Assigning the export actions to the links
                        $(".excel-Icon").attr("href", exportActionExcel + "?parameters=" + params);
                        $(".pdf-Icon").attr("href", exportActionPDF + "?parameters=" + params);
                        
                        //Fixing the html rendered report width                        
                        $("#oReportCell").css('width', '100%');
                    }
                });
            });
        });
        
        //Returns the selected parameters for the report
        function GetParams(){
            var parameters;
            var dataValues = new Array();
            $('.parameter').each(function() {
                dataValues[dataValues.length] = $(this).attr("name") + "," + $(this).val();                         
            });
            
            //Setting the parameters
            parameters = dataValues.join(";");
            $("#parameters").val(parameters);
            
            return parameters;
        }      
    </script>
    <script type="text/javascript">
        $(function () {
            $('table[cols=12]:contains("Numeros") td:nth-child(2):not(:contains("Numeros")),' +
            'table[cols=12]:contains("Numeros") td:nth-child(6):not(:contains("Numeros")),' +
            'table[cols=12]:contains("Numeros") td:nth-child(10):not(:contains("Numeros"))').live('click', function () {
                // Ignore empty lines
                if ($(this).children().first().html() == null)
                    return;

                $('#detailDialog').dialog('open');
                $('#detailDialogContent').html('');
                $('#detailDialog').find('.loader').show();

                $.post('<%= Url.Action( "NumberBets", "LottoBet", new { @area = "Lottery" }, null )%>',
                {
                    "parameters.StartDate": $('#StartDate').val(),
                    "parameters.EndDate": $('#EndDate').val(),
                    "parameters.StoringCenterId": $('select[name=OptionalStoringCenter]').val(),
                    "parameters.LotteryId": $('select[name=OptionalLotto]').val(),
                    "parameters.BetTypeId": $(this).parent().find('td:nth-child(1)').children().first().html(),
                    "parameters.SportBookId": $('select[name=OptionalSportBook]').val(),
                    "parameters.Numbers": $(this).children().first().html()
                },
                function (html) {
                    $('#detailDialog').find('.loader').hide();
                    $('#detailDialogContent').html(html);
                });
            });
        });
    </script>
</asp:Content>
