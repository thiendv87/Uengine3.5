Array.prototype.add = add;
Array.prototype.remove = remove;
function add(element)
{
	len = this.length;
	this[len] = element;
}
function remove(idx)
{
	var temp = new Array();
	var j=0;

	for(i=0; i<idx; i++) {
		temp[j++] = this[i];
	}

	for(i=idx+1; i<this.length; i++) {
		temp[j++] = this[i];
	}
	this.length=0;
	for(i=0; i<temp.length; i++) {
		this[i] = temp[i];
	}
}

function addFile(dirname, filename, filesize, attachObj)
{
    document.getElementById(attachObj + "_file").value = document.getElementById(attachObj + "_file").value + dirname +"|" + filename + "|" + filesize + "||";
}

function addList(dirname, filename, filesize, attachObj)
{
	document.getElementById(attachObj + "_file_list").options.add(new Option(filename, dirname +"/" + filename));
}

function popFile(attachObj) {
	window.open("../../common/attachFile.jsp?attachObj=" + attachObj, "addfile", "width=330, height=200");
}

function removeFile(index, attachObj)
{
    arrAttachfile = document.getElementById(attachObj + "_file").value.split("||");

    arrAttachfile.remove(index);
    document.getElementById(attachObj + "_file").value = arrAttachfile.join("||");
}

