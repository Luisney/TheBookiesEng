<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TransferBalanceModel>" %>

<%@ Import Namespace="System.Security.Policy" %>
<%@ Import Namespace="Gambling.Areas.Recargas.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Recargas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% var partnershipBalance = Model.AvailableBalance; %>
    <h2>
        Transferir Balance a Grupo de Bancas
    </h2>
    <form id="frmTransf" action="/Recargas/Recarga/TransferirBalanceGrupoBanca" onsubmit="return postData()" method="post">
    <% if (ViewData["StoringCenterId"] != null)
       {%>
    <input type="hidden" name="code" value='<%=ViewData["StoringCenterId"].ToString() %>' />
    <% } %>
    <b>Balance en Centro de Acopio <%=ViewData["StoringCenterName"].ToString() %></b>
    <table class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Balance
                </th>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Tricom
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    Disponible
                </td>
                <td class="monto">
                    <%=partnershipBalance.ClaroBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=partnershipBalance.OrangeBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=partnershipBalance.VivaBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=partnershipBalance.TricomBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=(partnershipBalance.ClaroBalance + partnershipBalance.OrangeBalance + partnershipBalance.VivaBalance + partnershipBalance.TricomBalance).ToString("#,##0")%>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <br />
    <%
        int tableCount = 0;
        int rowCount = 0;
        var balances = Model.CurrentBalance.Where(x => x.HasBalance == true);
        foreach (RechargeBalanceRow balance in balances)
        {
            %>
    <b>Grupo de Bancas: 
        <%=balance.Name%></b>
    <table id="tbc<%=tableCount++ %>" class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Balance
                </th>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Tricom
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    Actual
                </td>
                <td class="monto">
                    <%=balance.Claro.ToString("#,##0") %>
                </td>
                <td class="monto">
                    <%=balance.Orange.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=balance.Viva.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=balance.Tricom.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=(balance.Claro + balance.Orange + balance.Viva + balance.Tricom).ToString("#,##0")  %>
                </td>
            </tr>
            <tr>
                <td>
                    Transferido
                    <input type="hidden" id="RecargaId<%=rowCount%>" name="Balances[<%=rowCount%>].RecargaId" value="<%=balance.Id %>"/>
                </td>
                <td class="monto">
                    
                    <input id="Claro<%=rowCount%>" name="Balances[<%=rowCount%>].Claro" type="text" 
                    <% if(Model.AvailableBalance.ClaroBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled" 
                         style="background-color: #cccccc"  
                       <% }%>
                    />
                </td>
                <td class="monto">
                    <input id="Orange<%=rowCount%>" name="Balances[<%=rowCount%>].Orange" type="text"                     
                    <% if(Model.AvailableBalance.OrangeBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled"
                         style="background-color: #cccccc"   
                       <% }%>
                    />
                </td>
                <td class="monto">
                    <input id="Viva<%=rowCount%>" name="Balances[<%=rowCount%>].Viva" type="text"
                    <% if(Model.AvailableBalance.VivaBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled"
                         style="background-color: #cccccc" 
                       <% }%>
                   
                    />
                </td>
                <td class="monto">
                    <input id="Tricom<%=rowCount %>" name="Balances[<%=rowCount%>].Tricom" type="text"
                    <% if(Model.AvailableBalance.TricomBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled"
                         style="background-color: #cccccc" 
                       <% }%>
                   
                    />
                </td>
                <td class="monto">
                </td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td>
                    Total
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
            </tr>
        </tfoot>
    </table>
    <br />
    <br />
    <% rowCount++;
        } %>
    <%

        balances = Model.CurrentBalance.Where(x => x.HasBalance == false);
        if (balances.Any())
        {
    %>
    <b>Bancas sin balance definido</b>
    <table id="tbcd" class="table" style="width: 500px">
        <thead>
            <tr>
                <th>
                    Balance
                </th>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Tricom
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead>
        <tbody>
            <% foreach (RechargeBalanceRow balance in balances)
               { %>
            <tr>
                <td>
                    <%=balance.Name %>
                    <input type="hidden" id="RecargaId<%=rowCount%>" name="Balances[<%=rowCount%>].RecargaId" value="<%=balance.Id %>"/>
                </td>
                <td class="monto">
                     
                    <input id="Claro<%=rowCount%>" name="Balances[<%=rowCount%>].Claro" type="text" 
                    <% if(Model.AvailableBalance.ClaroBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled" 
                         style="background-color: #cccccc"  
                       <% }%>
                    />
                </td>
                <td class="monto">
                    <input id="Orange<%=rowCount%>" name="Balances[<%=rowCount%>].Orange" type="text"                     
                    <% if(Model.AvailableBalance.OrangeBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled"
                         style="background-color: #cccccc"   
                       <% }%>
                    />
                </td>
                <td class="monto">
                    <input id="Viva<%=rowCount%>" name="Balances[<%=rowCount%>].Viva" type="text" 
                    <% if(Model.AvailableBalance.VivaBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled"
                         style="background-color: #cccccc" 
                       <% }%>
                   
                    />
                </td>
                <td class="monto">
                    <input id="Tricom<%=rowCount %>" name="Balances[<%=rowCount%>].Tricom" type="text" 
                    <% if(Model.AvailableBalance.TricomBalance > 0)
                       {%>
                    onblur="calc(this)" 
                    <% } else {%>
                         disabled="disabled"
                         style="background-color: #cccccc" 
                       <% }%>
                   
                    />
                </td>
                <td class="monto">
                </td>
            </tr>
            <%
                   rowCount++;
               } %>
        </tbody>
        <tfoot>
            <tr>
                <td>
                    Total
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
                <td class="monto">
                </td>
            </tr>
        </tfoot>
    </table>
    <%
        }
        
    %>
    <br />
    <b>Transferencia</b>
    <table class="table" style="width: 500px; margin-top: 10px; margin-bottom: 20px">
        <thead>
            <tr>
                <th>
                    Banca
                </th>
                <th>
                    Claro
                </th>
                <th>
                    Orange
                </th>
                <th>
                    Viva
                </th>
                <th>
                    Tricom
                </th>
                <th>
                    Total
                </th>
            </tr>
        </thead> 
        <tbody>
            <tr>
                <td>
                    Disponible en Centro de Acopio
                </td>
                <td class="monto">
                    <%=partnershipBalance.ClaroBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=partnershipBalance.OrangeBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=partnershipBalance.VivaBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=partnershipBalance.TricomBalance.ToString("#,##0")%>
                </td>
                <td class="monto">
                    <%=(partnershipBalance.ClaroBalance + partnershipBalance.OrangeBalance + partnershipBalance.VivaBalance).ToString("#,##0")%>
                </td>
            </tr>
            <tr>
                <td>
                    Transferido a Bancas 
                </td>
                <td id="tClaro" class="monto"> 
                </td>
                <td id="tOrange" class="monto"> 
                </td>
                <td id="tViva" class="monto"> 
                </td>
                <td id="tTricom" class="monto"> 
                </td>
                <td id="tTotal" class="monto"> 
                </td>
            </tr>
        </tbody>             
        <tfoot>             <tr>
                <td>
                    Disponible Después de Transferencia
                </td>
                <td id="dClaro" class="monto"> 
                </td>
                <td id="dOrange" class="monto"> 
                </td>
                <td id="dViva" class="monto"> 
                </td>
                <td id="dTricom" class="monto"> 
                </td>
                <td id="dTotal" class="monto"> 
                </td>
            </tr>
        </tfoot>
    </table>
    <div id="msgInvalidMonto" style="font-size: 12pt; color: red; display: none; padding: 15px;">
        <p>Los montos suministrados exceden el balance disponible.</p>
        <br/>
    </div>
    <table style="width: 500px; padding-bottom:15px">
        <tr>
            <td><input id="acceptTransfer" type="checkbox" onclick="calc()"/><label for="acceptTransfer">He revisado los datos</label></td>
            <td style="text-align: right"> <input id="btnTransf" type="submit" value="Transferir Balance" /></td>
        </tr>
    </table>
   </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <style type="text/css">
        .monto
        {
            text-align: right;
            width: 70px;
        }
        .monto input
        {
            text-align: right;
            width: 65px;
        }
        .table th
        {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        var balanceClaro  = <%=Model.AvailableBalance.ClaroBalance %>;
        var balanceOrange = <%=Model.AvailableBalance.OrangeBalance %>;
        var balanceViva = <%=Model.AvailableBalance.VivaBalance %>;
        var balanceTricom = <%=Model.AvailableBalance.TricomBalance %>;
        var balanceTotal = balanceClaro + balanceOrange + balanceViva + balanceTricom;
        var tbcCount = 0;
        var fdCount = 0;

        function calc(fld) {
            
            if(fld)
                fld.value = stripNumber(fld.value);

            var totalClaro = 0;
            var totalOrange = 0;
            var totalViva = 0; 
            var totalTricom = 0;           
            var x = 0;

            while($('#Claro' + x).length > 0) {
                var fldClaro = $("#Claro" + x);
                var fldOrange = $("#Orange" + x);
                var fldViva =  $("#Viva" + x);
                var fldTricom =  $("#Tricom" + x);
                
                totalClaro += toFloat(fldClaro.val());
                totalOrange += toFloat(fldOrange.val());
                totalViva += toFloat(fldViva.val());
                totalTricom += toFloat(fldTricom.val());

                x++;
                
            }
            var totalTransf = totalClaro + totalOrange + totalViva + totalTricom;
            $("#tClaro").text(formatNumber(-totalClaro));
            $("#tOrange").text(formatNumber(-totalOrange));
            $("#tViva").text(formatNumber(-totalViva));
            $("#tTricom").text(formatNumber(-totalTricom));
            $("#tTotal").text(formatNumber(-totalTransf));
            
            $("#dClaro").text(formatNumber(balanceClaro - totalClaro));
            $("#dOrange").text(formatNumber(balanceOrange - totalOrange));
            $("#dViva").text(formatNumber(balanceViva - totalViva));
            $("#dTricom").text(formatNumber(balanceTricom - totalTricom));
            
            
            $("#dTotal").text(formatNumber(balanceTotal - totalTransf));
            var $btnTransf = $("#btnTransf");
            
            $btnTransf.attr('disabled','disabled');
            
            var nbalClaro = balanceClaro - totalClaro;
            var nbalOrange = balanceOrange - totalOrange;
            var nbalViva = balanceViva - totalViva;
            var nbalTricom = balanceTricom - totalTricom;
            
            $("#msgInvalidMonto").css("display", "none");            
            if(nbalClaro < 0 || nbalOrange < 0 || nbalViva < 0 || nbalTricom < 0) {
                $("#msgInvalidMonto").css("display", "block");                
            }
            
            if($('#acceptTransfer:checked').length > 0 && totalTransf > 0 && nbalClaro >= 0 && nbalOrange >= 0 && nbalViva >=0 && nbalTricom >=0) {
                $btnTransf.removeAttr('disabled');

            }

            totalClaro = 0;
            totalOrange = 0;
            totalViva = 0;
            totalTricom = 0;
            var t = 0;
            x = 0;
            while($('#tbc' + t + ' tbody').length > 0)
            {
                var $tbody = $('#tbc' + t + ' tbody');
                var $tfoot = $('#tbc' + t + ' tfoot');
                var $row1 = $tbody.find('tr:nth-child(odd)').children('td');
                var $row2 = $tbody.find('tr:nth-child(even)');
                var $row3 = $tfoot.find('tr').children('td');
                
                var $inputs = $row2.find('input');

                var rowTotal = 0;
                for(var i=1; i <= 4; i++) {
                    var valor = toFloat($inputs[i].value);
                    rowTotal += valor;
                    $row3.eq(i).text(formatNumber(toFloat($row1.eq(i).text()) + valor));
                }
                $row2.children('td').eq(5).text(formatNumber(rowTotal));
                $row3.eq(5).text(formatNumber(rowTotal + toFloat($row1.eq(5).text())));

                t++;
            }
            
            if($('#tbcd tbody').length > 0) {
                totalClaro = 0;
                totalOrange = 0;
                totalViva = 0;
                totalTricom = 0;                 
                var $rows = $('#tbcd tbody').children('tr');
                
                for(var r=0; r < $rows.length; r++) {
                    var $tds = $rows.eq(r).find('td');
                     $inputs = $tds.find('input');
                    
                    var valorClaro = toFloat($inputs[1].value);
                    var valorOrange = toFloat($inputs[2].value);
                    var valorViva = toFloat($inputs[3].value);
                    var valorTricom = toFloat($inputs[4].value);

                    totalClaro += valorClaro;
                    totalOrange += valorOrange;
                    totalViva += valorViva;
                    totalTricom += valorTricom;
               
                    $tds.eq(5).text(formatNumber(valorClaro + valorOrange + valorViva + valorTricom));
         
                    
                }
                var $tdf = $('#tbcd tfoot').find('td');

                $tdf.eq(1).text(formatNumber(totalClaro));
                $tdf.eq(2).text(formatNumber(totalOrange));
                $tdf.eq(3).text(formatNumber(totalViva));
                $tdf.eq(4).text(formatNumber(totalTricom));
                $tdf.eq(5).text(formatNumber(totalClaro + totalOrange + totalViva + totalTricom));
               
            }


        }
        function postData() {
            calc();
            if($('#btnTransf').attr('disabled') != '') {
                return false;
            }
            
            var elements = $("#frmTransf").serialize();
            blockScreen();
            
            $.ajax({
                type: "POST",
                url: "/Recargas/Recarga/TransferirBalanceGrupoBanca",
                data: elements,
                dataType: "text",
                success: function(msg) {
                     if(msg == 'OK')
                        document.location.href = '/Recargas/Recarga';
                     else {
                         alert(msg);
                         unBlockScreen();
                     }
                },
                error: function(xhr, textStatus, errorThrown) {
                    alert(xhr.responseText);
                    unBlockScreen();
                }
            });
            
            return false;
                
        }



 $(document).ready(function() {
     calc();
 });

     
    </script>

</asp:Content>
