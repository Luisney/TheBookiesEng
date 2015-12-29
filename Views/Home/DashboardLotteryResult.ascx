<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<Result>>" %>
<%@ Import Namespace="TheBookies.Model" %>
<%if( Model.Count( ) > 0 )
  {%>
<script>
    $(document).ready(function() {
        $('#lottery-scroll').accessNews({
            headline: "Lottery",
            speed: "normal",
            slideBy: 1
        });
    })
</script>

<div class="resultBox-Wrap noMarginRight">
    <h2 class="dashboard-heading">
        Previous day results - Lottery</h2>
    <div class="scrollable accessible_news_slider" id="lottery-scroll">
        <p class="back">
            <a href="#" title="Anterior">&laquo; Previous</a></p>
        <p class="next">
            <a href="#" title="Siguiente">Next &raquo;</a></p>
        <br />
        <ul>
            <%if( Model.Count( ) > 0 )
              {%>
            <%}%>
            <%
                foreach( Result result in Model )
                {%>
            <li>
                <div class="result-Box">
                    <h4>
                        <%= result.Lottery.Name %></h4>
                    <table class="resultsTable" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                Primero
                            </td>
                            <td>
                                <%= result.Prizes.Split( ' ' ).First( ) %>
                            </td>
                        </tr>
                        <% if( result.Prizes.Split( ' ' ).Length > 2 )
                        {%>
                        <tr>
                            <td>
                                Segundo
                            </td>
                            <td>
                                <%= result.Prizes.Split( ' ' ).Skip( 1 ).First( )%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tercero
                            </td>
                            <td>
                                <%= result.Prizes.Split( ' ' ).Skip( 2 ).First( )%>
                            </td>
                        </tr>    
                        <%}%>
                    </table>
                </div>
            </li>
            <%} %>
        </ul>
    </div>
    <!--END: result-Box -->
</div>
<%}%>