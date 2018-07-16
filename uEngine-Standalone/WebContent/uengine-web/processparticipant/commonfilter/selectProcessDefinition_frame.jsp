<%
	String moveToDef = request.getParameter("moveToDef");
%>
<html>
<head>
<title>Process Definition List</title>
</head>
<frameset cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="selectProcessDefinition.jsp?moveToDef=<%=moveToDef%>" name="popmain" scrolling="no">
</frameset>
<noframes> 
</noframes> 
</html>
