<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%@include file="../../common/header.jsp"%>
	<%@include file="../../common/getLoggedUser.jsp"%>
	<% try { %>
			
		<%@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"%>
		<table width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
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
	
			ProcessDefinition procDef = null;
			if (initiate)
				procDef = (ProcessDefinition) pm.getProcessDefinition(initiationProcessDefinition);
			else
				procDef = piRemote.getProcessDefinition();
	
			FormActivity formActivity = (FormActivity) procDef.getActivity(tracingTag);
			boolean isCompleted = "Completed".equals(formActivity.getStatus(instance));
			FormApprovalActivity approvalActivity = (FormApprovalActivity) procDef.getActivity(tracingTag);
	
			HtmlFormContext formContext = initiate ? (HtmlFormContext) (formActivity.getVariableForHtmlFormContext().getDefaultValue()) : (HtmlFormContext) (formActivity.getVariableForHtmlFormContext().get(instance, ""));
			String formDefId = formContext.getFormDefId();
	
			if (instance != null)
				request.setAttribute("instance", instance);
			if (pm != null)
				request.setAttribute("pm", pm);
			if (formActivity != null)
				request.setAttribute("formActivity", formActivity);
			if (loggedRoleMapping != null)
				request.setAttribute("loggedRoleMapping", loggedRoleMapping);
		
			final Map mappedResult = formActivity.getMappedResult(instance);
			request.setAttribute("mappingResult", mappedResult);
	
			String isExtInitiate = decode(request.getParameter("isExtInitiate"));
			String fckEditorContents = decode(request.getParameter("fckEditorContents"));
			String isCopyInitiate = decode(request.getParameter("isCopyInitiate"));
			String copyProcInstId = decode(request.getParameter("copyProcInstId"));
			String copyTracingTag = decode(request.getParameter("copyTracingTag"));
	
			String[] defIdAndVersionId = formDefId.split("@");
			String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
			String formFileName = currProductionFormDefId;
	
			//------------- pass values to submit.jsp -------------------//
	%> 
	<%
			String approvalLineActivityTT = request.getParameter("approvalLineActivityTT");
	
			FormApprovalLineActivity formApprovalLineActivity = (FormApprovalLineActivity) procDef.getActivity(approvalLineActivityTT);
			FormApprovalActivity draftActivity = formApprovalLineActivity.getDraftActivity();
			boolean isLastApprove = false;
			boolean isDraftActivity = (tracingTag.trim()).equals(draftActivity.getTracingTag().trim());
			isViewMode = isViewMode || ((FormApprovalActivity)formActivity).isViewMode() || isCompleted;
			request.setAttribute("isDraftActivity", isDraftActivity);
			
			StringBuffer approverHtml = new StringBuffer();
	
			Vector vChildActivities = null;
			List approverList = new ArrayList();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String approveDate = null;
			String rejectTracingTag = null;
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
		<%
			out.flush();
		
			String cachedFormRoot = "/wih/formHandler/cachedForms/";
			File contextDir = new File(request.getRealPath(cachedFormRoot));

			FormUtil.copyToContext(contextDir, formFileName);
			isDraftActivity = UEngineUtil.isNotEmpty(request.getParameter("editAble")) ? 	(new Boolean(request.getParameter("editAble"))).booleanValue() : isDraftActivity;
					
			RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot + formFileName + (isViewMode ? "_formview.jsp" : "_write.jsp"));
			request.setAttribute("isViewMode", isViewMode);
			rdIncludeAction.include(request, response);
			out.flush();
		%>