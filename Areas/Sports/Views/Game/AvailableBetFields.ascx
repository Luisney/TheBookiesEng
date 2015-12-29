<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<List<IGrouping<BetTypePeriod, BetLineViewModel>>>" %>
<%@ Import Namespace="Gambling.Models.ViewModels"%>
<%@ Import Namespace="Gambling.Models"%>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#period-select').change(function() {
                var toShowSelector = "#period-" + $(this).val();

                $(toShowSelector).show();

                $('.current-selected').removeClass('current-selected').hide();

                $(toShowSelector).addClass('current-selected');
            });

            $('#period-1').addClass('current-selected').show();
        });
    </script>
<%= this.Select("period-select").Options(Model.ToDictionary(c => c.Key.Id, c => c.Key.Name)).Label("Filtrar por período:") %>
<br/>
<%
    int counter = 2;
    foreach (var periodGroup in Model)
    {%>
    <div id="period-<%= periodGroup.Key.Id %>" class="ui-hide">
    <%= Html.Hidden( "PeriodFrequency", periodGroup.Key.Frequency )%>
    <%= Html.Hidden( "PeriodIndex", periodGroup.Key.PeriodIndex )%>
    <%= Html.Hidden( "PeriodId", periodGroup.Key.Id )%>
           
    <%
        foreach( BetLineViewModel lineViewModel in periodGroup )
        {%>
            <fieldset id="fields_<%= lineViewModel.BetType.Id %>" class="availableBet">
            <h4><%= lineViewModel.BetType.Name %></h4>
            
            <%= this.CheckBox(string.Format("betTemplateViewModels[{0}].IsActive", counter)).Label("Activa:").Checked(lineViewModel.IsActive).Class("active-check")%>
            
            <%= this.CheckBox( string.Format( "betTemplateViewModels[{0}].IsCalculated", counter ) ).Label( "Bloquear calculo automatico:" ).Checked( lineViewModel.IsCalculated ).Class( "calculated-check" )%>
            
            <%= Html.Hidden(string.Format("betTemplateViewModels[{0}].BetTypeId", counter), lineViewModel.BetType.Id)%>
            
            <%
            if (lineViewModel.BetType.UseIndividualScore)
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].ScoreVisitor", counter ) ).Value( lineViewModel.ScoreVisitor ).Label( "Puntaje/Carreraje Visitante:" ).Class( "visitor-score" )%>
                </p>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].ScoreLocal", counter ) ).Value( lineViewModel.ScoreLocal ).Label( "Puntaje/Carreraje Local:" ).Class( "local-score" )%>
                </p>
            <%} %>

             <%
                if( lineViewModel.BetType.UseGlobalScore )
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].Score", counter ) ).Value( lineViewModel.Score ).Label( "Puntaje/Carreraje combinado:" ).Class( "global-score" )%>
                </p>
            <%}
            %>

            <%
            if (lineViewModel.BetType.UseIndividualSpread)
            {%>
                <p>
                    <%= this.TextBox(string.Format("betTemplateViewModels[{0}].SpreadVisitor", counter)).Value(lineViewModel.SpreadVisitor).Label("Gavela Visitante:").Class("visitor-spread")%>
                </p>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].SpreadLocal", counter ) ).Value( lineViewModel.SpreadLocal ).Label( "Gavela Local:" ).Class( "local-spread" )%>
                </p>
            <%} %>
            
            <%
            if (lineViewModel.BetType.UseIndividualPrice)
            {%>
                <p>
                    <%= this.TextBox(string.Format("betTemplateViewModels[{0}].Visitor", counter)).Value(lineViewModel.Visitor).Label("Precio Visitante:").Class("visitor")%>
                </p>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].Local", counter ) ).Value( lineViewModel.Local ).Label( "Precio Local:" ).Class( "local" )%>
                </p>
            <%} %>
            
            <%
            if (lineViewModel.BetType.UseIndividualPriceOver )
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].OverVisitor", counter ) ).Value( lineViewModel.OverVisitor ).Label( "Precio (+) Visitante:" ).Class( "visitor-over" )%>
                </p>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].OverLocal", counter ) ).Value( lineViewModel.OverLocal ).Label( "Precio (+) Local:" ).Class( "local-over" )%>
                </p>                
            <%}
            %>

            <%
                if( lineViewModel.BetType.UseGlobalPriceOver )
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].PriceOver", counter ) ).Value( lineViewModel.PriceOver ).Label( "Precio (+) combinado:" ).Class( "global-over" )%>
                </p>
            <%}
            %>
            
            <%
                if( lineViewModel.BetType.UseIndividualPriceUnder )
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].UnderVisitor", counter ) ).Value( lineViewModel.UnderVisitor ).Label( "Precio (-) Visitante:" ).Class( "visitor-under" )%>
                </p>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].UnderLocal", counter ) ).Value( lineViewModel.UnderLocal ).Label( "Precio (-) Local:" ).Class( "local-under" )%>
                </p>                
            <%}%>
            
            <%  if( lineViewModel.BetType.UseGlobalPriceUnder )
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].PriceUnder", counter ) ).Value( lineViewModel.PriceUnder ).Label( "Precio (-) combinado:" ).Class( "global-under" )%>
                </p>
            <%}
            %>

            
            <%  if( lineViewModel.BetType.UsePropositionPrice )
            {%>
                <p>
                    <%= this.TextBox( string.Format( "betTemplateViewModels[{0}].PropositionPrice", counter ) ).Value( lineViewModel.PropositionPrice ).Label( "Precio:" ).Class( "proposition" )%>
                </p>
            <%}
            %>
            
            </fieldset>
        <%
            counter++;
        } %>
        </div>
    <%} %>
