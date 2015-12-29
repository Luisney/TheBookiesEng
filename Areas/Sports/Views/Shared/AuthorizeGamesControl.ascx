<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Object>" %>
<%@ Import Namespace="Gambling.Helpers" %>
<%@ Import Namespace="Gambling.Models" %>
<%= Html.GetScript( "jquery.cascadingddl" )%>
<script type="text/javascript">
    var AuthorizeGamesControlConfig = {
        AuthorizeGamesUrl: '<%= Url.Action("AuthorizeGames", "Game") %>',
        FilterDivisionsBySportUrl: '<%= Url.Action("FilterDivisionsBySport", "Division") %>',
        GetSportsUrl: '<%= Url.Action("GetSports", "Sport") %>',
        CopyMode: '<%= (int) AuthorizeAllGamesForDivisionMode.Both %>'
    };

    // It's possible to override the AuthorizeGamesControlConfig values by declaring
    // the ExtendedAuthorizeGamesControlConfig object before render this control
    $(function () {
        if (typeof ExtendedAuthorizeGamesControlConfig != 'undefined')
            $.extend(AuthorizeGamesControlConfig, ExtendedAuthorizeGamesControlConfig);

        $.getJSON(AuthorizeGamesControlConfig.GetSportsUrl, {}, function (data) {
            $('#authorizeGamesSportId').prepend('<option value="-1" selected="true">Seleccione un deporte</option>');
            if (data.length > 0) {
                $.each(data, function (i, item) {
                    $('#authorizeGamesSportId').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                });
            }
        });

        $('#authorizeGamesSportId').cascadingDdl({
            source: AuthorizeGamesControlConfig.FilterDivisionsBySportUrl,
            cascaded: "authorizeGamesDivisionId",
            dependentNothingFoundLabel: "No hay elementos",
            dependentStartingLabel: "Selecciona una",
            dependentLoadingLabel: "Cargando opciones"
        });

        // Start date DatePicker
        $("#authorizeGamesDate").datepicker({
            dateFormat: 'dd/mm/yy'
        });

        $('#authorizeGamesFilter-btn').click(function () {
            $('#authorizeGamesFilterLoader').fadeIn();
            $('#authorizeGamesFilter-btn').fadeOut();
            $.post(AuthorizeGamesControlConfig.AuthorizeGamesUrl,
                        {
                            date: $('#authorizeGamesDate').val(),
                            divisionId: $('#authorizeGamesDivisionId').val(),
                            mode: AuthorizeGamesControlConfig.CopyMode
                        },
                        function (data) {
                            $("#AuthorizeGamesInfoDialog").find('.message').html(data);
                            $("#AuthorizeGamesInfoDialog").dialog('open');
                            $('#authorizeGamesFilterLoader').fadeOut();
                            $('#authorizeGamesFilter-btn').fadeIn();
                        },
                        "json");
        });

        $('#AuthorizeGamesInfoDialog').dialog({
            bgiframe: true,
            modal: true,
            autoOpen: false,
            buttons: {
                "Ok": function () {
                    $("#AuthorizeGamesInfoDialog").dialog('close');
                }
            }
        });
    });
</script>
<div id="AuthorizeGamesContainer">
        <%= this.TextBox( "authorizeGamesDate" ).Class("datepicker").Label( "Fecha:" ).Value( DateTime.Now.ToShortDateString( ) )%>
        <%= this.Select( "authorizeGamesSportId" ).Label( "Deporte:" )%>
        <%= this.Select( "authorizeGamesDivisionId" ).Label( "Liga:" )%>
    <div class="authorizeGamesFilterContainer">
        <a id="authorizeGamesFilter-btn" class="button-right"><span>Autorizar</span></a>
        <img id="authorizeGamesFilterLoader" src="<%= Html.GetImageURL( "ajax-loader-small.gif" )%>"
            alt="Cargando..." class="ui-hide" />
    </div>
    <br />
    <br />
    <br />
</div>
<div id="AuthorizeGamesInfoDialog" title="Info">
    <br />
    <p class="message">
    </p>
</div>
