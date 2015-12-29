<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetPackage( AssetPackage.JqAutocomplete ) %>
    <%= Html.GetPackage( AssetPackage.JqGrid ) %>
    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action( "JsonSearch" ) %>/',
            AutocompleteByLimitBetType: '<%= Url.Action( "ByLimitBetTypeProfile", "AutoComplete", new { @area="root" } ) %>',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            Associations: '<%= Url.Action("Associations") %>/'
        }
    </script>
    <script src="/Content/js/limitbettype.index.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Limits by Sale Limit - Sale Limit Profiles Listing" )%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Sale Limits - Profile Sales Limit listing" )%>
    </h2>
    <% Html.RenderPartial( "SearchBox" ); %>
    <br />
    <br />
    <div class="twoColumnsSmall">
        <div class="twoColumnsSmall-left">
            <table id="ajaxDataTable">
            </table>
            <div id="Pager">
            </div>
        </div>
        <div id="rightColumnSmall" class="twoColumnsSmall-right">
            <img id="rightColumnLoader" alt="Loading..." src="<%= Html.GetImageURL("loading-Horizontal.gif")%>" style="display:none;"/>
            <div id="rightColumnContent">
            </div>      
        </div>
    </div>
    <div class="twoColumnsSmall-bottomCenter">
    <p>
        <br/>
        <a class="button" href="<%= Url.Action("Create") %>"><span>Create New</span></a>
    </p>
    </div>
</asp:Content>
