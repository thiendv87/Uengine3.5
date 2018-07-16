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

// *****************************************************************************************************
/*
function addFile(dirname, filename, filesize, attachObj) {
    document.getElementById(attachObj + "_file").value = document.getElementById(attachObj + "_file").value + dirname +"|" + filename + "|" + filesize + "||";
}

function addList(dirname, filename, filesize, attachObj) {
	document.getElementById(attachObj + "_file_list").options.add(new Option(filename, dirname +"/" + filename));
}

function popFile(attachObj) {
	window.open("../../common/attachFile.jsp?attachObj=" + attachObj, "addfile", "width=330, height=200");
}

function removeFile(index, attachObj) {
    arrAttachfile = document.getElementById(attachObj + "_file").value.split("||");

    arrAttachfile.remove(index);
    document.getElementById(attachObj + "_file").value = arrAttachfile.join("||");
}

function removeAttach(attachObj) {
    var attachlist = document.getElementById(attachObj + "_file_list");

    if (attachlist.selectedIndex <= 0)
        return;

    removeFile(attachlist.selectedIndex-1, attachObj);

    attachlist.remove(attachlist.selectedIndex);
}

function selectedFileDown(obj) {
	if(obj.value == '') return;
	//alert(obj.value);
	//var filePathAndName = document.getElementById("attachfilelist")[document.getElementById("attachfilelist").selectedIndex].value;
	location.href="../../common/fileDown.jsp?filePathAndName=" + encodeURI(obj.value);
	//alert(filePathAndName);
}
*/
/// FILEUPLOAD CONTROL **************************************************************************
//var scripts = new Array;


//function changeEncTypeToMultipart() {
	//document.forms[0].encoding = 'multipart/form-data';
//}
/*
function fuMake_array(status, display_script) {
	this.status = status;
	this.display_script = display_script;
}

function fuAttach(obj) {

	var val = obj.value;
	var fileCtrlName = obj.name.split(']')[0]+"]";

    var fileNameTemp = obj.name.split('[')[1];
    fileNameTemp = fileNameTemp.replace('[','');
    fileNameTemp = fileNameTemp.replace(']','');
    var indexCtrl = fileNameTemp+"";

	var idx = obj.id.substring('file'.length);
	obj.style.display = 'none';

	fuAdd_item(obj,indexCtrl,++idx, val);
	fuItem_list(document.getElementById(obj.name).sourceIndex);
}

function fuAdd_item(obj,indexCtrl, idx, val) {
    var fileCtrlName = obj.name.split(']')[0]+"]";
	var file_script = '<span id=file_item'+idx+' ><input type=file name='+fileCtrlName+'['+idx+'] id=file'+idx+' onchange=fuAttach(this) size=1 style=width:0;cursor:pointer></span>';

	for (var i=obj.sourceIndex; i>=0; i--) {
		var tg = document.all(i);
		if (tg.tagName == 'SELECT') {
		    var seq = tg.options.length;
		    var display_script = idx + "," + val + "," + obj.name + "," + indexCtrl + "," + seq;
		    tg.options.add(new Option(display_script, seq));
		    break;
		}
		if (tg.id=='file_items') {
			tg.insertAdjacentHTML("afterEnd", file_script);
		}
	}
}

function fuItem_list(ctrlSourceIndex) {
	var validate_cnt = 0;
	var display_scripts = '';

	for (var i=ctrlSourceIndex; i>=0; i--) {
		var tg = document.all(i);

		if (tg.id=='display_items') {
			tg.innerHTML = display_scripts;
			break;
		}
		if (tg.tagName == 'SELECT') {
		    validate_cnt = tg.options.length;
		    if (validate_cnt == 0){
			    display_scripts = 'No files..';
			} else {
			    for (var j = 0; j < validate_cnt; j++) {
			        if(tg.options[j] !=null && tg.options[j].text !=""){
			            var valueString = tg.options[j].text.split(',');

			            var idx = valueString[0];
			            var val = valueString[1];
			            var objName = valueString[2];
			            var indexCtrl = valueString[3];
			            var seq = valueString[4];

						var scriptString = "<span id=display_item"+idx+">"+val+" <b onclick=fuRemove_item('"+objName+"',"+indexCtrl+","+idx+","+j+") style=cursor:pointer>remove..</b></span><br>";
						display_scripts += '<b>'+(j+1)+'</b>.'+scriptString;
					}
			    }
		    }
	    }
	}
}

function fuRemove_item(fileCtrlName,indexCtrl,idx,seq) {
    --idx;
    var ctrlSourceIndex = document.getElementById(fileCtrlName).sourceIndex
	for (var i=document.getElementById(fileCtrlName).sourceIndex; i>=0; i--) {
		var tg = document.all(i);
		if (tg.tagName == 'SELECT') {
		    tg.remove(seq);
		    break;
		}
		if (tg.id == 'file_item' + idx) {

		   tg.innerHTML = '';
		}
    }

	//document.getElementById('file_item;+idx).innerHTML = '';

	fuItem_list(ctrlSourceIndex);
}


function fuPreprocessing() {
	var idx = scripts.length + 1;
	if(document.getElementById('file_item' + idx) != undefined)
	   document.getElementById('file_item' + idx).innerHTML = '';
}

function initUploadScripts() {
	var i=0;
	if (document.getElementById('display_items') != undefined ){
		while (true) {
			var tg = document.all(i);
			if(tg == null || tg == "" || tg == undefined){
			   break;
			}
			if(tg.id == 'display_items'){
			   tg.innerHTML = 'No files..';
			}
			if(tg.id =='file_item1'){
			   tg.innerHTML = "<input id='file1' style='width: 0px; cursor: pointer' type='file' size='1' onclick='changeEncTypeToMultipart()' onchange='fuAttach(this)' name='file[0][0]' />";
			}
		    if(tg.id == 'uploadlistDiv'){
			   tg.innerHTML = '<select multiple=true name=uploadlist>';
			}
			var j=2;
			while (true){
				if (tg.id == 'file_item'+j) {
				   tg.innerHTML = '';
				}
				j++;
				if(j>10){ break;}
			}
			i++;
		}
	}
}
*/
//*****************************************************************************************************