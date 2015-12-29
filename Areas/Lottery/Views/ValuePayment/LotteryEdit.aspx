<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Lottery.ValuePaymentEditViewModel>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetPackage( AssetPackage.JqToolTip ) %>
    <%= Html.GetPackage( AssetPackage.JqValidate ) %>
    <script type="text/javascript">
        $(function () {
            $('#exchangeButton').click(function () {
                var exchangeFactor = $('#exchangeFactor').val();
                if (exchangeFactor > 0)
                    $("input[name$='BetTypeUseAnExchangeUnit']")
                    .each(function (i, exchangeApplies) {
                        if ($(exchangeApplies).val() == "True") {
                            $(exchangeApplies).parent().parent().find('input:not(:hidden)')
                                .each(function (i, currentInput) {
                                    var newValue = parseFloat($(currentInput).val()) * (1 / exchangeFactor);
                                    // Remove extra zeros (just 2 left)
                                    newValue = Math.round(newValue * 100) / 100;
                                    $(currentInput).val(newValue);
                                });
                        }
                    });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Profiles of Values to pay - Edit values to pay of lotteries for profile:
    <%= Model.ProfileName%>
    <% htmlNamePrefix = "ValuePaymentProfile"; %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Profiles or values to pay - Edit values to pay of lottery
    </h2>
    <%= Html.ValidationSummary("Edit failed. Please try again.") %>
    <div class="exchangeContainer">
        <input id="exchangeFactor" value="1.00" class="jqtooltipWE" title="Convierte los montos de las apuestas a cheles, desde cheles a pesos. Ingrese el valor de cada chele" />
        <span id="exchangeButton">
            <img alt="Convertir" src="<%= Html.GetImageURL("action_refresh.gif") %>" />Convertir
            cheles </span>
    </div>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <h5>
            Valores a Pagar del perfil:
            <%= Model.ProfileName %></h5>
        <table id="profileDetails">
            <thead>
                <tr>
                    <td class="productHeader">
                        <h3>
                            Product</h3>
                    </td>
                    <td class="lotteryHeader">
                        <h3>
                            Lottery</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            1st prize</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            2nd prize</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            3rd prize</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            Payment for dollar</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            Payment for dollat (pata)</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            Direct pay</h3>
                    </td>
                    <td class="valueHeader">
                        <h3>
                            Combined pay</h3>
                    </td>
                </tr>
            </thead>
            <tbody>
                <%
                    var CommissionFieldAttributes = new Dictionary<string, object> { { "class", "value" } };
                    for( int CurrentCommission = 0; CurrentCommission < Model.Details.Count( ); CurrentCommission++ )
                    {
                        var currentDetail = Model.Details.ElementAt( CurrentCommission );  
                %>
                <tr>
                    <td>
                        <%= Model.Details.ElementAt( CurrentCommission ).BetTypeName %>
                        <%= Html.Hidden( string.Format( "Details[{0}].BetTypeId", CurrentCommission ), currentDetail.BetTypeId )%>
                        <%= Html.Hidden( string.Format( "Details[{0}].BetTypeUseAnExchangeUnit", CurrentCommission ), currentDetail.BetTypeUseAnExchangeUnit )%>
                    </td>
                    <td>
                        <%= Model.Details.ElementAt( CurrentCommission ).LotteryName %>
                        <%= Html.Hidden( string.Format( "Details[{0}].LotteryId", CurrentCommission ), currentDetail.LotteryId )%>
                    </td>
                    <td>
                        <%= currentDetail.ShowLotteryPrizes?
                                Html.TextBox( string.Format( "Details[{0}].TWinAmountFirst", CurrentCommission ), ( currentDetail.TWinAmountFirst ?? 0 ).ToString("F2"), CommissionFieldAttributes ) :
                                                            Html.Hidden( string.Format( "Details[{0}].TWinAmountFirst", CurrentCommission ), ( currentDetail.TWinAmountFirst ?? 0 ).ToString( "F2" ) )%>
                    </td>
                    <td>
                        <%= currentDetail.ShowLotteryPrizes?
                                                            Html.TextBox( string.Format( "Details[{0}].TWinAmountSecond", CurrentCommission ), ( currentDetail.TWinAmountSecond ?? 0 ).ToString( "F2" ), CommissionFieldAttributes ) :
                                Html.Hidden( string.Format( "Details[{0}].TWinAmountSecond", CurrentCommission ), ( currentDetail.TWinAmountSecond ?? 0 ).ToString("F2"), CommissionFieldAttributes ) %>
                    </td>
                    <td>
                        <%= currentDetail.ShowLotteryPrizes?
                                Html.TextBox( string.Format( "Details[{0}].TWinAmountThird", CurrentCommission ), ( currentDetail.TWinAmountThird ?? 0 ).ToString("F2"), CommissionFieldAttributes ):
                                Html.Hidden( string.Format( "Details[{0}].TWinAmountThird", CurrentCommission ), ( currentDetail.TWinAmountThird ?? 0 ).ToString("F2"), CommissionFieldAttributes ) %>
                    </td>
                    <td>
                        <%= currentDetail.ShowWinnerAmmount?
                                Html.TextBox( string.Format( "Details[{0}].TWinAmount", CurrentCommission ), ( currentDetail.TWinAmount ?? 0 ).ToString("F2"), CommissionFieldAttributes ):
                                Html.Hidden( string.Format( "Details[{0}].TWinAmount", CurrentCommission ), ( currentDetail.TWinAmount ?? 0 ).ToString("F2"), CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= currentDetail.ShowAlterPrize?
                                Html.TextBox( string.Format( "Details[{0}].TWinAlterAmount", CurrentCommission ), ( currentDetail.TWinAlterAmount ?? 0 ).ToString("F2"), CommissionFieldAttributes ):
                                Html.Hidden( string.Format( "Details[{0}].TWinAlterAmount", CurrentCommission ), ( currentDetail.TWinAlterAmount ?? 0 ).ToString("F2"), CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= currentDetail.ShowConditionalPrizes?
                                Html.TextBox( string.Format( "Details[{0}].TWinDirectBets", CurrentCommission ), currentDetail.TWinDirectBets ?? 0, CommissionFieldAttributes ):
                                Html.Hidden( string.Format( "Details[{0}].TWinDirectBets", CurrentCommission ), currentDetail.TWinDirectBets ?? 0, CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= currentDetail.ShowConditionalPrizes?
                                Html.TextBox( string.Format( "Details[{0}].TWinCombinedBets", CurrentCommission ), currentDetail.TWinCombinedBets ?? 0, CommissionFieldAttributes ):
                                Html.Hidden( string.Format( "Details[{0}].TWinCombinedBets", CurrentCommission ), currentDetail.TWinCombinedBets ?? 0, CommissionFieldAttributes )%>
                    </td>
                </tr>
                <%= Html.ClientSideValidation<TheBookies.Model.ValuePaymentProfileDetail>( String.Format( "Details[{0}]", CurrentCommission ) )%>
                <%} %>
            </tbody>
        </table>
        <br />
        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
