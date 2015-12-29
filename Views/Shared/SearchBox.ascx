<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<div class="searchbox">
    Buscar :
    <%= this.Html.TextBox("SearchText", "", new { Class = "searchbox_textbox", autocomplete = "off" })%>
    <button id="submitButton" class="searchbox_btn">
        Buscar</button>
</div>
