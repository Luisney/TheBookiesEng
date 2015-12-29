<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.Surplus>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Surplus - Edit Surplus
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "surplusToEdit"; %>
    <h2>Editar Bote</h2>
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <%= this.TextBox(model => model.LottoDate.ToShortDateString()).Label("Date:") %>
            <%= this.ValidationMessage(model => model.LottoDate) %>
        </p>
        <p>
            <label>Partner:</label>
            <%= Html.DropDownList("surplusToEdit.PartnershipId")%>
        </p>
        <p>
            <%= this.TextBox(model => model.Order).Label("Order:") %>
            <%= this.ValidationMessage(model => model.Order) %>
        </p>
        <p>
            <%= this.TextBox(model => model.Maximum.ToString("F2")).Label("Maximum Amount:")%>
            <%= this.ValidationMessage(model => model.Maximum) %>
        </p>
        <p>
            <label>&nbsp;</label>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>
    <div>
        <%=Html.ClientSideValidation<TheBookies.Model.Surplus>(HtmlNamePrefix)%>
        <%=Html.ActionLink("Return to listing", "Index", new {}, new { @class = "navPrev" })%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">
    <script type="text/javascript" src="/Content/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/Content/js/xVal.jquery.validate.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#surplusToEdit_LottoDate").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });
    </script>
</asp:Content>
