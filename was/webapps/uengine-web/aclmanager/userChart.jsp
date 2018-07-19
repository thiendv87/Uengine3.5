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

//	List results = UserLocalServiceUtil.search(loggedUser.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), new ContactLastNameComparator(true));

//	int cnt = UserLocalServiceUtil.searchCount(loggedUser.getCompanyId(), "", "", "", "", true, null, false);
	List results = UserLocalServiceUtil.search(loggedUser.getCompanyId(), null, null, null, null, true, null, true, 0, 1000, new ContactLastNameComparator(true));

	com.liferay.portal.model.User[] users = (User[])results.toArray(new com.liferay.portal.model.User[0]);
	
	for(int i=0; i<users.length; i++){
	%>
		<option value="id=<%= users[i].getUserId() %>;name=<%= users[i].getFullName() %>;isMale=<%=users[i].isMale()%>;birthday=<%=users[i].getBirthday().getTime()%>;title=title;loginName=loginName"> + <%= users[i].getFullName() %> <br>
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
