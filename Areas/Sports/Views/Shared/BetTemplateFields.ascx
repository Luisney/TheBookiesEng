<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<IEnumerable<IGrouping<BetTypePeriod, BetTemplatesFieldViewModel>> >" %>
<%@ Import Namespace="Gambling.Models.ViewModels"%>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#period-select').change(function() {
                var toShowSelector = "#period-id-" + $(this).val();

                $(toShowSelector).show();

                $('.current-selected').removeClass('current-selected').hide();

                $(toShowSelector).addClass('current-selected');
            });

            $('.period:first').addClass('current-selected').show();
        })
    </script>
    <p>
        <%= this.Select("period-select").Options(Model.ToDictionary(c => c.Key.Id, c => c.Key.Name)).Label("Filtrar por período:") %>
    </p>
    <%
    var counter = 1;
    foreach( IGrouping<BetTypePeriod, BetTemplatesFieldViewModel> periodGroup in Model )
    {%>
    
    <div class="period ui-hide" id="period-id-<%= periodGroup.Key.Id %>">
        <%
        foreach (BetTemplatesFieldViewModel field in periodGroup)
        {
            field.Index = counter;
            Html.RenderPartial("BetTemplateField", field);
            counter++;
        } %>
    </div>
    <%} %>

