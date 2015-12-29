<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.Models.ViewModels.BetTemplatesFieldViewModel>" %>
<%= Html.ValidationSummary("Creación fallida. Por favor corrija los errores e intente de nuevo.") %>
<fieldset>
    <h4>
        Apuesta Base: <span class="base-bet-name">
            <%= Model.BetType.Name %></span></h4>
    <%= Html.Hidden("templatesFieldViewModels[" + Model.Index + "].BetTypeId", Model.BetType.Id) %>
    <%  if( Model.BetType.UseGlobalScore )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].GlobalScore" ).Class( "serializable default-score tabfix" ).Label( "Carreraje combinado:" ).Value( Model.GlobalScore )%>
        <%= this.ValidationMessage( PageModel => PageModel.GlobalScore )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseIndividualScore )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalMaleScore" ).Class( "serializable default-male-score tabfix" ).Label( "Carreraje Macho:" ).Value( Model.LocalMaleScore )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalMaleScore ) %>
        <span></span>
    </p>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalFemaleScore" ).Class( "serializable default-female-score tabfix" ).Label( "Carreraje Hembra:" ).Value( Model.LocalFemaleScore )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalFemaleScore )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseIndividualSpread )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalValueMale" ).Class( "serializable default-male-spread tabfix" ).Label( "Gavela Macho:" ).Value( Model.LocalValueMale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalValueMale ) %>
        <span></span>
    </p>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalValueFemale" ).Class( "serializable default-female-spread tabfix" ).Label( "Gavela Hembra:" ).Value( Model.LocalValueFemale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalValueFemale )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseIndividualPrice )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalMale" ).Class( "serializable default-male tabfix" ).Label( "Precio Macho:" ).Value( Model.LocalMale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalMale ) %>
        <span></span>
    </p>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalFemale" ).Class( "serializable default-female tabfix" ).Label( "Precio Hembra:" ).Value( Model.LocalFemale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalFemale )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseGlobalPriceOver )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].PriceOver" ).Class( "serializable default-global-over tabfix" ).Label( "Precio (+):" ).Value( Model.PriceOver )%>
        <%= this.ValidationMessage( PageModel => PageModel.PriceOver )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseIndividualPriceOver )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalOverMale" ).Class( "serializable default-male-over tabfix" ).Label( "Precio (+) Macho:" ).Value( Model.LocalOverMale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalOverMale ) %>
        <span></span>
    </p>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalOverFemale" ).Class( "serializable default-female-over tabfix" ).Label( "Precio (+) Hembra:" ).Value( Model.LocalOverFemale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalOverFemale )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseGlobalPriceUnder )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].PriceUnder" ).Class( "serializable default-global-under tabfix" ).Label( "Precio (-):" ).Value( Model.PriceUnder )%>
        <%= this.ValidationMessage( PageModel => PageModel.PriceUnder )%>
        <span></span>
    </p>
    <%  }%>
    <%  if( Model.BetType.UseIndividualPriceUnder )
        {%>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalUnderMale" ).Class( "serializable default-male-under tabfix" ).Label( "Precio (-) Macho:" ).Value( Model.LocalUnderMale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalUnderMale ) %>
        <span></span>
    </p>
    <p>
        <%= this.TextBox( "templatesFieldViewModels[0].LocalUnderFemale" ).Class( "serializable default-female-under tabfix" ).Label( "Precio (-) Hembra:" ).Value( Model.LocalUnderFemale )%>
        <%= this.ValidationMessage( PageModel => PageModel.LocalUnderFemale )%>
        <span></span>
    </p>
    <%  }%>
</fieldset>
