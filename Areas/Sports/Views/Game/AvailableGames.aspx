<%@ Page Title="" Language="C#" MasterPageFile="../Shared/MainOneColumn.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<PagedList<Game>>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers" %>
<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetStyle( "pagination" )%>
    <%= Html.GetScript( "line.toogleVisibility" )%>
    <%= Html.GetScript( "jquery.cascadingddl" )%>
    <%= Html.GetScript( "jquery.pagination" )%>
    <script type="text/javascript">
    var LoaderImgUrl = '<%= Html.GetImageURL( "ajax-loader-small.gif" )%>';

    $(document).ready(function() {
        $("#date").datepicker({
            dateFormat: 'dd/mm/yy'
        });

        $('#SportId').cascadingDdl({
            source: "/Sports/Division/FilterDivisionsBySport",
            cascaded: "DivisionId",
            dependentNothingFoundLabel: "No hay elementos",
            dependentStartingLabel: "Selecciona una",
            dependentLoadingLabel: "Cargando opciones"
        });

        $('#filter-btn').click(function() {
             var loader = $('<img />').attr('src', LoaderImgUrl);
             $(this).parent().append(loader);
             
             $('#filtered-lines').load(
                '<%= Url.Action("FilterBetLines", "Game") %>',
                {
                    SportId: $('#SportId').val(),
                    date: $('#date').val(),
                    DivisionId: $('#DivisionId').val()
                },
                function(result){
                    loader.remove();
                });
          });
        
        initPagination(<%= Model.TotalCount %>);
    });
    
    // Setting the isFiltered value to false by default since we're not filtering anything at this stage yet
    var paginationFilterData = { isFiltered: false, date:'<%= DateTime.Now.ToShortDateString() %>', sportId:0, divisionId:0 };

    function initPagination(totalItems) {
        $("#Pagination").pagination(totalItems, {
            num_edge_entries: 2,
            num_display_entries: 8,
            callback: pageselectCallback,
            items_per_page: 5
        });
    }
    
    function setFilterPaginationData() {
        paginationFilterData.isFiltered = true;
        paginationFilterData.date = $('#date').val();
        paginationFilterData.divisionId = $('#DivisionId').val();
        paginationFilterData.sportId = $('#SportId').val();
    }
    
    function pageselectCallback(page_index, jq)
    {
        if(paginationFilterData.isFiltered) {
            var sendData = { pageIndex: page_index, divisionId: paginationFilterData.divisionId, sportId: paginationFilterData.sportId }
        } else {
            var sendData = { pageIndex: page_index }
        }
        
        $('#filtered-lines').load('/Sports/Game/PaginateGames', sendData, function() {
            $('.pagination .loading').remove();
        });
        
        $('.pagination').append('<span class="loading"><img src="/Content/images/ajax-loader-small.gif" /></span>');
        
        return false;
    }
    
    function rePaginate() {
        setFilterPaginationData();
        
        $.getJSON('/Sports/Game/GetTodayFilteredGamesCount', { divisionId: paginationFilterData.divisionId, sportId: paginationFilterData.sportId }, function(count) {
            initPagination(count);
        });
    }
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Juegos - Lineas disponibles
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        Lineas disponibles
    </h1>
    <div id="filter-box">
        <%= this.TextBox("date").Label("Fecha:").Value(DateTime.Now.ToShortDateString())%>
        <%= this.Select("SportId").Options((Dictionary<string, string>)ViewData["Sports"]).Label("Deporte:").FirstOption("Selecciona uno")%>
        <%= this.Select("DivisionId").Label("Liga:") %>
        <a id="filter-btn" class="button-right"><span>Filtrar</span></a>
    </div>
    <% if( !Model.Any( ) )
       {%>
    <p>
        No se han creado juegos.
    </p>
    <%} %>
    <div id="filtered-lines">
        <% Html.RenderPartial( "FilteredLines", Model ); %>
    </div>
    <div id="Pagination" class="pagination">
    </div>
    <br/>
    <br/>
    <br/>
    <br/>
    <div class="authorizeGamesContainer">
        <h5>
            Autorizar juegos de una liga</h5>
        <script type="text/javascript">
            var ExtendedAuthorizeGamesControlConfig = {
                CopyMode: '<%= ( int ) AuthorizeAllGamesForDivisionMode.GameBets %>'
            }
        </script>
        <% Html.RenderPartial( "AuthorizeGamesControl" ); %>
    </div>
</asp:Content>
