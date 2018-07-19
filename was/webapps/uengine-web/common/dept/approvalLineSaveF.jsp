<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:useBean id="_rdm" type="com.woorifis.srms.core.result.ResultDataManager" scope="request"/>
<jsp:useBean id="_sm" type="com.woorifis.srms.util.SessionManager" scope="request" /> 
<%@page import="com.woorifis.srms.common.bean.ApprovalLineBean"%>
<%@page import="java.util.List"%>
<%@page import="com.woorifis.srms.util.StringUtil"%>
<%@page import="com.woorifis.srms.util.EncodeUtil"%>
<%@page import="com.woorifis.srms.util.DateUtil"%>    
<%
	String grpNm = "";
	StringUtil ut = new StringUtil();
	grpNm = ut.nvl((String)_rdm.get("grpNm"));
%>    
<html>
<head>
<title>Sign up for our newsletter</title>
<link rel="stylesheet" href="/style/formdefault.css" />
<link rel="stylesheet" href="/style/_expando.css" />
<link rel="stylesheet" href="/style/popup.css" />
<script type="text/javascript">
function selfclosef(){
	document.all.myform.closes.value='c';
	parent.emailwindow.hide();
}
</script>
</head>
<body style="background: #F3F3F3">

<div class="pop_layer11" style="padding-top:15px;">
    <div class="box" style="padding-right:0px;">		
		<p class="ab">
        	<div style="height:34px;">
            	<table width="90%" border="0" cellspacing="0" cellpadding="0">
				    <tr>
				        <td><form id="myform">결재선이름 : <input class="tblinput" id="grpNm" type="text" name="grpNm" value="<%=grpNm %>" size="30"/>
				        <input name="closes" type="hidden"></form></td>
				        
				        <td><div id="gBtn"> <a href="#" onClick="parent.emailwindow.hide()"><span>저장</span></a> </div></td>
				        <td><div id="gBtn"> <a href="#" onClick="javascript:selfclosef();"><span>취소</span></a></div></td>
				    </tr>
				</table>
            </div>
		</p>
	</div>
</div>



</body>
</html>
