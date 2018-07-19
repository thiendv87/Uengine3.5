<%@include file="../common/header.jsp"%><%@page import="org.uengine.kernel.workflow.*"%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String instanceId="";
	try{
		WorkflowHandler wh = WorkflowHandler.getInstance();
		instanceId = wh.doAction(pm,request);
		
		pm.applyChanges();
	}catch(Exception e ){
		out.print("0");
		try{
			pm.cancelChanges();
		}catch(Exception ex){
		}
		throw e;
	}finally{
		try{
			pm.remove();
		}catch(Exception ex){
		}
	}
	//response.setContentType("text/html;charset=EUC-KR");
	//PrintWriter pw = response.getWriter();
	out.print(instanceId);
%>