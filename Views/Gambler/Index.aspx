<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambler>" %>

<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="Gambling.Models" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            InitAutoCompleteUtil('#SearchText', "/AutoComplete/ByGamblerName");

            var actionUrl = '<%= Url.Action("JsonSearch") %>';

            $("#ajaxDataTable").jqGrid({
                width: 700,
                height: '100%',
                url: actionUrl,
                datatype: 'json',
                mtype: 'GET',
                colNames: ['Código', 'Nombre', 'Dirección', 'Teléfono', 'Correo Electrónico', 'Total Apostado', 'Total de Pagos', '', ''],
                colModel: [
               { name: 'Id', index: 'Code', sortable: true, width: 150 },
               { name: 'Name', index: 'Name', sortable: true, width: 150 },
               { name: 'Address', index: 'Address', sortable: true, width: 150 },
               { name: 'Phone', index: 'Phone', sortable: true, width: 150 },
               { name: 'Email', index: 'Email', sortable: true, width: 150 },
               { name: 'TotalBets', index: 'TotalBets', sortable: true, width: 150 },
               { name: 'TotalPayments', index: 'TotalPayments', sortable: true, width: 150 },
               { name: 'Action', index: 'Action', sortable: false, width: 80 },
               { name: 'Action2', index: 'Action2', sortable: false, width: 80 }
                ],
                pager: '#Pager',
                rowNum: 10,
                rowList: [10, 20, 50],
                sortname: 'Name',
                sortorder: 'asc',
                viewrecords: true,
                caption: 'Apostadores',
                gridComplete: function() {
                    var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var currentId = ids[i];
                        editLink = '<a href=\"<%= Url.Action("Edit") %>/' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Editar</a>";
                        deleteLink = "<a class='delete-link' id='" + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "'>Eliminar</a>";
                        $("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
                    }

                    activateDelete();
                }
            });

            $('#submitButton').click(
            function() {
                var searchText = jQuery("#SearchText").val();
                $("#ajaxDataTable").jqGrid('setGridParam',
                    {
                        url: actionUrl + "?SearchText=" + escape(searchText),
                        page: 1
                    })
                    .trigger("reloadGrid");
            });
        });

        function activateDelete() {
            $('.delete-link').click(function() {
                var name = $("#ajaxDataTable").jqGrid('getRowData', this.id).Name;
                $("#ajaxDataTable").jqGrid('delGridRow', this.id, {
                    caption: "Eliminar registro",
                    reloadAfterSubmit: true,
                    bSubmit: "Eliminar",
                    bCancel: "Cancelar",
                    url: '<%= Url.Action("Delete") %>',
                    mtype: "POST",
                    width: 300,
                    // Workaround for bug: msg is not correctly updated after first rendering.
                    beforeShowForm: function(formid) {
                        $(".delmsg", formid).html("Desea eliminar este apostador: " + name + " ?");
                    }
                });
            });
        }
    </script>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gamblers - Gablers Listing
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Gamblers Listing
    </h2>
    <div class="searchbox">
        Search :
        <%= Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
        <button id="submitButton" class="searchbox_btn">
            Search</button>
    </div>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create new</span></a>
    </p>
</asp:Content>
