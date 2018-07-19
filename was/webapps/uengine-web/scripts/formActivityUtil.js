function isInputElement(element) {
	var strTagName = "";
	if (element) {
		strTagName = element.tagName.toUpperCase();
	}
	return (strTagName == "INPUT" || strTagName == "TEXTAREA" || strTagName == "SELECT") ;
}

function getElementValue(element) {
	var strValue = "";
	if (element) {
		if (isInputElement(element)) {
			strValue = element.value;
		} else {
			strValue = element.innerHTML;
		}
	}

	return strValue;
}

function setElementValue(element, strValue) {
	var isElement = false;
	if ((element) && (strValue)) {
		if (isInputElement(element)) {
			strValue = strValue.encodeHtml();
			element.value = strValue;
		} else {
			strValue = strValue.decodeHtml();
			element.innerHTML = strValue;
		}
		isElement = true;
	} else {
		isElement = false;
	}

	return isElement;
}


function copyObjToObj(idElData, idElTarget) {
	var elData = document.getElementById(idElData);
	var elTarget = document.getElementById(idElTarget);

	if (elData && elTarget) {
		setElementValue(elTarget, getElementValue(elData));
	}
}

function setSelectDefaultValue(element) {
	var options = element.options;
	for (var i = 0; i < options.length; i++) {
		var option = options[i];
		var strDefaultValue = element.defaultValue;
		
		if (strDefaultValue) {
			var listStrDefaultValue = strDefaultValue.split(";")
	
			for (var j = 0; j < listStrDefaultValue.length; j++) {
				var strTmp = listStrDefaultValue[j]
	
				if (option.value == strTmp) {
					option.selected = true;
				}
			}
		}
	}
}

function setDefaultValue() {
	var listSelect = document.getElementsByTagName("select");
	for (var i = 0; i < listSelect.length; i++) {
		setSelectDefaultValue(listSelect[i])
	}

}

function openCalendarPopup(input_name) {
	var url = "../../common/calendar.jsp?field_name="+input_name ;
	window.open(url,'_calendar','top=190,left=500,width=250,height=220,resizable=true,scrollbars=no');
}
//function popUp(arg0) {
//	var url = arg0 ;
//	window.open(url,'','top=100,left=100,width=800,height=600,resizable=true,scrollbars=no');
//}

var onUserSelected = function(selectedPeople, inputName) {
	var userEndpoints = '';
	var userNames = '';
	var genders = '';
	var birthdays = '';
	var sep = '';
    var genXML = '';
    var chkCnt = 0;
    
	for (i=0; i<selectedPeople.length; i++) {
		userNames += (sep + selectedPeople[i].name);
		genders += (sep + selectedPeople[i].isMale);
		birthdays += (sep + selectedPeople[i].birthday);
		userEndpoints += (sep + selectedPeople[i].id);

		if (chkCnt == 0) {
			genXML += "  <" + RM_CLS_NAME + ">";
			genXML += "  <endpoint>"+selectedPeople[i].id+"</endpoint>";	
			genXML += "  <resourceName>"+selectedPeople[i].name+"</resourceName>";	
			sep = ';';
		} else if (chkCnt==1) {
			genXML += "<multipleMappings>";
			genXML += "  <" + RM_CLS_NAME + " reference='../..'/>";
		}
		
		if (chkCnt > 0) {
			genXML += "<" + RM_CLS_NAME + ">";
			genXML += "  <endpoint>"+selectedPeople[i].id+"</endpoint>";
			genXML += "  <resourceName>"+selectedPeople[i].name+"</resourceName>";	
			genXML += "</" + RM_CLS_NAME + ">";
		}
		chkCnt++;
		
	}
	if (chkCnt > 1) {
		genXML += "</multipleMappings>";
		genXML += "<dispatchingOption>-1</dispatchingOption>";
	}
	if(chkCnt>0){
		genXML += "</" + RM_CLS_NAME + ">";
	}

	var inputNameSplit = inputName.split('[');
	var indexStr = '';
	if (inputNameSplit[1] != undefined) {
		indexStr = '['+inputNameSplit[1];
	}
	
	if (document.getElementById(inputNameSplit[0] + indexStr) != null) {
		/* IE의 경우 INPUT element의 ID와 name 을 제대로 구분하지 못함 */
//		document.getElementById(inputNameSplit[0] + indexStr).value = userEndpoints;
//		document.getElementById(inputNameSplit[0] + '_display' + indexStr).value = userNames;
//		document.getElementById(inputNameSplit[0] + '__which_is_xml_value' + indexStr).value = genXML;
		$("input[name=" + inputNameSplit[0] + indexStr + "]").val(userEndpoints);
		$("input[name=" + inputNameSplit[0] + '_display' + indexStr + "]").val(userNames);
		$("input[name=" + inputNameSplit[0] + '__which_is_xml_value' + indexStr + "]").val(genXML);
	}else{
		var elems = document.forms[0].elements;
		elems[inputNameSplit[0] + indexStr].value = userEndpoints;
		elems[inputNameSplit[0] + '_display' + indexStr].value = userNames;
		elems[inputNameSplit[0] + '__which_is_xml_value' + indexStr].value = genXML;
	}
}

