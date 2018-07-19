<%@page contentType="text/html; charset=UTF-8" %>
<%@include file="../wihDefaultTemplate/header.jsp"%>


<%
	try{
%>

<%@include file="../wihDefaultTemplate/initialize.jsp"%>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="5" topmargin="0" marginwidth="0" marginheight="0" onload="drawLoopLines()">

<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28" valign="bottom">
			<p><img src="../../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
			<%=decode(request.getParameter("definitionName"))%> > <b> <%=decode(request.getParameter(KeyedParameter.TITLE))%> </b>
		</td>
	</tr>
	<tr>
		<td height="1" class="path_underline"></td>
	</tr>
</table>

<!--table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="10"></td>
	</tr>
</table-->


<form name="apprForm" action=submit.jsp method=POST>

<input type="hidden" name="apprStat" value="">

<%@include file="./passValues.jsp"%>
<%@include file="../wihDefaultTemplate/showFlowChart.jsp"%>
<%@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"%>

<!--Approval Line-->
<script language="javascript" src="../../scripts/util.js"></script>
<script>
function addApprovalLine(box, value) {
	var orgPicker = window.open('<%=GlobalContext.WEB_CONTEXT_ROOT%>/common/organizationChartPicker.jsp','_new','width=250,height=450,resizable=true');
	orgPicker.onOk = onApprovalLineSelected;
	orgPicker.inputName = box.name;
}

function onApprovalLineSelected(selectedPeople, inputName){
	//alert(selectedPeople);
	var sep = ';';
	var box = document.apprForm.all[inputName];
	for(i=0; i<selectedPeople.length; i++){
		var text = selectedPeople[i].name; 
		var value = selectedPeople[i].name + sep 
				 + selectedPeople[i].id + sep
				 + selectedPeople[i].isMale + sep
				 + selectedPeople[i].birthday + sep; 		 
		addItem(box, text, value, false);
	}
}

function completeApprove(apprStat){
	var confirmMessage = "";
	if( apprStat == "draft" ){
		confirmMessage = "상신하시겠습니까?";
		selectAll(document.apprForm.approvalLine);	// 결재선을 모두 선택한다.
		if( !isSelected(document.apprForm.approvalLine) ){
			alert('결재자를 지정해 주세요.');
			return;
		}
	}else if( apprStat == "approve" ){
		confirmMessage = "승인하시겠습니까?";
	}else if( apprStat == "arbitraryApprove" ){
		confirmMessage = "전결하시겠습니까?";
	}else if( apprStat == "reject" ){
		confirmMessage = "반려하시겠습니까?";
	}
	
//	if(confirm(confirmMessage)){
		document.apprForm.apprStat.value = apprStat;
		document.apprForm.target = "_self";
		document.apprForm.submit();
//	}
	return;
}
</script>



<%
	String approvalLineActivityTT = request.getParameter("approvalLineActivityTT");
	ProcessDefinition processDefinitionObject = null;
	if( initiate  ){
		processDefinitionObject = pm.getProcessDefinition(processDefinition);
	}else{
		processDefinitionObject = pm.getProcessDefinitionWithInstanceId(instanceId);
	}
	
	ApprovalLineActivity approvalLineActivity = (ApprovalLineActivity)processDefinitionObject.getActivity(approvalLineActivityTT);
	ApprovalActivity draftActivity = approvalLineActivity.getDraftActivity();
	boolean isLastApprove = false;
	boolean isDraftActivity = tracingTag.equals(draftActivity.getTracingTag());
	StringBuffer approverHtml = new StringBuffer();
	
%>

<%--
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
<%
	if( instanceId != null ){
		approvalLineActivity = (ApprovalLineActivity)processDefinitionObject.getActivity(approvalLineActivityTT);
		Vector vChildActivities = approvalLineActivity.getChildActivities();
		for(int i=0; i<vChildActivities.size(); i++){
			if( vChildActivities.get(i) instanceof ApprovalActivity ){
				ApprovalActivity approveStep = (ApprovalActivity)vChildActivities.get(i);
				if( i == vChildActivities.size() -1 ){
					isLastApprove = tracingTag.equals(approveStep.getTracingTag());
				}
				
				String signMsg = "";
				String apprStat = approveStep.getApprovalStatus(pm.getProcessInstance(instanceId));
				if( ApprovalActivity.SIGN_APPROVED.equals(apprStat) ){
					signMsg = "승인";
				}else if( ApprovalActivity.SIGN_ARBITRARY_APPROVED.equals(apprStat) ){
					signMsg = "전결";
				}else if( ApprovalActivity.SIGN_REJECT.equals(apprStat) ){
					signMsg = "반려";
				}
				
				RoleMapping approver = approveStep.getApprover();
				if( approver != null ){
					if( isDraftActivity ){
						approverHtml.append("<option value=\""+approver.getResourceName()+";"+approver.getEndpoint()+";\">"+approver.getResourceName()+"</option>");
					}
%>
	<td>
	  <table cellpadding="0" cellspacing="0" border=1 bordercolor="blue" bordercolordark=white>
		<tr>
		  <td height="80" width="80" align="center"><%=approver.getResourceName()%></td>
		</tr>
		<tr>
		  <td height="20" align="center">&nbsp;<i><%=signMsg%></i></td>
		</tr>
	  </table>
	</td>				
<%
				}
			}
		}
	}
%>
  </tr>
</table>
--%>

<%
	if( isDraftActivity ){
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20" >
		<td width="150" align=left bgcolor="f4f4f4">
			&nbsp; <b>Approval Line</b><br>
			Please add reviewers by clicking (+) button	
		</td>
		<td width="10"></td>
		<td width="*" align=left>

<table border="0" cellpadding="0" cellspacing="0">
  <tr>
	<td>
	  <select name="approvalLine" size=5 multiple="true">
<!--		<option value="JJY;pongsor2@hotmail.com;">Jinyoung Jang</option>-->
<!--		<option value="SDM;alcolins@hotmail.com;">Dongmin Shin</option>-->
<%
	if( instanceId != null && ApprovalActivity.SIGN_REJECT.equals(approvalLineActivity.getApprovalLineStatus(pm.getProcessInstance(instanceId))) ){
		approvalLineActivity = (ApprovalLineActivity)processDefinitionObject.getActivity(approvalLineActivityTT);
		Vector vChildActivities = approvalLineActivity.getChildActivities();
		for(int i=0; i<vChildActivities.size(); i++){
			if( vChildActivities.get(i) instanceof ApprovalActivity ){
				ApprovalActivity approveStep = (ApprovalActivity)vChildActivities.get(i);
				if( i == vChildActivities.size() -1 ){
					isLastApprove = tracingTag.equals(approveStep.getTracingTag());
				}
				
				String signMsg = "";
				String apprStat = approveStep.getApprovalStatus(pm.getProcessInstance(instanceId));
				if( ApprovalActivity.SIGN_APPROVED.equals(apprStat) ){
					signMsg = "승인";
				}else if( ApprovalActivity.SIGN_ARBITRARY_APPROVED.equals(apprStat) ){
					signMsg = "전결";
				}else if( ApprovalActivity.SIGN_REJECT.equals(apprStat) ){
					signMsg = "반려";
				}
				
				RoleMapping approver = approveStep.getApprover();
				if( approver != null ){
					if( isDraftActivity ){
						out.print("<option value=\""+approver.getResourceName()+";"+approver.getEndpoint()+";\">"+approver.getResourceName()+"</option>");
					}
				}
			}
		}
	}
%>
	  </select>
	</td>
	<td valign="top">
		<a href="javascript: reorder(document.forms[0].approvalLine, 0);"><img border="0" height="16" hspace="0" src="../../images/03_up.gif" vspace="2" width="16"></a><br>
		<a href="javascript: reorder(document.forms[0].approvalLine, 1);"><img border="0" height="16" hspace="0" src="../../images/03_down.gif" vspace="2" width="16"></a><br>
		<a href="javascript: removeItem(document.forms[0].approvalLine);"><img border="0" height="1" hspace="0" src="/html/skin/image/common/spacer.gif" vspace="0" width="2"><img border="0" height="11" hspace="0" src="../../images/05_minus.gif" vspace="2" width="11"></a><br>
		<a href="javascript: addApprovalLine(document.forms[0].approvalLine);"><img border="0" height="1" hspace="0" src="/html/skin/image/common/spacer.gif" vspace="0" width="2"><img border="0" height="11" hspace="0" src="../../images/05_plus.gif" vspace="2" width="11"></a><br>
	</td>
  </tr>
</table>
		</td>		
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>

<%
	}
%>
<!--Aapproval Line-->

<%@include file="../wihDefaultTemplate/showRoleBindingForm.jsp"%>
<%@include file="../wihDefaultTemplate/showInputForm.jsp"%>

<script>
	function customizeForm(){	
		document.forms[0].action='showEditor.jsp';
		document.forms[0].submit();
	}
</script>
<a href="javascript:customizeForm()">Customize...</a>


<%@include file="../wihDefaultTemplate/showRelatedKnowledges.jsp"%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">		
	<tr>
		<td align="right" valign="center">
<!--			<input type=submit value="Complete">-->
<%
if(isMine){
	if( isDraftActivity ){
%>
			<input type=button onclick="completeApprove('draft');" value="draft">
<%
	}else{
%>
			<input type=button onclick="completeApprove('approve');" value="approve">
<%
		if(!isLastApprove){
%>
			<input type=button onclick="completeApprove('arbitraryApprove');" value="arbitrary approve">
<%
		}
%>
			<input type=button onclick="completeApprove('reject');" value="reject">
<%			
	}
}
%>		
		</td>
	</tr>
</table>

</form>
<%
	}finally{
		pm.remove();
	}
%>

