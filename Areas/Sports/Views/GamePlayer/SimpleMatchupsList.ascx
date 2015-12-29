<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<GamePlayer>>" %>
<%@ Import Namespace="Gambling.Models"%>
<%
foreach (var GamePlayer in Model)
{
    Html.RenderPartial("Matchup", GamePlayer);
}
%>





