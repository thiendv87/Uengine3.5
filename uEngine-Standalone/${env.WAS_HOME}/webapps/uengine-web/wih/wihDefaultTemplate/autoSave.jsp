<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>

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
		try {
			return decode(orgVal);
		} catch(Exception e) {
			return null;
		}
	}
	
%>
<jsp:useBean id="processManagerFactory" scope="application" 
class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	InitialContext context = new InitialContext();
	boolean isAuto = UEngineUtil.isTrue(request.getParameter("autoSave"));

	Map parameterMap;

	WebUtil.setWebStringDecoder(
		new WebStringDecoder() {
			public String decode(String src){
				return outterdecoder(src);
			}
		}
	);
	
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));

	parameterMap = FormActivity.createParameterMapFromRequest(request);

	String processDefinition = getParameter(parameterMap, "processDefinition");
	String initiationProcessDefinition = getParameter(parameterMap, "initiationProcessDefinition");
	String processInstance = decode(getParameter(parameterMap, "instanceId"));
	String tracingTag = decode(getParameter(parameterMap, "tracingTag"));
	String taskId = decode(getParameter(parameterMap, "taskId"));
	boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
	boolean saveOnly = "yes".equals(getParameter(parameterMap, "saveOnly"));
	boolean autoSave = "yes".equals(getParameter(parameterMap, "autoSave"));
	boolean isEventHandler = "yes".equals(getParameter(parameterMap, "isEventHandler"));
	
	// 2009-08-07 add start
	String InstanceName = decode(getParameter(parameterMap,"name"));
	//add end
	
	ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
	String executionScope = getParameter(parameterMap, "executionScope");
	if(UEngineUtil.isNotEmpty(executionScope)){
		instance.setExecutionScope(executionScope);
	}
	
	Vector result = new Vector();
	
	boolean isValid = true;

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try {
		if (tx != null) tx.begin();		

%>
<div id="getResult" style="display : 'NONE'">
<%@include file="getResult.jsp"%>
</div>

<%
	
		if(isValid){
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();
			KeyedParameter[] processVariableChanges = new KeyedParameter[result.size()];
			result.toArray(processVariableChanges);
			resultPayload.setProcessVariableChanges(processVariableChanges);
			
			String url_of_application_result = getParameter(parameterMap, "url_of_application_result");
			if(UEngineUtil.isNotEmpty(url_of_application_result)){
				resultPayload.setExtendedValue(
						new KeyedParameter("url_of_application_result", url_of_application_result)
				);
			}
 
			String html_of_application_result = getParameter(parameterMap, "html_of_application_result");
			if(UEngineUtil.isNotEmpty(html_of_application_result)){
				resultPayload.setExtendedValue(
						new KeyedParameter("html_of_application_result", html_of_application_result)
				);
			}

			resultPayload.setExtendedValues(new KeyedParameter[]{new KeyedParameter("TASKID", taskId)});
			
			Map genericContext = new HashMap();
			genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
			genericContext.put("request", request);
			//modify by yookjy 
			genericContext.put("response", response);
			genericContext.put("servlet", this);
			genericContext.put("parameterMap", parameterMap);

			//added
			String initiationTime = getParameter(parameterMap, "initiationTime");
			if(UEngineUtil.isNotEmpty(initiationTime)){
				genericContext.put("initiationTime", initiationTime);
			}
			//end
			
			pm.setGenericContext(genericContext);

			if(isEventHandler){
				//String mainInstanceId = getParameter(parameterMap, "mainInstanceId");
				String eventName = getParameter(parameterMap, "eventName");
				String triggerActivityTracingTag = request.getParameter("triggerActivityTracingTag");

				pm.executeEventByWorkitem(processInstance, eventName, triggerActivityTracingTag , resultPayload);
			
			} else if (initiate) {//The case that this workitem handler should initiate the process
				if(processInstance!=null && (processInstance.trim().equals("null") || processInstance.trim().length()==0))
					processInstance = null;
				
				processInstance = pm.initializeProcess(processDefinition, processInstance);
				ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(processDefinition);
				
				org.uengine.kernel.Role[] roles = pdr.getRoles();
				WebInputter inputterForRoleMapping = (WebInputter)ObjectType.getDefaultInputter(RoleMapping.class); 
				for(int i=0; i<roles.length; i++){
					String key = roles[i].getName().replace(' ', '_');
					
					RoleMapping roleMapping = (RoleMapping)inputterForRoleMapping.createValueFromHTTPRequest(parameterMap, "rolemappings", key, null);

					if (roleMapping!=null && roleMapping.getEndpoint()!=null) {
						roleMapping.setName(roles[i].getName());
						pm.putRoleMapping(processInstance, roleMapping);
					}
				}

				pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
%>
<script type="text/javascript">
//<!--
var parentDocument = window.parent.document;
var fld_InstanceId = parentDocument.getElementById("instanceId");
var fld_initiate = parentDocument.getElementById("initiate");

fld_InstanceId.value = "<%=processInstance%>";
fld_initiate.value = "no";
//-->
</script>

<%
			} else {
				pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}
			
			pm.applyChanges();

%>
<%@include file="saveFormInstance.jsp" %>

<script type="text/javascript">
//<!--
<%	}

	if (tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.commit();
	
	if (!isAuto) {
%>
	alert("Success! To save work item.");
<%}%> 
    var  today = new Date();
	window.top.insertMassge("The last auto saving : " + today.getHours() + "h : " + today.getMinutes() + "m");
//-->
</script>
<%
} catch(Exception e) {
	try {
		pm.cancelChanges();
	} catch(Exception ex) { }
	
	if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.rollback();
	
	throw e;
} finally {
	try {
		pm.remove();
	} catch(Exception e) { }
}
%>