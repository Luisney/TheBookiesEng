<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<TheBookies.Model.Result>>" %>
<%@ Import Namespace="Gambling.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Resultos - Results listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Result listing</h2>
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create new</span></a>
    </p>
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
    <div id="deleteResultDialog" title="Delete Result">
        <p id="deleteResultDialogMessage">
        </p>
        <br />
        <form>
        <fieldset>
            <p>
                <label>
                    Admin User:</label>
                <%= this.TextBox("adminUser") %>
            </p>
            <p>
                <label>
                    Authorization Password:</label>
                <%= this.Password( "authPassword" )%>
            </p>
        </fieldset>
        </form>
    </div>
    <input id="resultToDeleteId" type="hidden" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
	<%= Html.GetPackage( AssetPackage.JqAutocomplete ) %>
	
	<%= Html.GetPackage( AssetPackage.JqGrid ) %>
	<script type="text/javascript" language="javascript">
		var ControllerActions = {
		    Search: '<%= Url.Action("Search") %>/',
			Delete: '<%= Url.Action("Delete") %>/'
		}

		$(document).ready(function() {
		    var actionUrl = ControllerActions.Search;
			$("#ajaxDataTable").jqGrid({
			    width: 700,
				height: "100%",
				url: actionUrl,
				datatype: 'json',
				mtype: 'GET',
				colNames: ['Loteria', 'Fecha', 'Premios', ''],
				colModel: [
					{   
                        name: 'Lottery',
                        index: 'Lottery.Name',
                        sortable: true,
                        search: false,
                        width: 150
                    },
					{   
                        name: 'Date',
					    index: 'Date',
					    sortable: true,
                        width: 150,
                        search: true,
                        searchoptions: {
                            sopt: ['eq', 'ne', 'gt', 'ge', 'lt', 'le'],
                            defaultValue: '<%= DateTime.Now.ToShortDateString( ) %>',
                            dataInit: createDatePicker
                        }
                    },
					{
					    name: 'Prizes',
					    index: 'Prizes',
					    align: 'center',
					    sortable: true,
					    search: false,
					    width: 150
                    },
					{
					    name: 'Action',
					    index: 'Action',
					    sortable: false,
					    width: 80
                    }
				],
				pager: '#Pager',
				toolbar: [true, "bottom"],
				rowNum: 10,
				rowList: [10, 20, 50],
				sortname: 'Date',
				sortorder: 'desc',
				viewrecords: true,
				caption: 'Resultados',
				gridComplete: function() {
					var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
					for (var i = 0; i < ids.length; i++) {
					    deleteLink = "<a class='delete-link' id='" + ids[i] + "'>Eliminar</a>";
						$("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: deleteLink });
					}
                    $('.delete-link').click(
                        function () {
                            $('#deleteResultDialog').dialog('open');
                            $('#deleteResultDialogMessage').text('Desea eliminar este resultado?');
                            $('#resultToDeleteId').val(this.id);
                        }
                    );
                }
            })
            .navGrid(
                '#Pager',
                { view: false, del: false, add: false, edit: false },
                {}, // default settings for edit
                {}, // default settings for add
                {}, // delete instead that del:false we need this
                {closeOnEscape: true, multipleSearch: true, closeAfterSearch: true }, // search options
                {}); // view parameters

            $('#deleteResultDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 400,
                buttons: {
                    "Eliminar": function () {
                        $.getJSON(ControllerActions.Delete,
						{
						    id: $('#resultToDeleteId').val(),
						    adminUser: $('#deleteResultDialog input[name=adminUser]').val(),
						    authPassword: $('#deleteResultDialog input[name=authPassword]').val()
						},
						function (data) {
						    $('#deleteResultDialog').dialog('close');
						    // Info message
						    $('#infoDialog').dialog('open');
						    $('#infoDialogMessage').text(data);
						    $('#ajaxDataTable').trigger('reloadGrid');
						});
                    },
                    "Cancelar": function () {
                        $("#deleteResultDialog").dialog('close');
                    }
                }
            });

            $('#infoDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                buttons: {
                    "Ok": function () {
                        $("#infoDialog").dialog('close');
                    }
                }
                });
            });
    </script>
</asp:Content>
