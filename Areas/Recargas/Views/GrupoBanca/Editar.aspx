<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<RechargeBanSportBookGroup>" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
    <style type="text/css">
    #Name { width: 300px; }
    label { text-align: left ! important; width: 220px ! important; display:block;}
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Detalles Grupo de Bancas")%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Detalles Grupo de Bancas" )%>
    </h2>

    <fieldset>
        <table>
        <tr>
        <td><b>ID: </b></td>
        <td>
     <%= Model.Id %>
        </td>
        
        </tr>
        <tr>
        <td><b>Nombre: </b></td>
        <td>
     <%= Model.Name %>
        </td>
        
        </tr>
        <tr>
        <td>
        <b>Centro de acopio:</b>
        </td>
        <td><%=ViewData["StoringCenterName"].ToString()%>
        </td>
 
        </tr>
        </table>
        
        <fieldset id="spGroup" style="margin-top:10px; " >
            <legend>Bancas</legend>
        <div id="SportBooks">
        <% var items = (List<SelectListItem>)ViewData["SportBooks"];
           foreach (SelectListItem item in items)
           {   
        %>
            <label><input type="checkbox" value="<%=item.Value %>" name="sportbooks" <%=item.Selected ? "checked" : "" %> disabled><%= item.Text %></label>
        <% } %>
        </div>
        <br />
        </fieldset>

    </fieldset>

    <br />

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
    
</asp:Content>
