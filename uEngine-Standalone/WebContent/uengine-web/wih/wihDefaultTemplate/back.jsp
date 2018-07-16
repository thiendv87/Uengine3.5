<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="javax.transaction.*"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	String nextTaskId = null;
	
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	String backTracingTag = request.getParameter("backTracingTag");
	String pi = request.getParameter("instanceId");
	ProcessInstance instance = null;

	InitialContext context = new InitialContext();
	
	String gotoTaskId = "";
	if(pi != null){
		UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

		try{
			if(tx!=null) tx.begin();	
			
			instance = pm.getProcessInstance(pi);
			HumanActivity humanActivity = (HumanActivity)instance.getProcessDefinition().getActivity(backTracingTag);
			//add by yookjy 2011.04.14 (for save snapshot)
			Map genericContext = new HashMap();	
			genericContext.put("request", request);
			genericContext.put("response", response);
			genericContext.put("servlet", this);
			pm.setGenericContext(genericContext);
			//end
			pm.flowControl("compensateTo", pi, backTracingTag);
			
			//System.out.println("humanActivityName: " + humanActivity.getName());
			String[] taskIds = humanActivity.getTaskIds(instance);

			pm.applyChanges();

			if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
				tx.commit();
		
			//forward to
			//System.out.println("taskId: " + taskIds[0]);
			gotoTaskId = taskIds[0];
			//location err
			//pageContext.forward((wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/processparticipant/worklist/workitemHandler.jsp?taskId="+taskIds[0]);
			%>
			<script type="text/javascript">
				window.top.location.href="<%=GlobalContext.WEB_CONTEXT_ROOT+ "/processparticipant/worklist/workitemHandler.jsp?taskId="+taskIds[0]%>";
			</script>
			<%

		}catch(Exception e){
			e.printStackTrace();
			try{
				pm.cancelChanges();	
			}catch(Exception ex){
			}
			
			if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
				try{
					tx.rollback();
				}catch(Exception ex){}
			//throw e;
		}finally{
			try{
				pm.remove();	
			}catch(Exception ex){
			}
		}
	}
	
	%>