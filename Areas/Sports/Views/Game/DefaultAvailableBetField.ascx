<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.Models.ViewModels.BetLineViewModel>" %>
<fieldset id="fields_<%= Model.BetType.Id %>" class="availableBet">
    <h4>
        <%= Model.BetType.Name %></h4>
    <%  var Key = String.Format( "betTemplateViewModels[{0}]", Model.Index ); %>
    <%= this.CheckBox( Key + ".IsActive").Label("Activa:").Checked(Model.IsActive).Class("active-check")%>
    <%= Html.Hidden( Key + ".BetTypeId", Model.BetType.Id, new{ @class="bettype" } )%>
    <%
        if( Model.BetType.UseGlobalScore )
        {%>
    <p>
        <%= this.TextBox( Key + ".Score" ).Value( Model.Score ).Label( "Puntaje/Carreraje combinado:" ).Class( "global-score" )%>
    </p>
    <%} %>
    <%
        if( Model.BetType.UseIndividualScore )
        {%>
    <p>
        <%= this.TextBox( Key + ".ScoreVisitor" ).Value( Model.ScoreVisitor ).Label( "Puntaje/Carreraje Visitante:" ).Class( "visitor-score" )%>
    </p>
    <p>
        <%= this.TextBox( Key + ".ScoreLocal" ).Value( Model.ScoreLocal ).Label( "Puntaje/Carreraje Local:" ).Class( "local-score" )%>
    </p>
    <%} %>
    <%  if( Model.BetType.UseIndividualSpread )
        {%>
    <p>
        <%= this.TextBox( Key + ".SpreadVisitor" ).Value( Model.SpreadVisitor ).Label( "Gavela Visitante:" ).Class( "visitor-spread" )%>
    </p>
    <p>
        <%= this.TextBox( Key + ".SpreadLocal" ).Value( Model.SpreadLocal ).Label( "Gavela Local:" ).Class( "local-spread" )%>
    </p>
    <%} %>
    <%
        if( Model.BetType.UseIndividualPrice )
        {%>
    <p>
        <%= this.TextBox( Key + ".Visitor" ).Value( Model.Visitor ).Label( "Precio Visitante:" ).Class( "visitor" )%>
    </p>
    <p>
        <%= this.TextBox( Key + ".Local" ).Value( Model.Local ).Label( "Precio Local:" ).Class( "local" )%>
    </p>
    <%} %>
    <%
        if( Model.BetType.UseGlobalPriceOver )
        {%>
    <p>
        <%= this.TextBox( Key + ".PriceOver" ).Value( Model.PriceOver ).Label( "Precio (+):" ).Class( "global-over" )%>
    </p>
    <%} %>
    <%
        if( Model.BetType.UseIndividualPriceOver )
        {%>
    <p>
        <%= this.TextBox( Key + ".OverVisitor" ).Value( Model.OverVisitor ).Label( "Precio (+) Visitante:" ).Class( "visitor-over" )%>
    </p>
    <p>
        <%= this.TextBox( Key + ".OverLocal" ).Value( Model.OverLocal ).Label( "Precio (+) Local:" ).Class( "local-over" )%>
    </p>
    <%}
    %>
    <%
        if( Model.BetType.UseGlobalPriceUnder )
        {%>
    <p>
        <%= this.TextBox( Key + ".PriceUnder" ).Value( Model.PriceUnder ).Label( "Precio (-):" ).Class( "global-under" )%>
    </p>
    <%} %>
    <%
        if( Model.BetType.UseIndividualPriceUnder )
        {%>
    <p>
        <%= this.TextBox( Key + ".UnderVisitor" ).Value( Model.UnderVisitor ).Label( "Precio (-) Visitante:" ).Class( "visitor-under" )%>
    </p>
    <p>
        <%= this.TextBox( Key + ".UnderLocal" ).Value( Model.UnderLocal ).Label( "Precio (-) Local:" ).Class( "local-under" )%>
    </p>
    <%}%>

    <%  if( Model.BetType.UsePropositionPrice )
        {%>
    <p>
        <%= this.TextBox( Key + ".PropositionPrice" ).Value( Model.PropositionPrice ).Label( "Precio:" ).Class( "proposition" )%>
    </p>
    <%} %>

</fieldset>
