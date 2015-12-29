<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<TheBookies.Core.Services.Lotto.GetBetsParameters>" %>
<script type="text/javascript">
	var numberBetsActions = {
		Search: '<%= Url.Action("NumberBetsSearch") %>/'
	};

	$("#numberBetsAjaxDataTable").jqGrid({
		width: 700,
		height: "100%",
		url: numberBetsActions.Search,
		datatype: 'json',
		mtype: 'POST',
		colNames: ['Centro de acopio', 'Banca', 'Terminal', 'Numero de ticket', 'Audit Number', 'Fecha', 'Hora', 'Monto','En linea',''],
		colModel: [
			{ name: 'StoringCenter', index: 'Bet.StoringCenter.Name', sortable: true, width: 150 },
			{ name: 'SportBook', index: 'Bet.SportBook.Name', sortable: true, width: 150 },
			{ name: 'Terminal', index: 'Bet.Terminal.Id', sortable: true, width: 150 },
			{ name: 'Id', index: 'Bet.Id', sortable: true, width: 150 },
			{ name: 'AuditNumber', index: 'Bet.AuditNumber', sortable: true, width: 150 },
			{ name: 'Date', index: 'Bet.Date', sortable: true, width: 150 },
			{ name: 'Time', index: 'Bet.Time', sortable: true, width: 150 },
			{ name: 'Amount', index: 'Amount', sortable: true, width: 150 },
            { name: 'IsOffLine', index: 'Bet.IsOffLine', width: 70, formatter: booleanFormatter },
            { name: 'ItemsDetail', index: 'Id', sortable: false, width: 150 }
		],
		pager: '#numberBetsPager',
		toolbar: [true, "bottom"],
		rowNum: 10,
		rowList: [10, 20, 50],
		sortname: 'Bet.StoringCenter.Name',
		sortorder: 'asc',
		viewrecords: true,
		caption: 'Tickets Relacionados',
		postData: {
			"parameters.StartDate": "<%= Model.StartDate %>",
			"parameters.EndDate": "<%= Model.EndDate %>",
			"parameters.StoringCenterId": "<%= Model.StoringCenterId %>",
			"parameters.LotteryId": "<%= Model.LotteryId %>",
			"parameters.BetTypeId": "<%= Model.BetTypeId %>",
			"parameters.SportBookId": "<%= Model.SportBookId %>",
			"parameters.Numbers": "<%= Model.Numbers %>"
		}
	});
</script>
<div id="numberBetsContainer">
	<table id="numberBetsAjaxDataTable">
	</table>
	<div id="numberBetsPager">
	</div>
</div>
