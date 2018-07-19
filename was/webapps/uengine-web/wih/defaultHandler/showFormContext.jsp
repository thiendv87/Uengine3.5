<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@include file="../wihDefaultTemplate/definition.jsp"%>
<%@include file="../wihDefaultTemplate/initialize.jsp"%>
<%@include file="../wihDefaultTemplate/checkLogin.jsp"%>
<html>
<head>
<style type="text/css"> 
BODY {
	background: url(../../processmanager/images/empty.gif) #ffffff 
}
</style>
	<jsp:include page="../../scripts/formActivity.js.jsp" flush="false">
		<jsp:param name="rmClsName" value="<%=rmClsName%>" />
	</jsp:include>
<script src="../../scripts/showFormContext.js" type="text/javascript" ></script>
<script type="text/javascript">
<!--
	function init() {};	 
	
//-->
<% if (!piRemote.isNew()) { %>
		$("#spanInstanceName", top.document).html("(<%=piRemote.getName()%>)");
<% } %>
	function customizeForm(){	
		document.mainForm.action='showEditor.jsp';
		document.mainForm.submit();
	}
	
	function acceptWorkitem(){
		document.mainForm.action='../wihDefaultTemplate/accept.jsp';
		document.mainForm.submit();
	}
	
	var inputName;
	function delegateSearchPeople(){
		
		inputName = "delegateEndpoint"; 
		var orgPicker = window.open('<%=GlobalContext.WEB_CONTEXT_ROOT%>/common/organizationChartPicker.jsp?fncName=onDelegateWorkitem','_new','width=430,height=700,resizable=true,scrollbars=no');
		//orgPicker.onOk= onDelegateWorkitem;
		orgPicker.inputName=inputName;
	}
	
	function onDelegateWorkitem(selectedPeople, inputName){
	    var ids='';
		$(selectedPeople).each(function (index, user) {
			ids += user.id + ";";
		});
		
		$("#" + inputName).val(ids);
		$("form[name=mainForm]").attr("action", "../wihDefaultTemplate/delegateWorkItem.jsp");
		document.mainForm.submit();
	}
	
	function delegateWorkitem(){
		delegateSearchPeople();
	}
	
	function saveWorkitem(){
		document.mainForm.saveOnly.value="yes";
		document.mainForm.submit();
	}
</script>
</head>
<body>
	<%
		String width = GlobalContext.getPropertyString("wih.content.width");
		String divWidth = UEngineUtil.isNotEmpty(width) ? (Integer.parseInt(width) + 60) + "px" : "98%"; 
	%>
	<div align="center"><div style="width: <%=divWidth %>;">
	<iframe name="messageFrameName" id="messageFrameName" width="100%" height="0" border="0" 
		frameborder="0" scrolling="auto" marginheight="0" marginwidth="0"  src="about:blank">
	</iframe>
	<%@include file="../wihDefaultTemplate/showFormContextHeader.jsp"%>
			<form name="mainForm" action="submit.jsp" method="post" target="messageFrameName">
<%
try {
	
	if(Activity.STATUS_RUNNING.equals(currentActivity.getStatus(piRemote)) 
			|| Activity.STATUS_TIMEOUT.equals(currentActivity.getStatus(piRemote))
			){   
%>
		<%--@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"--%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td width="26" height="14"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo01.gif"  /></td>
				<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineT.gif"></td>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineT.gif"></td>
				<td width="30"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo02.gif"  /></td>
			</tr>
			<tr>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineL.gif"></td>
				<td></td>
				<td align="center" style="padding:20px 1 ;">
					<div id="inputLayer" style="text-align: left;width: <%=divWidth %>;">
						<%@include file="../wihDefaultTemplate/showInputForm.jsp"%>
						<!-- %@include file="../wihDefaultTemplate/showRoleBindingForm.jsp"%-->
					</div>
				</td>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineR.gif"></td>
			</tr>
			<tr>
				<td height="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo04.gif"  /></td>
				<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineB.gif"></td>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineB.gif"></td>
				<td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo03.gif"  /></td>
			</tr>
		</table>
				
	    <%@include file="../wihDefaultTemplate/showTags.jsp"%>
		<%@include file="../wihDefaultTemplate/showActions.jsp"%>
		<%@include file="../wihDefaultTemplate/passValues.jsp"%>
<%
	}
}catch(Exception e){
	/*	out.print("<b>Error Form, Modify the form.</b><br/><br/>");
		java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\d\\:");
	    for ( String splittedString : e.getMessage().split(pattern.pattern()) ) {
	        out.print(splittedString + "<br />");
	    }*/
	    Exception exception = e;
	%><%@include file="../wihDefaultTemplate/errorpage.jsp"%><%
	   	//e.printStackTrace(response.getWriter());
}finally{
	try{pm.cancelChanges();}catch(Exception ex){}
	try{pm.remove();}catch(Exception ex){}
}
%>
			<input type=hidden name='saveOnly' value='false' />
		</form>
		<form name='hiddenForm' id="hiddenForm" method="post">
			<input type="hidden" name="value">
		</form>
</div></div>
</body>
</html>