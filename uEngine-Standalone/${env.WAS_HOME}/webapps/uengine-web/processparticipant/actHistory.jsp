<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@page import="org.uengine.processmanager.ProcessManagerRemote"%>
<%@page import="org.uengine.kernel.*"%>
<%@page import="org.uengine.util.dao.*,org.uengine.persistence.dao.WorkListDAO, org.uengine.persistence.processinstance.*"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="java.util.*" %>

<%
	String instanceId = request.getParameter("instanceId");
%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = null;
	
	try{
		DefaultConnectionFactory defaultConnectionFactory = DefaultConnectionFactory.create();
		pm = processManagerFactory.getProcessManagerForReadOnly();
		ProcessInstance instance = pm.getProcessInstance(instanceId).getRootProcessInstance();
		String rootInstanceId = instance.getInstanceId();
		
		%>
<link href="/style/formdefault.css" rel="stylesheet" type="text/css">
		
<div class="size90per">
<div id="srctiontab">
<ul>
    <li><span>Activity History</span></li>
</ul>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
	<tr>
		<td width="3" height="3"><img src="/images/Common/GrayBoxMo01.gif" width="3" height="3"></td>
		<td background="/images/Common/GrayBoxLine01.gif"></td>
		<td width="3"><img src="/images/Common/GrayBoxMo02.gif" width="3" height="3"></td>
	</tr>
	<tr>
		<td background="/images/Common/GrayBoxLine04.gif"></td>
		<td >		
	
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td class="tbllisttitle" align="center" height="26" >번호</td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" >개발요청 상태</td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" >결재정보</td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" >등록일</td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" >결재일</td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" >소요시간</td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" >의견</td>
				</tr>
		<%
		WorkListDAO wl = (WorkListDAO)GenericDAO.createDAOImpl(defaultConnectionFactory, "select * from bpm_worklist where rootinstid=?rootinstid", WorkListDAO.class);
		wl.setRootInstId(new Long(rootInstanceId));
		wl.select();
		
		int seq = 1;
		
		while(wl.next()){
			
			if(Activity.STATUS_COMPLETED.toUpperCase().equals(wl.getStatus())){
				String activityName = null;
				boolean existComment = false;
				String currInstanceId = "" + wl.getInstId();
				String tracingTag = wl.getTrcTag();
				
				if("formApprovalHandler".equals(wl.getTool())){					
					ProcessInstance currInstance = pm.getProcessInstance(currInstanceId);
					FormApprovalActivity formApprovalActivity = (FormApprovalActivity)currInstance.getProcessDefinition().getActivity(tracingTag);
					SRMSRoleMapping approver = (SRMSRoleMapping) formApprovalActivity.getApprover(currInstance);
					approver.fill(currInstance);
					String approveType = null;
					if(tracingTag.equals(formApprovalActivity.getApprovalLineActivity().getDraftActivity().getTracingTag())){
						approveType = "상신";
					}else if(formApprovalActivity.isNotificationWorkitem()){
						approveType = "후결";
					}else{
						approveType = "결재";
					}
					String stepName = approver.getResourceName() + "(" + approveType + ")";
					activityName = formApprovalActivity.getApprovalLineActivity().getDraftActivity().getName().getText() + " " + stepName;
					String apprStat = formApprovalActivity.getApprovalStatus(currInstance);
					
					if(FormApprovalActivity.SIGN_APPROVED.equals(apprStat) || 
							FormApprovalActivity.SIGN_REJECT.equals(apprStat)){
						existComment = true;
					}
				
				}else{
					activityName = wl.getTitle();
				}
				SRMSRoleMapping rm = (SRMSRoleMapping)RoleMapping.create();
				rm.setEndpoint(wl.getEndpoint());
				rm.fill(pm.getProcessInstance("" + wl.getInstId()));
				
				Date startDate = wl.getStartDate();
				Date endDate = wl.getEndDate();
				long elapsedTime = (endDate.getTime() - startDate.getTime());
				long days = elapsedTime / (1000*60*60*24);
				double restHours = elapsedTime % (1000*60*60*24);
				double hours = restHours / (1000*60*60);
				double restMins = restHours % 3600;
				double mins = restMins / 60;
			%>
				<tr>
					<td class="tbllisttitle" align="center" height="26" ><%=seq %></td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="left" height="26" ><%=notNull(activityName)%></td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="left" height="26" ><%=notNull(rm.getDept_nm() + " " + rm.getResourceName()) %></td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" ><%=notNull(startDate)%></td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" ><%=notNull(endDate)%></td><td class="tbllistbg"></td>
					<td class="tbllisttitle" align="center" height="26" ><%=notNull(new Long(days).intValue() + "일 " + new Double(hours).intValue() + "시 " + new Double(mins).intValue() + "분")%></td><td class="tbllistbg"></td>
			<%
				if(existComment){
					%>
					<td class="tbllisttitle" align="center" height="26" >
						<a href="javascript:viewComment('<%=currInstanceId %>','<%=tracingTag %>')"><img src="/images/Common/b_btm_opinion.gif"></a>
					</td>
					<%			
				}else{
					%>
					<td class="tbllisttitle" align="center" height="26" ></td>
					<%
				}
			%>			
				</tr>
			<%
			}
			seq++;
		}		
	%>
			</table>
		</td>
			<td background="/images/Common/GrayBoxLine02.gif"></td>
	</tr>
	<tr>
		<td height="3"><img src="/images/Common/GrayBoxMo04.gif" width="3" height="3"></td>
		<td background="/images/Common/GrayBoxLine03.gif"></td>
		<td><img src="/images/Common/GrayBoxMo03.gif" width="3" height="3"></td>
	</tr>
</table>
</div>	
<%
	} catch(Exception e) {
		throw e;
	} finally {
		if(pm != null) try{ pm.remove(); } catch(Exception e){}
	}
	
%>