/**
 * @author erim1005
 */
var global_tn = '';
function SelectedInfo() {
	var type = '',
		id = '',
		name = '',
		title = '',
		birthday = '',
		isMale = true,
		jikName = ''
	;
}


function getSelectedUsers() {
	if (IS_MULTIPLE) {
		selectedOrganizationList = new Array();
		var j = 0;
		for (var i=0; i < $("#selectUserList option").size(); i++) {
			var user = new SelectedInfo();
			var userInfo = $("#selectUserList option:eq("+i+")").val();
			
			var userInfoArray = userInfo.split(';');
			var userId = userInfoArray[0].split('=');
			var userName = userInfoArray[1].split('=')[1];
			var jikName = userInfoArray[1].split('=')[2];
			user.type 		= "";
			user.name 	= userName.replace('_',' ');
			user.id 		= userId[1];
			user.isMale	= "1";
			user.birthday	= "";
			
			user.jikName = jikName;
			selectedOrganizationList [j++] = user;
		}
	}
//	if (IS_MULTIPLE) {
//		selectedOrganizationList = new Array();
//
//		var selectList = document.mainForm.selectUserList;
//		var j = 0;
//		for (var i=0; i<selectList.options.length; i++) {
//			var user = new SelectedInfo();
//			var userInfo = selectList.options[i].value;
//
//			var userInfoArray = userInfo.split(';');
//			var userId = userInfoArray[0].split('=');
//			var userName = userInfoArray[1].split('=')[1];
//			var jikName = userInfoArray[1].split('=')[2];
//			user.type 		= "";
//			user.name 	= userName.replace('_',' ');
//			user.id 		= userId[1];
//			user.isMale	= "1";
//			user.birthday	= "";
//			
//			user.jikName = jikName;
//			selectedOrganizationList [j++] = user;
//		}
//	}
	
	return selectedOrganizationList;
}

function setUser(chkBoxUser) {
	var userInfo = null;
	var user = new SelectedInfo();
	
	if (chkBoxUser.checked) {
		userInfo = chkBoxUser.value;
		
		var userInfoArray = userInfo.split(';');
		var userId = userInfoArray[0].split('=');
		var userName = userInfoArray[1].split('=')[1].replace('_',' ');
		var jikName = userInfoArray[2].split('=')[1].replace('_',' ');
		
		user.type 		= "";
		user.name 		= userName;
		user.id 		= userId[1];
		user.isMale		= "1";
		user.birthday	= "";
		user.jikName 	= jikName;

		if (IS_MULTIPLE) {
			/*
			var newOption = document.createElement("option");
			var realTargetTag = document.mainForm.selectUserList;
			
			newOption.value = chkBoxUser.value;
			newOption.text = " " + userName
			
			realTargetTag.options.add(newOption);
			*/
			
			// 12.22 add
			var flag 	   = false;
			var selectList = document.forms[0].selectUserList;

			for (var i=0; i<selectList.options.length; i++) {
				var refUserInfo 	  = selectList.options[i].value;
				var refUserInfoArray  = refUserInfo.split(';');
				var refUserId 		  = refUserInfoArray[0].split('=');
				
				if(userId[1] == refUserId[1]){
					flag = true;
					break;
				}
			}
			
			if(flag == false){
				var newOption 	  = document.createElement("option");
				var realTargetTag = document.forms[0].selectUserList;
				newOption.value   = chkBoxUser.value;
				newOption.text    = " " + userName
				realTargetTag.options.add(newOption);
				
			} else {
				userNameList += ((userNameList == "")?user.name:", " + user.name);
			}
		} else {
			selectedOrganizationList = [user];
		}
	}
}

