<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
%>
<html>
<head>
	 
	<%@page import="org.uengine.contexts.HtmlFormContext"%>
	<%@page import="org.uengine.contexts.MappingContext"%>
	<%@page import="org.uengine.formmanager.FormUtil"%>
	<%@page import="org.uengine.util.*"%>
	
	<%@include file="../../wihDefaultTemplate/header.jsp"%>
	<%@include file="../../wihDefaultTemplate/definition.jsp"%>
	<%@include file="../../wihDefaultTemplate/initialize.jsp"%>
	
	<link rel="stylesheet" type="text/css" href="../../style/showFormContext.css" />
	
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/formApprovalScript.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/js/formValidation.js" ></script>
	
	<jsp:include page="../../../scripts/formActivity.js.jsp" flush="false">
		<jsp:param name="rmClsName" value="<%=rmClsName%>" />
	</jsp:include>
	<script type="text/javascript">
	<!--
		function init() {
			setDefaultValue(); 
			setMainFormTarget(); 
			try {
				eval('onLoadForm()');
			} catch(e) {}
		}
	//-->
	</script>
</head>
<body onLoad="init();" leftmargin="2" topmargin="0" marginwidth="0" marginheight="0" >
	<%@include file="../../wihDefaultTemplate/showFormContextHeader.jsp"%>
	<form name="mainForm" action="submit.jsp" method="POST" target="messageFrameName">
	<iframe name="messageFrameName" id="messageFrame" width="100%" height="0" border="0" 
		frameborder="0" scrolling="auto" marginheight="0" marginwidth="0" >
	</iframe>
		<%
		try {
		%>
		<%@include file="../../wihDefaultTemplate/returnIfNotRunning.jsp"%>
		<table width="730px" border="0" cellspacing="0" cellpadding="4" align="center">
		<% if (isRacing) { %>
			<tr height="1">
				<td align="center" bgcolor='yellow'>
					<b>
					<%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %>
					</b>
				</td>
			</tr>
		<% } %>
	
		<%
			//------------- declaration & initialize -------------------//
			
			String isHistoryView = UEngineUtil.isNotEmpty(request.getParameter("isHistoryView")) ? decode(request.getParameter("isHistoryView")) : "";
			isMine = initiate || "yes".equals(request.getParameter("isMine"));
			ProcessInstance instance = piRemote;
			HumanActivity humanActivity = (HumanActivity) currentActivity;
			boolean isCompleted = "Completed".equals(humanActivity.getStatus(instance));
			HumanApprovalActivity approvalActivity = (HumanApprovalActivity) currentActivity;
	
			//HtmlFormContext formContext = initiate ? (HtmlFormContext) (humanActivity.getInput().getDefaultValue()) : (HtmlFormContext) (humanActivity.getInput().get(instance, ""));
			//String formDefId = formContext.getFormDefId();
	
			if (instance != null)
				request.setAttribute("instance", instance);
			if (pm != null)
				request.setAttribute("pm", pm);
			if (humanActivity != null)
				request.setAttribute("humanActivity", humanActivity);
			if (loggedRoleMapping != null)
				request.setAttribute("loggedRoleMapping", loggedRoleMapping);
		
			/*
			final Map mappedResult = humanActivity.getMappedResult(instance);
			request.setAttribute("mappingResult", mappedResult);
			*/
	
			String isExtInitiate = request.getParameter("isExtInitiate");
			String fckEditorContents = request.getParameter("fckEditorContents");
			String isCopyInitiate = request.getParameter("isCopyInitiate");
			String copyProcInstId = request.getParameter("copyProcInstId");
			String copyTracingTag = request.getParameter("copyTracingTag");
	
			/*
			String[] defIdAndVersionId = formDefId.split("@");
			String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
			String formFileName = currProductionFormDefId;
			*/
			//------------- pass values to submit.jsp -------------------//
	%> 
			<%@include file="../../wihDefaultTemplate/passValues.jsp"%>
	<%
			String approvalLineActivityTT = request.getParameter("approvalLineActivityTT");
	
			HumanApprovalLineActivity humanApprovalLineActivity = (HumanApprovalLineActivity) currentProcessDefinition.getActivity(approvalLineActivityTT);
			HumanApprovalActivity draftActivity = humanApprovalLineActivity.getDraftActivity();
			boolean isLastApprove = false;
			boolean isDraftActivity = (tracingTag.trim()).equals(draftActivity.getTracingTag().trim());
			isViewMode = isViewMode || ((HumanApprovalActivity) humanActivity).isViewMode() || isCompleted;
			request.setAttribute("isDraftActivity", isDraftActivity);
			
			StringBuffer approverHtml = new StringBuffer();
	
			Vector vChildActivities = null;
			List approverList = new ArrayList();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String approveDate = null;
			String rejectTracingTag = null;
			//System.out.println("---------------------"+tracingTag);
			//System.out.println("---------------------"+draftActivity.getTracingTag());
			
			//String requester = "null".equals(request.getParameter("requester")) || request.getParameter("requester") == null ? "" : decode(request.getParameter("requester"));
			//String form_name = "null".equals(request.getParameter("form_name")) || request.getParameter("form_name") == null ? "" : decode(request.getParameter("form_name"));
			
			String requester = UEngineUtil.isNotEmpty(request.getParameter("requester")) ? decode(request.getParameter("requester")) : "";
			String form_name = UEngineUtil.isNotEmpty(request.getParameter("form_name")) ? decode(request.getParameter("form_name")) : "";
	%> 
	
	<!-- BODY START -->
	<tr><td valign="top" width="100%">
		<div id="waitMsg" align="center" style="position: absolute; left: 0%; top: 0%; cursor: default; z-index: 1;">
			<input type="hidden" name="hiIsStarted" value="0">
		</div>
		
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>
				<td>
				
				<%@include file="../../wihDefaultTemplate/returnIfNotRunning.jsp"%>
				<%@include file="../../wihDefaultTemplate/showInputForm.jsp"%>
				<%@include file="../../wihDefaultTemplate/showRoleBindingForm.jsp"%>
				</td></tr><tr><td align="center">
				<input type=hidden name='saveOnly' value='false' />
		<%
		/*
			out.flush();

//			boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));
		
			String cachedFormRoot = "/wih/formHandler/cachedForms/";
			File contextDir = new File(request.getRealPath(cachedFormRoot));

			FormUtil.copyToContext(contextDir, formFileName);
		
			//isDraftActivity = "null".equals(request.getParameter("editAble")) || request.getParameter("editAble") == null || "".equals(request.getParameter("editAble")) ? isDraftActivity : (new Boolean(request.getParameter("editAble"))).booleanValue();
			isDraftActivity = UEngineUtil.isNotEmpty(request.getParameter("editAble")) ? 	(new Boolean(request.getParameter("editAble"))).booleanValue() : isDraftActivity;
					
			RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot + formFileName + (isViewMode ? "_formview.jsp" : "_write.jsp"));
			rdIncludeAction.include(request, response);
			out.flush();
		*/
		%>
					<br>
					
					<% if (!isDraftActivity && !isCompleted) { %>
						<%@include file="../../wihDefaultTemplate/commentWrite.jsp" %><br />
					<% } %>
					
					<br /><br />  
					<%@include file="inc_approvalLine.jsp" %><br />
					<%@include file="../showActions.jsp"%>
					<%@include file="../../wihDefaultTemplate/possible_actions.jsp" %>
				</td>
			</tr>
		</table>
		<br>
	</td></tr></table>
		
		<!-- BODY END -->
		<%
 			if (!initiate) {
 				String status = pm.getActivityStatus(instanceId, tracingTag);

 				if (status != null && !status.equals("Running")&& !status.equals("Timeout")) {
		 %>
				
				<script type="text/javascript">
						function newStartWithCopy(procInstId,tracingTag){
		<%
							String pdVer = null;
							ProcessDefinitionRemote[] arrPdr = null;
							arrPdr = pm.findAllVersions(currentProcessDefinition.getBelongingDefinitionId());
							if(arrPdr != null){
								String versionID = null;
								int version = -1;
								for(int i=0; i<arrPdr.length; i++){
									versionID = arrPdr[i].getId();
									version = arrPdr[i].getVersion();
									if(arrPdr[i].isProduction()){
										if( pdVer == null || "".equals(pdVer) || "null".equals(pdVer)){
											pdVer = versionID;
										}
									}
								}
								
								if( pdVer == null || "".equals(pdVer) || "null".equals(pdVer)){
									pdVer = versionID;
								}
							}
		%>
							if ('null' == '<%=pdVer%>') {
								alert('현재 프로세스는 사용불가능 합니다.\n 관리자에게 문의 하세요');
								return;
							} else {
								this.location = WEB_CONTEXT_ROOT + '/processmanager/initiateForm.jsp?processDefinition=<%=pdVer%>&isCopyInitiate=yes&fckEditorContents=&copyProcInstId='+procInstId+'&copyTracingTag='+tracingTag;
							}
						}
				</script>
		<%
				 			try {
					 			pm.cancelChanges();
					 		} catch (Exception ex) { }
					 		try {
					 			pm.remove();
					 		} catch (Exception ex) { }
				 //		return;
		 			}
		 		}
		 %> 
		 
		<input type="hidden" name="currentPage" 	value="<%=request.getParameter("currentPage")%>" /> 
		<input type="hidden" name="from_name" 	value="<%=form_name %>" /> 
		<input type="hidden" name="requester" 		value="<%=requester %>" /> 
		<input type="hidden" name="type" 			value="<%=request.getParameter("type")%>" />
		<input type="hidden" name="isExtInitiate"	value="<%=isExtInitiate%>" />
		
 <!------------ pass submit ---------------------------------> 
		<input type="hidden" name="userCode" /> 
		<input type="hidden" name="userName" /> 
		<input type="hidden" name="userJobPosition" />
		<input type="hidden" name="loadApprovealActivities" />  
		<input type="hidden" name="preConfirm" /> 
		<input type="hidden" name="status" /> 
		<input type="hidden" name="comname" /> 
		<input type="hidden" name="phone" /> 
		<input type="hidden" name="changedApprovalLine" value="no" />

		<input type="hidden" name="approveType" />
		<script type="text/javascript">
		<!--
		function confirmedCheck(){
			try { 
				stopWaitMsg();
			} catch(err) {}
			
		<% if(isDraftActivity) {%>
				actionWorkitem("draft");
		<% }else{ %>
				actionWorkitem("approve");
		<% } %>
		}
		
		//-->
		</script> 
		
		<input type="hidden" name="apprStat">
		<input type="hidden" name="saveOnly">
	</form>
	
	<form name="hiddenForm" method="POST">
		<input type="hidden" name="value">
	</form>
	<iframe id="hiddenframe" name="hiddenframe" id="hiddenframe" width="0" height="0"></iframe>

<%
		} catch(Exception e) {
			throw e;
		} finally {
			try{pm.cancelChanges();}catch(Exception ex){}
			try{pm.remove();}catch(Exception ex){}
		}
%>
</body>
</html>