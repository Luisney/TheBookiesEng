<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Gambling.Models.ViewModels.Lottery.BetScrutinyDaysNotScrutedViewModel>" %>
<h1>
    Dias pendientes por escrutar</h1>
<p>
    Haga click en las fechas para escrutar</p>
<div class="scrutinize-days">
    <%
        foreach( var PendingDay in Model.PendingDays )
        {%>
    <div class="scrutinize-day">
        <div class="eventStamp">
            <a class="eventDated" href="/Lottery/Scrutiny/index?date=<%=PendingDay.Date.ToShortDateString()%>"><%=PendingDay.Date.ToShortDateString()%></a>
        </div>
        <div class="eventContent">
            <h3> <span id="ShowPendingTicketsDay"><%=PendingDay.TicketsToScrute%></span> Tickets pendientes por escrutar</h3>
            Existen
            <%=PendingDay.OfflineTicketsToScrute%>
            tickets fuera de linea y
            <%=PendingDay.OnlineTicketsToScrute%>
            tickets en linea<br/>
            Ya han sido ingresados los resultados de
            <%=PendingDay.ResultsForDay%>
            loterias.<br />
            <span class="grayText">
            <% foreach( var Result in PendingDay.Results ) { %>
                <%= ( PendingDay.Results.First() == Result ? String.Empty: " <br/> " ) + Result.Lottery.Id + " - " + Result.Lottery.Name + " - " + Result.Prizes %>
            <% }%><br/><br/>
            <hr/>Combinaciones de Loterías en tickets pendientes:
                    <ul>
                    <%
                        string[] _array = null;
                        if(PendingDay.MissingLotteries.Length > 1)
                        {
                        _array = PendingDay.MissingLotteries.Substring(1).Split(',');
                        foreach (var _s in _array)
                        {%>
                          <li><%= _s %></li>  
                        <%}   
                            
                        }
                    %>
                    </ul>
                    <br/>
            </span>
        </div>
        <div class="clear" />
    </div>
    <%
        }%>
</div>
<%if( Model.HasMoreResults )
  {%>
<br />
<p>
    Existen mas dias sin escrutar. se muestran solo los
    <%= Model.MaxResultsShown %>
    más recientes.</p>
<%}%>
<%if( Model.PendingDays.Count( ) == 0 )
  {%>
<br />
<p>
    No existen mas dias sin escrutar.</p>
<%}%>