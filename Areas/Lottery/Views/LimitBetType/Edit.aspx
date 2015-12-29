<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Lottery.LimitBetTypeEditViewModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Limit Profiles - Edit Limits for the Profile:
    <%= Model.ProfileName%>
    <% htmlNamePrefix = "LimitBetTypeProfile"; %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Limit Profiles - Edit Limits for Lotteries
    </h2>
    <%= Html.ValidationSummary("Edición fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Profile Limits:
            <%= Model.ProfileName %></legend>
        <table id="profileDetails">
            <thead>
                <tr>
                    <td class="productHeader">
                        Product
                    </td>
                    <td class="lotteryHeader">
                        Lotteries
                    </td>
                    <td class="valueHeader">
                        Online Limit
                    </td>
                    <td class="valueHeader">
                        Offline Limit
                    </td>
                </tr>
            </thead>
            <tbody>
                <%
                    var CommissionFieldAttributes = new Dictionary<string, object> { { "class", "value" } };
                    for( int CurrentPosition = 0; CurrentPosition < Model.Details.Count( ); CurrentPosition++ )
                    {
                        var currentDetail = Model.Details.ElementAt( CurrentPosition );  
                %>
                <tr>
                    <% if( Model.Details.First( Detail => Detail.BetTypeId == currentDetail.BetTypeId ) == currentDetail )
                    {%>
                    <td class="topAligned" rowspan="<%=Model.Details.Count(Detail => Detail.BetTypeId == currentDetail.BetTypeId)%>">
                        <%=Model.Details.ElementAt(CurrentPosition).BetTypeName%>
                        <%=Html.Hidden(string.Format("Details[{0}].BetTypeId", CurrentPosition), currentDetail.BetTypeId)%>
                    </td>
                    <%}else{%>                 
                        <%=Html.Hidden(string.Format("Details[{0}].BetTypeId", CurrentPosition), currentDetail.BetTypeId)%>
                    <%}%>
                    <td>
                        <%= Model.Details.ElementAt( CurrentPosition ).LotteriesNames %>
                        <%= Html.Hidden( string.Format( "Details[{0}].Lottos", CurrentPosition ), currentDetail.Lottos )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].MaxValueOnLine", CurrentPosition ), currentDetail.MaxValueOnLine.ToString( "F2" ), CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].MaxValueOffLine", CurrentPosition ), currentDetail.MaxValueOffLine.ToString( "F2" ), CommissionFieldAttributes )%>
                    </td>
                </tr>
                <%= Html.ClientSideValidation<TheBookies.Model.LimitBetTypeProfileDetail>( String.Format( "Details[{0}]", CurrentPosition ) )%>
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
