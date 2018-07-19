<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.io.*, org.apache.commons.fileupload.servlet.* ,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../../common/header.jsp"%>
	<%@include file="../../common/getLoggedUser.jsp"%>
    <%@include file="../../common/styleHeader.jsp"%>
    
    <style type="text/css">
    	html, body {
    		margin: 0px;
    	}
    </style>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
	
	<script type="text/javascript">
	var groupInformation = window.dialogArguments;
	//var groupName = groupInformation.name.decodeURI();
	//var groupCode = groupInformation.code.decodeURI();
	var groupName = groupInformation.name;
    var groupCode = groupInformation.code;
	var imgSrc = groupInformation.imgSrc;
	document.title = "Change image for " + groupName;

	function init() {
		var imgGroupLogo = document.getElementById("idImgGroupLogo");
		imgGroupLogo.src = imgSrc;
		
		var inputGroupCode = document.getElementById("idInputGroupCode");
		inputGroupCode.value = groupCode;
	}
	</script>
	<base target="_self"/>
</head>
<body onload="init();">
	<script type="text/javascript">
		var tmp = ["Logo image"];
		createTabs(tmp);
	</script>
	 <br>
	
	
	<center>
	<img id="idImgGroupLogo" src="" />
	<br>
	<form name="formGroupLogo" action="groupLogoUpload.jsp" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="inputGroupCode" id="idInputGroupCode"/>
	<input type="file" name="fileGroupLogo" />
	<br/>197 * 74<br/>
	<input type="submit" value="<%=GlobalContext.getMessageForWeb("UPLOAD", loggedUserLocale)%>"/>
	</form>
	</center>
</body>
</html>