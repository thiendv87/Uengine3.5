<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="portalConst.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>


<html>
<head>
<title>결재선</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<frameset cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="flow_edit.jsp?multiple=<%=request.getParameter("multiple")%>&isChangeApprovalLine=<%= request.getParameter("isChangeApprovalLine") %>"  name="main" SCROLLING="yes" >
  <!-- frame src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/common/dept/userpickerPM"  name="main" SCROLLING="yes" -->
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>
