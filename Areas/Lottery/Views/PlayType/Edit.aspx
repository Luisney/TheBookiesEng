<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.BetType>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Bet type - Create bet type
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "betTypeToEdit"; %>
    <h2>
        Edit bet type</h2>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <%= this.TextBox( PageModel => PageModel.Name ).Disabled( true ).Label( "Nombre:" ) %>
            <%= this.ValidationMessage( PageModel =>  PageModel.Name )%>
            <%= this.Hidden( PageModel =>  PageModel.Name )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel =>  PageModel.ApplyPrize ).Label( "Use lottery prizes:" ).Attr( "title", "Activate for bets that use lottery prizes." ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.ApplyPrize )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.SortPrizes ).Label( "Wins in any order" ).Attr( "title", "Activate for bets that win in any order" ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.SortPrizes )%>
        </p>
        <div id="prize">
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Winner ).Label( "Winner:" ).Attr( "title", "Activate if the prixe of the product depents on the first number." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Winner )%>
            </p>
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Second ).Label( "Second:" ).Attr( "title", "Activate if the prize of the product depends on the second number." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Second )%>
            </p>
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Thrird ).Label( "Third:" ).Attr( "title", "Activate if the prize of the product depends on the third number." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Thrird )%>
            </p>
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.AlterPrize ).Label( "Consolation:" ).Attr( "title", "Activate for best that pay a consolation prize" ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel => PageModel.AlterPrize )%>
            </p>
        </div>
        <div id="bets">
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Pairs ).Label( "Even:" ).Attr( "title", "Activate if the prize of the product depends on the number being a even." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Pairs )%>
            </p>
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Odds ).Label( "Odds:" ).Attr( "title", "Activate if the prize of the product depends on the number being odd." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Odds )%>
            </p>
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Highs ).Label( "Bigger than 50:" ).Attr( "title", "Activate if the prize of the product depends on the number being higher than 50." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Highs )%>
            </p>
            <p>
                <%= this.CheckBox( PageModel =>  PageModel.Lows ).Label( "Smaller or equal to 50:" ).Attr( "title", "Activate if the prize of the product depends on it being smaller or equal to 50." ).Attr( "class", "jqtooltipWE" )%>
                <%= this.ValidationMessage( PageModel =>  PageModel.Lows )%>
            </p>
        </div>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseExchangeUnit ).Label( "User payment by change:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.UseExchangeUnit )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Maximum ).Value( Model.Maximum.ToString( "F2" ) ).Label( "Maximum ticket value:" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.Maximum )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.AccumulatedLimit ).Label( "Maximum sales limit:" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.AccumulatedLimit )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.AccumulatedTimes ).Label( "Times played limit:" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.AccumulatedTimes )%>
        </p>
        <p>
            <%= this.TextBox( PageModel =>  PageModel.Lottos ).Disabled( true ).Label( "Amount of lotteries:" )%>
            <%= this.Hidden( PageModel =>  PageModel.Lottos )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.Lottos )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.DigitNumbers ).Disabled(true).Label("Digits per prize:") %>
            <%= this.Hidden( PageModel => PageModel.DigitNumbers ) %>
            <%= this.ValidationMessage( PageModel => PageModel.DigitNumbers )%>
        </p>
        <p>
            <%= this.TextBox( PageModel =>  PageModel.BetNumbers ).Label( "Number amount:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.BetNumbers )%>
        </p>
        <p>
            <%= this.TextBox( PageModel =>  PageModel.Shortcut ).Label( "Shortcut:" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.Shortcut )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel =>  PageModel.ValidOffLine ).Label( "Valid offline:" ).Attr( "title", "Activate if the product is valid offline." ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.ValidOffLine )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.MaximumOffLine ).Value( Model.MaximumOffLine.Value.ToString( "F2" ) ).Label( "Maximum offline:" )%>
            <%= this.ValidationMessage( PageModel =>  PageModel.MaximumOffLine )%>
        </p>
        <p>
            <label>
                &nbsp;</label>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.BetType>(HtmlNamePrefix)%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/tipsy.css" rel="stylesheet" type="text/css" />

    <script src="/Content/js/jquery.tipsy.js" type="text/javascript"></script>

    <script src="/Content/js/jqtooltip.js" type="text/javascript"></script>

    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>

    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>

</asp:Content>
