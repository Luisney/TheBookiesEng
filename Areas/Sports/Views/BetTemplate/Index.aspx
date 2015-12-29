<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>
<%@ Import Namespace="TheBookies.Model.Sports" %>
<%@ Import Namespace="Gambling.Helpers" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <script type="text/javascript">
        var BetTemplateType = '<%= ( Byte ) Enumerations.BetTemplateType.Game %>'
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            GetDivisions: '<%= Url.Action("GetDivisions", "Division") %>/',
            GetSports: '<%= Url.Action("GetSports", "Sport") %>/',
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBysport", "Division") %>/',
            GetDefaultBetTypeForSport: '<%= Url.Action("GetDefaultBetTypeForSport", "BetType") %>/',
            GetBetTypesBySport: '<%= Url.Action("GetBetTypesBySport", "BetType") %>/',
            AdvancedGetBetTemplateDetails: '<%= Url.Action("AdvancedGetBetTemplateDetails", "BetTemplate") %>/',
            ShowDefaultBetTemplateField: '<%= Url.Action("ShowDefaultBetTemplateField", "BetTemplate") %>/',
            GetNomialValue: '<%= Url.Action("GetNomialValue", "SportNomial") %>/',
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/',
            GetGameBetPeriodsBySport: '<%= Url.Action("GetGameBetPeriodsBySport", "BetType") %>/',
            FilterGameTypesByPeriodAndSport: '<%= Url.Action("FilterGameTypesByPeriodAndSport", "BetType") %>/',
            ShowBetTemplateField: '<%= Url.Action("ShowBetTemplateField", "BetTemplate") %>/',
            GetNomialValue: '<%= Url.Action("GetNomialValue", "SportNomial") %>/',
            QuickSaveBetTemplate: '<%= Url.Action("QuickSaveBetTemplate", "BetTemplate") %>/',
            GetDivisionsBySport: '<%= Url.Action("GetDivisionsBySport", "Division") %>/',
            HasScore: '<%= Url.Action("HasScore", "BetType") %>/',
            GetBetTypeInfo: '<%= Url.Action("GetBetTypeInfo", "BetType") %>/',
            CopyBetTemplatesToDivision: '<%= Url.Action("CopyBetTemplatesToDivision", "BetTemplate") %>/',
            GetBetTypesWithPeriodAppendedBySport: '<%= Url.Action("GetBetTypesWithPeriodAppendedBySport", "BetType") %>/',
            QuickSaveBetTemplateField: '<%= Url.Action("QuickSaveBetTemplateField", "BetTemplate") %>/'
        }
	</script>
	<%= Html.GetPackage( AssetPackage.JqCascadeSelect ) %>
    <%= Html.GetPackage( AssetPackage.JqAutocomplete ) %>
    <%= Html.GetPackage( AssetPackage.JqGrid ) %>
    <%= Html.GetScript( "bettemplate.index" )%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Plantillas de Apuesta - Listado de Plantillas de Apuestas Para Apuestas a Juego
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h1>
		Listado de Plantillas de Apuestas Para Apuestas a Juego
	</h1>
	<div class="searchbox">
		Buscar :
		<%= Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
		<button id="submitButton" class="searchbox_btn">
			Buscar</button>
	</div>
	<br />
	<br />
	<table id="ajaxDataTable">
	</table>
	<div id="Pager">
	</div>
	<br />
	<a class="button" href="<%= Url.Action("Create") %>"><span>Crear nuevo</span></a>
	<a id="viewseries-btn" class="button"><span>Ver series</span></a>
	<a class="button" id="copy-btn"><span>Copiar entre deportes</span></a>
	<a class="button" id="quickadd-btn"><span>Creaci�n r�pida</span></a>
	<div id="copy-dialog" title="Copiar plantillas">
		<div class="dialog-content">
			<table>
				<tr>
					<td>De</td>
					<td><select id="CopyFromSport" ></select></td>
					<td>a</td>
					<td><select id="CopyToSport" ></select></td>
				</tr>
				<tr>
					<td></td>
					<td><select id="CopyFromDivision" ></select></td>
					<td></td>
					<td><select id="CopyToDivision" ></select></td>
				</tr>
			</table>
		</div>
		<div class="loading" align="center">
			<img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." />
		</div>
	</div>
	<div id="infoDialog" title="Info">
		<br/>
		<p id="infoDialogMessage"></p>
	</div>
	<div id="series-dialog" title="Ver serie de precios">
		<div class="dialog-content">
			<form id="series-form">
			<p>
				<label>
					Deporte:
				</label>
				<%= this.Select("SportForSeries") %>
			</p>
			<p>
				<label>
					Division:
				</label>
				<%= this.Select("DivisionForSeries") %>
			</p>
			<p>
				<label>
					Apuesta base:
				</label>
				<input id="BaseBetTypeForSeriesId" type="hidden" />
				<span id="BaseBetTypeForSeries"></span>
			</p>
			<p>
				<label>
					Apuesta a convertir:
				</label>
				<%= this.Select("BetTypeForSeries") %>
			</p>
			</form>
			<br />
			<table id="BetTemplateDetailAjaxDataTable">
			</table>
			<div id="BetTemplateDetailPager">
			</div>
			<br />
		</div>
		<div class="loading" align="center">
			<img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." />
		</div>
	</div>
	
	<div id="quickadd-dialog" title="Creando conversi�n de apuesta">
		<form id="quick-form">
		<div id="quickadd-step1">
			<p>
				<%= this.Select("SportId").Options((Dictionary<string, string>)ViewData["Sports"])
					.FirstOption("Selecciona uno")
					.Label("Deporte:") %>
			</p>
			
			<p>
				<%= this.Select("DivisionId").Label("Divisi�n:") %>
			</p>
			
			<div id="DefaultBet"></div>
			
			<p>
				<%= this.Select("PeriodId").Label("Per�odo:") %>
			</p>
			
			<p>
				<%= this.Select("BetTypeId").Label("Apuesta a convertir:")%>
			</p>
			
			<p class="ui-hide">
				<a class="navPrev" id="navFw">regresar</a>
			</p>
		</div>
		
		
		<div id="quickadd-step2">
			<div id="previous-step-data" class='ui-hide'>
				<p>
					<a class="navPrev" id="navPrev">regresar</a>
				</p>
				
				<p>
					<h4>Apuesta Base: <span class="base-bet-name"></span></h4>
					Macho: <span id="base-bet-male"></span>, Hembra: <span id="base-bet-female"></span>, Gavela: <span id="base-bet-score"></span>
				</p>
				  
			</div>
			
			<div id="BetToModify"></div>

			<div id="loading-wrapper"><span class="ui-icon ui-icon-info" style="display:none"></span></div>
		</div>  
		</form>
	</div>
	
	<div id="series-edit-dialog">
		<form id="series-edit-form">
			<div id="series-field-container"></div>
		</form>
		
		<div id="series-loading-wrapper"><span class="ui-icon ui-icon-info" style="display:none"></span></div>
	</div>
</asp:Content>
