<%@ Page Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.ViewModels.AccountViewModel>"
    Language="C#" MasterPageFile="../Shared/Site.Master" %>
<%@ Import Namespace="Gambling.Models" %>

<asp:Content ContentPlaceHolderID="Assets" ID="Content3" runat="server">
    <% HtmlNamePrefix = "AccountViewModel"; %>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>
    <script src="../../Content/js/jquery.cascade-select.0.8.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ControllerActions = {
            ResetPassword: '<%= Url.Action("ResetPassword") %>/',
            ChangeUserPassword: '<%= Url.Action("ChangeUserPassword") %>/'
        };

        $(function () {
            $('#tabs').tabs();

            $('#resetPasswordLoader').hide();
            $('#generatedPasswordLabel').hide();
            $('#generatedPasswordText').hide();

            $('#resetPasswordLink').click(
                function () {
                    $('#resetPasswordLink').hide();
                    $('#resetPasswordLoader').fadeIn();
                    $.post(
                        ControllerActions.ResetPassword,
                        {
                            Username: $('#usernameLabel').text()
                        },
                        function (data) {
                            $('#resetPasswordLink').fadeOut();
                            $('#resetPasswordLoader').fadeOut();
                            $('#generatedPasswordLabel').fadeIn();
                            $('#generatedPasswordText').fadeIn();
                            $('#generatedPasswordText').text(data);
                        },
                        "json");
                }
            );

            // Show change password window
            $('#changePasswordLink').click(function () {
                $("#changePassword-dialog").dialog('open');
            });

            $('#AccountViewModel_CompanyId').change(function () {
                // Deselect if 'none'
                if ($(this).val() == '0') {
                    $('#AccountViewModel_StoringCenterId').empty();
                    $('#AccountViewModel_StoringCenterId').append('<option value="0">Todos</option>');
                    $('#AccountViewModel_SportBookId').empty();
                    $('#AccountViewModel_SportBookId').append('<option value="0">Todas</option>');
                    $('#AccountViewModel_TerminalId').empty();
                    $('#AccountViewModel_TerminalId').append('<option value="0">Todas</option>');

                    return;
                }

                $('#AccountViewModel_StoringCenterId').empty();
                $('#AccountViewModel_StoringCenterId').append('<option value="0">Cargando...</option>');
                $('#AccountViewModel_SportBookId').empty();
                $('#AccountViewModel_SportBookId').append('<option value="0">Todas</option>');
                $('#AccountViewModel_TerminalId').empty();
                $('#AccountViewModel_TerminalId').append('<option value="0">Todas</option>');

                $.getJSON('<%=Url.Action("FilterByCompany", "StoringCenter", new { @area = "root" }, null)%>',
                    { selected: $('#AccountViewModel_CompanyId').val() },
                    function (data) {
                        $('#AccountViewModel_StoringCenterId').empty();
                        $('#AccountViewModel_StoringCenterId').append('<option value="0">Todos</option>');
                        if (data.length > 0) {
                            $.each(data, function (i, item) {
                                $('#AccountViewModel_StoringCenterId').append('<option value="' + item.value + '">' + item.label + '</option>');
                            });
                        }
                    }
                );
            });

            $('#AccountViewModel_StoringCenterId').change(function () {
                // Deselect if 'none'
                if ($(this).val() == '0') {
                    $('#AccountViewModel_SportBookId').empty();
                    $('#AccountViewModel_SportBookId').append('<option value="0">Todas</option>');
                    $('#AccountViewModel_TerminalId').empty();
                    $('#AccountViewModel_TerminalId').append('<option value="0">Todas</option>');

                    return;
                }

                $('#AccountViewModel_SportBookId').empty();
                $('#AccountViewModel_SportBookId').append('<option value="0">Cargando...</option>');
                $('#AccountViewModel_TerminalId').empty();
                $('#AccountViewModel_TerminalId').append('<option value="0">Todas</option>');

                $.getJSON('<%=Url.Action("GetSportBooksByStoringCenter", "SportBook", new { @area = "root" }, null)%>',
                    { StoringCenterId: $('#AccountViewModel_StoringCenterId').val() },
                    function (data) {
                        $('#AccountViewModel_SportBookId').empty();
                        $('#AccountViewModel_SportBookId').append('<option value="0">Todas</option>');
                        if (data.length > 0) {
                            $.each(data, function (i, item) {
                                $('#AccountViewModel_SportBookId').append('<option value="' + item.value + '">' + item.label + '</option>');
                            });
                        }
                    }
                );
            });

            $('#AccountViewModel_SportBookId').change(function () {
                // Deselect if 'none'
                if ($(this).val() == '0') {
                    $('#AccountViewModel_TerminalId').empty();
                    $('#AccountViewModel_TerminalId').append('<option value="0">Todas</option>');

                    return;
                }
                $('#AccountViewModel_TerminalId').empty();
                $('#AccountViewModel_TerminalId').append('<option value="0">Cargando...</option>');

                $.getJSON(
                    '<%=Url.Action("GetTerminalsBySportBook", "Terminal", new { @area = "root" }, null)%>',
                    { SportBookId: $('#AccountViewModel_SportBookId').val() },
                    function (data) {
                        $('#AccountViewModel_TerminalId').empty();
                        $('#AccountViewModel_TerminalId').append('<option value="0">Todas</option>');
                        if (data.length > 0) {
                            $.each(data, function (i, item) {
                                $('#AccountViewModel_TerminalId').append('<option value="' + item.value + '">' + item.label + '</option>');
                            });
                        }
                    }
                );
            });

            // Copy bet template - dialog
            $("#changePassword-dialog").dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 420,
                buttons: {
                    "Cerrar": function () {
                        $("#changePassword-dialog").dialog('close');
                        ClearPasswordDialogFields();
                    },
                    "Cambiar contraseña": changePasswordAction
                }
            });
            ChangePasswordDialog_DisplayStandBy();
        });

        changePasswordAction = function () {
            validateChangePasswordFields();

            ChangePasswordDialog_DisplayBusy();

            $.post(ControllerActions.ChangeUserPassword,
                {
                    UserName: $('#<%= this.IdFor( U => U.UserName ) %>').val(),
                    NewPassword: $('#newPassword').val(),
                    ConfirmPassword: $('#confirmPassword').val()
                },
                function (data) {
                    ChangePasswordDialog_DisplayStandBy();

                    // Show message dialog
                    $('#changePassword-dialog span[name="message"]').html(data.Message);
                },
                "json");
        }

        ChangePasswordDialog_DisplayStandBy = function () {
            $("#changePassword-dialog div[name='loading']").hide();
            $("#changePassword-dialog div[name='content']").show();
        }

        ChangePasswordDialog_DisplayBusy = function () {
            $("#changePassword-dialog div[name='loading']").show();
            $("#changePassword-dialog div[name='content']").hide();
        }

        ClearPasswordDialogFields = function () {
            $('#newPassword').val('');
            $('#confirmPassword').val('');
            $('#changePassword-dialog span[name="message"]').html('');
        }

        validateChangePasswordFields = function () {
            if (!($('#newPassword').val() > 0 &&
                $('#confirmPassword').val() > 0))
                return false;
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Usuarios - Editar Usuario
</asp:Content>
<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editar Usuario
    </h2>
    <%= Html.ValidationSummary("Edición fallida, por favor corrije lo errores y vuelve a intentar.") %>
    <% using( Html.BeginForm( ) )
       { %>
    <div id="tabs">
        <ul>
            <li><a href="#user-data">Datos</a></li>
            <li><a href="#user-retentions">Retenciones</a></li>
            <li><a href="#user-storingcenters">Centros de Acopio</a></li>
        </ul>
        <div id="user-data">
        <fieldset>
            <legend>
                <%= Html.Encode("Account information") %></legend>
            <%= this.Hidden( U => U.Id ) %>
            <%= this.Hidden( U => U.Status ) %>
            <p>
            </p>
            <p>
                <label for="roles">
                    User:
                </label>
                <span id="usernameLabel">
                    <%= Model.UserName %></span>
                <%= this.Hidden( U => U.UserName ) %>
            </p>
            <p>
                <label for="password">
                    Password:
                </label>
                <a id="resetPasswordLink"><span>[Generar nueva contraseña]</span></a>
                <img id="resetPasswordLoader" src="/Content/images/ajax-loader-small.gif" alt="Waiting ..." />
                <span id="generatedPasswordLabel">New Password: </span><span id="generatedPasswordText">
                </span><a id="changePasswordLink"><span>[Change Password]</span></a>
            </p>
            <p>
                <%= this.CheckBox( U => U.ForceOTP ).Label("Use token generator:") %>
                <%= this.ValidationMessage( U => U.ForceOTP )%>
            </p>
            <p>
                <%= this.TextBox( U => U.Email ).Label( "Email:" )%>
                <%= this.ValidationMessage( U => U.Email )%>
            </p>
            <p>
                <%= this.TextBox( U => U.Name ).Disabled(true).Label( "Name:" )%>
                <%= this.Hidden( U => U.Name ) %>
                <%= this.ValidationMessage( U => U.Name )%>
            </p>
            <p>
                <%= this.CheckBox( U => U.ForeignSaler ).Label( "Foreign Saler:" )%>
                <%= this.ValidationMessage( U => U.ForeignSaler )%>
            </p>
            <p>
                <%= this.Select( U => U.CommissionProfileId ).Label( "Perfil de comisión:" ).Options( Model.CommissionProfileList ).FirstOption( "", "-Heredado-" )%>
                <%= this.ValidationMessage( U => U.CommissionProfileId )%>
            </p>
            <p>
                <%= this.Select( U => U.ValuePaymentProfileId ).Label( "Value to pay profile:" ).Options( Model.ValuePaymentProfileList ).FirstOption( "", "-Heredado-" )%>
                <%= this.ValidationMessage( U => U.ValuePaymentProfileId )%>
            </p>
            <p>
                <%= this.Select( U => U.LimitBetTypeProfileId ).Label( "Limit profile:" ).Options( Model.LimitBetTypeProfileList ).FirstOption( "", "-Heredado-" )%>
                <%= this.ValidationMessage( U => U.LimitBetTypeProfileId )%>
            </p>
            <p>
                <%= this.TextBox( U => U.MaximumSales ).Label( "Maximo de ventas deportivas:" ).Value( Model.MaximumSales.ToString( "F2" ) )%>
                <%= this.ValidationMessage( U => U.MaximumSales )%>
            </p>
            <p>
                <%= this.TextBox( U => U.LottoMaximum ).Label( "Maximo de ventas loteria:" ).Value( Model.LottoMaximum.ToString("F2") )%>
                <%= this.ValidationMessage( U => U.LottoMaximum )%>
            </p>
            <p>
                <%= this.TextBox( U => U.LottoHoldbackPercentage ).Label( "Porcentaje retenido para comisión de loterias:" )%>
                <%= this.ValidationMessage( U => U.LottoHoldbackPercentage )%>
            </p>
            <p>
                <%= this.Select( U => U.CompanyId ).Label( "Consorcio:" ).Options( Model.CompaniesList ).FirstOption( "0", "Todas")%>
                <%= this.ValidationMessage( U => U.CompanyId )%>
            </p>
            <p>
                <%= this.Select( U => U.StoringCenterId ).Label( "Centro de acopio:" ).Options( Model.StoringCenterList ).FirstOption( "0", "Todos" )%>
                <%= this.ValidationMessage( U => U.StoringCenterId )%>
            </p>
            <p>
                <%= this.Select( U => U.SportBookId ).Label( "Banca:" ).Options( Model.SportBooksList ).FirstOption( "0", "Todas" )%>
                <%= this.ValidationMessage( U => U.SportBookId )%>
            </p>
            <p>
                <%= this.Select( U => U.TerminalId ).Label( "Terminal:" ).Options( Model.TerminalsList ).FirstOption( "0", "Todas" )%>
                <%= this.ValidationMessage( U => U.TerminalId )%>
            </p>
            <label for="roles">
                Roles</label>
            <div class="rolesContainer">
                <% foreach( String CurrentRole in Model.AvalaibleRoles )
                   { %>
                <label style="text-align:left; width:200px"><input type="checkbox" <%= ( Model.SelectedRoles.Contains( CurrentRole ) )? "checked=\"checked\"" : "" %>
                    value="<%=CurrentRole%>" name="<%= ( this.HtmlNamePrefix != null )? this.HtmlNamePrefix + ".": ""  %>SelectedRoles">
                    <%= CurrentRole%>
                </input></label><br />
                <%} %>
                <%= Html.ValidationMessage("SelectedRoles") %>
            </div>
        </div>
        <div id="user-retentions">
            <fieldset>
                <legend>
                    <%= Html.Encode("Retention by bet type") %></legend>
                <%
                    var CurrentRetentionIndex = 0;
                    foreach( var Retention in Model.Retentions.OrderBy( Retention => Retention.BetTypeId ) )
                    {%>
            <p>
                    <label>
                        <%= Retention.BetTypeName %></label>
                    <%= Html.Hidden( string.Format( "AccountViewModel.Retentions[{0}].Id", CurrentRetentionIndex ),
                        Retention.Id )%>
                    <%= Html.Hidden( string.Format( "AccountViewModel.Retentions[{0}].BetTypeId", CurrentRetentionIndex ),
                        Retention.BetTypeId )%>
                    <%= Html.TextBox( string.Format( "AccountViewModel.Retentions[{0}].Percentage", CurrentRetentionIndex ),
                        Retention.Percentage.ToString( "F2" ),
                        new { @class = "short" } )%><%= Html.Encode("%") %>
            </p>
                <%      CurrentRetentionIndex++;
                    }%>
        </fieldset>
    </div>
            <div id="user-storingcenters">
            <fieldset>
                <legend>
                    <%= Html.Encode("Select the collection centers for query") %></legend>

                <% foreach( KeyValuePair<string, string> centro in Model.StoringCenterList )
                   { %>
                <label style="text-align:left; width:200px"><input type="checkbox" 
                    value="<%=centro.Key%>" name="<%= ( this.HtmlNamePrefix != null )? this.HtmlNamePrefix + ".": ""  %>StoringCenters">
                    <%= centro.Value %>
                </input></label><br />
                <%} %>
            </fieldset>
    </div>
    <br />
    <p>
        <input type="submit" value="Save" />
    </p>
    <br />
    <% } %>
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <div id="changePassword-dialog" title="Change password">
        <div name="content" align="center">
            <form>
            <fieldset>
                <p>
                    <label>
                        New password:</label>
                    <%= this.Password("newPassword") %>
                </p>
                <p>
                    <label>
                        Confirm Password:</label>
                    <%= this.Password( "confirmPassword" )%>
                </p>
                <p>
                    <span name="message"></span>
                </p>
            </fieldset>
            </form>
        </div>
        <div name="loading" align="center">
            <img src="/Content/images/ajax-loader-small.gif" alt="Waiting ..." />
        </div>
    </div>
</asp:Content>
