<%@ Page Title="" Language="C#" MasterPageFile="../Shared/MainOneColumn.Master" Inherits="System.Web.Mvc.ViewPage<List<GamePlayer>>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetPackage( AssetPackage.JqBlockUI ) %>
    <script src="/Content/js/jquery.cascadingddl.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ControllerActions = {
            Delete: '<%= Url.Action("Delete", "GamePlayer", new { @area = "Sports" } ) %>',
            Cancel: '<%= Url.Action("CancelMatchup", "GamePlayer", new { @area = "Sports" } ) %>',
            FilterMatchups: '<%= Url.Action("FilterMatchups", "GamePlayer") %>',
            GetSports: '<%= Url.Action("GetSports", "Sport") %>',
            FilterDivisionsBySport: '<%=Url.Action("FilterDivisionsBySport", "Division") %>'
        };
        var LoaderImgUrl = '<%= Html.GetImageURL( "ajax-loader-small.gif" )%>';

        $(document).ready(function () {
            $("#matchupsDate").datepicker({
                dateFormat: 'dd/mm/yy',
                beforeShow: function () {
                    $('#ui-datepicker-div').css('z-index', 2005);
                }
            });

            $('#matchupsSportId').cascadingDdl({
                source: ControllerActions.FilterDivisionsBySport,
                cascaded: "matchupsDivisionId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $('#matchupsFilter-btn').click(function () {
                var loader = $('<img />').attr('src', LoaderImgUrl);
                $(this).parent().append(loader);

                $('#matchups').load(ControllerActions.FilterMatchups,
                    {
                        SportId: $('#matchupsSportId').val(),
                        date: $('#matchupsDate').val(),
                        DivisionId: $('#matchupsDivisionId').val()
                    },
                    function (result) {
                        loader.remove();
                        // Apply style to blocked matchups
                        blockCancelledMatchups('.disabled-matchup');
                    }
                );
            });

            $.getJSON(ControllerActions.GetSports,
                    {},
                    function (data) {
                        $('#matchupsSportId').prepend('<option value="-1" selected="true">Seleccione un deporte</option>');
                        if (data.length > 0) {
                            $.each(data, function (i, item) {
                                $('#matchupsSportId').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                            });
                        }
                    });
        });
    </script>
    <%= Html.GetScript( "sports/gameplayer/gameplayeractions.shared" )%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Listado de Match-Ups
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Listado de Match-Ups</h2>
    <div id="filter-box">
        <%= this.TextBox("matchupsDate").Label("Fecha:").Value(DateTime.Now.ToShortDateString())%>
        <%= this.Select("matchupsSportId").Label("Deporte:").FirstOption("Selecciona uno")%>
        <%= this.Select("matchupsDivisionId").Label("Liga:")%>
        <a id="matchupsFilter-btn" class="button-right"><span>Filtrar</span></a>
    </div>
    <div id="matchups">
        <%  foreach( var GamePlayer in Model )
            {
                Html.RenderPartial( "Matchup", GamePlayer );
            } %>
    </div>
    <div class="authorizeMatchupsContainer">
        <h5>
            Autorizar Matchups</h5>
        <script type="text/javascript">
            var ExtendedAuthorizeGamesControlConfig = {
                CopyMode: '<%= ( int ) AuthorizeAllGamesForDivisionMode.PlayerBets %>'
            }
        </script>
        <% Html.RenderPartial( "AuthorizeGamesControl" ); %>
    </div>
</asp:Content>
