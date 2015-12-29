<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<RechargeCommissionProfile>" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Editar Perfil Comisión de Recarga")%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Editar Perfil Comisión de Recarga " )%> <%=Model.Id %>
    </h2>
    <form id="frm" action="/Recargas/Comision/Editar" onsubmit="return postData()" method="post">
    <fieldset>
        <table>
            <tr>
                <td style="padding: 5px">
                    Nombre:
                </td>
                <td style="padding: 5px">
                    <%= this.TextBox( model => model.Profile )%>&nbsp;
                </td>
            </tr>
        </table>
    </fieldset>
    <table class="table">
        <thead>
            <tr>
                <th>
                    Producto
                </th>
                <th>
                    Usuario
                </th>
                <th>
                    Terminal
                </th>
                <th>
                    Banca
                </th>
                <th>
                    Centro de Acopio
                </th>
                <th>
                    Sobre Utilidad
                </th>
            </tr>
        </thead>            
        <tbody>
        <% 
            int r = 0;
            foreach (RechargeCommissionProfileDetail detail in Model.RechargeCommissionProfileDetails)
            { 
               %>
        <tr>
           <td>
                    <%=detail.RechargeProduct.Name %><input type="hidden" name="Comisiones[<%=r%>].Id" value="<%=detail.RechargeProduct.ProductId %>" />
                </td>
                <td class="comision">
                    <input id="User<%=r%>" name="Comisiones[<%=r%>].User" type="text" maxlength="5" onblur="chkfld(this)" value="<%=detail.CommisUser%>"/>
                </td>
                <td class="comision">
                    <input id="Terminal<%=r%>" name="Comisiones[<%=r%>].Terminal" type="text" maxlength="5" onblur="chkfld(this)"  value="<%=detail.CommisTerminal%>"/>
                </td>
                <td class="comision">
                    <input id="Banca<%=r%>" name="Comisiones[<%=r%>].Banca" type="text" maxlength="5" onblur="chkfld(this)" value="<%=detail.CommisSportBook%>"/>
                </td>
                <td class="comision">
                    <input id="Centro<%=r%>" name="Comisiones[<%=r%>].Centro" type="text" maxlength="5" onblur="chkfld(this)" value="<%=detail.CommisStoringCenter%>"/>
                </td>
                <td class="comision">
                    <input id="Utilida<%=r%>" name="Comisiones[<%=r%>].Utilidad" type="text" maxlength="5" onblur="chkfld(this)" value="<%=detail.CommisStoringCenter%>"/>
                </td>
        </tr>
        <% 
                r++;
            } %>
        </tbody>
    </table>
    <br />
    <table style="width: 590px; padding-bottom: 15px">
        <tr>
            <td>
                <input id="acceptTransfer" type="checkbox" onclick="valFrm(this)"/><label for="acceptTransfer">He
                    revisado los datos</label>
            </td>
            <td class="comision">
                <input id="btnSubmit" type="submit" value="Guardar" disabled="disabled" />
            </td>
        </tr>
    </table>
    <br />
    <br />
 </form>
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
    <style type="text/css">
        .comision
        {
            width: 90px;
        }
        .comision input[type=text]
        {
            width: 75px;
            text-align: right;
        }
        #Profile { width:470px; }
    </style>
    <script type="text/javascript">

        function valFrm(obj) {
            if (obj != null && !obj.checked) {
                $("#btnSubmit").attr('disabled', 'disabled');
                return;
            }

            $("#btnSubmit").attr('disabled', 'disabled');
            if (jQuery.trim($("#Profile").val()) == "") {
                alert("Debe especificar el nombre.");
                $("#Profile").focus();
                 $("#acceptTransfer").attr('checked', false);
                return false;
            }

            
            $("#btnSubmit").removeAttr('disabled');
            return true;
        }

        function postData() {
            if (!valFrm())
                return false;

            var elements = $("#frm").serialize();
            blockScreen();

            $.ajax({
                type: "POST",
                url: "/Recargas/Comision/Editar/<%=Model.Id %>",
                data: elements,
                dataType: "text",
                success: function (msg) {
                    if (msg == 'OK')
                        document.location.href = '/Recargas/Comision';
                    else {
                        alert(msg);
                        unBlockScreen();
                    }
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
    </script>
</asp:Content>
