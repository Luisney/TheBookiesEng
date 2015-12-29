<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Gambling.Models.ViewModels.Sports.GameAvailableBetViewModel>" %>
<%@ Import Namespace="TheBookies.Model" %>
<fieldset id="fields_<%= Model.AvailableBet.Id %>">
<h4><%= Model.AvailableBet.BetType.Name %></h4>

<%= this.CheckBox( string.Format( "betLineViewModels[{0}].IsActive", Model.Id ) ).Label( "Activa:" ).Checked( Model.AvailableBet.Status == ( Byte ) Enumerations.AvailableBetStatus.Active )%>
               
<%= Html.Hidden(string.Format("betLineViewModels[{0}].BetTypeId", Model.Id ), Model.AvailableBet.BetType.Id)%>
              
<%
if (Model.AvailableBet.BetType.UseGlobalScore)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].Score", Model.Id ) ).Value( Model.AvailableBet.Score ).Label( "Carreraje combinado:" )%>
    </p>
<%} %>

<%
    if( Model.AvailableBet.BetType.UseIndividualScore )
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].ScoreVisitor", Model.Id ) ).Value( Model.AvailableBet.ScoreVisitor ).Label( "Carreraje Visitante:" ).Class( "visitor" )%>
    </p>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].ScoreLocal", Model.Id ) ).Value( Model.AvailableBet.ScoreLocal ).Label( "Carreraje Local:" ).Class( "local" )%>
    </p>
<%} %>
 
<%
if (Model.AvailableBet.BetType.UseIndividualSpread)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].SpreadVisitor", Model.Id ) ).Value( Model.AvailableBet.SpreadVisitor ).Label( "Ventaja Visitante:" ).Class( "visitor-spread" )%>
    </p>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].SpreadLocal", Model.Id ) ).Value( Model.AvailableBet.SpreadLocal ).Label( "Ventaja Local:" ).Class( "local-spread" )%>
    </p>
<%} %>

<%
if (Model.AvailableBet.BetType.UseIndividualPrice)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].Visitor", Model.Id ) ).Value( Model.AvailableBet.PriceVisitor ).Label( "Visitante:" ).Class( "visitor" )%>
    </p>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].Local", Model.Id ) ).Value( Model.AvailableBet.PriceLocal ).Label( "Local:" ).Class( "local" )%>
    </p>
<%} %>
    
<%
if (Model.AvailableBet.BetType.UseGlobalPriceOver)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].PriceOver", Model.Id ) ).Value( Model.AvailableBet.PriceOver ).Label( "Precio a más de:" )%>
    </p>
<%} %>
   
<%
if (Model.AvailableBet.BetType.UseIndividualPriceOver)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].OverVisitor", Model.Id ) ).Value( Model.AvailableBet.PriceVisitorOver ).Label( "Over Visitante:" ).Class( "visitor" )%>
    </p>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].OverLocal", Model.Id ) ).Value( Model.AvailableBet.PriceLocalOver ).Label( "Over Local:" ).Class( "local" )%>
    </p>                
<%}
%>

<%
if (Model.AvailableBet.BetType.UseGlobalPriceUnder)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].PriceUnder", Model.Id ) ).Value( Model.AvailableBet.PriceUnder ).Label( "Precio a menos de:" )%>
    </p>
<%} %>    
    
<%
    if (Model.AvailableBet.BetType.UseIndividualPriceUnder)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].UnderVisitor", Model.Id ) ).Value( Model.AvailableBet.PriceVisitorUnder ).Label( "Under Visitante:" ).Class( "visitor" )%>
    </p>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].UnderLocal", Model.Id ) ).Value( Model.AvailableBet.PriceLocalUnder ).Label( "Under Local:" ).Class( "local" )%>
    </p>                
<%}
%>
   
<%
if (Model.AvailableBet.BetType.UsePropositionPrice)
{%>
    <p>
        <%= this.TextBox( string.Format( "betLineViewModels[{0}].PropositionPrice", Model.Id ) ).Value( Model.AvailableBet.PropositionPrice ).Label( "Precio:" )%>
    </p>
<%} %>

</fieldset>