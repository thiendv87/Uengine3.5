<input type=hidden value='<%=request.getParameter("instanceId")%>' name='instanceId' id="instanceId" />
<input type=hidden value='<%=request.getParameter("executionScope")%>' name='executionScope' id="executionScope" />
<input type=hidden value='<%=request.getParameter("processDefinition")%>' name='processDefinition' id="processDefinition" />
<input type=hidden value='<%=request.getParameter("processDefinition")%>' name='definitionVersionId' id="definitionVersionId" />

<input type=hidden value='<%=initiationProcessDefinition%>' name='initiationProcessDefinition' id="initiationProcessDefinition" />

<input type=hidden value='<%=request.getParameter("message")%>' name='message' id="message" />
<input type=hidden value='<%=request.getParameter("tracingTag")%>' name='tracingTag' id="tracingTag" />
<input type=hidden value='<%=request.getParameter("initiatorHumanActivityTracingTag")%>' name='initiatorHumanActivityTracingTag'>
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
