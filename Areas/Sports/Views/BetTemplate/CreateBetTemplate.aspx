<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<Gambling.ViewModels.BetTemplateViewModel>" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script type="text/javascript">
        var ControllerActions = {
            JsonSearch: '<%= Url.Action("JsonSearch") %>/',
            JsonDelete: '<%= Url.Action("JsonDelete") %>/',
            Edit: '<%= Url.Action("Edit") %>/',
            ShowDefaultBetTemplateField: '<%= Url.Action("ShowDefaultBetTemplateField", "BetTemplate") %>/',
            GetNomialValue: '<%= Url.Action("GetNomialValue", "SportNomial") %>/',
            ShowBetTemplateFields: '<%= Url.Action("ShowBetTemplateFields", "BetTemplate") %>/',
            ShowTemplatePeriod: '<%= Url.Action("ShowTemplatePeriod", "BetTemplate") %>/',
            GetDivisionsBySport: '<%= Url.Action("GetDivisionsBySport", "Division") %>/'
        }

        $(document).ready(function () {
            $('#tabs').hide();

            $('#SportCode').change(function () {

                $('#DefaultBet').load(ControllerActions.ShowDefaultBetTemplateField, { SportCode: $(this).val() }, function () {
                    FixTabIndex();

                    $('.default-female').blur(function () {
                        ValidateDefaultFemale(this.id);
                    });

                    $('.default-male').blur(function () {
                        $(this).next().empty();
                        var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(this).next());

                        var favorite = -Math.abs($(this).val());

                        $(this).val(favorite);

                        var currentField = this;
                        $.getJSON(ControllerActions.GetNomialValue, { BaseNomial: $(this).val(), SportCode: $('#SportCode').val() }, function (data) {

                            $('.default-female').val(data);

                            loader.fadeOut('fast', function () {
                                loader.remove();
                            });
                        });
                    });
                });

                $('#BetsToModify').load(ControllerActions.ShowBetTemplateFields, { SportCode: $(this).val(), AppliesToTotals: false }, function () {
                    // It's assumed that only the favorite (male) value is used to get the underdog's
                    $('.autocalculates-nomial').blur(function () {
                        $(this).parents('tr').find('span').empty();
                        var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(this).parents('tr').find('span'));

                        var currentField = this;

                        //var favorite = -Math.abs($(this).val());
                        var favorite = $(this).val();

                        $(this).val(favorite);

                        $.getJSON(ControllerActions.GetNomialValue, { BaseNomial: favorite, SportCode: $('#SportCode').val() }, function (data) {

                            //$(currentField).next('span').html($(currentField).next('span').hasClass("foreign") ? "Hembra visitante: " + data : "Hembra local: " + data);
                            $(currentField).parents('tr').find('.female').val(data);
                            loader.fadeOut('fast', function () {
                                loader.remove();
                            });
                        });
                    });

                    $('.autocalculates-value').blur(function () {
                        var data = Math.abs($(this).val());
                        //$(this).next('span').html($(this).next('span').hasClass("foreign") ? "Gavela hembra visitante: " + data : "Gavela hembra local: " + data);
                        $(this).parents('tr').find('.female').val(data);
                        $(this).val(-data);
                    });

                    $('.female').blur(function () {
                        ValidateFemale(this.id);
                    });

                    // Setup tabs
                    FixTabIndex();
                    $('#tabs').show();
                    $('#tabs').tabs();
                });

                $('#TemplatePeriods').load(ControllerActions.ShowTemplatePeriod, { SportId: $(this).val() }, function () {
                });
            });

            // Fiter the division ddl
            $('#SportCode').change(function () {
                $.getJSON(ControllerActions.GetDivisionsBySport, { SportCode: $(this).val() }, function (data) {
                    $('#DivisionCode').empty();
                    if (data.length > 0) {
                        $.each(data, function (i, item) {
                            $('#DivisionCode').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                        });
                    }
                });
            });
        });
        
        FixTabIndex = function() {
            $('.tabfix').each(function (i, item) {
                $(item).attr("tabindex", i+1);
            });
        }

        ValidateFemale = function(fieldId) {
            var femaleValue = $('#' + fieldId).val();
            var maleValue = $('#' + fieldId).parents('tr').find('.male').val();

            if (femaleValue != maleValue) {
                //$('#' + fieldId).parents('tr').find('.female').val(data);
                $('#' + fieldId).val(Math.abs($('#' + fieldId).val()));
            }
        }

        ValidateDefaultFemale = function(fieldId) {
            var femaleValue = $('#' + fieldId).val();
            var maleValue = $('.default-male').val();

            if (femaleValue != maleValue) {
                //$('#' + fieldId).parents('tr').find('.female').val(data);
                $('#' + fieldId).val(Math.abs($('#' + fieldId).val()));
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Crear Plantilla de Apuesta
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Crear Plantilla de Apuesta</h2>
    <%= Html.ValidationSummary("La creación no fue exitosa. Por favor corrija los errores e intente otra vez.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <legend>
            Deporte y División</legend>
        <p>
            <%= this.Select("SportCode").Options(Model.SportsList, c => c.Value, c => c.Key).FirstOption("Seleccione un deporte").Label("Deporte:") %>
            <%= this.ValidationMessage(c => c.Code) %>
        </p>
        <p>
            <%= this.Select( "DivisionCode" ).Label( "Liga:" )%>
        </p>
    </fieldset>
    
    
    <div id="DefaultBet">
    </div>
    
    <div id="tabs">
        <ul>
            <li><a href="#BetsToModify">Jugadas</a></li>
            <li><a href="#TemplatePeriods">Períodos</a></li>
        </ul>
        
        <div id="BetsToModify">
        </div>

        <div id="TemplatePeriods">
        </div>
    </div>
    <br>
    <p>
        <input type="submit" value="Crear" />
    </p>
    <% } %>
    <div>
        <br />
        <br />
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
