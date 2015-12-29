<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.Lottery>" %>

<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Lotteries - Edit Lotteries
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "lottoToEdit";  %>
    <h2>
        Edit Lotteries</h2>
    <%= Html.ValidationSummary("Edit Failed. Please Try Agian.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Información General</legend>
        <p>
            <label for="uploadify">
                Logo:</label>
            <%= Html.Hidden("LogoURL") %>
            <img width="103" height="90" alt="Logo <%= Model.Name %>" src="<%= Model.LogoURL %>"
                id="logo-img" />
            <input id="fileInput" name="fileInput" type="file" />
        </p>
        <div id="fileQueue">
        </div>
        <p>
            <%= this.TextBox( model => model.Name ).Disabled( true ).Label("Name:") %>
            <%= this.Hidden( model => model.Name ) %>
            <%= this.ValidationMessage(model => model.Name) %>
        </p>
        <p>
            <%= this.TextBox(model => model.PrintName).Label("Print Name:") %>
            <%= this.ValidationMessage(model => model.PrintName) %>
        </p>
        <p>
            <%= this.TextBox(model => model.DisplayName).Label("Display Name:") %>
            <%= this.ValidationMessage(model => model.DisplayName) %>
        </p>
        <p>
            <%= this.TextBox(PageModel => PageModel.DigitsPerPrize).Disabled(true).Label("Digits per prize:") %>
            <%= this.Hidden(PageModel => PageModel.DigitsPerPrize) %>
            <%= this.ValidationMessage( PageModel => PageModel.DigitsPerPrize ) %>
        </p>
        <p>
            <%= this.TextBox( PageModel => PageModel.PrizesNumber ).Disabled( true ).Label( "Number or Prizes:" ) %>
            <%= this.Hidden( PageModel => PageModel.PrizesNumber ) %>
            <%= this.ValidationMessage( PageModel => PageModel.PrizesNumber ) %>
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
            <%= this.CheckBox(c => c.Tue).Label("Tuesday:") %>
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
        <input type="submit" value="Save" />
    </p>
    <% } %>
    <div>
        <a class="navPrev" href="<%= Url.Action("Index") %>">Return to listing</a>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.Lottery>(HtmlNamePrefix)%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/uploadify.css" />
    <link rel="Stylesheet" type="text/css" href="/Content/CSS/token-input.css" />

    <script type="text/javascript" src="/Content/js/swfobject.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.uploadify.v2.1.0.min.js"></script>

    <script type="text/javascript" src="/Content/js/utils.upload.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.tokeninput.js"></script>

    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>

    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            InitUploadUtil('#fileInput', '#LogoURL', '#logo-img');
            LoadCloseTime();
        });

        function LoadCloseTime() {
            SetTime("Monday", '<%= Model.CloseTimeMon %>');
            SetTime("Tuesday", '<%= Model.CloseTimeTue %>');
            SetTime("Wednesday", '<%= Model.CloseTimeWed %>');
            SetTime("Thursday", '<%= Model.CloseTimeThu %>');
            SetTime("Friday", '<%= Model.CloseTimeFri %>');
            SetTime("Saturday", '<%= Model.CloseTimeSat %>');
            SetTime("Sunday", '<%= Model.CloseTimeSun %>');
        }

        function SetTime(day, time) {
            var closeTime = time;
            var timeArray = closeTime.split(':');
            if (timeArray.length == 3) {
                //Evaluating time
                var meridian = (timeArray[0] >= 12) ? 'PM' : 'AM';

                // Convert time 24h to 12h
                var hour;
                if (timeArray[0] == '00')
                    hour = '12';
                else
                    if (timeArray[0] > 12)
                // a zero padding is applied here
                    hour = String('0' + (timeArray[0] - 12)).slice(-2);
                else
                // a zero padding is applied here
                    hour = String('0' + timeArray[0]).slice(-2);

                var minutes = timeArray[1];

                //Seleting the current close time for the lotto                
                $("select[name='" + day + "_Hours']").val(hour);
                $("select[name='" + day + "_Minutes']").val(minutes);
                $("select[name='" + day + "_Meridian']").val(meridian);
            }
        }
    </script>

</asp:Content>
