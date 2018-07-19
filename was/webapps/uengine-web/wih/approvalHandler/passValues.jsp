<input type=hidden value='<%=decode(request.getParameter("instanceId"))%>' name=instanceId>
<input type=hidden value='<%=request.getParameter("message")%>' name=message>
<input type=hidden value='<%=decode(request.getParameter("processDefinition"))%>' name=processDefinition>
<input type=hidden value='<%=initiationProcessDefinition%>' name=initiationProcessDefinition>
<input type=hidden value='<%=request.getParameter("tracingTag")%>' name=tracingTag>
<input type=hidden value='<%=request.getAttribute("taskId") !=null ? request.getAttribute("taskId") : request.getParameter("taskId")%>' name=taskId>
<input type=hidden value='<%=request.getParameter("initiate")%>' name=initiate>
<input type=hidden value='<%=request.getParameter("isEventHandler")%>' name=isEventHandler>
<input type=hidden value='<%=request.getParameter("mainInstanceId")%>' name=mainInstanceId>
<input type=hidden value='<%=request.getParameter("eventName")%>' name=eventName>
<input type=hidden value='<%=request.getParameter("triggerActivityTracingTag")%>' name=triggerActivityTracingTag>
<input type=hidden value='<%=request.getParameter("approvalLineActivityTT")%>' name=approvalLineActivityTT>




