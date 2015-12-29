<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Incompatible Bets - Incompatible Bets Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Bet Type Listing</h2>
    <table id="ajaxDataTable"></table>
    <div id="Pager"></div>    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            GetDynamicBetTypeData: '<%= Url.Action("GetDynamicBetTypeData") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/'
        }
        $(document).ready(function() {
            var actionUrl = ControllerActions.GetDynamicBetTypeData;
            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Id', 'Nombre', ''],
                colModel: [
                { name: 'Id', index: 'Id', hidden: true, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 430 },               
               { name: 'Action', index: 'Action', sortable: false, width: 120 }],               
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Apuestas Incompatibles',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"' + ControllerActions.Edit + '' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Incompatibilidades</a>";                        
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink });
                    }           
                }
            });
        });       
    </script>
</asp:Content>
