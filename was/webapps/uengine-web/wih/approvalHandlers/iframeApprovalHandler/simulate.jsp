<%@ page language="java" contentType="text/html; charset=UTF-8" import="org.uengine.processdesigner.SimulatorProcessInstance,org.uengine.util.ActivityForLoop"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>
<%@include file="../wihDefaultTemplate/header.jsp"%>

<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.uengine.contexts.HtmlFormContext"%>
<%@page import="com.fujixerox.common.bean.*"%>
<%@page import="com.fujixerox.activitytypes.FXKApprovalLineActivity"%>

<script>

	function replaceApprovalLine(){

		//opener.document.getElementById('approvalLineDIV').innerHTML = document.getElementById('approvalLineDIV').innerHTML;
		parent.document.getElementById('approvalLineDIV').innerHTML = document.getElementById('approvalLineDIV').innerHTML;
		parent.confirmedCheck();
		//window.close();
	}

</script>
<body onload="replaceApprovalLine()">
<%!
	final String fileUploadEncoding = "UTF-8";


	public String getParameter(Map parameterMap, String key){
		String[] paramPair = (String[])parameterMap.get(key);
		if(paramPair!=null && paramPair.length > 0)
			return paramPair[0];
		else
			return null;
	}

	public String outterdecoder(String orgVal){
		try{
			return decode(orgVal);
		}catch(Exception e){
			return null;
		}
	}
	
%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
ProcessManagerRemote pm = processManagerFactory.getProcessManager();
ProcessManagerBean pmbForSimulation = new ProcessManagerBean();

    try{
        Map parameterMap = FormActivity.createParameterMapFromRequest(true,request); 
        boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
        String tracingTag = getParameter(parameterMap, "tracingTag");
        ProcessDefinition procDef=null;
        ProcessInstance instance=null;
        //if(initiate){
		    Map genericContext = new HashMap();
		    genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
		    genericContext.put("parameterMap", parameterMap);
		    genericContext.put("response", response);
		    genericContext.put("servlet", this);
					
	        Simulatebean simulateBean = new Simulatebean();
	        HashMap dataMap = simulateBean.getSimulatedDefintion(pm ,pmbForSimulation ,loggedRoleMapping , parameterMap,genericContext );
	        procDef = (ProcessDefinition)dataMap.get("definition");
	        instance = (ProcessInstance)dataMap.get("instance");
		//}	
	
%>
<%
	String approvalLineActivityTT = getParameter(parameterMap, "approvalLineActivityTT");

NavienFormApprovalLineActivity formApprovalLineActivity = (NavienFormApprovalLineActivity)procDef.getActivity(approvalLineActivityTT);
NavienFormApprovalActivity draftActivity = formApprovalLineActivity.getDraftActivity();
boolean isLastApprove = false;
boolean isDraftActivity = tracingTag.equals(draftActivity.getTracingTag());
StringBuffer approverHtml = new StringBuffer();

Vector vChildActivities = null;
List approverList = new ArrayList();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String approveDate = null;
String rejectTracingTag = null;
String instanceId;
instanceId = decode(getParameter(parameterMap, "instanceId"));
ProcessInstance piRemote = null;
if(!initiate && UEngineUtil.isNotEmpty(instanceId))
	piRemote = pm.getProcessInstance(instanceId);
%>
<%@include file="./inc_approvalLine.jsp"%>

<%
	
}finally{
	try{
		pm.cancelChanges();
		pm.remove();
	}catch(Exception ex){}
	try{
		pmbForSimulation.remove();

	}catch(Exception ex){}
}
%>
