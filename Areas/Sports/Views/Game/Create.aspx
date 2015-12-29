<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MainTwoColumns.Master"
    Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.Models.Game>" %>

<%@ Import Namespace="xVal.Rules" %>
<%@ Import Namespace="Gambling.Models.ViewModels" %>
<%@ Import Namespace="Gambling.Models" %>
<%@ Import Namespace="Gambling.Helpers" %>
<asp:Content ID="Assets" ContentPlaceHolderID="Assets" runat="server">
    <%= Html.GetStyle( "ui.jqgrid" )%>
    <%= Html.GetStyle( "token-input" )%>
    <%= Html.GetScript( "xVal.jquery.validate" )%>
    <%= Html.GetScript( "jquery.validate" )%>
    <%= Html.GetScript( "jquery.tokeninput" )%>
    <%= Html.GetScript( "jquery.cascade-select.0.8" )%>
    <%= Html.GetScript( "jqGrid/i18n/grid.locale-sp" )%>
    <%= Html.GetScript( "jqGrid/jquery.jqGrid.min" )%>
    <script type="text/javascript">
        var ControllerActions = {
            GetNomialValue: '<%= Url.Action("GetNomialValue", "SportNomial") %>/',
            GetTeamAlias: '<%= Url.Action("GetTeamAlias", "TeamAlias") %>/',
            GetTeamAliasesByDivision: '<%= Url.Action("GetTeamAliasesByDivision", "Team") %>',
            GetDivisionData: '<%= Url.Action("GetDivisionData", "Division") %>/',
            FilterDivisionsBySport: '<%= Url.Action("FilterDivisionsBySport", "Division") %>/',
            ShowDefaultAvailableBetField: '<%= Url.Action("ShowDefaultAvailableBetField") %>/',
            ShowDefaultAvailableBetFieldForTotals: '<%= Url.Action("ShowDefaultAvailableBetFieldForTotals") %>/',
            ShowAvailableBetsFields: '<%= Url.Action("ShowAvailableBetsFields") %>/',
            GetTeamsByDivision: '<%= Url.Action("GetTeamsByDivision") %>/',
            DateIsValid: '<%= Url.Action("DateIsValid") %>/',
            CalculateLineValues: '<%= Url.Action("CalculateLineValues") %>/',
            GetTemplatePeriods: '<%= Url.Action("GetTemplatePeriods") %>/',
            GetSport: '<%= Url.Action("GetSport", "Sport") %>/'
        };

        var LoaderImgUrl = '<%= Html.GetImageURL( "ajax-loader-small.gif" )%>';
        var GameTemplateType = '<%= ( Byte ) TheBookies.Model.Sports.Enumerations.BetTemplateType.Game %>';
        var TotalsTemplateType = '<%= ( Byte ) TheBookies.Model.Sports.Enumerations.BetTemplateType.Totals %>';
    </script>
    <%= Html.GetScript( "sports/game/game.shared" )%>
    <%= Html.GetScript( "sports/game/game.add" )%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Juegos - Crear Juego
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="leftColumn" runat="server">
    <h2>
        Listado de Juegos</h2>
    <% Html.RenderPartial( "ReduxListWidget" ); %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="rightColumn" runat="server">
    <h2>
        Crear Juego</h2>
    <%= Html.ValidationSummary("Hubo errores al crear el juego. Revise los campos e intente nuevamente.") %>
    <div id="tabs">
        <ul>
            <li><a href="#game-data">Juego</a></li>
            <li><a href="#game-baseBet">Apuesta Base</a></li>
            <li><a href="#game-lines">Linea</a></li>
        </ul>
        <% using( Html.BeginForm( ) )
           {%>
        <div id="game-data">
            <fieldset>
                <legend>Información general</legend>
                <p>
                    <%= this.Select("PublicationStatus").Options((Dictionary<int, string>)ViewData["StatusList"]).Selected((int)Constants.GamePublicationStatus.Private).Label("Estado:") %>
                </p>
                <p>
                    <label for="StartDate">
                        Fecha de Inicio:</label>
                    <%= Html.TextBox( "StartDate", Model.StartDate.ToShortDateString( ) )%>
                    <%= Html.ValidationMessage("StartDate", "*") %>
                </p>
                <p>
                    <label for="StartTime">
                        Hora de Inicio:</label>
                    <select id="Hours" name="Hours">
                        <%for( int i = 1; i <= 12; ++i )
                          {%>
                        <option <% if( i == ( int.Parse( new DateTime( Model.StartTime.Ticks ).ToString( "hh" ) ) ) )
                               Response.Write( " selected='selected' value=\"" + i + "\"" );
                           else
                               Response.Write( " value=\"" + i + "\"" );%>>
                            <%=i%></option>
                        <%} %>
                    </select>
                    <%= this.Select( "Minutes" ).Options( ( Dictionary<int, string> ) ViewData [ "Minutes" ] ).Selected( Model.StartTime.Minutes )%>
                    <select id="Meridian" name="Meridian">
                        <option <%= new DateTime(Model.StartTime.Ticks).ToString("tt") == "p.m." ? "selected='selected'" : "" %>>
                            PM</option>
                        <option <%= new DateTime(Model.StartTime.Ticks).ToString("tt") == "a.m." ? "selected='selected'" : "" %>>
                            AM</option>
                    </select>
                    <%= this.Hidden("FauxDateInput").Value("1") %>
                    <%= Html.ValidationMessage("StartTime", "*")%>
                </p>
                <p>
                    <label for="Sport">
                        <%= Html.Encode("Deporte:")%>
                    </label>
                    <%= Html.DropDownList("Sport","Escoga el Deporte")%>
                    <%= Html.ValidationMessage("Sport", "*")%>
                </p>
                <p>
                    <label for="DivisionCode">
                        <%= Html.Encode("División:")%>
                    </label>
                    <%= Html.DropDownList( "DivisionCode", "Escoga el Deporte" )%>
                    <%= Html.ValidationMessage("DivisionCode", "*")%>
                </p>
                <p>
                    <%= this.TextBox("TeamCodeAId").Label("Visitante:") %>
                    <%= this.ValidationMessage(c => c.TeamAsA) %>
                </p>
                <p>
                    <%= this.TextBox("TeamCodeBId").Label("Local:") %>
                    <%= this.ValidationMessage(c => c.TeamAsB) %>
                </p>
            </fieldset>
            <p>
                <input type="submit" value="Crear" />
            </p>
        </div>
        <div id="game-baseBet">
            <div id="DefaultBetType">
            </div>
            <div id="DefaultBetTypeForTotals">
            </div>
            <br />
            <br />
            <p>
                <a id="autocalc-btn" class="button"><span>Calcular lineas automaticas</span></a>
            </p>
            <br />
            <br />
            <p>
                <input type="submit" value="Crear" />
            </p>
        </div>
        <div id="game-lines">
            <div id="BetTypes">
            </div>
            <p>
                <input type="submit" value="Crear" />
            </p>
        </div>
        <% } %>
    </div>
    <br />
    <div>
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
        <%= Html.ClientSideValidation<GameValidationViewModel>().AddRule("FauxDateInput", new CustomRule("startDateValidation", new { RuleName = "Custom" }, "La fecha de inicio no es válida"))%>
    </div>
</asp:Content>
