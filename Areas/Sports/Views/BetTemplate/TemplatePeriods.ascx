<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<TemplatePeriodViewModel>>" %>
<%@ Import Namespace="Gambling.Models"%>

<%@ Import Namespace="Gambling.Models.ViewModels"%>

<script type="text/javascript">
    $(document).ready(function() {
        $('#template-period-select').change(function() {
            var toShowSelector = "#template-period-fields_" + $(this).val();

            $(toShowSelector).show();

            $('.period-current-selected').removeClass('period-current-selected').hide();

            $(toShowSelector).addClass('period-current-selected');
        });

        $('.template-period:first').addClass('period-current-selected').show();
    })
</script>

<%
    IEnumerable<IGrouping<BetTypePeriod, TemplatePeriodViewModel>> periodGroups = Model.GroupBy(c => c.BetTypePeriod);
    %>
    <p>
        <%= this.Select("template-period-select").Options(periodGroups.ToDictionary(c => c.Key.Id, c => c.Key.Name)).Label("Filtrar por período:")%>
    </p>

    <%
    var counter = 0;
    foreach (var periodGroup in periodGroups)
    {%>
        <div id="template-period-fields_<%= periodGroup.Key.Id %>" class="template-period ui-hide">
            <%
            foreach (TemplatePeriodViewModel periodViewModel in periodGroup)
            {
                periodViewModel.Index = counter;
                Html.RenderPartial("TemplatePeriod", periodViewModel);

                counter++;
            }
            %>
        </div>
    <%} %>
    
    
