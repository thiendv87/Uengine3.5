<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%
	String formId = request.getParameter("formId");
	String formVerId = request.getParameter("formVerId");

	String ownCompany = request.getParameter("ownCompany");	

	System.out.println("select_binding_mandatory_element_frame.jsp : formId : " + formId);
	System.out.println("select_binding_mandatory_element_frame.jsp : formVerId : " + formVerId);
	System.out.println("select_binding_mandatory_element_frame.jsp : ownCompany : " + ownCompany);	
	
%>
<html>
<head>
<title>필수입력항목설정</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<frameset cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="select_binding_mandatory_element.jsp?formId=<%=formId%>&formVerId=<%=formVerId%>"  name="main" SCROLLING="no" >
</frameset>

<noframes> 


<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes> 
</html>
