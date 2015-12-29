<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.ViewModels.GameResultsViewModel>" %>
<%@ Import Namespace="TheBookies.Model" %>
<%@ Import Namespace="Gambling.Models" %>
<%
    IEnumerable<GameAvailableBet> propositionAvailableBets = Model.AvailableBets.Where( availableBet => availableBet.BetType.UsePropositionPrice );
    IEnumerable<GameDetail> propositionBetsResults = Model.GameResults.Where( G => G.GameDetailType == ( Byte ) Constants.GameDetailType.Proposition );
%>
<h5>
    Apuestas proposition
</h5>
<table class="propositionBetsTable">
    <thead>
        <tr>
            <th>
            </th>
            <th>
                Pendiente
            </th>
            <th>
                Perdedor
            </th>
            <th>
                Ganador
            </th>
        </tr>
    </thead>
    <tbody>
        <% foreach( var availableBet in propositionAvailableBets )
           {
               GameDetail currentDetail = propositionBetsResults.Where( result => result.BetType != null && result.BetType.Id == availableBet.BetType.Id ).FirstOrDefault( );
        
        %>
        <tr>
            <td>
                <%=availableBet.BetType.Name%>
            </td>
            <td>
                <%=Html.Hidden( string.Format( "GameDetails[{0}].Id", Model.CurrentIndex ), ( currentDetail ?? new GameDetail() ).Id,
                                  new {@class = "score-serializable"})%>
                <%=Html.Hidden( string.Format( "GameDetails[{0}].GameDetailType", Model.CurrentIndex ),
                                  (Byte) Constants.GameDetailType.Proposition, new {@class = "score-serializable"})%>
                <%=Html.Hidden( string.Format( "GameDetails[{0}].BetTypeId", Model.CurrentIndex ),
                    availableBet.BetType.Id, new { @class = "score-serializable" } )%>
                <%=this.RadioButton( string.Format( "GameDetails[{0}].PropositionScore", Model.CurrentIndex ) ).Value( ( Byte ) Enumerations.PropositionResult.Pending )
                    .Checked(currentDetail != null ? currentDetail.PropositionScore == ( Byte ) Enumerations.PropositionResult.Pending: true )
                    .Attr( "class", "score-serializable" ) %>
            </td>
            <td>
                <%=this.RadioButton( string.Format( "GameDetails[{0}].PropositionScore", Model.CurrentIndex ) ).Value( ( Byte ) Enumerations.PropositionResult.Loser )
                                        .Checked( ( currentDetail ?? new GameDetail() ).PropositionScore == ( Byte ) Enumerations.PropositionResult.Loser )
                    .Attr( "class", "score-serializable" ) %>
            </td>
            <td>
                <%=this.RadioButton( string.Format( "GameDetails[{0}].PropositionScore", Model.CurrentIndex ) ).Value( ( Byte ) Enumerations.PropositionResult.Winner )
                                        .Checked( ( currentDetail ?? new GameDetail() ).PropositionScore == ( Byte ) Enumerations.PropositionResult.Winner )
                    .Attr( "class", "score-serializable" ) %>
            </td>
        </tr>
        <%
            Model.CurrentIndex++;
           }%>
    </tbody>
</table>
