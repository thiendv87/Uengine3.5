<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<script type="text/javascript">
		function init(){}
	</script>
</head>
<body onload="init();" style="overflow:hidden;">
	<form action="setApprovalLine.jsp" name="formIndexPassValues" method="POST"  target="_top">
		테스트용으로 전송합니다..
		<button type="submit">전송</button>
		
		<input type=hidden value='<%=request.getParameter("instanceId")%>' name='instanceId' id="instanceId" />
		<input type=hidden value='<%=request.getParameter("executionScope")%>' name='executionScope' id="executionScope" />
		<input type=hidden value='<%=request.getParameter("processDefinition")%>' name='processDefinition' id="processDefinition" />
		<input type=hidden value='<%=request.getParameter("processDefinition")%>' name='definitionVersionId' id="definitionVersionId" />
		
		<input type=hidden value='<%=request.getParameter("initiationProcessDefinition")%>' name='initiationProcessDefinition' id="initiationProcessDefinition" />
		
		<input type=hidden value='<%=request.getParameter("message")%>' name='message' id="message" />
		<input type=hidden value='<%=request.getParameter("tracingTag")%>' name='tracingTag' id="tracingTag" />
		<input type=hidden value='<%=request.getParameter("isEventHandler")%>' name='isEventHandler' id="isEventHandler" />
		<input type=hidden value='<%=request.getParameter("mainInstanceId")%>' name='mainInstanceId' id="mainInstanceId" />
		<input type=hidden value='<%=request.getParameter("eventName")%>' name='eventName' id="eventName" />
		<input type=hidden value='<%=request.getParameter("triggerActivityTracingTag")%>' name='triggerActivityTracingTag' id="triggerActivityTracingTag" />
		<input type=hidden value='<%=request.getParameter("approvalLineActivityTT")%>' name='approvalLineActivityTT' id="approvalLineActivityTT" />
		<input type=hidden value='<%=request.getParameter("mainProcessDefinition")%>' name='mainProcessDefinition' id="mainProcessDefinition" />
		<input type=hidden value='<%=request.getParameter("strategyId")%>' name='strategyId' id="strategyId" />
		
		<input type=hidden value='<%=request.getAttribute("taskId") != null ? request.getAttribute("taskId") : request.getParameter("taskId")%>' name='taskId' id="taskId" />
		<input type=hidden value='<%=request.getAttribute("initiate") != null ? request.getAttribute("initiate") : request.getParameter("initiate")%>' name='initiate' id="initiate" />
		
		<input type=hidden value='<%=request.getParameter("workitemHandler")%>' name='workitemHandler' id="workitemHandler" />
		
		
		<input type=hidden value='<%=request.getParameter("isViewMode")%>' 			name='isViewMode' 			/>
		<input type=hidden value='<%=request.getParameter("isCustomizing")%>' 		name='isCustomizing' 		/>
		<input type=hidden value='<%=request.getParameter("isMine")%>' 				name='isMine' 				/>
		<input type=hidden value='<%=request.getParameter("cus_com")%>' 			name='cus_com' 				/>
		<input type=hidden value='<%=request.getParameter("editAble")%>' 			name='editAble' 			/>
		<input type=hidden value='<%=request.getParameter("currentPage")%>' 		name='currentPage' 			/>
		<input type=hidden value='<%=request.getParameter("type")%>' 				name='type' 				/>
		
		<input type=hidden value='<%=request.getParameter("isHistoryView")%>' 		name='isHistoryView' 		/>
		<input type=hidden value='<%=request.getParameter("isExtInitiate")%>' 		name='isExtInitiate' 		/>
		<input type=hidden value='<%=request.getParameter("fckEditorContents")%>' 	name='fckEditorContents'	/>
		<input type=hidden value='<%=request.getParameter("isCopyInitiate")%>' 		name='isCopyInitiate' 		/>
		<input type=hidden value='<%=request.getParameter("copyProcInstId")%>' 		name='copyProcInstId' 		/>
		<input type=hidden value='<%=request.getParameter("copyTracingTag")%>' 		name='copyTracingTag' 		/>
		<input type=hidden value='<%=request.getParameter("requester")%>' 			name='requester' 			/>
		<input type=hidden value='<%=request.getParameter("form_name")%>' 			name='form_name' 			/>
		
		<input type=hidden value='<%=request.getParameter("improve_process_defverid")%>' name='improve_process_defverid' />
		<input type=hidden value='<%=request.getParameter("activityName")%>' name='activityName' />
		<input type=hidden value='<%=request.getParameter("dispatchingOption")%>' name='dispatchingOption' />
				
	</form>
</body>
</html>
