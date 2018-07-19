<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%--
  - Author(s): Sungsoo Park
  - Copyright Notice:
	Copyright 2001-2005 by HANWHA S&C Corp.,
	All rights reserved.

	This software is the confidential and proprietary information
	of HANWHA S&C Corp. ("Confidential Information").  You
	shall not disclose such Confidential Information and shall use
	it only in accordance with the terms of the license agreement
	you entered into with HANWHA S&C Corp.
  - @(#)
  - Description: ¹®¼­À¯
--%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.bpm.util.IDAOGenerator"%>
<%@page import="hanwha.bpm.util.StringUtils"%>
<%
	IDAOGenerator iDAOGen = new IDAOGenerator();
	iDAOGen.populate(pageContext);
	System.out.println(iDAOGen.generateDAOClass());
	System.out.println(iDAOGen.generateDAOTemplateCode());
%>
<XML id="responseXML">
<template>
	<template id="DAO_DECLARATION">
	<![CDATA[<%=iDAOGen.generateDAOClass()%>]]>
	</template>
	<template id="DAO_CODE">
	<![CDATA[<%=iDAOGen.generateDAOTemplateCode()%>]]>
	</template>
</template>
</XML>