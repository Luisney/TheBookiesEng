<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Gambling.Models.Company>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Html.Encode( "Companies - Company detailes" )%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode( "Company detailes" )%>
    </h2>
    <fieldset>
        <legend>Fields</legend>
        <p>
            Name:
            <%= Html.Encode(Model.Name) %>
        </p>
        <p>
            <%= Html.Encode( "Address:" ) + Html.Encode(Model.Address) %>
        </p>
        <p>
            <%= Html.Encode("Phones:") + Html.Encode(Model.Phone) %>
        </p>
        <p>
            Email:
            <%= Html.Encode(Model.Email) %>
        </p>
        <p>
            Rnc:
            <%= Html.Encode(Model.Rnc) %>
        </p>
        <p>
            Manager:
            <%= Html.Encode(Model.Manager) %>
        </p>
        <p>
            President:
            <%= Html.Encode(Model.Ceo) %>
        </p>
        <p>
            <%= Html.Encode( "Maximum available:" ) + Html.Encode(String.Format("{0:F}", Model.Maximum)) %>
        </p>
        <p>
            Percentage:
            <%= Html.Encode(String.Format("{0:F}", Model.Percentage)) %>
        </p>
    </fieldset>
    <p>
        <%=Html.ActionLink( "Edit", "Edit", new { Code = Model.Id } )%>
        |
        <%=Html.ActionLink( "Return to listing", "Index", new {}, new { @class = "navPrev" } )%>
    </p>
</asp:Content>
