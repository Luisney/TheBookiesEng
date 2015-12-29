<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.Models.ViewModels.BetTemplatesFieldViewModel>" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers" %>
<fieldset>
    <h4>
        Apuesta a convertir:
        <%=Model.BetType.Name%></h4>
    <%=Html.Hidden("templatesFieldViewModels[" + Model.Index + "].BetTypeId", Model.BetType.Id)%>
    <table>
        <tr>
            <th>
            </th>
            <th>
                <%  if (Model.BetType.UseIndividualFields( ))
                    {%>
                    Macho Local
                <%  }%>
            </th>
            <th>
                 <%  if (Model.BetType.UseIndividualFields( ))
                    {%>
                    Hembra Visitante
                 <% }%>
            </th>
        </tr>
        <%
            if (Model.BetType.UseGlobalScore)
            {%>
        <tr>
            <td>
                Puntaje/Carreraje combinado
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].GlobalScore").Class("serializable tabfix male").Value(Model.GlobalScore)%>
            </td>
            <td>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualScore)
            {%>
        <tr>
            <td>
                Puntaje/Carreraje
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalMaleScore").Class("serializable tabfix male").Value(Model.LocalMaleScore)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].VisitorFemaleScore").Class("serializable female").Value(Model.VisitorFemaleScore)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualSpread)
            {%>
        <tr>
            <td>
                Gavela
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalValueMale").Class("autocalculates-value serializable tabfix male").Value(Model.LocalValueMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].ForeignValueFemale").Class("serializable female").Value(Model.ForeignValueFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualPrice)
            {%>
        <tr>
            <td>
                Precio
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalMale").Class("autocalculates-nomial serializable tabfix male").Value(Model.LocalMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].ForeignFemale").Class("serializable female").Value(Model.ForeignFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseGlobalPriceOver)
            {%>
        <tr>
            <td>
                Precio (+)
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].PriceOver").Class("autocalculates-nomial serializable tabfix male").Value(Model.PriceOver)%>
            </td>
            <td>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualPriceOver)
            {%>
        <tr>
            <td>
                Precio (+)
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalOverMale").Class("autocalculates-nomial serializable tabfix male").Value(Model.LocalOverMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].VisitorOverFemale").Class("serializable female").Value(Model.VisitorOverFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseGlobalPriceUnder)
            {%>
        <tr>
            <td>
                Precio (-)
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].PriceUnder").Class("autocalculates-nomial serializable tabfix male").Value(Model.PriceUnder)%>
            </td>
            <td>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualPriceUnder)
            {%>
        <tr>
            <td>
                Precio (-)
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalUnderMale").Class("autocalculates-nomial serializable tabfix male").Value(Model.LocalUnderMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].VisitorUnderFemale").Class("serializable female").Value(Model.VisitorUnderFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <%  if (Model.BetType.UsePropositionPrice)
            {%>
        <tr>
            <td>
                Precio
            </td>
            <td>
                <%= this.TextBox( "templatesFieldViewModels[" + Model.Index + "].PropositionPrice" ).Class( "serializable tabfix male" ).Value( Model.PropositionPrice )%>
            </td>
            <td>
            </td>
        </tr>
        <%} %>
    </table>
    <br />
    <table>
        <tr>
            <th>
            </th>
            <th>
                <%  if (Model.BetType.UseIndividualFields( ))
                    {%>
                Macho Visitante
                <%}%>
            </th>
            <th>
            <%  if (Model.BetType.UseIndividualFields( ))
                    {%>
                Hembra Local
                <%}%>
            </th>
            <th>
            </th>
        </tr>
        <% if (Model.BetType.UseIndividualScore)
            {%>
        <tr>
            <td>
                Puntaje/Carreraje
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].VisitorMaleScore").Class("serializable tabfix male").Value(Model.VisitorMaleScore)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalFemaleScore").Class("serializable female").Value(Model.LocalFemaleScore)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualSpread)
            {%>
        <tr>
            <td>
                Gavela
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].ForeignValueMale").Class("autocalculates-value serializable tabfix male").Value(Model.ForeignValueMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalValueFemale").Class("serializable female").Value(Model.LocalValueFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualPrice)
            {%>
        <tr>
            <td>
                Precio
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].ForeignMale").Class("autocalculates-nomial serializable tabfix male").Value(Model.ForeignMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalFemale").Class("serializable female").Value(Model.LocalFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualPriceOver)
            {%>
        <tr>
            <td>
                Precio (+)
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].VisitorOverMale").Class("autocalculates-nomial serializable tabfix male").Value(Model.VisitorOverMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalOverFemale").Class("serializable female").Value(Model.LocalOverFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
        <% if (Model.BetType.UseIndividualPriceUnder)
            {%>
        <tr>
            <td>
                Precio (-)
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].VisitorUnderMale").Class("autocalculates-nomial serializable tabfix male").Value(Model.VisitorUnderMale)%>
            </td>
            <td>
                <%= this.TextBox("templatesFieldViewModels[" + Model.Index + "].LocalUnderFemale").Class("serializable female").Value(Model.LocalUnderFemale)%>
                <span></span>
            </td>
        </tr>
        <%} %>
    </table>
</fieldset>
