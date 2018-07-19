<%@page import="org.uengine.util.*,org.uengine.kernel.*, org.uengine.processmanager.*, org.uengine.contexts.*, java.io.*"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = null;
	
	try{
	
		pm = processManagerFactory.getProcessManagerForReadOnly();
		
		String instanceId = request.getParameter("instanceId");
		String tracingTag = request.getParameter("tracingTag");
		
		ProcessInstance pi = null;
		String filePath = null;
		String FILE_SYSTEM_DIR = GlobalContext.getPropertyString("filesystem.path", ProcessDefinitionFactory.DEFINITION_ROOT);
		
		if(UEngineUtil.isNotEmpty(instanceId)){ //try instance document first
			pi = pm.getProcessInstance(instanceId);
			ProcessDefinition pd = pi.getProcessDefinition();
			OfficeDocumentActivity activity = (OfficeDocumentActivity)pd.getActivity(tracingTag);
			OfficeDocumentInstance odi = (OfficeDocumentInstance)activity.getVariableForOfficeDocumentInstance().get(pi, "");
			
			if(odi!=null && odi.getFilePath()!=null){
				filePath = odi.getFilePath();
			}
		}
		
		if(filePath==null){ //if there's no instance document have been saved, try template doc.
			String documentDefVerId = request.getParameter("documentDefVerId");		
			String documentDefinitionInXml = pm.getResource(documentDefVerId);

			OfficeDocumentDefinition odd = (OfficeDocumentDefinition)GlobalContext.deserialize(documentDefinitionInXml, OfficeDocumentDefinition.class);
			filePath = odd.getFilePath();
		}
		
		FileInputStream fis = new FileInputStream(FILE_SYSTEM_DIR + filePath);
		
		String contentType = "text/html";
	
		if(filePath.endsWith(".doc")){
			contentType = "application/msword";
		}else
		if(filePath.endsWith(".ppt")){
			contentType = "application/vnd.ms-powerpoint";
		}else
		if(filePath.endsWith(".xls")){
			contentType = "application/vnd.ms-excel";
		}
	
		response.setContentType(contentType + "; charset=UTF-8");
		response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	
		
		UEngineUtil.copyStream(fis, response.getOutputStream());

	}finally{
		pm.remove();
	}
%>