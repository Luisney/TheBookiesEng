<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<TheBookies.Model.RestrictedNumber>>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Restricted Numbers - Restricted Number Listing
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h2>
		Restricted Number Listing</h2>
	<table id="ajaxDataTable">
	</table>
	<div id="Pager">
	</div>
	<br />
	<p>
		<a class="button" href="<%= Url.Action("Create") %>"><span>Create New</span></a>
	</p>
</asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script src="/Content/js/jqGrid/jqGridUtils.js" type="text/javascript"></script>
  
	<script type="text/javascript" language="javascript">
		var ControllerActions = {
			GetDynamicRestrictedNumberData: '<%= Url.Action("GetDynamicRestrictedNumberData") %>/',
			Edit: '<%= Url.Action("Edit") %>/',
			Delete: '<%= Url.Action("Delete") %>/',
            GetBetTypes: '<%= Url.Action( "GetBetTypes", "PlayType", new { @area = "Lottery" }, null) %>/'
		}

		$(document).ready(function () {
			var actionUrl = ControllerActions.GetDynamicRestrictedNumberData;
			$("#ajaxDataTable").jqGrid({
				stateOptions: "restrictedNumberTable",
				width: 700,
				height: "100%",
				url: actionUrl,
				datatype: 'json',
				mtype: 'GET',
				colNames: ['Id', 'Fecha inicial', 'Fecha final', 'Producto', 'Limita Apuesta', 'Numeros', 'Monto permitido', '', ''],
				colModel: [
					{ name: 'Id', index: 'Id', hidden: true, search: false, width: 150 },
					{ name: 'Date', index: 'Date', sortable: true, width: 100,
					    searchoptions: {
					        sopt: ['eq', 'ne', 'gt', 'ge', 'lt', 'le'],
					        dataInit: createDatePicker
					    }
					},
					{ name: 'FinalDate', index: 'FinalDate', sortable: true, width: 100,
					    searchoptions: {
					        sopt: ['eq', 'ne', 'gt', 'ge', 'lt', 'le'],
					        dataInit: createDatePicker
					    }
					},
					{ name: 'BetTypeName', index: 'BetType.Name', sortable: true, width: 150,
					    searchoptions: {
					        sopt: ['eq', 'ne'],
					        dataUrl: ControllerActions.GetBetTypes,
					        buildSelect: createDropDownListOnlyUsingLabel
					    }
					},
					{ name: 'ActionToTake', index: 'ActionToTake', align: 'center', sortable: true, search: false, width: 100 },
					{ name: 'RestrictedNumberDetailsSummary', index: 'RestrictedNumberDetails.Count', align: 'left', search: false, sortable: false, width: 140 },
					{ name: 'MaxAmount', index: 'MaxAmount', align: 'right', search: false, sortable: true, width: 100 },
					{ name: 'Action', index: 'Action', sortable: false, width: 50 },
					{ name: 'Action2', index: 'Action2', sortable: false, width: 50 }
				],
				toolbar: [true, "bottom"],
				pager: '#Pager',
				rowNum: 10,
				rowList: [10, 20, 50],
				sortname: 'Date',
				sortorder: 'asc',
				viewrecords: true,
				caption: 'Números Restringidos',
				gridComplete: function () {
					var ids = $("#ajaxDataTable").jqGrid('getDataIDs');
					for (var i = 0; i < ids.length; i++) {
						var currentId = ids[i];
						editLink = '<a href=\"' + ControllerActions.Edit + '' + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "\">Editar</a>";
						deleteLink = "<a class='delete-link' id='" + $("#ajaxDataTable").jqGrid('getRowData', currentId).Id + "'>Eliminar</a>";
						$("#ajaxDataTable").jqGrid('setRowData', ids[i], { Action: editLink, Action2: deleteLink });
					}

					activateDelete();
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
		});

		function activateDelete() {
			$('.delete-link').click(function () {
				// Build message string
				var name = 'Fecha: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).Date + '<br/>' +
				'Apuesta: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).BetTypeName + '<br/>' +
				'Limita apuesta: ' + $("#ajaxDataTable").jqGrid('getRowData', this.id).ActionToTake +
				'<br/><br/>' + $("#ajaxDataTable").jqGrid('getRowData', this.id).RestrictedNumberDetailsSummary;

				$("#ajaxDataTable").jqGrid('delGridRow', this.id, {
					caption: "Eliminar registro",
					reloadAfterSubmit: true,
					bSubmit: "Eliminar",
					bCancel: "Cancelar",
					url: ControllerActions.Delete,
					mtype: "POST",
					width: 350,
					// Workaround for bug: msg is not correctly updated after first rendering.
					beforeShowForm: function (formid) {
						$(".delmsg", formid).html("Desea eliminar este numero restringido?<br/>" + name);
					}
				});
			});
		}
	</script>
</asp:Content>
