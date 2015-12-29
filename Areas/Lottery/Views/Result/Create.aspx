<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.Result>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Results - Create Result
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "resultToCreate"; %>
    <h2>
        Crear Resultados</h2>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <label>
                Lottery:</label>
            <%= Html.DropDownList("LottoId") %>
        </p>
        <p>
            <%= this.TextBox(PageModel => PageModel.Date).Value( Model != null ? Model.Date.ToShortDateString(): DateTime.Now.ToShortDateString()).Label("Fecha:") %>
            <%= this.ValidationMessage(PageModel => PageModel.Date) %>
        </p>
        <p>
            <label>
                Prizes:</label>
            <span id="Prizes"></span>
            <%= this.ValidationMessage(PageModel => PageModel.Prizes) %>
        </p>
        <div>
            <input id="btnCrear" type="submit" value="Create" />
        </div>
    </fieldset>
    <% } %>
    <div>
        <a class="navPrev" href="<%= Url.Action("Index") %>">Return to listing</a>
    </div>
    <%= Html.ClientSideValidation<TheBookies.Model.Result>(HtmlNamePrefix)%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>

    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>

    <script type="text/javascript">
        // Serialized results
        var results = '<%= Model != null ? Model.Prizes: String.Empty %>'
        
        $(function() {
            $("#resultToCreate_Date").datepicker({
                dateFormat: 'dd/mm/yy'
            });

            $('#LottoId').change(function() {
                $('#Prizes').html('<img src="/Content/images/ajax-loader-small.gif" alt="Esperando ..." />');

                $.getJSON('<%= Url.Action("GetLotteryInfo", "Lotto") %>', { lotteryId: $(this).val() }, function(data) {
                    var numbers = results.split(" ");
                    $('#Prizes').html('');
                    for (var index = 0; index < data.PrizesNumber; index++) {
                        var currentValue = index < numbers.length ? numbers[index] : "";
                        $('#Prizes').append('<input type="text" class="shortScore" value="' + currentValue + '" name="Prizes[' + index + ']">');
                    }
                });
            });

            $('#LottoId').change();

            // Keep serialized results synchronized
            $('.shortScore').live('change', function() {
                results = "";
                $('.shortScore').each(function(index, element) {
                    results += $(element).val() + " ";
                });
            });
        });
    </script>

</asp:Content>