function removeAttach(attachObj) 
{
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


function openCalendarPopup(input_name){
	var url = "../../common/calendar.jsp?field_name="+input_name ;
	window.open(url,'_calendar','top=190,left=500,width=250,height=220,resizable=true,scrollbars=no');	
}
function popUp(arg0){
	var url = arg0 ;
	window.open(url,'','top=100,left=100,width=800,height=600,resizable=true,scrollbars=no');	
}

function onUserSelected(selectedPeople, inputName){

	var userEndpoints = '';
	var userNames = '';
	var genders = '';
	var birthdays = '';
	var sep = '';
    var genXML = '';
    var chkCnt = 0;
	for(i=0; i<selectedPeople.length; i++){
		if(chkCnt==0){
			genXML = genXML + "  <<%=rmClsName%>>"; 
			genXML = genXML + "  <endpoint>"+selectedPeople[i].id+"</endpoint>";								
		}
		if(chkCnt==1){
			genXML = genXML + "<multipleMappings>";
			genXML = genXML + "  <<%=rmClsName%> reference='../..'/>";
		}
		if(chkCnt>0){
			genXML = genXML + "<<%=rmClsName%>>";
			genXML = genXML + "  <endpoint>"+selectedPeople[i].id+"</endpoint>";
			genXML = genXML + "</<%=rmClsName%>>";
		}
		chkCnt++;
		
		userNames += (sep + selectedPeople[i].name);		
		genders += (sep + selectedPeople[i].isMale);		
		birthdays += (sep + selectedPeople[i].birthday);	
		sep = ';';
	}
	if(chkCnt>1){
		genXML = genXML + "</multipleMappings>";
	}
	if(chkCnt>0){
		genXML = genXML + "</<%=rmClsName%>>";
	}

	var inputNameSplit = inputName.split('[');
	var indexStr = '';
	if(inputNameSplit[1]!=undefined){
		indexStr = '['+inputNameSplit[1];
	}

	document.forms[0].elements[inputNameSplit[0]+'_display'+indexStr].value = userNames;
	document.forms[0].elements[inputNameSplit[0]+'__which_is_xml_value'+indexStr].value = genXML;
}

	
function searchPeopleObj(obj){
	var inputName = ""+obj.name; 
	var orgPicker = window.open('<%=GlobalContext.WEB_CONTEXT_ROOT%>/common/organizationChartPicker.jsp','_new','width=380,height=450,resizable=true,scrollbars=no');

	orgPicker.onOk = onUserSelected;
	orgPicker.inputName = inputName;
}

function setDate(imgobj) {
		
		var name = ""+imgobj.id;
		var addString='';
		if(name.indexOf('[')>-1){
			addString = "["+name.split("[")[1];
			name = name.split("[")[0];
		}
		name = name.substring(0, name.length - 13);
		
		var buttonName = name+"_date_trigger"+addString;

		var inputFieldName = name+addString;
		
		//alert(inputFieldName);alert(buttonName);
        Calendar.setup({
            inputField     :    inputFieldName ,    
            ifFormat       :    "y-mm-dd",      
            button         :    buttonName,  
            align          :    "BC",           // alignment (defaults to "Bl")
            singleClick    :    true,
            callback       :    true
        });
}

String.prototype.replaceAll = function(str1, str2)
{
	var temp_str = this.trim();
//	temp_str = temp_str.replace(eval("/" + str1 + "/gi"), str2);
	temp_str = temp_str.replace(new RegExp(str1, "gi"), str2);  
	return temp_str;
}
	
String.prototype.trim = function()
{
	 return this.replace(/(^\s*)|(\s*$)/gi, "");
}

function openSelectProcessDefinition(obj){
	var ctrlName = obj.name.split('_ProcessDefinition_button');

	var addArrayString = '';
	if(ctrlName[1].indexOf('[')>-1){
		addArrayString=ctrlName[1];
	}
	var input_processDefinitionName = ctrlName[0]+"_ProcessDefinition_Name"+addArrayString;
	var input_processDefinitionAlias = ctrlName[0]+addArrayString;

	var url = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/selectProcessDefinition_frame.jsp";
	var StrOption ;
	StrOption  = "dialogWidth:500px;dialogHeight:300px;";
	StrOption += "center:on;scroll:auto;status:off;resizable:no";
	var arrResult = new Array(2);
	arrResult = showModalDialog (url , window, StrOption);
	
	if( arrResult != null && arrResult[0] != null ){
		document.getElementById(input_processDefinitionName).value=arrResult[1];
		document.getElementById(input_processDefinitionAlias).value="["+arrResult[2]+"]";
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
		
		url="dbBrowser.jsp?sql="+sql+"&dsn="+dsn+"&ctrlName="+valueCtrlName;
 
        window.open(url,'dbBrowser','top=190,left=500,width=250,height=300,resizable=true,scrollbars=yes');
}

function addRow(btn, deletorName){    

   var table = btn;
   var existingRow = null;
   
   while(!table.rows){
     table= table.parentElement;
     if(table.cells) existingRow = table;
   }
   
   var indexOfExistingRow = 0;
   for(i=0; i<table.rows.length; i++){
      if(table.rows[i]==existingRow){
       		indexOfExistingRow = i;
       		break;
      }
   }
   
//   alert("indexOfExistingRow="+indexOfExistingRow);
   if(table.rows.length - 1 > indexOfExistingRow){
   		table.deleteRow(indexOfExistingRow);
   		return;
   }

   var oRow = table.insertRow();
 
   for(i=0; i<existingRow.cells.length; i++){
      var oCell = oRow.insertCell();
      var existingRowHTML = existingRow.cells[i].innerHTML;
    
      var namePairs= existingRowHTML.split(" name=");
      var newHTML="";
      newHTML = newHTML + namePairs[0];
      for(j=1; j<namePairs.length; j++){
        
        var separator = " ";
      	var nameAndRemainder = namePairs[j].split(" ");
      	
      	var nameAndRemainderB = namePairs[j].split(">");
      	if(nameAndRemainderB[0].length < nameAndRemainder[0].length){
      		nameAndRemainder = nameAndRemainderB;
      		separator=">";
      	}
      		
      	var nameAndRemainderC = namePairs[j].split("\"");
      	if(nameAndRemainderC[0].length < nameAndRemainder[0].length){
      		nameAndRemainder = nameAndRemainderC;
      		separator="\"";
      	}
      	
         var n = table.rows.length - 2;
      	
      	var nameOnly = nameAndRemainder[0];
      	var addArrayString = '';
      	var arrayIndexPos = nameOnly.indexOf("[");
      	if( arrayIndexPos > -1 ){
      		var nameOnlyArray = nameOnly.split('[');
      		if(nameOnlyArray.length >2){
      		   addArrayString = '['+nameOnlyArray[2];
      		}
      	    var fileNameTemp = nameOnly.split('[')[1];
            fileNameTemp = fileNameTemp.replace('[','');
            n = fileNameTemp.replace(']','');     	
      	    n++;
 
      		nameOnly = nameOnly.substring(0, arrayIndexPos);
      	}
      	      	
        newHTML = newHTML + " name=" + nameOnly + "["+n+"]"+addArrayString;
        
        var maxCnt = nameAndRemainder.length;
      	for(k=1; k<nameAndRemainder.length; k++){
			newHTML = newHTML + separator + nameAndRemainder[k];
	    }
     }

      namePairs= newHTML.split(" id=");
      newHTML="";
      newHTML = newHTML + namePairs[0];
      for(j=1; j<namePairs.length; j++){
        
        var separator = " ";
      	var nameAndRemainder = namePairs[j].split(" ");
      	
      	var nameAndRemainderB = namePairs[j].split(">");
      	if(nameAndRemainderB[0].length < nameAndRemainder[0].length){
      		nameAndRemainder = nameAndRemainderB;
      		separator=">";
      	}
      		
      	var nameAndRemainderC = namePairs[j].split("\"");
      	if(nameAndRemainderC[0].length < nameAndRemainder[0].length){
      		nameAndRemainder = nameAndRemainderC;
      		separator="\"";
      	}
      	
         var n = table.rows.length - 2;
      	
      	var nameOnly = nameAndRemainder[0];
      	var addArrayString = '';
      	var arrayIndexPos = nameOnly.indexOf("[");
      	if( arrayIndexPos > -1 ){
      		var nameOnlyArray = nameOnly.split('[');
      		if(nameOnlyArray.length >2){
      		   addArrayString = '['+nameOnlyArray[2];
      		}
      	    var fileNameTemp = nameOnly.split('[')[1];
            fileNameTemp = fileNameTemp.replace('[','');
            n = fileNameTemp.replace(']','');     	
      	    n++;
 
      		nameOnly = nameOnly.substring(0, arrayIndexPos);
      	}
      	      	
        newHTML = newHTML + " id=" + nameOnly + "["+n+"]"+addArrayString;
        
        var maxCnt = nameAndRemainder.length;
      	for(k=1; k<nameAndRemainder.length; k++){
			newHTML = newHTML + separator + nameAndRemainder[k];
	    }
     }
     
      oCell.innerHTML = newHTML;      
   }
   
	return table.rows.length-2;
}



var onDataReceive;
function requestDataLoad(sql, onDataReceive_)
{
onDataReceive = onDataReceive_;
	createXMLHttpRequest();
	xmlHttp.onreadystatechange=onDataLoad;
	
	xmlHttp.open("GET","dbValueLoader.jsp?sql=" + sql, true);
	xmlHttp.send(null);
}

var xmlHttp;
function createXMLHttpRequest()
{
	if (window.ActiveXObject)
	{
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xmlHttp=new XMLHttprequest();
	}
}

function onDataLoad(){
  if(xmlHttp.readyState == 4) {
    if(xmlHttp.status == 200) {
    //eval("alert('xx')");
	eval(onDataReceive + "('"+xmlHttp.responseText+"')");
    }
  }
}

function openTableAsXSL(htmlTableName){

	var table = document.getElementById(htmlTableName);
//alert(table);

	for(i=0; i<table.rows.length; i++){

		var row = table.rows[i];
//alert(row);
		for(k=0; k<row.cells.length; k++){
			var oCell = row.cells[k];

		      for(j=0; j<oCell.childNodes.length; j++){
		      	var child = oCell.childNodes[j];
		      	if(child.name){
		      		var elemName = child.name;
		      		//alert(elemName);
		      		
		      		try{
		      		
		      			oCell.innerHTML = document.forms[0].all[elemName].value;
		      		}catch(e){
		      		}
		      	}
		      }
		}
	}

	document.hiddenForm.value.value="<table>" + document.getElementById(htmlTableName).innerHTML + "</table>";
	
	document.hiddenForm.action='xls.jsp';
	document.hiddenForm.submit();

}

/// fileupload//////////////////////////////////////////////////////////////////////////////
var scripts = new Array;


function changeEncTypeToMultipart(){
		document.forms[0].encoding = 'multipart/form-data';
}

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
	
	for(var i=obj.sourceIndex; i>=0; i--){
		var tg = document.all(i);
		if(tg.tagName == 'SELECT')	{
		    var seq = tg.options.length;
		    var display_script = idx+","+val+","+obj.name+","+indexCtrl+","+seq;
		    tg.options.add(new Option(display_script, seq));
		    break;
		}
		if(tg.id=='file_items'){
			tg.insertAdjacentHTML("afterEnd", file_script);
		}	
	}
}

function fuItem_list(ctrlSourceIndex) {
	var validate_cnt = 0;
	var display_scripts = '';

	for(var i=ctrlSourceIndex; i>=0; i--){
		var tg = document.all(i);

		if(tg.id=='display_items'){
			tg.innerHTML = display_scripts;
			break;
		}	
		if(tg.tagName == 'SELECT')	{
		    validate_cnt = tg.options.length;
		    if (validate_cnt == 0){
			    display_scripts = 'No files..';	
			}else{
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
	for(var i=document.getElementById(fileCtrlName).sourceIndex; i>=0; i--){
		var tg = document.all(i);
		if(tg.tagName == 'SELECT')	{
		    tg.remove(seq); 
		    break;
		}
		if(tg.id=='file_item'+idx){
	
		   tg.innerHTML = '';
		}
    } 
    
	//document.getElementById('file_item;+idx).innerHTML = '';

	fuItem_list(ctrlSourceIndex);
}

function fuPreprocessing() {
	var idx = scripts.length + 1;
	if(document.getElementById('file_item'+idx)!=undefined)
	   document.getElementById('file_item'+idx).innerHTML = '';
}

function initUploadScripts(){
	var i=0;
	if(document.getElementById('display_items') !=undefined){
		while(true){
			var tg = document.all(i);
			if(tg ==null || tg ==""){ 
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
			while(true){
				if(tg.id == 'file_item'+j){
				   tg.innerHTML = '';
				}
				j++;
				if(j>10){ break;}
			}
			i++;
		}
	}
}


function removeCtrlIcon(){
  var ctrlIcon = document.all['ctrlIconDiv'];

  if(ctrlIcon !=undefined){
  	  if(ctrlIcon.length == undefined){
  	  		ctrlIcon.style.display="NONE";
  	  }else{
		  for(i=0;i<ctrlIcon.length;i++){
		     ctrlIcon[i].style.display="NONE";
		  }
	  }
  }
}


/// fileupload//////////////////////////////////////////////////////////////////////////////

function disableFuncAlert(){
	var url='<%=GlobalContext.WEB_CONTEXT_ROOT%>/common/alertWindow.jsp';
	window.open(url,'','top=300,left=400,width=450,height=150,resizable=no,scrollbars=no');	
}