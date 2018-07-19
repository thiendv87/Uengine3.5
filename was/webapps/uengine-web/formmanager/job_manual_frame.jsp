<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%
	String formId = request.getParameter("formId");
	
%>
<html>
<head>
<title>¸Å´º¾ó</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<frameset cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="job_manual.jsp?formid=<%=formId%>"  name="main" SCROLLING="yes" >
</frameset>

<noframes> 


<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes> 
</html>
