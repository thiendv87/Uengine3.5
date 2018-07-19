<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
    boolean isAutoComplete = false;
%>

<html>
<head>
	<style type="text/css">
		body {
			scrollbar-3dlight-color:#989898;
			scrollbar-arrow-color:#FFFFFF;
			scrollbar-base-color:#CFCFCF;
			scrollbar-darkshadow-color:#FFFFFF;
			scrollbar-face-color:#CFCFCF;
			scrollbar-highlight-color:#FFFFFF;
			scrollbar-shadow-color:#989898;
			background:url(../../processmanager/images/empty.gif) #ffffff;
		}
	</style>
	<%@page import="org.uengine.contexts.HtmlFormContext" %>
	<%@page import="org.uengine.contexts.MappingContext" %>
	<%@page import="org.uengine.formmanager.FormUtil" %>
	<%@page import="org.uengine.util.*" %> 

	<style TYPE="TEXT/CSS"> 
		BODY {
			background:url(../../processmanager/images/empty.gif) #ffffff
		}
	</style> 
</head>

<body onload="enableTooltips();drawLoopLines();removeCtrlIcon(); try{eval('onLoadForm()');}catch(e){}" onunload="try{opener.refresh()}catch(e){}" style="overflow:auto;"> 
	
	<form name="mainForm" action=submit.jsp method=POST>
	<%@include file="/bpm/wih/wihHeaderInfo.jsp"%>

	<div style="overflow-y:hidden;white-space:nowrap">
		<%@include file="../wihDefaultTemplate/showFlowChart.jsp"%>
	</div>

	</form>
	
	<form name=hiddenForm method=POST>
		<input type=hidden name="value">
	</form>

</body>



<script src="../../scripts/showFormContent.js" type="text/javascript" ></script>

</html>
