<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<IEnumerable<RechargeCommissionProfileDetailValue>>" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <link href="/Content/css/jquery.tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $("#tabs").tabs();
        });
    </script>
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
        label
        {
            line-height: 25px;
            width: 310px !important;
            float: left;
        }
        
        legend
        {
            font-weight: bold;
            margin-bottom: 3px;
        }
    </style>
    <script type="text/javascript">

        function valFrm() {
            //$("#btnSubmit").attr('disabled', 'disabled');

            //$("#btnSubmit").removeAttr('disabled');
            return true;
        }

        function postData(frm) {
            if (!valFrm())
                return false;

            var elements = $(frm).serialize();
            blockScreen();

            $.ajax({
                type: "POST",
                url: frm.action,
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
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Asignar Perfil Comisión de Recargas ID " + ViewData["Id"].ToString() )%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% int id = (int)ViewData["id"]; %>
    <h2>
        <%= Html.Encode("Asignar Perfil Comisión de Recargas " + ViewData["Id"].ToString())%>
    </h2>
    <form action="/Recargas/Comision/Asignar/<%=id %>" onsubmit="return postData(this)"
    method="post">
    <div id="tabs">
        <ul>
            <li><a href="#tabs-1">Usuarios</a></li>
            <li><a href="#tabs-2">Terminales</a></li>
            <li><a href="#tabs-3">Bancas</a></li>
            <li><a href="#tabs-4">Centros de Acopio</a></li>
        </ul>
        <div id="tabs-1">
            <p>
                <b>Seleccione los usuarios</b>:</p>
            <div>
                <%                     
                    var users = Model.Where(x => x.Type == "U" && x.ProfileId == id).ToList();
                    if (users.Count > 0)
                    {
                        foreach (RechargeCommissionProfileDetailValue val in users)
                        {
                %>
                <label>
                    <input name="user" type="checkbox" <%=val.ProfileId == null ? "" : "checked" %> value="<%=val.Id %>" />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                    users = Model.Where(x => x.Type == "U" && x.ProfileId == null).ToList();
                    if (users.Count > 0)
                    {
                        foreach (RechargeCommissionProfileDetailValue val in users)
                        {      
                %>
                <label>
                    <input name="user" type="checkbox" value="<%=val.Id %>" />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                %>
                <div style="clear: both">
                </div>
            </div>
            <div>
                <%
                    users = Model.Where(x => x.Type == "U" && x.ProfileId != null && x.ProfileId != id).ToList();
                    if (users.Count > 0)
                    {
                %>
                <br />
                <p>
                    <b>Usuarios asignados a otro perfil</b>:</p>
                <% 
                        foreach (RechargeCommissionProfileDetailValue val in users)
                        {      
                %>
                <label class="col">
                    <input name="user" type="checkbox" value="<%=val.Id %>" />
                    <%=String.Format("{0} <i>({1} - {2})</i>",val.Name, val.ProfileId, val.ProfileName)%>
                </label>
                <%
                        }
                    }                               
                %>
                <br />
                <br />
                <div style="clear: both">
                </div>
            </div>
            <br />
            <br />
        </div>
        <div id="tabs-2">
            <div>
                <p>
                    <b>Selección de terminales</b>:</p>
                <% 
                    var terminals = Model.Where(x => x.Type == "T" && x.ProfileId == id).ToList();
                    if (terminals.Count > 0)
                    {
                        foreach (RechargeCommissionProfileDetailValue val in terminals)
                        {      
                %>
                <label>
                    <input name="terminal" type="checkbox" value="<%=val.Id %>" <%=val.ProfileId == null ? "" : "checked" %> />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                    terminals = Model.Where(x => x.Type == "T" && x.ProfileId == null).ToList();
                    if (terminals.Count > 0)
                    {
                        foreach (RechargeCommissionProfileDetailValue val in terminals)
                        {      
                %>
                <label>
                    <input name="terminal" type="checkbox" value="<%=val.Id %>" />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                    terminals = Model.Where(x => x.Type == "T" && x.ProfileId != null && x.ProfileId != id).ToList();
                    if (terminals.Count > 0)
                    {
                %>
            </div>
            <br />
            <div style="clear: both">
            </div>
            <div>
                <br />
                <p>
                    <b>Terminales asignadas a otro perfil</b>:</p>
                <% 
                        foreach (RechargeCommissionProfileDetailValue val in terminals)
                        {      
                %>
                <label>
                    <input name="terminal" type="checkbox" value="<%=val.Id %>" />
                    <%=String.Format("{0} <i>({1} - {2})</i>",val.Name, val.ProfileId, val.ProfileName)%>
                </label>
                <%
                        }
                    }                               
                %>
                <div style="clear: both">
                </div>
            </div>
            <br />
            <br />
        </div>
        <div id="tabs-3">
            <div>                <p>
                    <b>Seleccione las bancas:</b></p>
                <% 
                    var bancas = Model.Where(x => x.Type == "B" && x.ProfileId == id).ToList();
                    if (bancas.Count > 0)
                    {
                        foreach (RechargeCommissionProfileDetailValue val in bancas)
                        {      
                %>
                <label>
                    <input name="banca" type="checkbox" <%=val.ProfileId == null ? "" : "checked" %>
                        value="<%=val.Id %>" />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                    bancas = Model.Where(x => x.Type == "B" && x.ProfileId == null).ToList();
                    if (bancas.Count > 0)
                    {

                        foreach (RechargeCommissionProfileDetailValue val in bancas)
                        {      
                %>
                <label>
                    <input name="banca" type="checkbox" value="<%=val.Id %>" />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                %>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <br />
                <%
                    bancas = Model.Where(x => x.Type == "T" && x.ProfileId != null && x.ProfileId != id).ToList();
                    if (bancas.Count > 0)
                    {
                        
                %>
                <br />
                <p>
                    <b>Bancas asignadas a otro perfil</b>:</p>
                <%                         
                        foreach (RechargeCommissionProfileDetailValue val in bancas)
                        {      
                %>

                <label>
                    <input name="banca" type="checkbox" value="<%=val.Id %>" />
                    <%=String.Format("{0} <i>({1} - {2})</i>",val.Name, val.ProfileId, val.ProfileName)%>
                </label>
                <%
                        }

                    }                               
                %>
                <div style="clear: both;">
                </div>
            </div>
            <br />
            <br />
        </div>
        <div id="tabs-4">
            <div>
                <p>
                    <b>Seleccione los centros de acopio:</b></p>
                <% 
                    var centros = Model.Where(x => x.Type == "C" && x.ProfileId == id).ToList();
                    if (centros.Count > 0)
                    {
                        foreach (RechargeCommissionProfileDetailValue val in centros)
                        {      
                %>
                <label>
                    <input name="centro" type="checkbox" value="<%=val.Id %>" <%=val.ProfileId == null ? "" : "checked" %> />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                    centros = Model.Where(x => x.Type == "C" && x.ProfileId == null).ToList();
                    if (centros.Count > 0)
                    {

                        foreach (RechargeCommissionProfileDetailValue val in centros)
                        {      
                %>
                <label>
                    <input name="centro" type="checkbox" value="<%=val.Id %>" />
                    <%=val.Name%>
                </label>
                <%
                        }
                    }
                %>
                <div style="clear: both">
                </div>
            </div>
            <div>
                <br />
                <%
                    centros = Model.Where(x => x.Type == "C" && x.ProfileId != null && x.ProfileId != id).ToList();
                    if (centros.Count > 0)
                    {
                %>
                <br />
                <p>
                    <b>Centros de acopio asignados a otro perfil</b></p>
                <%                         
                        foreach (RechargeCommissionProfileDetailValue val in centros)
                        {      
                %>
                <label>
                    <input name="centro" type="checkbox" value="<%=val.Id %>" />
                    <%=String.Format("{0} <i>({1} - {2})</i>",val.Name, val.ProfileId, val.ProfileName)%>
                </label>
                <%
                        }
                    }                               
                %>
                <div style="clear: both">
                </div>
            </div>
            <br />
            <br />
        </div>
    </div>
    <br />
    <p>
        <input type="submit" value="Enviar" /></p>
    </form>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
