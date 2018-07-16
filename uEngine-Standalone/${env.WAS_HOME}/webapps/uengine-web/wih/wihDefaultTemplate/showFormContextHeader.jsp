<%@page import="org.uengine.kernel.SubProcessActivity"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.util.Properties"%>
<%@page import="org.uengine.kernel.ProcessInstance"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@page import="org.uengine.kernel.HumanActivity"%>
<%@page import="org.uengine.kernel.Activity" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLDecoder" %>


<%@page import="java.util.Date"%>
<%@page import="org.uengine.util.UEngineUtil"%><script type="text/javascript">
	var loggedUserId = "<%=loggedUserId%>";
	var loggedUserName = "<%=loggedUserFullName%>";
	var loggedUserPartCode = "<%=loggedUserPartCode%>";

	function showHistoryContent(tag) {
		$("#btnShowHistory_" + tag).hide();
		$("#btnHideHistory_" + tag).show();
		$('#tableHistoryContent_' + tag).show('normal');
	}

	function hideHistoryContent(tag) {
		$("#btnShowHistory_" + tag).show();
		$("#btnHideHistory_" + tag).hide();
		$('#tableHistoryContent_' + tag).hide('normal');
	}
	
	function resizeFrame(size, tag){
		document.getElementById("historyContentArea_"+tag).height=size;
	}
	
	function getFormContext(tag,src){
		$("#btnGetHistory_" + tag).hide();
		$("#historyContentArea_"+tag).attr({
			"src":src
		});
		showHistoryContent(tag);
	}
	
	jQuery(document).ready(function() {
		try { 
			if (window.top.opener.document.refreshForm != null && window.top.opener.document.refreshForm != undefined) {
				window.top.opener.document.refreshForm.submit();
			} else {
				window.top.opener.location.reload(true);
			}
		} catch (e) {}
	});
</script><%
int activityCount = 1;

