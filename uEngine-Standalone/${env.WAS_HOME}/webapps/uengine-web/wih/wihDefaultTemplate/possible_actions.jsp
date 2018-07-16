
	<script type="text/javascript">
		function onEventButtonClicked(eventName){
			document.forms[0].action = "<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/eventHandler.jsp";
			document.forms[0].eventName.value = eventName;
			document.forms[0].submit();
		}
	</script>

<%
		org.uengine.kernel.EventHandler[] eventHandlersInAction = (org.uengine.util.UEngineUtil.isNotEmpty(instanceId) ? pm.getEventHandlersInAction(instanceId) : null);

		if(eventHandlersInAction!=null && eventHandlersInAction.length > 0){
			for(int i=0; i<eventHandlersInAction.length; i++){
				org.uengine.kernel.EventHandler theEventHandler = eventHandlersInAction[i];
				if (
						theEventHandler.getTriggeringMethod() == org.uengine.kernel.EventHandler.TRIGGERING_BY_EVENTBUTTON 
						//&& theEventHandler.getHandlerActivity() instanceof SubProcessActivity
				) {
					if (
							(theEventHandler.getOpenRoles() != null 
							&& !theEventHandler.getOpenRoles().containsMapping(piRemote, loggedRoleMapping))
							|| (isEventHandler && theEventHandler.getName().equals(eventName)) //자기 자신이 이벤트 핸들러이고, 동일한 이벤트 네임을 가지고 있다면 이벤트 버튼을 출력하지 않는다.
					) continue;
					
					if("reject".equals(theEventHandler.getName())){
						%>
						<a href="javascript:onEventButtonClicked('<%=theEventHandler.getName()%>');"><img src="../../images/Common/b_btn_reject.gif"></a>&nbsp;
						<%							
					} else if ("reselect".equals(theEventHandler.getName())) {
						%>
						<a href="javascript:onEventButtonClicked('<%=theEventHandler.getName()%>');"><img src="../../images/Common/b_btm_reselect.gif"></a>&nbsp;
						<%
					} else {
						%>
						<div class="gBtn1"><a href="javascript:onEventButtonClicked('<%=theEventHandler.getName()%>')"><%=theEventHandler.getDisplayName().getText(loggedUserLocale)%></a></div>&nbsp;
						<%
					}
				}
			}	
		}else{
			
		}
		//<!-- a href="javascript:onEventButtonClicked('<!--%=theEventHandler.getName()%-->')"><!-- img src="/images/Common/b_btn_reject.gif"></a>&nbsp;-->
%>