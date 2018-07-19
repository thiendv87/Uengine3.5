<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	String type = request.getParameter("type");
	String objType = request.getParameter("objType");
	String code = request.getParameter("code");
	String comCode = request.getParameter("comCode");
	String itemName = reqMap.getString("itemName", "Organization Tree");
%>
<html>
<head>
	<title><%=GlobalContext.getMessageForWeb("Organization List", loggedUserLocale) %></title>
	<%@include file="../common/styleHeader.jsp"%>
	<style type="text/css">
	</style>
    <LINK rel="stylesheet" href="../style/form.css" type="text/css"/>
    
	<script type="text/javascript">
		var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
		
		function init()
		{
			tbodyUsers = document.getElementById("tbodyUsers");
			tbodyGroups = document.getElementById("tbodyGroups");
			getGrouptList("<%=type%>", "<%=code%>");
		}
	</script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/crossBrowser/elementControl.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/organizationScript.js"></script>
	<link href="../style/default.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="init();" style="padding: 15px;">
<div id="divDescriptionForGroup" onmouseout="hideElement(this);" 
style="background-color: white; display: none; position: absolute; padding:5px 15px 15px 15px; border:1px solid #666; z-index: 2;"></div>

	<div id="idDivInformation">
	<span class="sectiontitle" id="idSpanTitle"><%=itemName %> Information</span>
	<table border="0" cellpadding="0" cellspacing="0" width="100%"  class="tableborder">
		<col span="1" width="150" />
		<col span="1" width="170" />
		<col span="1" />
		<col span="1" />
		<col span="1" />
		<col span="1" />
		<thead>
			<tr><td class="formheadline" colspan="6"></td></tr>
		</thead>
		<tbody id="idRowLogoImage">
			<tr>
				<td class="formtitle"><%=GlobalContext.getMessageForWeb("LOGO IMAGE", loggedUserLocale)%></td>
				<td class="formcon" colspan="5"><img onclick="changeGroupImage();" alt="Click for change" style="cursor: pointer;" id="idImgLogo" src="" onerror="setNoImage(this);" width="137" height="49" align="top" /></td>
			</tr>
			<tr><td class="formline" colspan="6" height="1"></td></tr>
		</tbody>
		<tbody>
			<tr>
				<td class="formtitle"><%=GlobalContext.getMessageForWeb("NAME", loggedUserLocale)%></td>
				<td class="formcon"><span id="idSpanName"></span></td>
				<td class="formtitle"><%=GlobalContext.getMessageForWeb("ID", loggedUserLocale)%></td>
				<td class="formcon"><span id="idSpanCode"></span></td>
				<td class="formtitle"><%=GlobalContext.getMessageForWeb("TYPE", loggedUserLocale)%></td>
				<td class="formcon"><span id="idSpanType"></span></td>
			</tr>
			<tr><td class="formline" colspan="6" height="1"></td></tr>
			<tr>
				<td class="formtitle"><%=GlobalContext.getMessageForWeb("DESCRIPTION", loggedUserLocale)%></td>
				<td class="formcon" colspan="5"><span id="idSpanDescription"></span></td>
			</tr>
		</tbody>
		<tfoot>
			<tr><td class="formheadline" colspan="6"></td></tr>
		</tfoot>
	</table>
	<br /><br />
	</div>
	
	<span class="sectiontitle" id="span_child_grp_name">Children groups of <%=itemName %></span>
	<table border="0" cellpadding="0" cellspacing="0" width="100%"  class="tableborder">
		<thead  class="tabletitle">
			<tr height="25">
				<th><%=GlobalContext.getMessageForWeb("GROUP NAME", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("GROUP CODE", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("GROUP DESC", loggedUserLocale)%></th>
			</tr>
		</thead>
		<tbody id="tbodyGroups"></tbody>
	</table>
	
	<br /><br />
	<span class="sectiontitle" id="span_child_usr_name">Children users of <%=itemName %></span>
	<table border="0" cellpadding="0" cellspacing="0" width="100%"  class="tableborder">
		<col span="1" width="25%" align="center" />
		<col span="1" width="25%" align="center" />
		<col span="1" width="25%" align="center" />
		<col span="1" width="25%" align="center" />
		<thead  class="tabletitle">
			<tr height="25">
				<th><%=GlobalContext.getMessageForWeb("Name", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Department", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Company", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Email", loggedUserLocale)%></th>
			</tr>
		</thead>
		<tbody id="tbodyUsers"></tbody>
	</table>
	
</body>
</html>
