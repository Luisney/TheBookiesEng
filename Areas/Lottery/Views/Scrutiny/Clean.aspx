<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" %>

<%@ Import Namespace="TheBookies.Model" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script type="text/javascript" src="/Content/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/Content/js/jquery-ui-1.7.2.custom.min.js"></script>
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode("Create commision profile for recharge")%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Clear scrutiny on date" )%>
    </h2>
    <form method="post" onsubmit="return false;">
    <fieldset>
        <p>
            <label>
                Enter the date</label><br />
            <input id="date" name="date" type="text" style="width: 300px; margin-bottom: 5px"
                maxlength="10" class="datePicker" />
        </p>
    </fieldset>
    <input id="CleanButton" type="submit" value="Clear" onclick="validate()" />
    <br />
    <br />
    </form>
    <img id="animation" src="/Content/images/coganim.gif" style="display: none" />
    <script type="text/javascript">

        function validate() {
            if ($("#date").val() == "") {
                alert("Especifique la fecha.");
                return false;
            }

            $("#animation").show();
            $("#CleanButton").attr("disabled", "disabled");

            $.ajax({
                type: "POST",
                url: "/Lottery/Scrutiny/Clean?date=" + $("#date").val(),
                dataType: "text",
                success: function (msg) {
                    if (msg == "OK")
                        document.location.href = "/Lottery/BetScrutiny";
                    else {
                        alert(msg);
                        $("#CleanButton").attr("disabled", "");
                        $("#animation").show();
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });

            
            
            return true;
        }
        $(function () {
            // Date pickers
            $(".datePicker").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });
    </script>
</asp:Content>
