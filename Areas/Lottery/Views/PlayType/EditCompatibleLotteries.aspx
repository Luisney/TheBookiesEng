<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Lottery.BetTypeCompatibleLotteriesViewModel>" %>
<asp:Content ID="Content4" ContentPlaceHolderID="Assets" runat="server">
<script type="text/javascript" language="javascript">
    $(function() {
        $('input[name="CompatibleLotteries"]').change(
            function() {
                // Uncheck IsMandatory checkbox when lottery is disabled
                if( !$(this).attr("checked") )
                    $(this).parent().parent('tr[name="betLotteryCompatibility"]').find('input[name="MandatoryLotteries"]:checked').attr("checked", false);
            }
        );
    });
</script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit lotteries compatibles for the bet type
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Edit lotteries compatible for:
        <%= Model.BetTypeName %>
    </h2>
    <table>
        <thead>
            <tr>
                <td>
                    <h3>
                        Lottery</h3>
                </td>
                <td>
                    <h3>
                        Enabled?</h3>
                </td>
                <td>
                    <h3>
                        Mandatory?</h3>
                </td>
            </tr>
        </thead>
        <tbody>
            <% using( Html.BeginForm( ) )
               {
                   // Link index used by tab navigation
                   var LinkIndex = 400;
                   foreach( var Lottery in Model.Lotteries )
                   {
                       LinkIndex++;%>
            <tr name="betLotteryCompatibility">
                <td>
                    <%= Lottery.Name %>
                </td>
                <td>
                    <input type="checkbox" <%= Model.CompatibleLotteries.Any( compatibility => compatibility.Equals( Lottery.Id ) )?"checked=\"checked\"":"" %>
                        value="<%=Lottery.Id%>" name="CompatibleLotteries"></input>
                </td>
                <td>
                    <input type="checkbox" <%= Model.MandatoryLotteries.Any( compatibility => compatibility.Equals( Lottery.Id ) )?"checked=\"checked\"":"" %>
                        value="<%=Lottery.Id%>" name="MandatoryLotteries"></input>
                </td>
                <%}%>
        </tbody>
    </table>
    <p>
        <input type="submit" value="Save" />
    </p>
    <% } %>
    <br />
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", "PlayType", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
