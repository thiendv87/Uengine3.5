<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	int defId = Integer.parseInt(request.getParameter("defId"));
	AclManager acl = AclManager.getInstance(); 
	HashMap permission = acl.getPermission(defId, loggedUserId);
	if (loggedUserIsAdmin || permission.containsKey(AclManager.PERMISSION_MANAGEMENT)) {
		String todo = request.getParameter("todo");
		
		if ("add".equals(todo)) {
			String[] permissions = request.getParameterValues("permission");
			String userType = request.getParameter("userType");
			String userCode = request.getParameter(userType);
			
			acl.setPermission(defId, userType, userCode, permissions);
			
		} else if ("delete".equals(todo)) {
			int iAclId = Integer.parseInt(request.getParameter("aclId"));
			acl.removePermission(iAclId);
		}
%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		
		<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>Insert title here</title>
		</head>
		<body>
			<form name="formAuthority" action="authority.jsp" method="post">
				<input type="hidden" name="defId" value="<%=defId %>" />
				<input type="hidden" name="defName" value="<%=request.getParameter("defName") %>" />
			</form>
			<script type="text/javascript">
				document.formAuthority.submit();
			</script>
		</body>
		</html>
	<% } else { %>
		<script type="text/javascript">
			alert("You don't have Management Authority");
			window.location.href = "../processmanager/processInstanceList.jsp"; 
		</script>
	<% } %>