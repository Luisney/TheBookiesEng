<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<SportsResultViewModel>>" %>
<%@ Import Namespace="Gambling.Models.ViewModels" %>
<%if( Model.Count( ) > 0 )
  {%>

<script>
    $(document).ready(function() {
        $('#sport-scroll').accessNews({
            headline: "Sports",
            speed: "normal",
            slideBy: 1
        });
    })
</script>

<div class="resultBox-Wrap noMarginRight">
    <h2 class="dashboard-heading">
        Sports - Previous day results</h2>
    <div class="scrollable accessible_news_slider" id="sport-scroll">
        <p class="back">
            <a href="#" title="Siguiente">&laquo; Next</a></p>
        <p class="next">
            <a href="#" title="Anterior">Previous &raquo;</a></p>
        <br />
        <ul>
            <%
                foreach( SportsResultViewModel result in Model )
                {%>
            <li>
                <div class="result-Box">
                    <h4>
                        <%=result.Division.ShortName%></h4>
                    <table class="resultsTable" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="40%">
                                <%=result.VisitorName%>
                            </td>
                            <td>
                                <%=result.VisitorScore%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=result.LocalName%>
                            </td>
                            <td>
                                <%=result.LocalScore%>
                            </td>
                        </tr>
                    </table>
                </div>
            </li>
            <%
                }%>
        </ul>
    </div>
    <!--END: result-Box -->
</div>
<%}%>