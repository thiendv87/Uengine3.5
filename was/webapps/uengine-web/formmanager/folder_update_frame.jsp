<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%--
  - Author(s): Sungsoo Park ( ghbpark@hanwha.co.kr )
  - Copyright Notice:
	Copyright 2001-2005 by HANWHA S&C Corp.,
	All rights reserved.

	This software is the confidential and proprietary information
	of HANWHA S&C Corp. ("Confidential Information").  You
	shall not disclose such Confidential Information and shall use
	it only in accordance with the terms of the license agreement
	you entered into with HANWHA S&C Corp.
  - @(#)
  - Description:
--%>
<%
	String parentGroupId = request.getParameter("parentGroupId");
	String ownCompany = request.getParameter("ownCompany");	
	String action = request.getParameter("action");	

	System.out.println("parentGroupId : " + parentGroupId);
	System.out.println("ownCompany : " + ownCompany);	
	System.out.println("action : " + action);	
	
	String actionName = (action.equals("add")) ? "추가" : "수정";
%>
<html>
<head>
<title>폴더<%=actionName%></title>
</head>
<frameset cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="folder_update.jsp?action=<%=action%>&ownCompany=<%=ownCompany%>&parentGroupId=<%=parentGroupId%>" name="main" SCROLLING="yes" >
</frameset>

<noframes> 


<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes> 
</html>
