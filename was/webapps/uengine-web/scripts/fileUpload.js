function uploadFile(fileObj) {
	var fileTagId = $(fileObj).attr("id");
	$("#_loading_file_" + fileTagId)
	.ajaxStart(function(){
		$(this).show();
	})
	.ajaxComplete(function(){
		$(this).hide();
	});
	$.ajaxFileUpload
	(
		{
			url : WEB_CONTEXT_ROOT + '/common/fileUpload.jsp',
			secureuri : false,
			fileElementId : fileTagId,
			dataType  : 'text',
			fileClass : $(fileObj).attr("fileClass"),
			viewMode  : $(fileObj).attr("viewMode"),
			success   : function (data, status, e) {
				if(data.indexOf("divErrorHeader") == -1) {
					$("div[name='_div_file_" + fileTagId + "']").html(data);
				}
			},
			error: function (data, status, e) {
				alert("error:"+e);
			}
		}
	);
}

function deleteFile(obj) {
	var tagName = $(obj).attr("tagName");
	var fileObj;
	
	if (tagName == "IMG") {
		fileObj = $(obj).parent().prev();
	} else if (tagName == "INPUT") {
		fileObj = obj;
	}
	
	$(fileObj).prev().prev().remove();
	$(fileObj).next().remove();
	var html = $(fileObj).attr("outerHTML");
	$(fileObj).replaceWith(html.replace(/type=hidden/gi, "type=file"));
}