function searchPeopleObj(obj, multiple){
	// 12.22 add
	var elemid = $(obj).prev().prev().attr("name") + "," + $(obj).prev().attr("name");
	
	setInputName(obj);
	if (multiple == undefined) {
		multiple = true;
	}
	// 04-15 modify ybs
	var tmp;
	var orgPicker;
	if(!tmp){
		orgPicker = window.open(WEB_ROOT + '/common/organizationChartPicker.jsp?fncName=onUserSelected&multiple=' + multiple + '&elemid=' + elemid, '_new','width=400,height=550,resizable=true,scrollbars=no');
	   	orgPicker.focus();
	   	tmp = true;
	}else if(!orgPicker.closed && orgPicker){
	   	orgPicker.focus();
	}else{
		orgPicker = window.open(WEB_ROOT + '/common/organizationChartPicker.jsp?fncName=onUserSelected&multiple=' + multiple + '&elemid=' + elemid, '_new','width=400,height=550,resizable=true,scrollbars=no');
	   	tmp = true;
	}
	orgPicker.onOk = onUserSelected;
	orgPicker.inputName = inputName;
}

function onDepartmentSelect(departmentList, inputName)
{
	var input = document.getElementById(inputName);
	var input_display = document.getElementById(inputName + "_display");
	
	var departmentNames = "";
	var departmentCodes = "";
	
	var isFirst = true;
	for(var iCount = 0; iCount < departmentList.length; iCount++)
	{
		if (isFirst)
		{
			isFirst = false;
		}
		else
		{
			departmentNames += ";";
			departmentCodes += ";";
		}
		
		var department = departmentList[iCount];
		departmentNames += department.name;
		departmentCodes += department.code;
	}
	
	var inputNameSplit = inputName.split('[');
	var indexStr = '';
	if (inputNameSplit[1] != undefined) {
		indexStr = '['+inputNameSplit[1];
	}

	document.getElementById(inputNameSplit[0] + indexStr).value = departmentCodes;
	document.getElementById(inputNameSplit[0] + '_display' + indexStr).value = departmentNames.replace(/(^\s*)|(\s*$)/gi, "");
}

function searchDepartment(obj, multiple){
	setInputName(obj);
	if (multiple == undefined) {
		multiple = true;
	}
	
	var orgPicker = window.open(WEB_ROOT + '/organizationmanager/department/departmentChartPicker.jsp?multiple=' + multiple, '_new','width=400,height=550,resizable=true,scrollbars=no');
	orgPicker.onOk = onDepartmentSelect;
	orgPicker.inputName = inputName;
}

var inputName = "";
function setInputName(obj) {
	if (obj.name) {	
		inputName = obj.name;
	} else if(obj.id){
		inputName = obj.id;
	} else {
		inputName = "" + obj;
	}
}

function setDate(imgObj) {

	var name = "" + imgObj.id;
	var addString='';
	if (name.indexOf('[') > -1) {
		addString = "[" + name.split("[")[1];
		name = name.split("[")[0];
	}

	name = name.split("_date_trigger")[0];


	var inputFieldName = name + addString;

	//alert(inputFieldName);alert(buttonName);
	Calendar.setup({
	    inputField 	:    inputFieldName ,
	    ifFormat  	:    "y-mm-dd",
	    button       :    imgObj,
	    align         	:    "BC",           // alignment (defaults to "Bl"),
	    singleClick	:    true,
	    callback 		:    false
	});
}

function openSelectProcessDefinition(obj) {
	var ctrlName = obj.name.split('_ProcessDefinition_button');

	var addArrayString = '';
	if (ctrlName[1].indexOf('[')>-1) {
		addArrayString=ctrlName[1];
	}
	var input_processDefinitionName = ctrlName[0] + "_ProcessDefinition_Name" + addArrayString;
	var input_processDefinitionAlias = ctrlName[0] + addArrayString;

	var url = WEB_ROOT + "/processparticipant/worklist/selectProcessDefinition_frame.jsp";
	var StrOption ;
	StrOption  = "dialogWidth:500px;dialogHeight:300px;";
	StrOption += "center:on;scroll:auto;status:off;resizable:no";
	var arrResult = new Array(2);
	arrResult = showModalDialog (url , window, StrOption);

	if( arrResult != null && arrResult[0] != null ){
		document.getElementById(input_processDefinitionName).value=arrResult[1];
		document.getElementById(input_processDefinitionAlias).value = "[" + arrResult[2] + "]";
	}
}

var dataReceiverCtrl;
var extValue1Receiver;
var extValue2Receiver;
var extValue3Receiver;

