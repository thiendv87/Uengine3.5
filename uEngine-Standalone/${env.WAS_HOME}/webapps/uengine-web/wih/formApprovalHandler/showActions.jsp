<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="org.uengine.util.UEngineUtil"%><br>
<%if (!UEngineUtil.isTrue(isHistoryView) && !UEngineUtil.isTrue(isHistoryView)){%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td width="99%">
		<table cellpadding="0" cellspacing="0" border="0" width="100%"border="0" align="center">
			<tr>
				<td width="50%" align="right">
				<table cellpadding="0" cellspacing="0" border="0" border="0"align="center">
					<tr>
						<!-- 새프로세스 시작 -->
						<%
							instanceId = instance.getInstanceId();
							if(instanceId==null) instanceId = "";
							
							 if (isCompleted){
								 %>
								 <!-- 완료된 프로세스 -->
								 <td><a href="javascript:parent.window.close();"><img src="../../images/Common/b_btn_confirm.gif" /></a>&nbsp;</td>
								 <%
							 }else	if (initiate) {
								%>
						<!-- 결재선편집 -->
						<td>
							<a href="javascript:addApprovalLine('N')"
							><img src="../../images/Common/b_btm_lineappointment.gif" /></a>&nbsp;
						</td>
						<!-- 내양식함 저장 -->
						<!-- TD class="space_left_right2"><input type=button
							value=MyDocument
							onclick="saveMyDocument('<%=procDef.getBelongingDefinitionId()%>')">
						</td>
						<td width="2"></td-->
						<!-- 임시저장 -->
						<!--TD class="space_left_right2"><input type=button value=save
							onclick="saveWorkitem()"></td>
						<td width="2"></td-->
						<!-- 상신 -->
						<td>
							<a href="javascript:confirmedSubmit()"
							><img src="../../images/Common/b_btm_completion.gif" /></a>&nbsp;
						</td>
						<!-- 취소 -->
						<td>
							<a href="javascript:parent.window.close();"
							><img src="../../images/Common/b_btm_cancel.gif" /></a>&nbsp;
						</td>

						
						<%
								} else if (isDraftActivity && !isRacing) {
									//out.println("isDraftActivity  ::: "+isDraftActivity);
								%>
						<!-- 결재선편집 -->
						<td><a href="javascript:addApprovalLine('Y')"><img src="../../images/Common/b_btm_lineappointment.gif" /></a>&nbsp;</td>
						
						<!-- 상신 -->
						<td><a href="javascript:confirmedSubmit()"><img src="../../images/Common/b_btm_completion.gif" /></a>&nbsp;</td>
						
						<!-- 취소 -->
						<td><a href="javascript:parent.window.close();"><img src="../../images/Common/b_btm_cancel.gif" /></a>&nbsp;</td>
						
						<!-- 이벤트 -->
						<td>
							<%@include file="../wihDefaultTemplate/possible_actions.jsp"%>
						</td>
<script type="text/javascript">
<!--
function confirmation() {
	var answer = confirm("결재가 중단됩니다.\n중단된 결재는 개인업무함>>중지업무\n부서업무함>>중지업무에서 확인가능합니다.\n")
	if (answer){
		document.location.href="/bpm/processmanager/stopRootProcessInstance.jsp?processInstance=<%=instanceId%>&tracingTag=<%=tracingTag %>";
	}
	return;
}
//-->
</script>
<!-- 
<td>
<a href="JavaScript:confirmation();"><img src="../../images/Common/b_btm_srstop.gif" alt="중단"></a>
</td>
 -->
						<%
								} else if (isRacing) {
								%>
						<td><a href="javascript:acceptWorkitem()"><img src="../../images/Common/b_btm_acceptance.gif" /></a>&nbsp;</td>
						<!-- 결재자 -->
						<%
								//2.1.3 결재 
								} else if(isMine) {
									//out.println("else  ::: 2.1.3 결재");
								%>
						<td><a href="javascript:addApprovalLine('Y')"><img src="../../images/Common/b_btm_lineappointment.gif" /></a>&nbsp;</td>
						<!-- 확인(업무처리) 승인버튼 -->
						<td><a href="javascript:confirmWorkitem('<%=instanceId%>','<%=tracingTag%>','approve')"><img src="../../images/Common/b_btn_recognition.gif" /></a>&nbsp;</td>
						<td width="2"></td>
						<!-- 확인(업무처리) 반송버튼 -->
						<td><a href="javascript:confirmWorkitem('<%=instanceId%>','<%=tracingTag%>','reject')"><img src="../../images/Common/b_btn_reject.gif" /></a>&nbsp;</td>	
						<td width="2"></td>
						<!-- 취소  -->
						<td><a href="javascript:window.parent.window.close();"><img src="../../images/Common/b_btm_cancel.gif" /></a>&nbsp;</td>
						<!-- 결재선 변경  -->	
						<!-- 
						<td width="2"></td>
						<td><a href="javascript:addApprovalLine('Y')"><img src="../../images/Common/b_btm_lineedit.gif" /></a>&nbsp;</td>
						 -->
						
<script type="text/javascript">
<!--
function confirmation() {
	var answer = confirm("중단 하시면 전체 프로세스가 중단되며, 복구 하실 수 없습니다.\n중단된 SR은 개인업무함>>중지업무\n부서업무함>>중지업무에서 확인가능합니다.\n")
	if (answer){
		document.location.href="/bpm/processmanager/stopRootProcessInstance.jsp?processInstance=<%=instanceId%>&tracingTag=<%=tracingTag %>";
	}
	return;
}
//-->
</script>
<!--
<td>
<a href="JavaScript:confirmation();"><img src="/images/Common/b_btm_srstop.gif" alt="중단"></a>
</td>			
-->			
						<!-- 전결 -->
						<%		//out.println("approvalActivity.isArbitraryApprovable()  ::: 2.1.3 결재"+approvalActivity.isArbitraryApprovable());
								if (approvalActivity.isArbitraryApprovable()) {
								%>
						<td>
							<a href="javascript:confirmWorkitem('<%=instanceId%>','<%=tracingTag%>','arbitraryApprove')"><img src="../../images/Common/b_btm_decide.gif" /></a>&nbsp;
						</td>
						<%
								}
								%>
						<td width="2"></td>
						<!-- 의견보기 -->
						<!-- TD>
							<a href="javascript:viewComment('<%=instanceId%>')"><img src="../../images/Common/b_btm_completion.gif" /></a>&nbsp;
						</td  -->
						<%
								}else {
									%><td><a href="javascript:parent.window.close();"><img src="../../images/Common/b_btn_confirm.gif" /></a>&nbsp;</td><%
								}
						%>
					</tr>
				</table>
				
				</td>
			
			</tr>
		</table>
		</td>
		
		<td width="5" background="../../images/body/box01_06.gif"></td>
		
	</tr>

</table>

<%} %>
