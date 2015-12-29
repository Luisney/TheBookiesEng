<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<GamePlayerCreateViewModel>" %>
<%@ Import Namespace="Gambling.Models.ViewModels"%>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
	<link rel="Stylesheet" type="text/css" href="/Content/CSS/token-input.css" />
	
	<script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
	<script src="/Content/js/jquery.validate.js" type="text/javascript"></script>    
	<script src="/Content/js/jquery.tokeninput.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		Model = {
			TeamAId : <%= Model.TeamAId %>,
			TeamBId : <%= Model.TeamBId %>
		};
		
		$(document).ready(function(){
			
			TokenizeInputs(false);
			
			$('.PlayerTypeId').change(function() {
				$('#available-bets').load('<%= Url.Action("ShowAvailableBetField", "GamePlayer") %>', {playerTypeId: $(this).val()});
				
				$('#tokens-wrapper').empty();
				
				$('<p><label id="matchup_TeamAPlayerId_Label" for="matchup_TeamAPlayerId">Jugador A:</label><input type="text" value="" name="matchup.TeamAPlayerIdInput" id="TeamAPlayerIdInput" class="TeamAPlayerIdInput"><p>').appendTo('#tokens-wrapper');
				
				$('<p><label id="matchup_TeamBPlayerId_Label" for="matchup_TeamBPlayerId">Jugador B:</label><input type="text" value="" name="matchup.TeamBPlayerIdInput" id="matchup_TeamBPlayerIdInput" class="TeamBPlayerIdInput"><p>').appendTo('#tokens-wrapper');
				
				TokenizeInputs(false)
			});
		});
		
		function TokenizeInputs(prePopulateFields) {
			var tokensPlayerA = <%= Model.ForeignPlayerToken ?? "[]" %>;
			var tokensPlayerB = <%= Model.LocalPlayerToken ?? "[]" %>;
			
			if(prePopulateFields) {
				$('.TeamAPlayerIdInput').tokenInput('<%= Url.Action("GetPlayersForTeam", "Player") %>' , {
					hintText: "Escribe el nombre del Jugador",
					noResultsText: "No se encontro ningun jugador",
					searchingText: "Buscando...",
					tokenLimit: 1,
					prePopulate: tokensPlayerA,
					extraParams: { teamId: Model.TeamAId, typeId: function(){ return $('.PlayerTypeId').val() } }
				});
				
				$('.TeamBPlayerIdInput').tokenInput('<%= Url.Action("GetPlayersForTeam", "Player") %>' , {
					hintText: "Escribe el nombre del Jugador",
					noResultsText: "No se encontro ningun jugador",
					searchingText: "Buscando...",
					tokenLimit: 1,
					prePopulate: tokensPlayerB,
					extraParams: { teamId: Model.TeamBId, typeId: function(){ return $('.PlayerTypeId').val() } }
				});
			} else {
				$('.TeamAPlayerIdInput').tokenInput('<%= Url.Action("GetPlayersForTeam", "Player") %>' , {
					hintText: "Escribe el nombre del Jugador",
					noResultsText: "No se encontro ningun jugador",
					searchingText: "Buscando...",
					tokenLimit: 1,
					extraParams: { teamId: Model.TeamAId, typeId: function(){ return $('.PlayerTypeId').val() } }
				});
				
				$('.TeamBPlayerIdInput').tokenInput('<%= Url.Action("GetPlayersForTeam", "Player") %>' , {
					hintText: "Escribe el nombre del Jugador",
					noResultsText: "No se encontro ningun jugador",
					searchingText: "Buscando...",
					tokenLimit: 1,
					extraParams: { teamId: Model.TeamBId, typeId: function(){ return $('.PlayerTypeId').val() } }
				});
			}    
		}
	</script>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Creando Matchup
	<%
		this.htmlNamePrefix = "matchup"; %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<h2>Creando Matchup: 
	<span>Juego: [<%=Model.TeamAsACode %>] <%=Model.TeamAsADisplayName%> vs [<%=Model.TeamAsBCode %>] <%=Model.TeamAsBDisplayName %> </span></h2>

	<%= Html.ValidationSummary("Creacion fallida. Por favor corrija los errores e intente de nuevo.") %>

	<% using (Html.BeginForm()) {%>

		<fieldset>
			<legend>Jugadores</legend>
			
			<p>
				<%= this.Select("PlayerTypeId").Options(Model.PlayerTypesList).Class("PlayerTypeId").Label("Tipo de jugadores:").FirstOption("Elije un tipo") %>
			</p>
			<div id="tokens-wrapper">
				<p>
					<%= this.TextBox(c => c.TeamAPlayerIdInput).Label("Jugador A:").Class("TeamAPlayerIdInput").Value("")%>
					<%= this.ValidationMessage(c => c.TeamAPlayerIdInput)%>
				</p>
				<p>
					<%= this.TextBox(c => c.TeamBPlayerIdInput).Label("Jugador B:").Class("TeamBPlayerIdInput").Value("")%>
					<%= this.ValidationMessage(c => c.TeamBPlayerIdInput)%>
				</p>
			</div>
		</fieldset>
		
		<div id="available-bets">
		</div>
		
		<p>
			<input type="submit" value="Crear" />
		</p>

	<% } %>

	<%=Html.ActionLink( "Volver al listado", "Index", new { gamecode=Model.GameId}, new { @class = "navPrev" } )%>
	
	<%= Html.ClientSideValidation<GamePlayerCreateViewModel>(this.htmlNamePrefix)%>

</asp:Content>

