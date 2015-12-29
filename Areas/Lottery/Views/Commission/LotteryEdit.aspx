<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Lottery.CommissionEditViewModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Commision Profiles - Edit Lottery Commisions for profile:
    <%= Model.ProfileName%>
    <% htmlNamePrefix = "CommissionProfile"; %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Commision Profiles - Edit Lottery Commisions
    </h2>
    <%= Html.ValidationSummary("Edit Failes. Please try again.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Commision Profile:
            <%= Model.ProfileName %></legend>
        <table id="profileDetails">
            <thead>
                <tr>
                    <td class="productHeader">
                        Product
                    </td>
                    <td class="lotteryHeader">
                        Lottery
                    </td>
                    <td class="valueHeader">
                        User
                    </td>
                    <td class="valueHeader">
                        Terminal
                    </td>
                    <td class="valueHeader">
                        Bench
                    </td>
                    <td class="valueHeader">
                        Collection Center
                    </td>
                    <td class="valueHeader">
                        About Utility
                    </td>
                </tr>
            </thead>
            <tbody>
                <%
                    var CommissionFieldAttributes = new Dictionary<string, object> { { "class", "value" } };
                    for( int CurrentCommission = 0; CurrentCommission < Model.Details.Count( ); CurrentCommission++ )
                    {       
                %>
                <tr>
                    <td>
                        <%= Model.Details.ElementAt( CurrentCommission ).BetTypeName %>
                        <%= Html.Hidden( string.Format( "Details[{0}].BetTypeId", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).BetTypeId )%>
                    </td>
                    <td>
                        <%= Model.Details.ElementAt( CurrentCommission ).LotteryName %>
                        <%= Html.Hidden( string.Format( "Details[{0}].LotteryId", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).LotteryId )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].UserCommission", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).UserCommission ?? 0, CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].TerminalCommission", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).TerminalCommission ?? 0, CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].SportBookCommission", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).SportBookCommission ?? 0, CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].StoringCenterCommission", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).StoringCenterCommission ?? 0, CommissionFieldAttributes )%>
                    </td>
                    <td>
                        <%= Html.TextBox( string.Format( "Details[{0}].OverUtilityCommission", CurrentCommission ), Model.Details.ElementAt( CurrentCommission ).OverUtilityCommission ?? 0, CommissionFieldAttributes )%>
                    </td>
                </tr>
                <%= Html.ClientSideValidation<TheBookies.Model.CommissionProfileDetail>( String.Format( "Details[{0}]", CurrentCommission ) )%>
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
