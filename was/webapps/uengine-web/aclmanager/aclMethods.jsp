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


function searchPeople(obj,type){
	
	var inputName = ""+obj.name + "_value"; 
	var url="<%=GlobalContext.WEB_CONTEXT_ROOT%>/aclmanager/aclOrganizaionChartPicker.jsp?type="+type;
	var orgPicker = window.open(url,'_new','width=430,height=350,resizable=true,scrollbars=no');

	orgPicker.onOk = onUserSelected;
	orgPicker.inputName = inputName;
}
