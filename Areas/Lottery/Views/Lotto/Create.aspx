<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.Lottery>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Lotteries - Create Lottery
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "lottoToCreate";  %>
    <h2>
        Create Lottery</h2>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <label for="uploadify">
                Logo:</label>
            <%= Html.Hidden("LogoURL") %>
            <img width="103" height="90" alt="Logo Lotería" src="" id="logo-img" />
            <input id="fileInput" name="fileInput" type="file" />
        </p>
        <div id="fileQueue">
        </div>
        <p>
            <%= this.TextBox(c => c.Name).Label("Name:") %>
            &nbsp;<%= this.ValidationMessage(c => c.Name) %>
        </p>
        <p>
            <%= this.TextBox(c => c.PrintName).Label("Print Name:") %>
            &nbsp;<%= this.ValidationMessage(c => c.PrintName) %>
        </p>
        <p>
            <%= this.TextBox(c => c.DisplayName).Label("Display Name:") %>
            &nbsp;<%= this.ValidationMessage(c => c.DisplayName) %>
        </p>
        <p>
            <%= this.TextBox(PageModel => PageModel.DigitsPerPrize).Label("Digits per prize:") %>
            <%= this.ValidationMessage( PageModel => PageModel.DigitsPerPrize )%>
        </p>
        <p>
            <%= this.TextBox(PageModel => PageModel.PrizesNumber).Label("Prize Number:") %>
            <%= this.ValidationMessage( PageModel => PageModel.PrizesNumber )%>
        </p>
    </fieldset>
    <fieldset>
        <legend>Closing Times</legend>
        <p>
            <%= this.CheckBox(c => c.Sun).Label("Sunday:") %>
            <%= Html.TimeSelector("Sunday") %>
            <%= this.ValidationMessage(c => c.Sun) %>
        </p>
        <p>
            <%= this.CheckBox(c => c.Mon).Label("Monday:") %>
            <%= Html.TimeSelector("Monday") %>
            <%= this.ValidationMessage(c => c.Mon) %>
        </p>
        <p>
            <%= this.CheckBox(c => c.Tue).Label("Tuesdat:") %>
            <%= Html.TimeSelector("Tuesday") %>
            <%= this.ValidationMessage(c => c.Tue) %>
        </p>
        <p>
            <%= this.CheckBox(c => c.Wed).Label("Wednesday:")%>
            <%= Html.TimeSelector("Wednesday") %>
            <%= this.ValidationMessage(c => c.Wed) %>
        </p>
        <p>
            <%= this.CheckBox(c => c.Thu).Label("Thursday:") %>
            <%= Html.TimeSelector("Thursday") %>
            <%= this.ValidationMessage(c => c.Thu) %>
        </p>
        <p>
            <%= this.CheckBox(c => c.Fri).Label("Friday:") %>
            <%= Html.TimeSelector("Friday") %>
            <%= this.ValidationMessage(c => c.Fri) %>
        </p>
        <p>
            <%= this.CheckBox(c => c.Sat).Label("Saturday:")%>
            <%= Html.TimeSelector("Saturday") %>
            <%= this.ValidationMessage(c => c.Sat) %>
        </p>
    </fieldset>
    <p>
        <label>
            &nbsp;</label>
        <input type="submit" value="Create" />
    </p>
    <% } %>
    <div>
        <a class="navPrev" href="<%= Url.Action("Index") %>">Return to listing</a>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.Lottery>(HtmlNamePrefix) %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/uploadify.css" />
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/token-input.css" />

    <script type="text/javascript" src="/Content/js/swfobject.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.uploadify.v2.1.0.min.js"></script>

    <script type="text/javascript" src="/Content/js/utils.upload.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>

    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            InitUploadUtil('#fileInput', '#LogoURL', '#logo-img');
        });
    </script>

</asp:Content>