function addUser() {
	var userList = $("input[name='chkUser']");
	
	var userInfo = null;
	var user = new SelectedInfo();
	
	if (userList != null) {
		$("input[name='chkUser']").each(function(index, chkbox) {
	   		if (chkbox.checked) {
	   			userInfo = $(this).val();
	   			
	   			var userInfoArray = userInfo.split(';');
	   			var userId = userInfoArray[0].split('=');
	   			var userName = userInfoArray[1].split('=')[1].replace('_',' ');
	   			var jikName = userInfoArray[2].split('=')[1].replace('_',' ');
	   			
	   			user.type 		= "";
	   			user.name 		= userName;
	   			user.id 		= userId[1];
	   			user.isMale		= "1";
	   			user.birthday	= "";
	   			user.jikName 	= jikName;

	   			if (IS_MULTIPLE) {
	   				var flag 	   = false;
	   				
	   				for (var i=0; i < $("#selectUserList option").size(); i++) {
	   					var refUserInfo 	  = $("#selectUserList option:eq("+i+")").val();
	   					var refUserInfoArray  = refUserInfo.split(';');
	   					var refUserId 		  = refUserInfoArray[0].split('=');
	   					
	   					if(userId[1] == refUserId[1]){
	   						flag = true;
	   						break;
	   					}
	   				}
	   				
	   				if(flag == false){
	   					$("#selectUserList").append("<option value=\""+userInfo+"\">"+user.name+"</option>");
	   				} else {
	   					userNameList += ((userNameList == "")?user.name:", " + user.name);
	   				}
	   			} else {
	   				selectedOrganizationList = [user];
	   			}
	   		}
	    });
		
		if (IS_MULTIPLE) {
			getSelectedUsers(userList);
			
			// 12.22 add
			if(userNameList != ""){
				//alert("해당 유저(들)는 이미 포함되어 있습니다. " + userNameList);
			}
		}
	}
//	var userList = document.mainForm.chkUser;
	
//	if (userList != null) {
//		if (userList.length) {
//			for (var ii = 0; ii < userList.length; ii++) {
//				setUser(userList[ii])
//			}
//		} else {
//			setUser(userList)
//		}
//		
//		if (IS_MULTIPLE) {
//			getSelectedUsers(userList);
//			
//			// 12.22 add
//			if(userNameList != ""){
//				//alert("해당 유저(들)는 이미 포함되어 있습니다. " + userNameList);
//			}
//		}
//	}
}

var ELEMID = "";

//10.04 add
function addUserFromParent(){
	var elemid     = ELEMID.split(',');
	var pidArray   = $("input[name='"+elemid[0]+"']", opener.document).val().split(';');
	var pnameArray = $("input[name='"+elemid[1]+"']", opener.document).val().split(';');
	
	if(pidArray != ""){
		var j = 0;
		for(ii=0; ii<pidArray.length; ii++){
			var newOption 	  = document.createElement("option");
			var realTargetTag = document.forms[0].selectUserList;
			newOption.value   = "id=" + pidArray[ii] + ";name=" + pnameArray[ii] + ";jikName=";
			newOption.text    = " " + pnameArray[ii];
			realTargetTag.options.add(newOption);
			
			$("#selectUserList").append(newOption);
			
			var user 		  = new SelectedInfo();
			user.type 		  = "";
			user.name 		  = pnameArray[ii];
			user.id 		  = pidArray[ii];
			user.isMale		  = "1";
			user.birthday	  = "";
			user.jikName 	  = "";
			selectedOrganizationList[ii] = user;
		}
	}
}

function deleteApproval() {
	$("#selectUserList option:selected").remove();
//	var selectedUser = document.mainForm.selectUserList;
//
//	for (var ii = 0; ii < selectedUser.options.length; ii++) {
//		var option = selectedUser.options[ii];
//		if (option.selected) {
//			selectedUser.options[ii] = null;
//			ii--;
//		}
//	}

	getSelectedUsers();
}

function searchUser() {
	var condition = $("select[name='column']").val();
	var value = $("input[name='key']").val();
	getUserList(condition, value, "tableUserList", IS_MULTIPLE); 
	
	var chkBoxAllUsers = document.getElementById("chkBoxAllUsers");
	if (chkBoxAllUsers) {
		chkBoxAllUsers.checked = false;
	}
}

function chkEnter(e) {
	var code = (window.event) ? event.keyCode : e.which;
	if (code == 13) {
		searchUser();
		if (window.event) {
			window.event.returnValue = false;
		} else {
			e.returnValue = false;
		}
	}
}

// 12.22 add
var userNameList;
var selectedOrganizationList = new Array();
var inpuName = "";