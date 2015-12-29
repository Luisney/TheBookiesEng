<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<BetLineViewModel>>" %>
<%@ Import Namespace="Gambling.Models.ViewModels"%>

<%
    
    foreach (BetLineViewModel lineViewModel in Model)
    {%>
        <fieldset id="prop-fields_<%= lineViewModel.BetType.Id %>">
        <h4><%= lineViewModel.BetType.Name %></h4>
        
        <%= Html.Hidden(string.Format("propositionViewModels[{0}].BetTypeId", Model.IndexOf(lineViewModel)), lineViewModel.BetType.Id)%>
        
        <p>
            <%= this.CheckBox(string.Format("propositionViewModels[{0}].IsActive", Model.IndexOf(lineViewModel))).Label("Activa:").Checked(lineViewModel.IsActive)%>
        </p>
        
        <p>
            <%= this.TextBox(string.Format("propositionViewModels[{0}].PropositionPrice", Model.IndexOf(lineViewModel))).Label("Precio:").Value(lineViewModel.PropositionPrice)%>
        </p>
        </fieldset>
    <%
    } %>