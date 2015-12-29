<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<Game>>" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers"%>
<%@ Import Namespace="Gambling.Models"%>

<%
   foreach (Game game in Model)
   {%>
       <% Html.RenderPartial("Line", game); %>
   <%} %>