<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<SportBook>" %>

<%@ Import Namespace="Gambling.Models" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetPackage( AssetPackage.JqValidate )%>
    <%= Html.GetPackage( AssetPackage.JqCascadeSelect )%>

    <script src="/Content/js/SportBookTicketType/sportbooktickettype.common.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterRouteByCompany: '<%= Url.Action("FilterRouteByCompany", "SportBook") %>/',
            FilterStoringCenterByCompany: '<%= Url.Action("FilterByCompany", "StoringCenter") %>/',
            GetTicketLimitTotalsByDivision: '<%= Url.Action("GetTicketLimitTotalsByDivision", "SportBook") %>/'
        };

        $(document).ready(function() {
            $('#CompanyId').cascade({
                source: ControllerActions.FilterRouteByCompany,
                cascaded: "RouteId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
            
            $('#CompanyId').cascade({
                source: ControllerActions.FilterStoringCenterByCompany,
                cascaded: "StoringCenterId",
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Benches - Edit Benches
    <% HtmlNamePrefix = "SportBookToEdit"; %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Edit Benches</h2>
    <%= Html.ValidationSummary("Edit failed. Please try again.")%>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>General Information</legend>
        <%= this.Hidden(PageModel => PageModel.Id) %>
        <p>
            <%= this.Select("StatusId").Options((SelectList) ViewData["StatusId"]).Selected(((SelectList) ViewData["StatusId"]).SelectedValue).Label("Estado:") %>
            <%= this.ValidationMessage(PageModel => PageModel.Status ) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.SportBookId ).Disabled( true ).Label( "ID:" ) %>
            <%= this.Hidden( PageModel => PageModel.SportBookId ) %>
            <%= this.ValidationMessage( PageModel => PageModel.SportBookId ) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Name ).Label("Name:") %>
            <%= this.ValidationMessage( PageModel => PageModel.Name ) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Address ).Label( "Address:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.Address) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Phone ).Label( "Phone:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Phone )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Contact ).Label( "Contact:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Contact )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Email ).Label( "Email:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Email )%>
        </p>
        <p>
            <%= this.Select("CommissionProfileId")
                    .Options( ( SelectList ) ViewData [ "CommissionProfileId" ] )
                    .Selected( ( ( SelectList ) ViewData [ "CommissionProfileId" ] ).SelectedValue )
                                    .FirstOption( "null", "-Heredado-" )
                    .Label( "Commision profile:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.CommissionProfile )%>
        </p>
        <p>
            <%= this.Select("ValuePaymentProfileId")
                    .Options( ( SelectList ) ViewData [ "ValuePaymentProfileId" ] )
                    .Selected( ( ( SelectList ) ViewData [ "ValuePaymentProfileId" ] ).SelectedValue )
                                    .FirstOption( "null", "-Heredado-" )
                    .Label( "Value to pay profile:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.ValuePaymentProfile )%>
        </p>
        <p>
            <%= this.Select( "LimitBetTypeProfileId" )
                                    .Options( ( SelectList ) ViewData [ "LimitBetTypeProfileId" ] )
                                    .Selected( ( ( SelectList ) ViewData [ "LimitBetTypeProfileId" ] ).SelectedValue )
                    .FirstOption( "null", "-Heredado-" )
                    .Label( "Limit profile:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.LimitBetTypeProfile )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Maximum ).Label( "Maximum Sports sales:" ).Value( Model.Maximum.ToString( "F2" ) )%>
            <%= this.ValidationMessage( PageModel => PageModel.Maximum )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.LottoMaximum ).Label( "Maximum Lottery Sales:" ).Value( ( Model.LottoMaximum ?? 0 ).ToString( "F2" ) )%>
            <%= this.ValidationMessage( PageModel => PageModel.LottoMaximum )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.LottoExchangeUnit ).Label( "Penny Value:" ).Value( Model.LottoExchangeUnit.ToString( "F2" ) )%>
            <%= this.ValidationMessage( PageModel => PageModel.LottoExchangeUnit )%>
        </p>
        <p>
            <%= this.Select( "CompanyId" )
                .Options( ( SelectList ) ViewData [ "CompanyId" ] )
                .Selected( ( ( SelectList ) ViewData [ "CompanyId" ] ).SelectedValue ).Label( "Company:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Company )%>
        </p>
        <p>
            <%= this.Select("StoringCenterId")
                    .Options( ( SelectList ) ViewData [ "StoringCenterId" ] )
                    .Selected( ( ( SelectList ) ViewData [ "StoringCenterId" ] ).SelectedValue ).Label( "Collection Center:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.StoringCenter )%>
        </p>
        <p>
            <%= this.Select( "RouteId" )
                .Options( ( SelectList ) ViewData [ "RouteId" ] )
                .Selected( ( ( SelectList ) ViewData [ "RouteId" ] ).SelectedValue ).Label( "Route:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Route )%>
        </p>
        <%= Html.Hidden("TicketTypes")%>
    </fieldset>
    <h3>
        Limits for Sports sales</h3>
    <table>
        <tr>
            <td>
                Ticket Type:
            </td>
            <td>
                <%= this.Select("TicketType").Options((SelectList)ViewData["TicketType"]).FirstOption("Select a play type") %>
            </td>
        </tr>
        <tr>
            <td>
                Minimum sale:
            </td>
            <td>
                <%= Html.TextBox("minimumLimit")%>
            </td>
        </tr>
        <tr>
            <td>
                Maximum sale:
            </td>
            <td>
                <%= Html.TextBox("maximumLimit")%>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <a id="AddNumber" class="LinkAdd" href="#">Add</a>
            </td>
        </tr>
    </table>
    <br />
    <table class="dataTable" id="TicketTypeLimits">
    </table>
    <p>
        <label>
            &nbsp;</label>
        <input type="submit" value="Save" />
    </p>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<SportBook>( HtmlNamePrefix ) %>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
