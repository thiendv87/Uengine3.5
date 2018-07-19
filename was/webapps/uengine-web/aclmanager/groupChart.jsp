<script type="text/javascript">
	// 占쏙옙占시듸옙 占쏙옙占쏙옙占�/占싸쇽옙 d占쏙옙 클占쏙옙占쏙옙
	function SelectedInfo() {
		var type = '';
		var id = '';
		var name = '';
		var loginName = '';
		var title = '';
		var birthday;
		var isMale = true;
	}
	
	function selectedFromDirectEndpoint(endpointInput){
//		alert(user);
		selectedOrganizationList = new Array();
		var user = new SelectedInfo();
		
		user.type 		= "";
		user.name 		= endpointInput.value;
		user.loginName 	= endpointInput.value;
		user.title 		= "";
		user.isMale		= "true";
		user.birthday	= "";
		user.id = endpointInput.value;
	
		selectedOrganizationList [0] = user;
//		alert(user);
	}
	
	function selected(userlist) {	
		var options = userlist.options;
		var j=0;
		selectedOrganizationList = new Array();
		for(i=0; i<options.length; i++){
			if(options[i].selected){
				var user = new SelectedInfo();
				var bulkUserInfo = options[i].value;
				//alert(bulkUserInfo);
				var keyAndValuePairs = bulkUserInfo.split(";");
				var keyAndValues = new Array();
				
				for(k=0; k<keyAndValuePairs.length; k++){
					var keyAndValue = keyAndValuePairs[k].split("=");
					keyAndValues[keyAndValue[0]] = keyAndValue[1];
				}
				
				user.type 		= keyAndValues["type"];
				user.name 		= keyAndValues["name"];
				user.id 		= keyAndValues["id"];
				user.loginName 	= keyAndValues["loginName"];
				user.title 		= keyAndValues["title"];
				user.isMale		= (keyAndValues["isMale"] == "true");
				user.birthday	= keyAndValues["birthday"];
			
				selectedOrganizationList [j++] = user;
			}
		}
	}
	
	function view() {
		alert(selectedOrganizationInfo.type + "," + selectedOrganizationInfo.id + "," + selectedOrganizationInfo.name + "," + selectedOrganizationInfo.loginName + "," + selectedOrganizationInfo.title);
	}
	
	var selectedOrganizationList = new Array();

</script>


<!-- companyid is <%=loggedUser.getCompanyId()%> -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr height="20" >
<td width="150" align=left bgcolor="f4f4f4">
Organization Chart
</td>
<td width="10"></td>
<td width="*" align=left>
<select multiple name=users size="10" onChange="selected(this)" width=400>
	<option value=""><b>People                              -</b><br>
<%
	int userGroupCnt = UserGroupLocalServiceUtil.searchCount(loggedUser.getCompanyId(), null, null, null);
	java.util.List resultGroups = UserGroupLocalServiceUtil.search(loggedUser.getCompanyId(), null, null, null, 0, userGroupCnt);

	com.liferay.portal.model.UserGroup[] groups = (UserGroup[])resultGroups.toArray(new com.liferay.portal.model.UserGroup[0]);
	
	for(int i=0; i < groups.length; i++){
	%>
		<option value="id=<%= groups[i].getUserGroupId() %>;name=<%= groups[i].getName() %>"> + <%=groups[i].getName() %><br>
	<%
	}

%>
</select>
</td>		
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
<td width="10"></td>
<td align="center" height="1" class="bgcolor_head_upperline"></td>
</tr>

<tr height="20" >
<td width="150" align=left bgcolor="f4f4f4">
Direct endpoint
</td>
<td width="10"></td>
<td width="*" align=left>
	<input size=60 name="direct_endpoint" onChange="selectedFromDirectEndpoint(this)">
</td>		
</tr>
<tr height="1">
<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td height="10"></td>
</tr>
</table>
