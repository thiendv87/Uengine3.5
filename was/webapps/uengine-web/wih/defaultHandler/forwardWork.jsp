<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<%@include file="../../common/header.jsp"%>
	<%@include file="../../common/styleHeader.jsp"%>
	<style type="text/css">
	body {
		margin: 20px;
	}
	</style>
</head>
<body>
<%
	String userId = request.getParameter("userId");
	String taskId = request.getParameter("taskId");
	String  loggedUserId = "";
	
	//plz delete
	String endpoint = request.getParameter("endpoint");
	
	try {
		loggedUserId = (String) session.getAttribute("loggedUserId");
	} catch (Exception e) {}
	
	if (UEngineUtil.isNotEmpty(userId) && userId.equals(loggedUserId)) {
%>
	<script type="text/javascript">
		var screenWidth = screen.width;
		var screenHeight = screen.Height;
		var windowWidth = 950;
		var windowHeight = 650;
		var window_left = (screenWidth-windowWidth)/2; 
		var window_top = (screenHeight-windowHeight)/2;
	
		var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
		var url = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/workitemHandler.jsp?taskId=<%=taskId %>";
		window.open(url, "", option);
		window.location.href = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/index.jsp";
	</script>
<% } else { 
		if(UEngineUtil.isNotEmpty(endpoint)){
%>
<!-- plz delete -->
	<form action="loginAction.jsp" method="post" name="Lform1">
		<input type="hidden" name="userId" value="<%=endpoint %>" />
		<input type="hidden" name="passWd" value="test"/>
		<input type="hidden" name="taskId" value="<%=taskId %>" />
	</form>
	<script>
		document.Lform1.submit(); 
	</script>
<% 	   }else{%>
	<form action="loginAction.jsp" method="post">
		이름 : <input type="text" name="userId" value="<%=userId %>" /><br />
		암호 : <input type="password" name="passWd" /><br />
		<input type="submit">
		<input type="hidden" name="taskId" value="<%=taskId %>" />
	</form>
<%		} 
	} %>
</body>
</html>