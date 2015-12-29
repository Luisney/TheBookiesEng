<%@ Page Title="" Language="C#" MasterPageFile="../Shared/MainOneColumn.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.ViewModels.GamePlayerIndexViewModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetPackage( AssetPackage.JqBlockUI ) %>
    <%= Html.GetScript( "jqueryEditInPlace/jquery.editinplace" )%>
    <script type="text/javascript">
        var MatchupControllerActions = {
            EditAvailableBet: '<%= Url.Action("EditAvailableBet","Game") %>'
        };
        var ControllerActions = {
            Delete: '<%= Url.Action("Delete", "GamePlayer", new { @area = "Sports" } ) %>',
            Cancel: '<%= Url.Action("CancelMatchup", "GamePlayer", new { @area = "Sports" } ) %>',
            FilterMatchups: '<%= Url.Action("FilterMatchups", "GamePlayer") %>',
            GetSports: '<%= Url.Action("GetSports", "Sport") %>',
            FilterDivisionsBySport: '<%=Url.Action("FilterDivisionsBySport", "Division") %>'
        };
        var LoaderImgUrl = '<%= Html.GetImageURL( "ajax-loader-small.gif" )%>';

        var EditAvailableBetParamName = 'GameAvailableBet';

        $(document).ready(function () {
            $('.line-odd-value').editInPlace({
                url: MatchupControllerActions.EditAvailableBet,
                paramsCallback: getAvailableBetData,
                value_required: true,
                update_value: 'UpdatedValue'
            });
        });

        getAvailableBetData = function (domElement) {
            // Get element Id
            var AvailableBetId = /\b<%= Constants.LineAvailableBetKey %>([\S]*)\b/.exec($(domElement).attr('class'))[1];
            // Get availableBet fields
            var relatedFields = $('.<%= Constants.LineAvailableBetKey %>' + AvailableBetId + '[class*="<%=Constants.LineAvailableBetFieldKey%>"]');

            // Game available bet id
            var result = EditAvailableBetParamName + '.Id=' + AvailableBetId;
            var fieldName = "";
            $.each(relatedFields,
                function (indexInArray, currentElement) {
                    var matches = /\b<%=Constants.LineAvailableBetFieldKey%>([\S]*)\b/.exec($(currentElement).attr('class'));
                    fieldName = matches[1];
                    result += "&" + EditAvailableBetParamName + '.' + fieldName + "=" + escape($.trim($(currentElement).html()));
                }
            );

            return result;
        }
    </script>
    <%= Html.GetScript( "sports/gameplayer/gameplayeractions.shared" ) %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Listado de Match-Ups para un Juego - <%= "[" + Model.Game.TeamAsA.Code + "] " + Model.Game.TeamAsA.PrintName %> Vs. <%= "[" + Model.Game.TeamAsB.Code + "] " + Model.Game.TeamAsB.PrintName %> - <%= Model.Game.EndDate.ToShortDateString() %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        Listado de Match-Ups para un Juego<br />
    </h1>
    <h5>
        <%= "[" + Model.Game.TeamAsA.Code + "] " + Model.Game.TeamAsA.PrintName %>
        Vs.
        <%= "[" + Model.Game.TeamAsB.Code + "] " + Model.Game.TeamAsB.PrintName %>
        -
        <%= Model.Game.EndDate.ToShortDateString() %>
    </h5>
    <br />
    <a id="addButton" class="button" href="<%= Url.Action("Create", new { gameId = Model.GameCode }) %>">
        <span>Añadir Matchup</span></a>
    <div class="separtor">
        &nbsp;</div>
    <form action="" method="post">
    </form>
    <% foreach( var Item in Model.Rows )
       {
           Html.RenderPartial( "Matchup", Item );
       } %>
</asp:Content>
