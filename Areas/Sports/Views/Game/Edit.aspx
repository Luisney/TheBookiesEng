<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MainTwoColumns.Master"
    Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.Game>" %>

<%@ Import Namespace="Gambling.Helpers" %>

<%@ Import Namespace="Gambling.Models" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetStyle( "jquery.autocomplete" )%>
    <%= Html.GetScript( "jquery.autocomplete" )%>
    <%= Html.GetScript( "jquery.cascade-select.0.8" )%>
    <script type="text/javascript">
        var $GAMEID = <%= Model.Id %>;
        var ControllerActions = {
            Edit: '<%= Url.Action( "Index" )%>' + '/Edit/', <%--- Workaround for malfunction in Url.Action("Edit") -> it was returning an url containing the current page id '/Game/Edit/3' ---%> 
            GetNomialValue: '<%= Url.Action("GetNomialValue", "SportNomial") %>/',
            SearchGameByTeams: '<%= Url.Action("SearchGameByTeams") %>/',
            CalculateLineValues: '<%= Url.Action("CalculateLineValues") %>/',
            ShowDefaultAvailableBetField: '<%= Url.Action("ShowDefaultAvailableBetField") %>/',
            ShowDefaultAvailableBetFieldForTotals: '<%= Url.Action("ShowDefaultAvailableBetFieldForTotals") %>/',
            GetTemplatePeriods: '<%= Url.Action("GetTemplatePeriods") %>/',
            GetSport: '<%= Url.Action("GetSport", "Sport") %>/'
        };
        
        var LoaderImgUrl = '<%= Html.GetImageURL( "ajax-loader-small.gif" )%>';
        var GameTemplateType = '<%= ( Byte ) TheBookies.Model.Sports.Enumerations.BetTemplateType.Game %>';
        var TotalsTemplateType = '<%= ( Byte ) TheBookies.Model.Sports.Enumerations.BetTemplateType.Totals %>';

        var ModelProperties = {
            Visitor: { PrintName: '<%= Model.TeamAsA.PrintName %>' },
            Local: { PrintName: '<%= Model.TeamAsB.PrintName %>' }
        }
    </script>
    <%= Html.GetScript( "sports/game/game.shared" )%>
    <%= Html.GetScript( "sports/game/game.edit" )%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Juegos - Editar Juego
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="leftColumn" runat="server">
    <h2>
        Listado de Juegos</h2>
    <% Html.RenderPartial( "ReduxListWidget" ); %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="rightColumn" runat="server">
    <h2>
        Editar Juego:
        <%= Model.TeamAsA.DisplayName %>
        vs.
        <%= Model.TeamAsB.DisplayName %>
        <br />
        <span>Fecha:
            <%= Model.StartDate.ToLongDateString() %>
            a las
            <%= (new DateTime(Model.StartTime.Ticks)).ToString("hh:mm:ss tt") %></span>
    </h2>
    <%= this.TextBox("gameSearch").Label("Saltar a juego: ") %>
    <%= Html.ValidationSummary("Hubo errores al crear el juego. Revise los campos e intente nuevamente.") %>
    <br />
    <br />
    <div id="tabs">
        <ul id="tabs-links">
            <li><a href="#game-data">Juego</a></li>
            <li><a href="#game-baseBet">Apuesta Base</a></li>
            <li><a href="#game-lines">Linea</a></li>
        </ul>
        <% using( Html.BeginForm( ) )
           {%>
        <div id="game-data">
            <fieldset>
                <legend>Información general</legend>
                <%= Html.Hidden( "Id" ) %>
                <p>
                    <%= this.Select("PublicationStatus").Options((Dictionary<int, string>)ViewData["StatusList"]).Selected(Model.PublicationStatus).Label("Estado:") %>
                </p>
                <p>
                    <label for="StartDate">
                        Fecha de Inicio:</label>
                    <%= Html.TextBox("StartDate", Model.StartDate.ToShortDateString() ) %>
                    <%= Html.ValidationMessage("StartDate", "*") %>
                </p>
                <p>
                    <label for="StartTime">
                        Hora de Inicio:</label>
                    <select name="Hours">
                        <%for( int i = 1; i <= 12; ++i )
                          {%>
                        <option<% if( i == ( int.Parse( new DateTime( Model.StartTime.Ticks ).ToString( "hh" ) ) ) )
                               Response.Write( " selected='selected' value=\"" + i + "\"" );
                           else
                               Response.Write( " value=\"" + i + "\"" );%>>
                        <%=i%></option>
                        <%} %>
                    </select>
                    <%= this.Select("Minutes").Options((Dictionary<int, string>)ViewData["Minutes"]).Selected( Model.StartTime.Minutes ) %>
                    <select name="Meridian">
                        <option <%= new DateTime(Model.StartTime.Ticks).ToString("tt") == "p.m." ? "selected='selected'" : "" %>>
                            PM</option>
                        <option <%= new DateTime(Model.StartTime.Ticks).ToString("tt") == "a.m." ? "selected='selected'" : "" %>>
                            AM</option>
                    </select>
                    <%= Html.ValidationMessage("StartTime", "*")%>
                </p>
                <p>
                    <label for="GoalType">
                        <%= Html.Encode("Deporte:")%>
                    </label>
                    <%= this.Select("Sport").Disabled(true).Options((SelectList)ViewData["Sport"]).FirstOption("Escoja el Deporte").Selected(Model.TeamAsA.Team.Sport.Id) %>
                    <%= Html.ValidationMessage("Sport", "*")%>
                </p>
                <p>
                    <label for="GoalType">
                        <%= Html.Encode("División:")%>
                    </label>
                    <%= this.Select("DivisionCode").Disabled(true).Options((SelectList)ViewData["DivisionCode"]).FirstOption("Escoja la división").Selected(((SelectList)ViewData["DivisionCode"]).SelectedValue)%>
                    <%= Html.ValidationMessage("DivisionCode", "*")%>
                </p>
                <p>
                    <%= this.TextBox("TeamCodeAId").Value(Model.TeamAsA.PrintName).Label("Visitante:").Disabled(true) %>
                </p>
                <p>
                    <%= this.TextBox("TeamCodeBId").Value(Model.TeamAsB.PrintName).Label("Local:").Disabled(true) %>
                </p>
                <p>
                    <input type="submit" value="Guardar" />
                </p>
            </fieldset>
        </div>
        <div id="game-baseBet">
            <div id="DefaultBetType">
                <% Html.RenderPartial( "DefaultAvailableBetField", ViewData [ "detfaultBetLineFields" ] ); %>
            </div>
            <div id="DefaultBetTypeForTotals">
                <% Html.RenderPartial( "DefaultAvailableBetField", ViewData [ "defaultBetLineFieldsForTotals" ] ); %>
            </div>
            <br />
            <br />
            <p>
                <a id="autocalc-btn" class="button"><span>Calcular lineas automaticas</span></a>
            </p>
            <br />
            <br />
            <p>
                <input type="submit" value="Guardar" />
            </p>
        </div>
        <div id="game-lines">
            <div id="BetTypes">
                <% Html.RenderPartial( "AvailableBetFields", ViewData [ "betLineFields" ] ); %>
            </div>
            <p>
                <input type="submit" value="Guardar" />
            </p>
        </div>
        <%
            } %>
    </div>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
