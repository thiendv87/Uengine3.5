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
<%@page import="java.io.*" %>
<%@page import="hanwha.commons.util.*" %>
<%
	String contents = request.getParameter("contents");
	String path = request.getParameter("path");
	if ( path != null && contents != null ) {
		path = GWUtil.toEncode(path);
		contents = GWUtil.toEncode(contents);
		
		GWUtil.saveContents(path, contents);
//		GWUtil.saveContents(path, contents, "KSC5601");
		hanwha.commons.prop.Global.reloadBundle();
	}
	System.out.println(contents + ", " + path);
	
%>

<script>
	alert("저장에 성공하였습니다");
</script>