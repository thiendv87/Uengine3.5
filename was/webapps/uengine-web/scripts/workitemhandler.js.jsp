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
	document.forms[0].all[inputName+'_gender'].value = genders;
	document.forms[0].all[inputName+'_birthday'].value = birthdays;
	document.forms[0].all[inputName].value = userEndpoints;
}

function searchPeople(inputName){
	var orgPicker = window.open('/uengine-web/common/organizationChartPicker.jsp','_new','width=430,height=560,resizable=true,scrollbars=yes');
	orgPicker.onOk = onUserSelected;
	orgPicker.inputName = inputName;
}

	function setDate(name) {
        Calendar.setup({
            inputField     :    name + "_date",    
            ifFormat       :    "y-mm-dd",      
            button         :    name + "_date_trigger",  
            align          :    "BC",           // alignment (defaults to "Bl")
            singleClick    :    true,
            callback       :    true
        });
	}
    
