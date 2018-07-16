<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	if(isRacing){
%>
		<a href="javascript:acceptWorkitem()"><img src="/images/Common/b_btm_acceptance.gif" /></a>&nbsp;
<%	
	}else{
%>
<div id="bottombtnline">
	<a href="javascript:confirmWI('true');"><img src="/images/Common/b_btn_recognition.gif" /></a>&nbsp;
	<a href="javascript:confirmWI('false');"><img src="/images/Common/b_btn_reject.gif" /></a>&nbsp;
	<a href="javascript:window.parent.window.close();"><img src="/images/Common/b_btm_cancel.gif" /></a>&nbsp;
	<a href="javascript:delegateWorkitem()"><img src="/images/Common/b_btm_commission.gif" /></a>
	<input type=hidden name='delegateEndpoint' >
</div>
<%
	}
%>
<br>