<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.io.*, org.apache.commons.fileupload.servlet.* ,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.uengine.kernel.GlobalContext"%><html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<%@include file="../common/header.jsp"%>
	<%@include file="../common/getLoggedUser.jsp"%>
    <%@include file="../common/styleHeader.jsp"%>
	
	<% 
	 	String imgPath = request.getParameter("imgPath");
	%>
	<script type="text/javascript">
	var da = window.dialogArguments;
	var empName = da.empName.value;
	var empCode = da.empCode.value;
	
	document.title = empName + "님의 사진정보 변경";

	var dir = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/portrait/";


	function init() {	
		
		var divUserOldPic = document.getElementById("divUserOldPic");
		
		var img = document.createElement("img");
		img.src = '<%=imgPath %>';

		img.height = 135;
		img.width = 105;
		divUserOldPic.appendChild(img);

		var inputEmp = document.getElementById("emp");
		inputEmp.value = empCode;
	}
	
	function checkPic(file) {
/*		var divUserNewPic = document.getElementById("divUserNewPic");
		var src = "file://" + file.value.replace(/\\/gi, "/");
		divUserNewPic.innerHTML = "<img src='"+src+"'/>";
*/		
	}

	</script>
	<base target="_self"/>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
</head>
<body onLoad="init();" style="">
<script type="text/javascript">
	var tmp = new Array(
			"User Picture"
	);
	createTabs(tmp);
</script>
 <br>


<center>
<div id="divUserOldPic"></div>
<br>
<!-- 
<div id="divUserNewPic"></div>
-->
<form name="formUserPic" action="userPictureUpload.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="emp" id="emp"/>
<input type="file" name="fileUserPic" onChange="checkPic(this);" />
<br/><br/><input type="submit" value="upload"/>
</form>
</center>
</body>
</html>