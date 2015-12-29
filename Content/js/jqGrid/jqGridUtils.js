booleanFormatter = function (cellvalue, options, rowObject) {
    if (String(cellvalue).toUpperCase() != 'TRUE')
        return "<img src=\"/Content/images/true.png\"/>";
    else
        return "<img src=\"/Content/images/false.png\"/>";
}

booleanFormatter2 = function (cellvalue, options, rowObject) {
    if (String(cellvalue).toUpperCase() == 'TRUE')
        return "<img src=\"/Content/images/true.png\"/>";
    else
        return "<img src=\"/Content/images/false.png\"/>";
}

createDatePicker = function (elem) {
    $(elem).datepicker({
        dateFormat: 'dd/mm/yy'
    });
    // Workaround for z-index issue using modal and datepicker
    // http://code.google.com/p/jquery-datepicker/issues/detail?id=43
    $('#ui-datepicker-div').css('z-index', 32767);
}

createDropDownList = function (data) {
    var dropdown = '<select>';
    var json_data = data.responseText;
    var statuses = eval("(" + json_data + ")");
    if (statuses.length > 0) {
        $.each(statuses, function (i, item) {
            dropdown += '<option value="' + item.value + '">' + item.label + '</option>';
        });
    } else {
        dropdown += '<select value=-1>No hay opciones disponibles</select>';
    }
    dropdown += '</select>';
    return dropdown;
}

createDropDownListOnlyUsingLabel = function (data) {
    var dropdown = '<select>';
    var json_data = data.responseText;
    var statuses = eval("(" + json_data + ")");
    if (statuses.length > 0) {
        $.each(statuses, function (i, item) {
            dropdown += '<option value="' + item.label + '">' + item.label + '</option>';
        });
    } else {
        dropdown += '<select value=-1>No hay opciones disponibles</select>';
    }
    dropdown += '</select>';
    return dropdown;
}

createBooleanDropDownList = function (data) {
    var dropdown = '<select>';
    dropdown += '<option value="False">Si</option>';
    dropdown += '<option value="True">No</option>';
    dropdown += '</select>';
    return dropdown;
}