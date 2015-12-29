<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<StoringCenter>" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>
    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Collection Center
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Create Collection Center</h2>
    <%= Html.ValidationSummary("Creación fallida. por favor corrije los errores e intenta de nuevo") %>
    <% using( Html.BeginForm())
       {%>
    <fieldset>
        <legend>Fields</legend>
        <p>
            <label for="ID">ID:</label>
            <%= Html.TextBox("StoringCenterId") %>
            <%= Html.ValidationMessage( "StoringCenterId", "*" )%>
        </p>
        <p>
            <label for="Name">Name:</label>
            <%= Html.TextBox("Name") %>
            <%= Html.ValidationMessage("Name", "*") %>
        </p>
        <p>
            <label for="Address"><%= Html.Encode("Address:")%></label>
            <%= Html.TextBox("Address") %>
            <%= Html.ValidationMessage("Address", "*") %>
        </p>
        <p>
            <label for="Phone"><%= Html.Encode("Phone:")%></label>
            <%= Html.TextBox("Phone") %>
            <%= Html.ValidationMessage("Phone", "*") %>
        </p>
        <p>
            <label for="Contact">Contact:</label>
            <%= Html.TextBox("Contact") %>
            <%= Html.ValidationMessage("Contact", "*") %>
        </p>
        <p>
            <label for="Email">Email:</label>
            <%= Html.TextBox("Email") %>
            <%= Html.ValidationMessage("Email", "*") %>
        </p>
        <p>
            <label for="OpenTime">Opening Time:</label>            
            <%= Html.TimeSelector("OpenTime") %>
            <%= Html.ValidationMessage("OpenTime", "*") %>
        </p>
        <p>
            <label for="CloseTime">Closing Time:</label>            
            <%= Html.TimeSelector("CloseTime")%>
            <%= Html.ValidationMessage("CloseTime", "*") %>
        </p>
        <p>
            <label for="CommissionProfile">Commision Profile:</label>
            <%= Html.DropDownList("CommissionProfileId") %>
            <%= Html.ValidationMessage( "CommissionProfileId", "*" )%>
        </p>
        <p>
            <label for="ValuePaymentProfile">Value to pay profile:</label>
            <%= Html.DropDownList("ValuePaymentProfileId") %>
            <%= Html.ValidationMessage( "ValuePaymentProfileId", "*" )%>
        </p>
        <p>
            <label for="LimitBetTypeProfile">Limit profile:</label>
            <%= Html.DropDownList( "LimitBetTypeProfileId" )%>
            <%= Html.ValidationMessage( "LimitBetTypeProfileId", "*" )%>
        </p>
        <p>
            <label for="Company">Company:</label>
            <%= Html.DropDownList("CompanyId") %>
            <%= Html.ValidationMessage("CompanyId", "*")%>
        </p>
        <p>
            <label>&nbsp;</label>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>
    <p>
        <%= Html.ClientSideValidation<StoringCenter>()%>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
</asp:Content>
