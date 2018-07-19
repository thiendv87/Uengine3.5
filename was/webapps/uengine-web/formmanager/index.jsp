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
  - Description: 폼 어플리케이션 관리자 프레임
--%>
<%@include file="../../common/no_cache.jsp"%>
<html>
<head>
<title>EagleBPM 폼 어플리케이션 관리자</title>
</head>
<frameset id="mainFrameSet" name="mainFrameSet" cols="255,*" border="0" frameborder="0">
    <frame id="left" name="left" src="./menu.jsp" marginleft="0" marginright="0" margintop="0" scrolling="no" frameborder="0" noresize>
    <frame id="right" name="right" src="./edit.jsp" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0" noresize>
</frameset>

</html>
