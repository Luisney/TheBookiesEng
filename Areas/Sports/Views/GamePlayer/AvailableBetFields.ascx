<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<GameAvailableBet>>" %>
<%@ Import Namespace="Gambling.Models"%>
<%@ Import Namespace="Gambling.Models.ViewModels.Sports" %>
<% 
foreach( var availableBet in Model )
{%>
<%
    Html.RenderPartial("AvailableBetField", new GameAvailableBetViewModel
                                                {
                                                    Id = Model.IndexOf(availableBet),
                                                    AvailableBet = availableBet
                                                }); %>
<%} %>
