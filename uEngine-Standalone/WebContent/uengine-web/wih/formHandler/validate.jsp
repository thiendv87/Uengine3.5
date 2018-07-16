<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>
<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.uengine.contexts.HtmlFormContext"%>

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
	try{
		InitialContext context = new InitialContext();
		boolean nextUserIsCurrentUser = false;
		String nextTaskId = "";
		boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));
		
		ObjectType.addInputterPackage("org.uengine.processdesigner.inputters");
	
		Map parameterMap;
	
		WebUtil.setWebStringDecoder(
			new WebStringDecoder() {
				public String decode(String src){
					return outterdecoder(src);
				}
			}
		);
	
		if (FileUpload.isMultipartContent(request)){
			parameterMap = new HashMap();
			
			parameterMap.put("ignoreDecoder", "yes"); //commons-upload will decode form values by itself.
	
			DiskFileUpload diskFileUpload = new DiskFileUpload();
			diskFileUpload.setSizeThreshold(40960);
			diskFileUpload.setSizeMax(9981920);
			diskFileUpload.setRepositoryPath("temp");
			diskFileUpload.setHeaderEncoding(fileUploadEncoding);//request.getCharacterEncoding());
			List fileItemsList = diskFileUpload.parseRequest(request);
	
			Iterator it = fileItemsList.iterator();
			while (it.hasNext()){
			  FileItem fileItem = (FileItem)it.next();
			  if (fileItem.isFormField()){
				  
				  	String decodedValue = fileItem.getString(fileUploadEncoding);
			    	parameterMap.put(fileItem.getFieldName(), new String[]{decodedValue, ""});
			  }
			  else{
				  
			    File fullFile  = new File(fileItem.getName());
			    
			    String fileNameOnly = fileItem.getName();
			    int lastIndexOfSeparator = fileNameOnly.lastIndexOf("\\");
			    if(lastIndexOfSeparator == -1){
			    	lastIndexOfSeparator = fileNameOnly.lastIndexOf("/");
			    }
			    if(lastIndexOfSeparator > -1)
			    	fileNameOnly = fileNameOnly.substring(lastIndexOfSeparator + 1); 
			    
			    String uniqueFName = java.util.Calendar.getInstance().getTimeInMillis() + "_" + fileNameOnly;
			    File savedFile = new File(getServletContext().getRealPath(GlobalContext.WEB_CONTEXT_ROOT+"/uploads/"), uniqueFName);
			    fileItem.write(savedFile);
			    
			    
			    String xmlExp = GlobalContext.serialize(savedFile, File.class);
	
			    parameterMap.put(fileItem.getFieldName() + "__WHICH_IS_XML_VALUE", new String[]{xmlExp, ""});
			  }
			}
			
		}else{
			parameterMap = request.getParameterMap(); //
			
			//System.out.println(">>>>"+parameterMap);
		}
	
		String processDefinition = getParameter(parameterMap, "processDefinition");
		String initiationProcessDefinition = getParameter(parameterMap, "initiationProcessDefinition");
		String processInstance = decode(getParameter(parameterMap, "instanceId"));
		String tracingTag = decode(getParameter(parameterMap, "tracingTag"));
		String taskId = decode(getParameter(parameterMap, "taskId"));
		boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
		boolean saveOnly = "yes".equals(getParameter(parameterMap, "saveOnly"));
		boolean isEventHandler = "yes".equals(getParameter(parameterMap, "isEventHandler"));
		Vector result = new Vector();
		ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
		ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
		FormActivity formActivity = (FormActivity)procDef.getActivity(tracingTag);
	

	
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();

			if(initiate){//The case that this workitem handler should initiate the process
				if(processInstance!=null && (processInstance.trim().equals("null") || processInstance.trim().length()==0))
					processInstance = null;
				
				ProcessManagerBean pmbForSimulation = new ProcessManagerBean();
			
				Map genericContext = new HashMap();
				genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
				genericContext.put("request", request);
				genericContext.put("response", response);
				genericContext.put("servlet", this);
				pmbForSimulation.setGenericContext(genericContext);

				processInstance = new SimulatorProcessInstance(procDef, "Test", null);
				processInstance.setProcessTransactionContext(pmbForSimulation.getTransactionContext());
				processInstance.execute();

			}


	
}catch(Exception e){
	e.printStackTrace();
	
	try{
		pm.cancelChanges();
	}catch(Exception ex){}
	
	throw e;
}
%>
