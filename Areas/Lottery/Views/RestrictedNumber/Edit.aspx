<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.RestrictedNumber>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <% HtmlNamePrefix = "RestrictedNumberToEdit"; %>
    <link href="/Content/CSS/table.css" rel="stylesheet" type="text/css" />

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/RestrictedNumber/restrictednumber.common.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterSportBooksByStoringCenter: '<%= Url.Action("GetSportBooksByStoringCenter", "SportBook", new { @area = "root" }, null) %>/',
            FilterTerminalsBySportBook: '<%= Url.Action("GetTerminalsBySportBook", "Terminal", new { @area = "root" }, null ) %>/'
        };
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Restricted numbers - Edit restricted number
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Edit Restricted number</h2>
    <% using( Html.BeginForm( ) )
       {%>
    <h3>
        General Information</h3>
    <fieldset>
        <%= this.Hidden(PageModel => PageModel.Id) %>
        <%= this.Hidden(PageModel => PageModel.Status) %>
        <p>
            <%= this.TextBox(PageModel => PageModel.Date.ToShortDateString()).Label("Start Date:").Attr("class", "calendar") %>
            <%= this.ValidationMessage(PageModel => PageModel.Date) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.FinalDate.ToShortDateString( ) ).Label( "End Date:" ).Attr( "class", "calendar" )%>
            <%= this.ValidationMessage(PageModel => PageModel.FinalDate) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.MaxAmount ).Format("0.00").Label( "Maximum amount:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.MaxAmount )%>
        </p>
        <p>
            <label>
                Bet Type:</label>
            <%= Html.DropDownList("BetTypeId") %>
        </p>
        <p>
            <label>
                Number:</label>
            <%= this.TextBox( PageModel => PageModel.Numbers ) %>
            <%= this.ValidationMessage(PageModel => PageModel.Numbers) %>
        </p>
        <p>
            <%= this.CheckBox(PageModel => PageModel.ActionToTake).Label("Limits bets:") %>
            <%= this.ValidationMessage(PageModel => PageModel.ActionToTake) %>
        </p>
        <%= Html.Hidden("numbers") %>
    </fieldset>
    <br />
    <h3>
        <%= Html.Encode("This restricted number applies to the following lotteries:") %> </h3>
    <table>
        <tr>
            <td>
                <%= Html.DropDownList("LottoId") %>
            </td>
            <td>
                <a id="AddNumber" class="LinkAdd" href="#">Add</a>
            </td>
        </tr>
    </table>
    <%= this.ValidationMessage( PageModel => PageModel.LottoId )%>
    <br />
    <table class="dataTable" id="RestrictedNumbers">
    </table>
    <br />
    <br />
    <h3>
        This restricted number applies to:</h3>
    <%= this.Hidden( "associations" )%>
    <table>
        <tr>
            <td>
                <%= this.Select( "StoringCenterId" ).Options( ( Dictionary<string,string> ) ViewData["StoringCenterId"] ).FirstOption("0", "All collecting centers")%>
            </td>
            <td>
                <%= this.Select( "SportBookId" ).Options( new Dictionary<string,string>{ { "0", "All benches" } } )%>
            </td>
            <td>
                <%= this.Select( "TerminalId" ).Options( new Dictionary<string, string> { { "0", "All terminals" } } )%>
            </td>
            <td>
                <a id="AddEntityRelationship" class="LinkAdd" href="#">Agregar</a>
            </td>
        </tr>
    </table>
    <br />
    <table class="dataTable" id="EntityAssociations">
    </table>
    <br />
    <p>
        <input type="submit" value="Save" />
    </p>
    <% } %>
    <br />
    <br />
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.RestrictedNumber>(HtmlNamePrefix)%>
    <div id="infoDialog" title="Info">
        <br />
        <p id="infoDialogMessage">
        </p>
    </div>
</asp:Content>
