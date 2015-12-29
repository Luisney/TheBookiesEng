<%@ Page Title="" Language="C#" MasterPageFile="../Shared/Site.Master" Inherits="MvcContrib.FluentHtml.ModelViewPage<BetTemplateEditViewModel>" %>

<%@ Import Namespace="Gambling.Models.ViewModels" %>
<%@ Import Namespace="Gambling.ViewModels" %>
<%@ Import Namespace="MvcContrib.FluentHtml" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Assets" runat="server">

    <script>
    $BETTEMPLATECODE = <%= Model.Code %>;
    
    var ControllerActions = {
        JsonSearch: '<%= Url.Action("JsonSearch") %>/',
        JsonDelete: '<%= Url.Action("JsonDelete") %>/',
        Edit: '<%= Url.Action("Edit") %>/',
        Delete: '<%= Url.Action("Delete") %>/',
        ShowDefaultBetTemplateField: '<%= Url.Action("ShowDefaultBetTemplateField") %>/',
        GetNomialValue: '<%= Url.Action("GetNomialValue", "SportNomial") %>/',
        ShowBetTemplateFields: '<%= Url.Action("ShowBetTemplateFields") %>/',
        ShowTemplatePeriod: '<%= Url.Action("ShowTemplatePeriod") %>/',
        GetDivisionsBySport: '<%= Url.Action("GetDivisionsBySport", "Division") %>/'
    }
    
    $(document).ready(function() {
        SetAutoCalculate();
        FixTabIndex();

        $('#SportCode').change(function() {
            $('#DefaultBet').load(ControllerActions.ShowDefaultBetTemplateField, { SportCode: $(this).val() }, function() {
                FixTabIndex();
                SetAutoCalculate();
            });

            $('#BetsToModify').load(ControllerActions.ShowBetTemplateFields, { SportCode: $(this).val(), AppliesToTotals: true }, function() {
                FixTabIndex();
                SetAutoCalculate();
            });
            
            $('#TemplatePeriods').load(ControllerActions.ShowTemplatePeriod, { SportId: $(this).val() }, function() {
            });
        });


        // Fiter the division ddl
        $('#SportCode').change(function() {
            $.getJSON(ControllerActions.GetDivisionsBySport, { SportCode: $(this).val() }, function(data) {
                $('#DivisionCode').empty();
                //$('#SportNomialViewModel_DivisionCode').append('<option value="-1">Ninguna</option>');
                if (data.length > 0) {
                    $.each(data, function(i, item) {
                        $('#DivisionCode').append('<option value="' + item.Id + '">' + item.Label + '</option>');
                    });
                } else {
                    //$('#DivisionA').append('<option value=-1>No hay ligas disponibles</option>');
                }
            });
        })
        
        // Periods creation in case they weren't created on creation
        $('#create-periods-btn').click(function() {
            $('#TemplatePeriods').load(ControllerActions.ShowTemplatePeriod, { SportId: $('#SportCode').val() }, function() {
            });
        });

        $('#tabs').tabs();
    });

    SerializeFields = function() {
        var str = "";
        $('.serializable').each(function(i, item) {
            str += item.id + ":" + $(item).val() + ",";
        });

        return str;
    }

    SetAutoCalculate = function() {

        $('.default-female').blur(function() {
            ValidateDefaultFemale(this.id);
        });
        $('.female').blur(function() {
            ValidateFemale(this.id);
        });
        $('.autocalculates-nomial').unbind().blur(function() {
            $(this).parents('tr').find('span').empty();
            var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(this).parents('tr').find('span'));

            var currentField = this;
            
            //var favorite = -Math.abs($(this).val());
            var favorite = $(this).val();

            $(this).val(favorite);

            $.getJSON(ControllerActions.GetNomialValue, { BaseNomial: favorite, SportCode: $('#SportCode').val() }, function(data) {

                //$(currentField).next('span').html($(currentField).next('span').hasClass("foreign") ? "Hembra visitante: " + data : "Hembra local: " + data);
                $(currentField).parents('tr').find('.female').val(data);
                loader.fadeOut('fast', function() {
                    loader.remove();
                });
            });
        });

        $('.default-male').unbind().blur(function() {
            $(this).next().empty();
            var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').appendTo($(this).next());

            var currentField = this;
            
            var favorite = -Math.abs($(this).val());

            $(this).val(favorite);
            
            $.getJSON(ControllerActions.GetNomialValue, { BaseNomial: favorite, SportCode: $('#SportCode').val() }, function(data) {

                $('.default-female').val(data);

                loader.fadeOut('fast', function() {
                    loader.remove();
                });
            });
        });

        $('.autocalculates-value').blur(function() {
            var data = Math.abs($(this).val());
            //$(this).next('span').html($(this).next('span').hasClass("foreign") ? "Gavela hembra visitante: " + data : "Gavela hembra local: " + data);
            $(this).parents('tr').find('.female').val(data);
            $(this).val(-data);
        });
    }
    
    FixTabIndex = function() {
        $('.tabfix').each(function(i, item) {
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
    Editando Plantilla de Apuesta
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Editando Plantilla de Apuesta</h2>
    <%= Html.ValidationSummary("La creación no fue exitosa. Por favor corrija los errores e intente otra vez.") %>
    <% using( Html.BeginForm( ) )
       {%>
    <fieldset>
        <h4>
            Deporte y División</h4>
        <p>
            <%= this.Select("SportCode").Options(Model.SportsList).Label("Deporte:") %>
        </p>
        <p>
            <%= this.Select("DivisionCode").Selected(Model.DivisionCode).Options(Model.DivisionList).Label("Liga:") %>
        </p>
    </fieldset>
    <div id="DefaultBet">
        <% Html.RenderPartial( "BetTemplateDefaultField", Model.DefaultBetTemplatesField ); %>
    </div>
    <div id="tabs">
        <ul>
            <li><a href="#BetsToModify">Jugadas</a></li>
            <li><a href="#TemplatePeriods">Períodos</a></li>
        </ul>
        <div id="BetsToModify">
            <% Html.RenderPartial( "BetTemplateFields", Model.BetTemplatesFields ); %>
        </div>
        <div id="TemplatePeriods">
            <%
                Html.RenderPartial("TemplatePeriods", Model.TemplatePeriodViewModels); %>
                
                <%
               if (!Model.TemplatePeriodViewModels.Any())
               {%>
                    <a id="create-periods-btn">Crear períodos</a> 
               <%} %>
        </div>
    </div>
    <br>
    <p>
        <input type="submit" value="Guardar" />
    </p>
    <%}%>
    <div>
        <br />
        <br />
        <%=Html.ActionLink( "Volver al listado", "Index", new {}, new { @class = "navPrev" } )%>
    </div>
</asp:Content>
