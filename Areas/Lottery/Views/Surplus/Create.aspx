<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<TheBookies.Model.Surplus>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Surplus - Create surplus
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% HtmlNamePrefix = "surplusToCreate"; %>
    <h2>Create Surplus</h2>
    <% using (Html.BeginForm())
       {%>
    <fieldset>
        <legend>General Information</legend>
        <p>
            <%= this.TextBox(model => model.LottoDate).Value(DateTime.Now.ToShortDateString()).Label("Date:") %>
            <%= this.ValidationMessage(model => model.LottoDate) %>
        </p>
        <p>
            <label>Partnet:</label>
            <%= Html.DropDownList("surplusToCreate.PartnershipId")%>
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
            <input type="submit" value="Create" />
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
            $("#surplusToCreate_LottoDate").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });
    </script>
</asp:Content>
