<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<TemplatePeriodViewModel>" %>
<%@ Import Namespace="Gambling.Models.ViewModels"%>
<%@ Import Namespace="MvcContrib.FluentHtml" %>

<fieldset>
    <h4>Período: <%= Model.BetTypePeriod.Name %> <%= Model.IsInteger ? "" : "Cuando el carreraje del periodo no es entero"%></h4>
    
    <%= Html.Hidden("templatePeriodViewModels[" + Model.Index + "].BetTypePeriodId", Model.BetTypePeriod.Id) %>
    <%= Html.Hidden("templatePeriodViewModels[" + Model.Index + "].IsInteger", Model.IsInteger) %>
    
    <table>
        <tr>
            <th></th>
            <th>Macho Local</th>
            <th>Hembra Visitante</th>
        </tr>
        <tr>
            <td>Cantidad a sumar:</td>
            <td><%= this.TextBox("templatePeriodViewModels[" + Model.Index + "].AddToLocalMaleScore").Value(Model.AddToLocalMaleScore) %></td>
            <td><%= this.TextBox("templatePeriodViewModels[" + Model.Index + "].AddToVisitorFemaleScore").Value(Model.AddToVisitorFemaleScore) %></td>
        </tr>
    </table>
    
    <table>
        <tr>
            <th></th>
            <th>Macho Visitante</th>
            <th>Hembra Local</th>
        </tr>
        <tr>
            <td>Cantidad a sumar:</td>
            <td><%= this.TextBox("templatePeriodViewModels[" + Model.Index + "].AddToVisitorMaleScore").Value(Model.AddToVisitorMaleScore) %></td>
            <td><%= this.TextBox("templatePeriodViewModels[" + Model.Index + "].AddToLocalFemaleScore").Value(Model.AddToLocalFemaleScore) %></td>
        </tr>
    </table>
    
</fieldset>
