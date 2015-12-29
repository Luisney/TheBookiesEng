<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.ViewModels.TerminalViewModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <%  HtmlNamePrefix = "TerminalViewModel"; %>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            FilterSportBooksByCompany: '<%= Url.Action("FilterByCompany", "SportBook") %>',
            FilterStoringCenterByCompany: '<%= Url.Action("FilterByCompany", "StoringCenter") %>/',
            FilterTerminalModelByMaker: '<%= Url.Action("FilterModelByMaker", "Terminal") %>/'
        }
    </script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            var companyIdSelector = '#<%= this.IdFor( PageModel => PageModel.CompanyId ) %>';
            var sportBookId = '<%= this.IdFor( PageModel => PageModel.SportBookId ) %>';
            var storingCenterId = '<%= this.IdFor( PageModel => PageModel.StoringCenterId ) %>';

            $(companyIdSelector).cascade({
                source: ControllerActions.FilterSportBooksByCompany,
                cascaded: sportBookId,
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $(companyIdSelector).cascade({
                source: ControllerActions.FilterStoringCenterByCompany,
                cascaded: storingCenterId,
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Terminals - Create terminal
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Create Terminal
    </h2>
    <%= Html.ValidationSummary("Creación fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Fields</legend>
        <p>
            <%= this.Select( PageModel => PageModel.Status ).Options( Model.TerminalStatusList ).Label( "Estado:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Status )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.TerminalId ).Label( "Terminal ID:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.TerminalId )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Mac ).Label( "Coban:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.Mac) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Serial ).Label( "Serial:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.Serial) %>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.CompanyId ).Options( Model.CompanyList ).FirstOption( "Selecciona una" ).Label( "Company:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.CompanyId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.SportBookId ).Label( "Bench:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.SportBookId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.StoringCenterId ).Label( "Collection Center:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.StoringCenterId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.TerminalMakerId ).Options( Model.TerminalMakerList ).Label( "Make:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.TerminalMakerId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.TerminalModelId ).Options( Model.TerminalModelList ).Label( "Model:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.TerminalModelId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.CommissionProfileId ).Options( Model.CommissionProfileList ).Label( "Commision profile:" ).FirstOption( "", "-Heredado-" )%>
            <%= this.ValidationMessage( PageModel => PageModel.CommissionProfileId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.ValuePaymentProfileId ).Options( Model.ValuePaymentProfileList ).Label( "Value to pay profile:" ).FirstOption( "", "-Heredado-" )%>
            <%= this.ValidationMessage( PageModel => PageModel.ValuePaymentProfileId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.LimitBetTypeProfileId ).Options( Model.LimitBetTypeProfileList ).Label( "Limit profile:" ).FirstOption( "", "-Heredado-" )%>
            <%= this.ValidationMessage( PageModel => PageModel.LimitBetTypeProfileId )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Maximum ).Label( "Maximum sport sales:" )%>
            <%= this.ValidationMessage(PageModel => PageModel.Maximum) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.LottoMaximum ).Label( "Maximum lottery sales:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.LottoMaximum )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.LottoMaximumOffLine ).Label( "Maximum lottery sales offline:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.LottoMaximumOffLine )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.UseDetailedReport ).Label( "Use detailes reports:" ).Attr( "title", "Activate to use detailed reports (consumes more paper)" ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( PageModel => PageModel.UseDetailedReport )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.IsIndependent ).Label( "This terminal is independent:" ).Attr( "title", "Activate when this terminal does not belong to a company." ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( PageModel => PageModel.IsIndependent )%>
        </p>
        <p>
            <%= this.CheckBox( PageModel => PageModel.ShowReceiptLogo ).Label( "Show logo:" ).Attr( "title", "Activate to show logo in receipt" ).Attr( "class", "jqtooltipWE" )%>
            <%= this.ValidationMessage( PageModel => PageModel.ShowReceiptLogo )%>
        </p>
        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ClientSideValidation<Terminal>( HtmlNamePrefix )%>
        <%=Html.ActionLink( "Return to listing", "Index", new { }, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
