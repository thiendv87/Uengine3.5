<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	int defId = Integer.parseInt(request.getParameter("defId"));
	String todo = request.getParameter("todo");
	String[] anonymousPermission = request.getParameterValues("anonymousPermission");
	String[] membersPermission = request.getParameterValues("membersPermission");
	
	if ("set".equals(todo)) {
		AclManager acl = AclManager.getInstance();
		acl.setDefaultPermission(defId, anonymousPermission, membersPermission);
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
	<input type="hidden" name="defName" value="<%=request.getParameter("defName") %>" /><br />
</form>
<script type="text/javascript">
document.formAuthority.submit();
</script>
</body>
</html>