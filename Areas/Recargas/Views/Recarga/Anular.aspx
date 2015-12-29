<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Crear Perfil Comisión de Recarga")%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Anular Recarga" )%>
    </h2>
    <form onsubmit="return false">
    <label>
        Introduzca el No. de la Recarga</label><br />
    <input id="RechargeId" name="RechargeId" type="text" style="width: 300px; margin-bottom: 5px" maxlength="10" />
    <br />
    <input id="VerificarButton" type="submit" value="Verificar" onclick="verificar()" />
    <br />
    <br />
    <div>
        <div style="float: left; width: 240px">
            <table class="table" style="width: 230px">
                <tr>
                    <td>
                        Teléfono:
                    </td>
                    <td>
                        <div id="PhoneNumber" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Telefónica:
                    </td>
                    <td>
                        <div id="Product" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Monto $:
                    </td>
                    <td>
                        <div id="Amount" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Fecha:
                    </td>
                    <td>
                        <div id="Date" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Creado por:
                    </td>
                    <td>
                        <div id="CreatedBy" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Estatus:
                    </td>
                    <td>
                        <div id="Status" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="float: left">
            <input id="AnularButton" type="button" value="Anular" onclick="anular()" disabled="disabled"/>
        </div>
        <div style="clear: both">
        </div>
    </div>
    <br />
    </form>

     <div id="deleteResultDialog" title="Eliminar Recarga">
        <p id="deleteResultDialogMessage">
        </p>
        <br />
        <form onsubmit="return false">
        <fieldset>
            <p>
                <label>
                    Usuario Administrativo:</label>
                <input id="adminUser" name="adminUser" type="text" value="" />
            </p>
            <p>
                <label>
                    Contraseña de autorización:</label>
                <input id="authPassword" name="authPassword" type="password" value="" />
            </p>
        </fieldset> 
        <input id="resultToDeleteId" type="hidden" />
        </form>
    </div>
   

    <script type="text/javascript">

        function anular() {
            $('#deleteResultDialog').dialog('open');
            $('#deleteResultDialogMessage').text('Desea eliminar esta Recarga?');
            $('#resultToDeleteId').val($("#RechargeId").val());
        }
        $('#deleteResultDialog').dialog({
            bgiframe: true,
            modal: true,
            autoOpen: false,
            width: 400,
            buttons: {
                "Eliminar": function () {
                    $.getJSON("/Recargas/Recarga/AnularRecarga",
						{
						    id: $('#resultToDeleteId').val(),
						    adminUser: $('#deleteResultDialog input[name=adminUser]').val(),
						    authPassword: $('#deleteResultDialog input[name=authPassword]').val()
						},
						function (data) {
						    alert(data);
						    $('#deleteResultDialog').dialog('close');
						    // Info message
						    //$('#infoDialog').dialog('open');
						    //$('#infoDialogMessage').text(data);
						    $('#VerificarButton').click();
						});
                },
                "Cancelar": function () {
                    $("#deleteResultDialog").dialog('close');
                }
            }
        });


        function verificar() {
            var rid = jQuery.trim($("#RechargeId").val());

            if (rid == "" || isNaN(rid)) {
                alert("Especifique un número válido.");
                return false;
            }

            blockScreen();
            $("#AnularButton").attr("disabled", "disabled");

            $.ajax({
                type: "GET",
                url: "/Recargas/Recarga/GetRecarga/" + $("#RechargeId").val() + "?r=" + randomString(),
                dataType: "text",
                success: function (msg) {
                    var obj = jQuery.parseJSON(msg);
                    if (obj == null) {
                        alert("Servicio no disponible")
                        return;
                    }
                    else if (obj.Result == 0) {
                        $("#PhoneNumber").text(obj.PhoneNumber);
                        $("#Amount").text(obj.Amount);
                        $("#Date").text(obj.Date + ' ' + obj.Time);
                        $("#CreatedBy").text(obj.CreatedBy);
                        $("#Product").text(obj.Product);

                        if (obj.Status == "1") {
                            $("#AnularButton").removeAttr("disabled");
                            $("#Status").text("Activa");
                        }
                        else
                            $("#Status").text("Anulado");

                    }
                    else if (obj.Result == 1) {
                        $("#PhoneNumber").text("");
                        $("#Amount").text("");
                        $("#Date").text("");
                        $("#CreatedBy").text("");
                        $("#Product").text("");
                        $("#Status").text("");

                        alert("La recarga no existe.");
                    }
                    unBlockScreen();
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(xhr.responseText);
                    unBlockScreen();
                }
            });

            return false;

        }
        function chkfld(fld) {
            fld.value = stripNumber(fld.value);
            if (toFloat(fld.value) >= 100)
                fld.value = 0;
        }

        function randomString() {
            var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
            var string_length = 8;
            var randomstring = '';
            for (var i = 0; i < string_length; i++) {
                var rnum = Math.floor(Math.random() * chars.length);
                randomstring += chars.substring(rnum, rnum + 1);
            }
            return randomstring;
        }

    </script>
</asp:Content>
