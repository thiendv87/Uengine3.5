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

function bindingFormValue(formName, formValue) {
	var obj = document.getElementById(formName);
	var objType = obj.type;
	var objName;

	if( objType == "text" || objType == "select-one"){
		obj.value = formValue;
	} else if(objType == "hidden") {
		obj.value = formValue;
		var arrValue = formValue.split("||");
		var arrValue2;
		var attachObj = formName;
		var index = attachObj.lastIndexOf("_file");

		if(index > -1) {
			attachObj = attachObj.substring(0,6);
			for(i=0; i<arrValue.length; i++) {
				if(arrValue[i].length > 0) {
					arrValue2 = arrValue[i].split("|");
					addList(arrValue2[0], arrValue2[1], arrValue2[2], attachObj);
				}
			}
		}
	} else if(objType == 'textarea') {
		formValue = formValue.replace(/@xonebpm@/g, "\n");
		obj.value = formValue;
	} else if(objType == 'radio' || objType == 'checkbox') {
		objName = document.getElementsByName(formName);
		for(var i = 0; i < objName.length; i++) {
			if(objName[i].value == formValue) {
				objName[i].checked = true;
			} else {
				objName[i].checked = false;
			}
		}
	}
}

function openCalendarPopup(input_name){
	var url = "../../common/calendar.jsp?field_name="+input_name ;
	window.open(url,'_calendar','top=190,left=500,width=250,height=220,resizable=true,scrollbars=no');	
}

function searchPeople(inputName){
	var orgPicker = window.open('../../common/organizationChartPicker.jsp','_new','width=230,height=300,resizable=true,scrollbars=no');
	orgPicker.focus();
	orgPicker.onOk = onUserSelected;
	orgPicker.inputName = inputName;
}

function onUserSelected(selectedPeople, inputName){
	var userEndpoints = '';
	var userNames = '';
	var genders = '';
	var birthdays = '';
	var sep = '';

	for(i=0; i<selectedPeople.length; i++){
		userEndpoints += (sep + selectedPeople[i].id);		userNames += (sep + selectedPeople[i].name);		genders += (sep + selectedPeople[i].isMale);		birthdays += (sep + selectedPeople[i].birthday);		sep = ';';
	}

	document.forms[0].all[inputName+'_display'].value = userNames;
	//document.forms[0].all[inputName+'_gender'].value = genders;
	//document.forms[0].all[inputName+'_birthday'].value = birthdays;
	document.forms[0].all[inputName].value = userEndpoints;
}