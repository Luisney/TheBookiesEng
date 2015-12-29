<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AccountViewModel>" %>

<%@ Import Namespace="Gambling.ViewModels" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Users - User Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        User Detailes
    </h2>
    <fieldset>
        <p>
            <label>
                User:</label>
            <%= Html.Encode(Model.UserName) %>
        </p>
        <p>
            <label>
                <%= Html.Encode( "Date created: " ) %></label>
            <%= Html.Encode(Model.CreationDate) %>
        </p>
        <p>
            <label>
                Email:</label>
            <%= Html.Encode( Model.Email ) %>
        </p>
        <p>
            <label>
                Last activity:</label>
            <%= Html.Encode( Model.LastActivityDate ) %>
        </p>
        <p>
            <label>
                Last login:</label>
            <%= Html.Encode( Model.LastLoginDate ) %>
        </p>
        <p>
            <label>
                <%= Html.Encode("Is Online: ")%></label>
            <%= string.Format("<img src='{0}' />", Model.IsOnline? "/Content/images/true.png": "/Content/images/false.png" ) %>
        </p>
        <p>
            <label>
                <%= Html.Encode("Roles: ")%></label>
                
                <%if( Model.SelectedRoles.Count() > 0 )
                    foreach( String CurrentRole in Model.SelectedRoles )
                  {%>
                    <br/>  <%= CurrentRole  %>
                <%}else
                { %>
                    None
                <%} %>
        </p>
    </fieldset>
    <br />
    <br />
    <fieldset>
    <legend>Offline login code</legend>

    <p>
    <input type="button" value="Generate offline login code" onclick="generar()" />
    </p>
<br />
<p id="generatedCode"></p>
    </fieldset>

    <p>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </p>

         <div id="generateCodeDialog" title="Generate offline login code">
        <p id="generateCodeDialogMessage">
        </p>
        <br />
        <form onsubmit="return false">
        <fieldset>
            <p>
                <label>
                    Admin User:</label>
                <input id="adminUser" name="adminUser" type="text" value="" />
            </p>
            <p>
                <label>
                    Authorization Password:</label>
                <input id="authPassword" name="authPassword" type="password" value="" />
            </p>
        </fieldset> 
        </form>
    </div>

        <script type="text/javascript">

            function generar() {
                $('#generateCodeDialog').dialog('open');
                $('#generateCodeDialogMessage').text('Desea generar un Código Login Fuera de Línea para este usuario ?');

            }
            $('#generateCodeDialog').dialog({
                bgiframe: true,
                modal: true,
                autoOpen: false,
                width: 400,
                buttons: {
                    "Generar": function () {
                        $.getJSON("/Account/CLFL",
						{
						    userName: "<%=Model.UserName %>",
						    adminUser: $('#generateCodeDialog input[name=adminUser]').val(),
						    authPassword: $('#generateCodeDialog input[name=authPassword]').val()
						},
						function (data) {
						    if (data == null) {
						        alert("Error inesperado.");
						        return;
						    }
						    var datos = data.split(",");
						    if (datos[0] != "OK") {
						        alert(data);
						        return;
						    }
						    $("#generatedCode").html("El código generado es: " + datos[1]);


						    $('#generateCodeDialog').dialog('close');
						    // Info message
						    //$('#infoDialog').dialog('open');
						    //$('#infoDialogMessage').text(data);
						});
                    },
                    "Cancelar": function () {
                        $("#generateCodeDialog").dialog('close');
                    }
                }
            });


    </script>
</asp:Content>
