<html>
<head>

<%@include file="../wihDefaultTemplate/styleHeader.jsp"%>
<script>
function viewProcInfo(){
	var option = "width=1000,height=700,scrollbars=yes,resizable=yes";
	var url = "../../processparticipant/viewProcessInformation.jsp?omitHeader=yes&instanceId=<%=instance.getRootProcessInstanceId()%>";
	window.open(url, "", option)
}
</script>

<style TYPE="TEXT/CSS">
	body {
		background:url(../../processmanager/images/empty.gif) #ffffff 
	}
</style>
<script type="text/javascript">
var parentObject = window.parent.window.parent;
	if (!parentObject.document.getElementById("iframeWihContent")) {
		parentObject = window;;
	}

	try {
		window.parent.closeLoadingLayer();
	} catch (e) { }
	
	function showMessage(divId) {
		var div = document.getElementById(divId);
		parentObject.insertMassge(div.innerHTML);
		div.style.display = "none";
		
	}
</script>
</head>
<body onload="showMessage('divResultContent');">
<div id="divResultContent">
<div class="portlet-msg-success">
<% 
	if(!"".equals(nextWorkerInfo) && nextWorkerInfo!=null){
%>
				<%=GlobalContext.getLocalizedMessageForWeb("workitem_has_been_successfully", loggedUserLocale, "Workitem has been successfully") %> 
				<%=saveOnly ? GlobalContext.getLocalizedMessageForWeb("workitem_saved", loggedUserLocale, "saved")  :
				              GlobalContext.getLocalizedMessageForWeb("workitem_completed", loggedUserLocale, "completed") %>. 
<%
	}else{
%>
				<%=saveOnly ?  GlobalContext.getLocalizedMessageForWeb("workitem_saved", loggedUserLocale, "This process has been successfully saved")  :
				             GlobalContext.getLocalizedMessageForWeb("process_completed", loggedUserLocale, "This process has been successfully completed.")  %> 
<%
	}
%>
</div>


<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr >
		<td bgcolor="#ffffff">

		
<table width="100%" border="0" cellspacing="1" cellpadding="1">
<% 
	if(!"".equals(nextWorkerInfo) && nextWorkerInfo!=null){
%>
	<tr>
		<td nowrap>
			<%=nextWorkerInfo%>
		</td>
	</tr>
	<tr>
		<td><br>
			<fieldset class="block-labels">
			<legend><%=GlobalContext.getLocalizedMessageForWeb("what_do_you_want_to_do", loggedUserLocale, "What do you want to do?") %></legend>
			
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td nowrap>
						<img align="middle" src="../../style/classic/images/arrows/02_right.png"> 
						<a href="javascript:viewProcInfo()">
						<%=GlobalContext.getLocalizedMessageForWeb("i_wanna_see_the_current_status_of_this_process", loggedUserLocale, "I wanna see the current status of this process.") %>
						</a>
					</td>
				</tr>
				<tr>
					<td nowrap>
						<img align="middle" src="../../style/classic/images/arrows/02_right.png">
						<a href='../../processmanager/ProcessDesigner.jnlp?defVerId=<%=processDefinition%>'>
						<%=GlobalContext.getLocalizedMessageForWeb("i_wanna_improve_this_process", loggedUserLocale, "I wanna improve this process.") %> 
						</a>
					</td>
				</tr>
			</table>
			</fieldset>
		</td>
	</tr>
	
<%
	} else {
%>
	<tr>
		<td nowrap>
			<fieldset class="block-labels">
			<legend><%=GlobalContext.getLocalizedMessageForWeb("what_do_you_want_to_do", loggedUserLocale, "What do you want to do?") %></legend>
			
			<img align="middle" src="../../style/classic/images/arrows/02_right.png"> 
			<a href="javascript:viewProcInfo()">
			<%=saveOnly ?  GlobalContext.getLocalizedMessageForWeb("i_wanna_see_the_current_status_of_this_process", loggedUserLocale, "I wanna see the current status of this process.")  :
				           GlobalContext.getLocalizedMessageForWeb("i_wanna_analyze_the_completed_process", loggedUserLocale, "I wanna analyze the completed process.")  %> 
			</a>
			</fieldset>
		</td>
	</tr>
<%
	}
%>
</table>
		</td>
	</tr>

</table>
</div>
</body>
</html>