if("true".equals(org.uengine.kernel.GlobalContext.getPropertyString("wih.display.thread"))){
	ProcessInstance rootInstance = pm.getProcessInstance(piRemote.getRootProcessInstanceId());
	
	if (!initiate) {
		String roleName = "";
		String startTime = "";
		String endTime = "";
		String workTime = "";
		String workTitle = "";
		String resourceName = "";
		String taskId = null;
		String rootInstId = null;
		String iframeUrl = null;
		String statusMsg = "";
		ProcessInstance historyRootInstance = null;
		int year = 0;
		
		String viewTaskId = request.getParameter("taskId");
		
		if(!UEngineUtil.isNotEmpty(viewTaskId) && initiationActivity instanceof HumanActivity){
			String[] taskIds = ((HumanActivity)initiationActivity).getTaskIds(piRemote);
			if(taskIds!=null && taskIds.length > 1){
				viewTaskId = taskIds[0];
			}
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT wl.* "); 
		sql.append("   FROM bpm_worklist wl LEFT JOIN bpm_procinst pi ON wl.instid = pi.instid "); 
		sql.append("  WHERE pi.rootinstid = ").append(piRemote.getRootProcessInstanceId()); 
		sql.append("   AND wl.status NOT IN ( 'NEW' , 'CONFIRMED', 'DRAFT') "); 
		sql.append(" ORDER BY wl.startdate, wl.taskid "); 
		
		
		org.uengine.processmanager.ProcessTransactionContext ptc = piRemote.getProcessTransactionContext();
		org.uengine.util.dao.IDAO idao = org.uengine.util.dao.ConnectiveDAO.createDAOImpl(ptc, sql.toString(), org.uengine.util.dao.IDAO.class);
		idao.select();
		
		while(idao.next()){
			statusMsg = "";
			taskId = idao.getString("taskid");
			rootInstId = idao.getString("rootinstid");
			workTitle = idao.getString("title");
			resourceName = idao.getString("resname");
			
			if ("DELEGATED".equals(idao.getString("status"))) {
				statusMsg = "[" + GlobalContext.getMessageForWeb("Delegate", loggedUserLocale) + "] ";
			} 
			
			if (UEngineUtil.isNotEmpty(idao.getString("rolename"))) {
				roleName = idao.getString("rolename");
			}
			
			if(idao.get("enddate") != null){
				endTime = sdf.format(idao.getDate("enddate"));	
			}
			
			startTime = sdf.format(idao.getDate("startdate"));
			workTime = startTime + " ~ " + endTime; 
			
			historyRootInstance = pm.getProcessInstance(rootInstId);
			year = rootInstance.getProcessDefinition().getStartedTime(rootInstance).get(Calendar.YEAR);
			
			iframeUrl = GlobalContext.WEB_CONTEXT_ROOT + "/wih/defaultHandler/historyWorkItem.jsp?tag=" + activityCount + "&htmlPath=" 
						+ URLEncoder.encode(year + "/" + rootInstance.getInstanceId() + "/" + taskId + ".html", GlobalContext.ENCODING);
			
			if(!taskId.equals(viewTaskId)){
				%><div class="formcontextwrap">
		            <div class="formcontexticon"><%=(activityCount < 10) ? "0" + activityCount : activityCount%></div>
		            <div class="formcontexttitle"><%=statusMsg + workTitle %> (<%=roleName %> : <%=resourceName %>)</div>
		            <div class="formcontext">
		                <div id="btnGetHistory_<%=activityCount %>" onclick="getFormContext('<%=activityCount %>','<%=iframeUrl %>');" class="formcontextshowpane"><div class="endtime"><%=workTime %></div></div>
		                <div id="btnShowHistory_<%=activityCount %>" onclick="showHistoryContent('<%=activityCount %>');" class="formcontexthidepane" ><div class="endtime"><%=workTime %></div></div>
		                <div id="btnHideHistory_<%=activityCount %>" onclick="hideHistoryContent('<%=activityCount %>');" class="formcontextshowpanedisnone" ><div class="endtime" ><!-- style="float:right; padding:8px 90px 0 0;" --><%=workTime %></div></div>
		            </div>
		        </div>
		        <table id="tableHistoryContent_<%=activityCount %>" align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style="display:none; margin-bottom:35px;">
		            <tr>
		                <td width="26" height="14"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo01.gif" /></td>
						<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineT.gif"></td>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineT.gif"></td>
		                <td width="30"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo02.gif" /></td>
		            </tr>
					<tr>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineL.gif"></td>
		                <td></td>
		                <td align="left" >
		                <iframe frameborder="0" id="historyContentArea_<%=activityCount %>" src="" width="100%;"></iframe>
		                </td>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineR.gif"></td>
		            </tr>
					<tr>
		                <td height="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo04.gif"  /></td>
						<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineB.gif"></td>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineB.gif"></td>
		                <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo03.gif"  /></td>
		            </tr>
		        </table><%
			}else{
				%><div class="formcontextwrap">
		            <div class="formcontexticon"><%=(activityCount < 10) ? "0" + activityCount : activityCount%></div>
		            <div class="formcontexttitle"><%=statusMsg + workTitle %> (<%=roleName %> : <%=resourceName %>)</div>
		            <div class="formcontext">
		                <div id="btnShowHistory_<%=activityCount %>" onclick="showHistoryContent('<%=activityCount %>');" class="formcontexthidepane" style="display:none;"><div class="endtime"><%=workTime %></div></div>
		                <div id="btnHideHistory_<%=activityCount %>" onclick="hideHistoryContent('<%=activityCount %>');" class="formcontextshowpanedisnone" style="display:block;"><div class="endtime" ><!-- style="float:right; padding:8px 90px 0 0;" --><%=workTime %></div></div>
		            </div>
		        </div>
		        <table id="tableHistoryContent_<%=activityCount %>" align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:35px;">
		        	<tr>
		        		<td colspan="4"><%@include file="./returnIfNotRunning.jsp"%></td>
		        	</tr>
		            <tr>
		                <td width="26" height="14"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo01.gif" /></td>
						<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineT.gif"></td>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineT.gif"></td>
		                <td width="30"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo02.gif" /></td>
		            </tr>
					<tr>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineL.gif"></td>
		                <td></td>
		                <td align="left" >
		                <iframe frameborder="0" id="historyContentArea_<%=activityCount %>" src="<%=iframeUrl%>" width="100%;"></iframe>
		                </td>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineR.gif"></td>
		            </tr>
					<tr>
		                <td height="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo04.gif"  /></td>
						<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineB.gif"></td>
		                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineB.gif"></td>
		                <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo03.gif"  /></td>
		            </tr>
		        </table><%				
			}
			
			activityCount ++;
		}
		
		if(Activity.STATUS_RUNNING.equals(initiationActivity.getStatus(piRemote))){  
	   %><div class="runformcontextwrap">
           <div class="runformcontexticon"><%=(activityCount < 10) ? "0" + activityCount : "" + activityCount%></div>
           <div class="runformcontexttitle"><%= piRemote.getProcessDefinition().getActivity(tracingTag).getName() %></div>
           <div class="runformcontext"><div class="starttime"><%=initiationActivity.getStartedTime(piRemote).getTime().toLocaleString() %></div></div>
       </div><%
		}
	}
}
%>