function openDataList(sql,dsn,ctrl,extValue1ReceiverName,extValue2ReceiverName,extValue3ReceiverName){
		dataReceiverCtrl = ctrl;
		var dataReceiverCtrlName = dataReceiverCtrl.name;
		var arrayIndexPos = dataReceiverCtrlName.indexOf("[");
		var arrayIndexPart = "";

		if(arrayIndexPos > -1){
			arrayIndexPart = dataReceiverCtrlName.substring(arrayIndexPos, dataReceiverCtrlName.length);
		}

		if(extValue1ReceiverName != null){
			extValue1ReceiverName = extValue1ReceiverName + arrayIndexPart;
			extValue1Receiver = document.forms[0].all[extValue1ReceiverName];
		}else{
			extValue1Receiver = null;
		}

		if(extValue2ReceiverName != null){
			extValue2ReceiverName = extValue2ReceiverName + arrayIndexPart;
			extValue2Receiver = document.forms[0].all[extValue2ReceiverName];
		}else{
			extValue2Receiver = null;
		}

		if(extValue3ReceiverName != null){
			extValue3ReceiverName = extValue3ReceiverName + arrayIndexPart;
			extValue3Receiver = document.forms[0].all[extValue3ReceiverName];
		}else{
			extValue3Receiver = null;
		}

        sql = ""+sql;

		var valueCtrlName = dataReceiverCtrlName.substring(0, dataReceiverCtrlName.length - "_database_button".length);

		var url = "dbBrowser.jsp?sql=" + sql + "&dsn=" + dsn + "&ctrlName=" + valueCtrlName;

        window.open(url,'dbBrowser','top=190,left=500,width=250,height=280,resizable=true,scrollbars=no');
}




var onDataReceive;
function requestDataLoad(sql, onDataReceive_) {
onDataReceive = onDataReceive_;
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = onDataLoad;

	xmlHttp.open("GET","dbValueLoader.jsp?sql=" + sql, true);
	xmlHttp.send(null);
}

var xmlHttp;
function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttprequest();
	}
}

function onDataLoad() {
  if(xmlHttp.readyState == 4) {
    if(xmlHttp.status == 200) {
		eval(onDataReceive + "('" + xmlHttp.responseText + "')");
    }
  }
}

function openTableAsXSL(htmlTableName) {

	var table = document.getElementById(htmlTableName);

	for (i=0; i<table.rows.length; i++) {
		var row = table.rows[i];
		
		for (k=0; k<row.cells.length; k++) {
			var oCell = row.cells[k];

		      for (j=0; j<oCell.childNodes.length; j++) {
		      	var child = oCell.childNodes[j];
		      	if (child.name) {
		      		var elemName = child.name;
		      		//alert(elemName);

		      		try {

		      			oCell.innerHTML = document.forms[0].all[elemName].value;
		      		} catch(e) { }
		      	}
		      }
		}
	}

	document.hiddenForm.value.value = "<table>" + document.getElementById(htmlTableName).innerHTML + "</table>";

	document.hiddenForm.action = 'xls.jsp';
	document.hiddenForm.submit();

}

function disableFuncAlert() {
	var url = WEB_ROOT + '/common/alertWindow.jsp';
	var openOption = 'top=300,left=400,width=450,height=150,resizable=no,scrollbars=no';
	window.open(url,'',openOption);
}

/*
var id = "";
var beanValue = "";
var strCss = "";
function createRichTextEditor(strName, beanValue, strCss) {
	var strHtml = "<input id=\"MyEditor_" + strName + "\" name=\"" + strName + "\" type=\"hidden\" "
		+ " value=\"" + beanValue.replaceAll("\n", " ") + "\" /><input id=\"" + strName + "___Config\" type=\"hidden\" />"
		+ "<div><iframe id=\"" + strName + "___Frame\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" "
		+ " src=\"" + WEB_ROOT + "/lib/FCKeditor/editor/fckeditor.html?InstanceName="	+ strName + "&Toolbar=Basic\" frameborder=\"0\" "
		+ strCss + "></iframe></div>";

	document.write(strHtml);
}
*/
//*****************************************************************************************************


//2009-08-06 RSH add  : avoid Number format Exception
function validate_Number(obj){
	if(obj.value.length > 0) 
		if(isNaN(obj.value)){
			alert("Only use Number Type");
			obj.value = "";
			obj.focus();
		}else{
			obj.value = parseInt(obj.value);
		}
}



//2010-03-18 adding attribute 'title' in textarea
function clearTitle(element) {
	if (element.title.trim() == element.value.trim()) {
		element.value = "";
	}
	
	element.style.color = "#000";
}

function setTitle(element) {
	if (element.value.trim().length == 0) {
		element.value = element.title;
		element.style.color = "#CCC";
	}
}

function checkTitles(form)
{
	var texts = jQuery(":text");
	var textareas = jQuery("textarea");
	
	for (var i = texts.length - 1; i >= 0; i--) { clearTitle(texts[i]); }
	for (var i = textareas.length - 1; i >= 0 ; i--) { clearTitle(textareas[i]); }
}
