<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    
    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>
    <script src="/Content/js/commission.index.js" type="text/javascript" language="javascript"></script>
    
    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            LotteryEdit: '<%= Url.Action("LotteryEdit") %>/'
        }
    </script>
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Commision - Listing of Commision profiles" ) %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Commision - Listing of Commision profiles" ) %>
    </h2>
        <% Html.RenderPartial( "SearchBox" ); %>
    <br />
    <br />
    <table id="ajaxDataTable">
    </table>
    <div id="Pager">
    </div>
    <br />
    <p>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create new</span></a>
    </p>
</asp:Content>
