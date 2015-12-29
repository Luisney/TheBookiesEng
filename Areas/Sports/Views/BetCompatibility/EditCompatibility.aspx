<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.ViewModels.BetCompatibilityEditModel>" %>

<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Models.EntitiesHelpers" %>
<asp:Content ID="Content4" ContentPlaceHolderID="Assets" runat="server">

    <script type="text/javascript">

        /// <reference path="jquery-1.4.1-vsdoc.js"/>
        $(document).ready(function() {
            $('#BetTypeAccordion').accordion({ autoHeight: false });
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Editar compatibilidad de la apuesta
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%  int Linkindex = 40;
        List<String> Periods =
            Model.BetTypes
            .Select( B => B.Period.Name )
            .Distinct( )
            .OrderBy( B => B )
            .ToList( );%>
    <h2>
        Tipos de apuesta incompatibles para:
    </h2>
    <p>
        Deporte:
        <%= Model.BaseSport.Name%><br />
        Apuesta base:
        <%= Model.BaseBetType.Name%><br />
        Periodo:
        <%= Model.BaseBetType.Period.Name%>
    </p>
    <br />
    <br />
    <% using( Html.BeginForm( ) )
       {%>
    <div id="BetTypeAccordion">
        <%  foreach( String PeriodName in Periods )
            {
                Linkindex++;%>
        <h3>
            <a linkindex="<%= Linkindex %>" href="#BetTypeAccordion_Tab_<%= PeriodName.Replace( " ", "" ) %>">
                <%= PeriodName %></a></h3>
        <div id="BetTypeAccordion_Tab_<%= PeriodName.Replace( " ", "" ) %>">
            <% foreach( BetType B in Model.BetTypes
                   .Where( B => B.Period.Name.Equals( PeriodName ) && !B.Id.Equals( Model.BetTypeCode ) ) )
               {%>
            <p>
                <input type="checkbox" <%= Model.BaseBetType.IsCompatible( B.Id, Model.BetCompatibilities )?"checked=\"checked\"":""%>
                    value="<%=B.Id%>" name="CompatibleBetTypeCodes">
                    <%=B.Name%></input>
            </p>
            <%} %>
        </div>
        <%}%>
    </div>
    <br />
    <p>
        <input type="submit" value="Guardar" />
    </p>
    <% } %>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", "BetCompatibility", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
