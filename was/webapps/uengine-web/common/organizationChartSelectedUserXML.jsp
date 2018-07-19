<?xml version="1.0" encoding="UTF-8"?>
<%
response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@include file="header.jsp" %>
<%@page import="javax.transaction.*"%>

<%
	Vector roleUserList = new Vector();
	Vector groupUserList = new Vector();
	Vector selectedUsers = new Vector();
	String selectedRoles = request.getParameter("role");
	String selectedGroups = request.getParameter("group");
	
	
/*	String[] selectedRolesSplit = selectedRoles.split(";");
	for(int i=0; i<selectedRolesSplit.length ; i++){
		String[] selectedRolesId = selectedRolesSplit[i].split("=");
		
		List roleUsers = UserLocalServiceUtil.getRoleUsers(selectedRolesId[0]);
		com.liferay.portal.model.User[] users = (User[])roleUsers.toArray(new com.liferay.portal.model.User[0]);
		for(int j=0; j<users.length ;j++){
			if(!roleUserList.contains(users[j].getUserId())){
				roleUserList.add(users[j].getUserId());
			}
		}
	}
	

	String[] selectedGroupSplit = selectedGroups.split(";");
	for(int i=0; i<selectedGroupSplit.length ; i++){
		String[] selectedGroupsId = selectedGroupSplit[i].split("=");
		
		List groupUsers = UserLocalServiceUtil.getUserGroupUsers(selectedGroupsId[0]);
		com.liferay.portal.model.User[] users = (User[])groupUsers.toArray(new com.liferay.portal.model.User[0]);
		for(int j=0 ; j<users.length ; j++){
			if(!groupUserList.contains(users[j].getUserId())){
				groupUserList.add(users[j].getUserId());
			}
		}
	}
	
	if(!(groupUserList.size() == 0)){
		if(roleUserList.size() == 0){
			for(int i=0; i<groupUserList.size() ;i++){
				selectedUsers.add(groupUserList.get(i));
			}
		}else{
			for(int i=0; i< groupUserList.size() ; i++){
				if(roleUserList.contains(groupUserList.get(i))){
					selectedUsers.add(groupUserList.get(i));
				}
			}
		}
	}else{
		if(!(roleUserList.size() == 0)){
			for(int i=0; i< roleUserList.size() ; i++){
				selectedUsers.add(roleUserList.get(i));
			}
		}
	}	
	*/



	int userGroupCnt = UserLocalServiceUtil.searchCount(loggedUser.getCompanyId(), null, null, null);
	java.util.List selectedUsers  = UserLocalServiceUtil.search(loggedUser.getCompanyId(), null, new Boolean(true), null, 0, userGroupCnt, null);
	com.liferay.portal.model.User[] completeUsers = new com.liferay.portal.model.User[selectedUsers.size()];

%><response><%
	for(int i = 0; i < selectedUsers.size(); i++){
		
//		completeUsers[i] = UserLocalServiceUtil.getUserById(selectedUsers.get(i));
//		if(!completeUsers[i].isActive())continue;
		
	
%><users> 
		<name><%= selectedUsers[i].getUserId() %></name>
		<value><%=selectedUsers[i].getFullName() %></value>
</users>
<% 
	}
%>
</response>
