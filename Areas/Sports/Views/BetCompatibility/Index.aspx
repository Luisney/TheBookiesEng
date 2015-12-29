<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript">
        var actionUrl = '<%= Url.Action("JsonSearch") %>';
        var editUrl = '<%= Url.Action("EditCompatibility") %>';

        $(function() {
            $("#ajaxDataTable").jqGrid({
                width: 635,
                height: "100%",
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Deporte', 'Periodo', 'Tipo de apuesta', '', '', ''],
                colModel: [
               { name: 'Sport', index: 'Sport.Name', sortable: true, width: 130, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'Period', index: 'BetType.Period.Name', sortable: true, width: 130, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'BetType', index: 'BetType.Name', sortable: true, width: 120, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'SportId', hidden: true, sortable: true, width: 120, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'BetTypeId', hidden: true, sortable: true, width: 120, searchoptions: { sopt: ['eq', 'ne', 'cn']} },
               { name: 'Action', index: 'Action', sortable: false, width: 80 }
                ],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Sport.Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Compatibilidad',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        detailsLink = "<a href='" + editUrl + "?SportCode=" + $("#ajaxDataTable").jqGrid('getRowData', ids[i]).SportId +
                        '&BetTypeCode=' + $("#ajaxDataTable").jqGrid('getRowData', ids[i]).BetTypeId + "' class='details-link'>Detalle</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: detailsLink });
                    }
                }
            })
            .navGrid('#Pager', { view: false, del: false, add: false, edit: false },
               {}, // default settings for edit
               {}, // default settings for add
               {}, // delete instead that del:false we need this
               {closeOnEscape: true, multipleSearch: true, closeAfterSearch: true }, // search options
               {} /* view parameters*/
             );
        });

    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Tickets - Listado de Tickets
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Compatibilidad de apuestas
    </h2>
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
</asp:Content>
