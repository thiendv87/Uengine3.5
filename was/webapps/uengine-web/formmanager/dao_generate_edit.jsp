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
<%@page import="hanwha.commons.jdom.*" %>
<%@page import="hanwha.commons.jdom.output.*" %>
<%@page import="hanwha.bpm.BPMConstants" %>
<% 
	String path = BPMConstants.FORM_FILE_PATH + "/" + request.getParameter("path");
	String contents = "";
	if ( path != null ) {
		path = GWUtil.toEncode(path);
		System.out.println(path);
		File file = new File(path);
		if ( file.exists() ) {
			FileInputStream resourceFileStream = new FileInputStream(file);
			contents = StreamUtils.getString(resourceFileStream);
			int idx = path.lastIndexOf('.');
			if ( idx > 0 ) {
				String ext = path.substring(idx+1, path.length());
				if ( ext.equalsIgnoreCase("xml") ) {
					Text contentsText = new Text(contents);
					XMLOutputter outputter = new XMLOutputter(Format.getPrettyFormat());					
					contents = outputter.outputString(contentsText);
				}
			}
		}
	}
	if ( path == null ) path = "";
	
%>
<html>
<head>
<title>편집</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK rel="stylesheet" href="<%=CSS%>/portlet.css" type="text/css"/>	
<LINK rel="stylesheet" href="<%=CSS%>/portal.css" type="text/css"/>	
<LINK rel="stylesheet" href="<%=CSS%>/groupware.css" type="text/css"/>
<script type="text/javascript">
	function saveContents() {
		document.editForm.target = "hiddenFrame";
		document.editForm.action = "dao_generate_save.jsp";
		document.editForm.submit();
	}
</script>	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="10" topmargin="0" marginwidth="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="10px"></td>
		<td height="28px" valign="bottom">
			<img src="<%=IMG%>/icon_root.gif" align="absmiddle" width="10" height="11"> 
			<font class="font_small color_weight"><a>완료액션편집</a></font> 
		</td>
		<td></td>
	</tr>
	<tr>
		<td class="path_underline" colspan="3"></td>
	</tr>	
	<tr>
		<td height="5" colspan="3"></td>
	</tr>	
	<tr>
		<td width="10"></td>
		<td align="right">
			<p>
				<img src="<%=IMG%>/bu_save.gif" valign="middle" style="cursor:hand" alt="저장" onclick="saveContents();">
				&nbsp;&nbsp;&nbsp;&nbsp;
			</p>
		</td>
		<td width="10"></td>
	</tr>
	<tr>
		<td height="10"></td>
		<td></td>
		<td></td>
	</tr>	
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td align="center">
			<form name="editForm" method="post">
			<input type="hidden" name="path" value="<%=path%>">
			<textarea name="contents" style="width:90%;height:350px;"><%=contents%></textarea>
			<iframe name="hiddenFrame" style="display:none"></iframe>
			</form>
		</td>
	</tr>
</table>

</body>
</html>


