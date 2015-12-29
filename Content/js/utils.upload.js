/// <reference path="jquery-1.4.1-vsdoc.js"/>

InitUploadUtil = function(inputFacadeId, propertyFieldId, imageElementId) {
    //If image src is not set then show the default no-image file.
    if ($(imageElementId).attr('src').length == 0) {
        $(imageElementId).attr('src', '/Content/images/no-image.jpg');
    }

    $(inputFacadeId).uploadify({
        'uploader': '/Content/uploadify.swf',
        'script': '/Uploadify/Upload.ashx',
        'cancelImg': '/Content/images/cancel.png',
        'folder': '/Content/uploads',
        'queueID': 'fileQueue',
        'auto': 'true',
        'fileDesc': 'Image Files',
        'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
        'buttonText': "Buscar imagen",
        'onComplete': uploadCompleted
    });

    function uploadCompleted(event, queueId, fileOb, response) {
        $(propertyFieldId).val(response);
        $(imageElementId).attr('src', response);
    }
}