<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.Lottery.CommissionProfileCreateViewModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script src="/Content/js/jquery.validate.js" type="text/javascript"></script>

    <script src="/Content/js/xVal.jquery.validate.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Commision Profiles - Create Profile" )%>
    <% htmlNamePrefix = "CommissionProfile"; %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Commision Profiles - Create Profile" )%>
    </h2>
    <%= Html.ValidationSummary("Creation failes. Please fix the errors and try again") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>Campos</legend>
        <p>
            <%= this.TextBox( model => model.Profile ).Label( "Name:" ) %>
            <%= this.ValidationMessage(model => model.Profile) %>
        </p>
        <p>
            <input type="submit" value="Create" />

        </p>
    </fieldset>
    <% } %>
    <%= Html.ClientSideValidation<TheBookies.Model.CommissionProfile>( htmlNamePrefix )%>
    <div>
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
