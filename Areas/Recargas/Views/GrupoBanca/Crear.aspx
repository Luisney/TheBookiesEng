<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<RechargeBanSportBookGroup>" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#StoringCenterId").change(function () {
                $.getJSON('<%= Url.Action("GetSportBooksByStoringCenter", "GrupoBanca") %>/' + $("#StoringCenterId").val(), function (data) {
                    var items = [];
                    $("#spGroup1").css("display", "none");
                    $("#SportBooks1").html('');

                    $("#spGroup2").css("display", "none");
                    $("#SportBooks2").html('');

                    var show = 0;
                    $.each(data, function (key, val) {
                        if (val.group == 0) {
                            items.push('<label><input type="checkbox" value="' + val.value + '" name="sportbooks">' + val.label + '</label>');
                            show = 1;
                        }
                    });
                    if (show == 1) {
                        $("#SportBooks1").html(items.join(''));
                        $("#spGroup1").css("display", "block");
                    }

                    items = [];
                    show = 0;
                    $.each(data, function (key, val) {
                        if (val.group != 0) {
                            items.push('<label title="' + val.group + '"><input type="checkbox" value="' + val.value + '" name="sportbooks" disabled>' + val.label + '</label>');
                            show = 1;
                        }
                    });
                    if (show == 1) {
                        $("#SportBooks2").html(items.join(''));
                        $("#spGroup2").css("display", "block");
                    }


                });
            });
        });
    </script>
    <style type="text/css">
    #Name { width: 300px; }
    label { text-align: left ! important; width: 220px ! important}
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Crear Grupo de Bancas")%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Crear Grupo de Bancas" )%>
    </h2>
    <form id="frm" action="/Recargas/GrupoBanca/Crear" onsubmit="return postData()" method="post">
    <fieldset>
        <table>
        <tr>
        <td>Nombre: </td>
        <td><%= this.TextBox( model => model.Name )%>
       <%= this.ValidationMessage(model => model.Name) %>
        </td>
        
        </tr>
        <tr>
        <td>
        Centro de acopio:
        </td>
        <td>
               <%= this.Select("StoringCenterId")
                    .Options( ( SelectList ) ViewData [ "StoringCenterId" ] )
                    .Selected( ( ( SelectList ) ViewData [ "StoringCenterId" ] ).SelectedValue)
                    .FirstOption( "null", "-Seleccione uno-" )%>
            <%= this.ValidationMessage( model => model.StoringCenterId )%>
        </td>
 
        </tr>
        </table>
        
        <fieldset id="spGroup1" style="display:none; margin-top:10px; " >
            <legend>Bancas fuera de grupo</legend>
        <div id="SportBooks1"></div>
        <br />
        </fieldset>

        <fieldset id="spGroup2" style="display:none; margin-top:10px; " >
            <legend>Bancas en grupo</legend>
        <div id="SportBooks2"></div>
        <br />
        </fieldset>

    </fieldset>

    <br />
    <table style="width: 590px; padding-bottom: 15px">
        <tr>
            <td>
                <input id="acceptTransfer" type="checkbox" onclick="if(this.checked) valFrm()" /><label
                    for="acceptTransfer">He revisado los datos</label>
            </td>
            <td class="comision">
                <input id="btnSubmit" type="submit" value="Crear" disabled="disabled" />
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
        #Profile
        {
            width: 470px;
        }
    </style>
    <script type="text/javascript">

        function valFrm() {
            $("#btnSubmit").attr('disabled', 'disabled');

            if (jQuery.trim($("#Name").val()) == "") {
                alert("Debe especificar el nombre.");
                $("#Name").focus();
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
                url: "/Recargas/GrupoBanca/Crear",
                data: elements,
                dataType: "text",
                success: function (msg) {
                    if (msg == 'OK')
                        document.location.href = '/Recargas/GrupoBanca';
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
