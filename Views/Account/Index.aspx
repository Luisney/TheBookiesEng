<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <link href="/Content/CSS/jquery.autocomplete.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/ui.jqgrid.css" rel="Stylesheet" type="text/css" />
    <link href="/Content/CSS/table_styles.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            AutoComplete: '<%= Url.Action( "ByUserName", "AutoComplete", new { @area = "root" } ) %>/',
            JsonRemoveUserPasswordLock: '<%= Url.Action( "JsonRemoveUserPasswordLock" ) %>/',
            JsonSetUserLock: '<%= Url.Action( "JsonSetUserLock" ) %>/',
            Edit: '<%= Url.Action( "Edit" ) %>/',
            Details: '<%= Url.Action( "Details" ) %>/'            
        }
    </script>

    <script src="/Content/js/jquery.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/utils.autocomplete.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/i18n/grid.locale-sp.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/jqGrid/jquery.jqGrid.min.js" type="text/javascript" language="javascript"></script>

    <script src="/Content/js/account.index.js" type="text/javascript" language="javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Users - Users list
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Users List
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
