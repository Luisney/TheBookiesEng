<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.General.RegisterSportbookViewModel>" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <% HtmlNamePrefix = "RegisterSportBookModel"; %>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript" src="/Content/js/jquery.cascade-select.0.8.js"></script>

    <script type="text/javascript">
        var ControllerActions = {
            FilterRouteByCompany: '<%= Url.Action("FilterRouteByCompany", "SportBook") %>/',
            FilterStoringCenterByCompany: '<%= Url.Action("FilterByCompany", "StoringCenter") %>/'
        };

        $(document).ready(function() {
            var companyListIdSelector = '#<%= this.IdFor( PageModel => PageModel.CompanyId ) %>';
            var storingCenterListId = '<%= this.IdFor( PageModel => PageModel.StoringCenterId ) %>';
            var routeListId = '<%= this.IdFor( PageModel => PageModel.RouteId ) %>';

            $(companyListIdSelector).cascade({
                source: ControllerActions.FilterRouteByCompany,
                cascaded: routeListId,
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });

            $(companyListIdSelector).cascade({
                source: ControllerActions.FilterStoringCenterByCompany,
                cascaded: storingCenterListId,
                dependentNothingFoundLabel: "No hay elementos",
                dependentStartingLabel: "Selecciona una",
                dependentLoadingLabel: "Cargando opciones"
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registro Rapido
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Registro Rapido
    </h2>
    <%=Html.ValidationSummary("Creación fallida. por favor corrije los errores e intenta de nuevo")%>
    <%
        if( ViewData.Contains( "StatusMessage" ) )
        {%>
    <div id="quickRegisterSportbookMessage" class="ui-state-highlight ui-corner-all">
        <p><%=ViewData["StatusMessage"]%></p>
    </div>
    <br/>
    <%  }%>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Banca</legend>
        <p>
            <%= this.TextBox( PageModel => PageModel.SportBookId ).Label( "Id:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.SportBookId )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Name ).Label( "Nombre:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Name )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Address ).Label( "Dirección:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Address )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Phone ).Label( "Teléfono:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Phone )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Contact ).Label( "Contacto:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Contact )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Email ).Label( "Correo electronico:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Email )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.LottoExchangeUnit ).Label( "Valor de un chele:" ).Value( Model.LottoExchangeUnit.ToString( "F2" ) )%>
            <%= this.ValidationMessage( PageModel => PageModel.LottoExchangeUnit )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.CompanyId )
                .Options( Model.CompanyList )
                .Selected( Model.CompanyId )
                .FirstOption( "Seleccione una compañia" )
                .Label( "Consorcio:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.CompanyId )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.StoringCenterId )
                .Options( Model.StoringCenterList )
                .Selected( Model.StoringCenterId )
                .FirstOption( "Seleccione una compañia" )
                .Label( "Centro de acopio:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.StoringCenterId )%>
        </p>
        <p>
            <%=  this.Select( PageModel => PageModel.RouteId  )
                .Options( Model.RouteList )
                .Selected( Model.RouteId )
                .FirstOption( "Seleccione una compañia" )
                .Label( "Ruta:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.RouteId )%>
        </p>
    </fieldset>
    <fieldset>
        <legend>Terminal</legend>
        <p>
            <%= this.Select( PageModel => PageModel.TerminalModelId )
                .Options( Model.TerminalModelList )
                                .Selected( Model.TerminalModelId)
                .Label( "Modelo:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.TerminalModelId )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.TerminalId ).Label( "Terminal ID:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.TerminalId )%>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.Serial ).Label( "Serial:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Serial )%>
        </p>
        <p>
            <%= this.Select( PageModel => PageModel.Status )
                .Options( Model.StatusList )
                .Selected( Model.Status )
                .Label( "Estado:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Status )%>
        </p>
    </fieldset>
    <fieldset>
        <legend>Usuario</legend>
        <p>
            <%= this.TextBox( PageModel => PageModel.Username ).Label( "Usuario:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Username )%>
        </p>
        <p>
            <%= this.Password( PageModel => PageModel.Password ).Label( "Contraseña:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.Password )%>
        </p>
        <p>
            <%= this.Password( PageModel => PageModel.ConfirmPassword ).Label( "Confirmar contraseña:" )%>
            <%= this.ValidationMessage( PageModel => PageModel.ConfirmPassword )%>
        </p>
    </fieldset>
    <p>
        <input type="submit" value="Registrar" />
    </p>
    <% } %>
</asp:Content>
