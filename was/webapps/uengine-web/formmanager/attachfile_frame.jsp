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
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.commons.brainnet.commons.Constants"%>
<%
	String hiddenFieldName = request.getParameter("hiddenFieldName");
	String attrId = request.getParameter("attrId");
	System.out.println("hiddenFieldName : " + hiddenFieldName);
%>
<html>
<head>
<title>첨부파일 초기값 설정</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<frameset cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="attachfile.jsp?hiddenFieldName=<%=hiddenFieldName%>&attrId=<%=attrId%>"  name="main" SCROLLING="yes" >
</frameset>

<noframes> 


<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes> 
</html>
