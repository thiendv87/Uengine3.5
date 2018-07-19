<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
int activityCount = 1;

if("true".equals(GlobalContext.getPropertyString("wih.display.thread")) && !"formApprovalHandler".equals(workitemHandler)){
	String strSQL = "select wl.* from bpm_worklist wl, bpm_procinst pi where pi.rootinstid="+piRemote.getRootProcessInstanceId()+" and wl.instid = pi.instid order by startdate desc";
	ProcessTransactionContext ptc = piRemote.getProcessTransactionContext();
	org.uengine.util.dao.IDAO idao = org.uengine.util.dao.ConnectiveDAO.createDAOImpl(ptc, strSQL, org.uengine.util.dao.IDAO.class);
	idao.select();
	
	while(idao.next()){
		String instId = idao.getString("instId");
		String trctag = idao.getString("trctag");
		String tool = idao.getString("tool");
		String strWorkerName = idao.getString("roleName");
		
		String startTime = dateFormat.format(idao.getDate("startdate"));
		String endTime ="";
		if(idao.get("enddate") !=null){
			endTime = dateFormat.format((java.util.Date)idao.getDate("enddate"));	
		}
		String title = idao.getString("title");	
		
		if (trctag.equals(tracingTag) && instanceId.equals(instId)) {
			break;
		}
		
		ProcessInstance piTmp = pm.getProcessInstance(instId);
		RoleMapping rm =piTmp.getRoleMapping(strWorkerName);
		
		StringBuffer url = new StringBuffer(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
			
		url.append("/wih/").append(tool);
			
		String displayActTime = startTime +" ~ "+endTime;
		
		String divTag = instId+trctag;
%> 
	        <div class="formcontextwrap">
	            <div class="formcontexticon"><%=(activityCount < 10) ? "0" + activityCount : activityCount%></div>
	            <div class="formcontexttitle"><%=title %> (<%=strWorkerName %> : <%=rm.getResourceName() %>)</div>
	            <div class="formcontext">
	                <div id="btnGetHistory_<%=divTag %>" onclick="getFormContext('<%=divTag %>','<%=trctag %>', '<%=url %>', 'true');" class="formcontextshowpane" ><div style="float:right; padding:8px 90px 0 0;"><%=displayActTime %></div></div>
	                <div id="btnShowHistory_<%=divTag %>" onclick="showHistoryContent('<%=divTag %>');" class="formcontexthidepane"><div style="float:right; padding:8px 90px 0 0;"><%=displayActTime %></div></div>
	                <div id="btnHideHistory_<%=divTag %>" onclick="hideHistoryContent('<%=divTag %>');" class="formcontextshowpanedisnone" ><div style="float:right; padding:8px 90px 0 0;"><%=displayActTime %></div></div>
	            </div>
	        </div>
	        <table id="tableHidtoryContent_<%=divTag %>"  width="100%" border="0" cellspacing="0" cellpadding="0"  style="display: none; margin-bottom:35px; ">
	            <tr>
	                <td width="26" height="14"><img src="../../images/Common/formContextConBoxMo01.gif"  /></td>
					<td width="4" background="../../images/Common/formContextConBoxLineT.gif"></td>
	                <td background="../../images/Common/formContextConBoxLineT.gif"></td>
	                <td width="30"><img src="../../images/Common/formContextConBoxMo02.gif"  /></td>
	            </tr>
				<tr>
	                <td background="../../images/Common/formContextConBoxLineL.gif"></td>
	                <td></td>
	                <td><div id="historyContentArea_<%=divTag %>" style="text-align: left;width: <%=GlobalContext.getPropertyString("wih.content.width", "700") %>px;"> </div></td>
	                <td background="../../images/Common/formContextConBoxLineR.gif"></td>
	            </tr>
				<tr>
	                <td height="4"><img src="../../images/Common/formContextConBoxMo04.gif"  /></td>
					<td width="4" background="../../images/Common/formContextConBoxLineB.gif"></td>
	                <td background="../../images/Common/formContextConBoxLineB.gif"></td>
	                <td><img src="../../images/Common/formContextConBoxMo03.gif"  /></td>
	            </tr>
	        </table>
<%
		activityCount++;
	}
}
%>