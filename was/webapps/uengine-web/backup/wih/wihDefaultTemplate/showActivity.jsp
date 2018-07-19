<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/bpm/common/header.jsp"%>
<%@include file="/bpm/common/getLoggedUser.jsp"%>

<%@page import="org.uengine.processmanager.ProcessManagerRemote"%>
<%@page import="org.uengine.kernel.*"%>
<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="java.util.*,java.text.SimpleDateFormat, java.lang.*" %>

<%
	String instanceId = request.getParameter("instanceId");

%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = null;
	
	try{
		pm = processManagerFactory.getProcessManagerForReadOnly();
		ProcessInstance instance = pm.getProcessInstance(instanceId).getRootProcessInstance();
		String rootInstanceId = instance.getInstanceId();
		
%>
<html>
<head>

<link href="/style/formdefault.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../formApprovalHandler/formApprovalScript.js"></script>

</head>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td width="3" height="3"><img src="/images/Common/GrayBoxMo01.gif" width="3" height="3"></td>
		<td background="/images/Common/GrayBoxLine01.gif"></td>
		<td width="3"><img src="/images/Common/GrayBoxMo02.gif" width="3" height="3"></td>
	</tr>
	<tr>
		<td background="/images/Common/GrayBoxLine04.gif"></td>
		<td>	
		<table cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr height="26">
				<td class="tbllisttitle" align="center">번호</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center">개발요청 상태</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center">결재정보</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center">등록일</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center">결재일</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center">소요시간</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" width=80 align="center">의견</td>
			</tr>
		<%
		Connection conn = instance.getProcessTransactionContext().getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		//*** Edit by truewater 2009.03.31 order by 절 추가
//		sql.append("select * from bpm_worklist where rootinstid= ? ");
		sql.append("select wl.*, dc.*, sysdate as hyDate from bpm_worklist wl, doc_comments dc where wl.rootinstid = ? and wl.INSTID = dc.INSTANCE_ID(+) and wl.TRCTAG = dc.TRACINGTAG(+) order by startdate, taskid");
		ps = conn.prepareStatement(sql.toString());
		
		ps.setString(1, rootInstanceId);
		
		rs = ps.executeQuery();
//		WorkListDAO wl = (WorkListDAO)GenericDAO.createDAOImpl(defaultConnectionFactory, "select * from bpm_worklist where rootinstid=?rootinstid", WorkListDAO.class);
//		wl.setRootInstId(new Long(rootInstanceId));
//		wl.select();
		
		int seq = 1;
		
		String rowColor="";
		
		while(rs.next()){
			
			if(seq%2>0){
				rowColor = "#ffffff";
			}else{
				rowColor = "#F5F5F5";
			}
			
			

			if(Activity.STATUS_COMPLETED.toUpperCase().equals(rs.getString("status")) || "CONFIRMED".equals(rs.getString("status")) || "NEW".equals(rs.getString("status"))){
				String activityName = null;
				boolean existComment = false;
				String currInstanceId = "" + rs.getLong("instid");
				String tracingTag = rs.getString("trctag");
				
				if("formApprovalHandler".equals(rs.getString("tool"))){					
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
					
//					if(FormApprovalActivity.SIGN_APPROVED.equals(apprStat) || 
//							FormApprovalActivity.SIGN_REJECT.equals(apprStat)){
//						existComment = true;
//					}
					// 의견보기 부분 데이타 확인 부터 해서 수정해야함. ess
					if(rs.getString("contents") != null && !"".equals(rs.getString("contents"))){
						existComment = true;
					}
				
				}else{
					activityName = rs.getString("title");
				}
				SRMSRoleMapping rm = (SRMSRoleMapping)RoleMapping.create();
				rm.setEndpoint(rs.getString("endpoint"));
				rm.fill(pm.getProcessInstance("" + rs.getLong("instid")));
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date startDate = rs.getTimestamp("startdate");
				Date endDate = rs.getTimestamp("enddate");
				Date hyDate = rs.getTimestamp("hyDate");
				Date tmpDate = new Date();
				
				long elapsedTime = 0;
				long days = 0;
				double restHours = 0;
				double hours = 0;
				double restMins = 0;
				double mins = 0;
				String tmpEndDate = "";
				
				if("COMPLETED".equals(rs.getString("status")))
				{
					elapsedTime = (endDate.getTime() - startDate.getTime());
					//tmpEndDate = sdf.format(elapsedTime);
					tmpEndDate = sdf.format(endDate);
				}else if("CONFIRMED".equals(rs.getString("status")))
				{
					elapsedTime = (hyDate.getTime() - startDate.getTime());
					tmpEndDate = "<font color=blue><marquee>진행</marquee></font>";
				}else if("NEW".equals(rs.getString("status")))
				{		
					elapsedTime = (hyDate.getTime() - startDate.getTime());
					tmpEndDate = "<font color=red>미확인</font>";
				} 
				/* else if("DRAFT".equals(rs.getString("status")))
				{
					elapsedTime = (hyDate.getTime() - startDate.getTime());
					tmpEndDate = "<font color=green><marquee>변경</marquee></font>";
				}else if("CANCELLED".equals(rs.getString("status")))
				{
					elapsedTime = (hyDate.getTime() - startDate.getTime());
					tmpEndDate = "<font color=red><marquee>취소</marquee></font>";
				}
				*/
				
				// 소요시간 계산 오류 수정 ess
				days = elapsedTime / (1000*60*60*24);
				restHours = elapsedTime % (1000*60*60*24);
				hours = restHours / (1000*60*60);
				restMins = restHours % (1000*60*60);
				mins = restMins / (1000*60);
 
				
				if(seq!=1){
			%>
			<tr>
				<td class="tbllinedot" colspan="19"></td>
			</tr>
			<%		
						}
			%>
			<tr height="26" bgcolor="<%=rowColor%>">
				<td align="center"><%=seq %></td>
				<td class="tbllistbg"></td>
				<td align="left">&nbsp;<%=notNull(activityName)%></td>
				<td class="tbllistbg"></td>
				<td align="center"><%=notNull(rm.getDept_nm() + " " + rm.getResourceName()) %></td>
				<td class="tbllistbg"></td>
				<td align="center"><%=notNull(sdf.format(startDate))%></td>
				<td class="tbllistbg"></td>
				<td align="center"><%=notNull(tmpEndDate)%></td>
				<td class="tbllistbg"></td>
				<td align="center"><%=notNull(new Long(days).intValue() + "일 " + new Double(hours).intValue() + "시 " + new Double(mins).intValue() + "분")%></td>
				<td class="tbllistbg"></td>
			<%
				if(existComment){
					%>
				<td class="tblpadding10" align="center" height="26" >
					<a href="javascript:viewComment('<%=currInstanceId %>','<%=tracingTag %>')"><img src="/images/Common/b_btm_opinion.gif" border=0></a>
				</td>
					<%			
				}else{
					%>
				<td class="tblpadding10" align="center" height="26" ></td>
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
<%
	} catch(Exception e) {
		throw e;
	} finally {
		if(pm != null) try{ pm.remove(); } catch(Exception e){}
	}
	
%>