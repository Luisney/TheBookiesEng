/// <reference path="jquery-1.4.1-vsdoc.js"/>
$(document).ready(function() {
    $("a[name='closeIcon']").click(function() {
        id = $(this).attr("id");

        if (id == 'AddMatchupCloseIcon') {
            $("#divAdd").hide("slow");
            $("#addClear").hide("slow");
        }
        else {
            $("#ajaxLoader").show();
            $.post('/GamePlayer/Delete/', { Code: id }, function(data) {
                $("#ajaxLoader").hide();
                if (data == 'True') {
                    $("#divMatchUp" + id).hide("slow");
                    $("#clearMatchUp" + id).hide("slow");
                } else {
                    alert("No se pudo eliminar este Matchup. Al parecer ya hay apuestas en el sistema con este matchup");
                }
            });
        }
    });

    $(".imgAdd").click(function() {
        $("#dialog").show();
    });

    $("#addButton").click(function() {
        $("#divAdd").show("slow");
        $("#addClear").show("slow");
    });

    $("img[name='addPlayerA']").click(function() {
        $("#PlayersTeamA").show("scale");
    });
    $("img[name='addPlayerB']").click(function() {
        $("#PlayersTeamB").show("scale");
    });


    $("input[type='submit']").click(function(event) {
        if ($("input[name='PlayerCodeA']").val() == '' || $("input[name='PlayerCodeB']").val() == '') {
            event.preventDefault();
            alert("Debe elegir los dos jugadores");
        }
        else {
            if ($("#playerTypeA").html() == 'Pitcher' && ($("input[name='ScheduleGoalsPlayerA']").val() == '' || $("input[name='ScheduleGoalsPlayerB']").val() == '')) {
                event.preventDefault();
                alert("Debe llenar el estimado de ponches de cada Pitcher");
            }
            else {
                if ($("#playerTypeA").html() != 'Pitcher' && ($("input[name='PriceA']").val() == '' || $("input[name='PriceB']").val() == '')) {
                    event.preventDefault();
                    alert("Debe llenar el precio de cada jugador");
                }
            }
        }
    });

    ActivateSelectPlayer();
});

function ActivateSelectPlayer() {
    $('#PlayersTeamA').find(".rowmouseup").click(function() {
        $("#PlayersTeamA").hide("slow");

        id = $(this).find("span").html();
        $("input[name='PlayerCodeA']").val(id);
        $("#namePlayerA").html($(this).find("h3").html());
        $("#playerTypeA").html($(this).find("p").html());
        $("img[name='addPlayerA']").attr("src", $(this).find("img").attr("src"));

        ValidateBetweenTypes();
    });

    $('#PlayersTeamB').find(".rowmouseup").click(function() {
        $("#PlayersTeamB").hide("slow");

        id = $(this).find("span").html();
        $("input[name='PlayerCodeB']").val(id);
        $("#namePlayerB").html($(this).find("h3").html());
        $("#playerTypeB").html($(this).find("p").html());
        $("img[name='addPlayerB']").attr("src", $(this).find("img").attr("src"));
    });
}

function ValidateBetweenTypes(parentId) {
    alert(parentId);
}