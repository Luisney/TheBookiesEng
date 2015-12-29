<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MainOneColumn.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="Assets" runat="server">
    
    <link href="/Content/css/jquery.accessible-news-slider.css" rel="stylesheet" type="text/css" />
      <link href="/Content/css/table_styles.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="/Content/js/Charting/jquery.thebookies.charts.js"></script>
    
    <script type="text/javascript" src="/Content/js/jquery.accessible-news-slider.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#tabs').tabs();
            window.setTimeout(refreshMonitoreo, 75);
        });

        function refreshMonitoreo() {
            var ob = $("#OrderBy").val();
            $("#cnt-quinielas").load("/Lottery/Lotto/GetCensus?BetType=1&from=2013-04-01&to=2013-04-01&sorting=" + ob);
            $("#cnt-pale").load("/Lottery/Lotto/GetCensus?BetType=2&from=2013-04-01&to=2013-04-01&sorting=" + ob);
            $("#cnt-tripleta").load("/Lottery/Lotto/GetCensus?BetType=3&from=2013-04-01&to=2013-04-01&sorting=" + ob);
            $("#cnt-superpale").load("/Lottery/Lotto/GetCensus?BetType=4&from=2013-04-01&to=2013-04-01&sorting=" + ob);
        }
    </script>	
	<style type="text/css">
	.tbh, .tbr { border-collapse:collapse;  }
	.thn { width: 90px;  border: 1px solid #dddddd; background-color: #dddddd; }
	.tdn { width: 90px; text-align:center; border: 1px solid #dddddd; }
	.thc { width: 80px; border: 1px solid #dddddd; background-color: #dddddd; }	
	.tdc { width: 80px; text-align:center; border: 1px solid #dddddd; }
	.thm { width: 90px; border: 1px solid #dddddd; background-color: #dddddd;  }
	.tdm { width: 90px; text-align:right; border: 1px solid #dddddd;}	
	.tdg, .thg { width: 20px; }
	
	.thn, .thc, .thm, .thg, .tdn,  .tdc, .tdm, .tdg { padding: 1px 0px 1px 0px; }
	</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home
</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <table style="width:100%"><tr><td><h2>Numbers monitor</h2><td><td style="width:300px;text-align:right">Ordenado por: 
	<select id="OrderBy" onchange="refreshMonitoreo()">
	<option value="0">Numbers</option>
<option value="1">Plays</option>
<option value="2">Net sales</option>
<option value="3">Descending Numbers</option>
<option value="4">Descending PLays</option>
<option value="5" selected="selected">Descending net sales</option>
	</select>
	
	
	</td></tr></table>
    <div id="tabs" style="height:400px">
        <ul>
            <li><a href="#mn-quinielas">Quinielas</a></li>
            <li><a href="#mn-pale">Pale</a></li>
            <li><a href="#mn-tripleta">Tripleta</a></li>
            <li><a href="#mn-superpale">Super Pale</a></li>
        </ul>
        <div id="mn-quinielas">
            <div id="cnt-quinielas"></div>        
        </div>
        <div id="mn-pale">
            <div id="cnt-pale"></div>     
        </div>
        <div id="mn-tripleta">
            <div id="cnt-tripleta"></div> 
        </div>
        <div id="mn-superpale">
            <div id="cnt-superpale"></div> 
        </div>
    </div>
    <br />    
    <h2>Sales Histogram</h2>
    
    <% Html.RenderPartial("LotterySalesHistogram"); %>
    
    <h2 class="dashboard-heading">By play type</h2>
        
    <% Html.RenderPartial("LotteryBetsPieChart"); %>


    <div class="clear"></div>
    
    <% Html.RenderPartial("DashboardLotteryResult", ViewData["lotteryResults"]); %>
</asp:Content>