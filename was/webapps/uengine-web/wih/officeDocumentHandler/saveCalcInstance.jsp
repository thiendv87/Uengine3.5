<%@include file="../../common/header.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="org.uengine.util.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.io.*"%>
<%@page import="org.uengine.contexts.*"%>
<%@page import="org.uengine.kernel.*"%>
<%@page import="java.text.SimpleDateFormat"%>
	
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = null;
	try{
		pm = processManagerFactory.getProcessManager();
	}finally{
		if(pm!=null) try{pm.remove();}catch(Exception e){}
	}
	
	String loggedUserId = request.getParameter("loggedUserId");
	RoleMapping loggedRoleMapping = RoleMapping.create();
	loggedRoleMapping.setEndpoint(loggedUserId);
	
	String path = null;
	try{
		String FILE_SYSTEM_DIR = GlobalContext.getPropertyString("filesystem.path", ProcessDefinitionFactory.DEFINITION_ROOT);
		String processDefId = request.getParameter("processDefId");
		String instanceId = request.getParameter("instanceId");
		String tracingTag = request.getParameter("tracingTag");
		System.out.println("instanceId before = " + instanceId);
		if(!UEngineUtil.isNotEmpty(instanceId)){ //if initiation work-item
		
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();

			Map genericContext = new HashMap();
			genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
			genericContext.put("request", request);
			genericContext.put("response", response);
			genericContext.put("servlet", this);
			pm.setGenericContext(genericContext);
		
			instanceId = pm.initializeProcess(processDefId, instanceId);
			pm.saveWorkitem(instanceId, tracingTag, null, resultPayload);
			System.out.println("processDefId = " + processDefId);	
			System.out.println("instanceId after = " + instanceId);		
		}
		
		ProcessInstance procInstance = pm.getProcessInstance(instanceId);
		ProcessDefinition procDefinition = procInstance.getProcessDefinition();
		OfficeDocumentActivity activity = (OfficeDocumentActivity)procDefinition.getActivity(tracingTag);
		
		path = File.separatorChar + "upload";
		
		//System.out.println("defId == " + defId + "  path == " + path);
		DiskFileUpload upload = new DiskFileUpload();
		
		File f = new File(path + File.separatorChar + "temp");
		if(!f.exists())
			f.mkdirs();
			
		upload.setSizeMax(10*1024*1024); //파일 업로드 최대 size 
		upload.setSizeThreshold(4096);//메모리에 저장할 최대 size 		
		upload.setRepositoryPath(f.getAbsolutePath()); //파일 임시 저장소 		 
		 
		List items = upload.parseRequest(request); 
		Iterator iter = items.iterator(); 
		String fileName = null;
		//System.out.println(items.size() + "items.size()");
		String fieldMapInXML = null;
		while (iter.hasNext()) {		
			FileItem item = (FileItem)iter.next();
			if(item.isFormField()){	 
			    String name = item.getFieldName();// 필드 이름 
				System.out.println("name " + name);
			    String value = item.getString();// 필드 값
			    if(name.equals("fieldMapInXML")) {
			    	fieldMapInXML = value;
			    }
			}else{ //input type="file" 인경우
			    //System.out.println("fileName = " + fileName );
			    
				String filePath = UEngineUtil.getCalendarDir();
				File dirToCreate = new File(FILE_SYSTEM_DIR + filePath);
				dirToCreate.mkdirs();
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS", Locale.KOREA);
				String datePrefix = sdf.format(new Date());
				fileName = filePath + File.separator + instanceId +"_"+datePrefix + "_"+item.getName();
				File newFile = new File(FILE_SYSTEM_DIR + fileName);			  		
				//FileOutputStream fos = new FileOutputStream(newFile);
				//fos.close();
			    //실질적인 저장 
			    item.write(newFile);
			}
		}
		
		String documentDefId = ((OfficeDocumentInstance)activity.getVariableForOfficeDocumentInstance().getDefaultValue()).getDocumentDefId();
		Map fieldMap = (Map)GlobalContext.deserialize(fieldMapInXML);
		
		OfficeDocumentInstance officeDocInstance = new OfficeDocumentInstance();
     	officeDocInstance.setFilePath(fileName);     	
		officeDocInstance.setDocumentDefId(documentDefId);
     	officeDocInstance.setValueMap(fieldMap);
     	try {
			officeDocInstance.saveValueMap();
		} catch (Exception e1) {
			e1.printStackTrace();
		}     		
		
		activity.getVariableForOfficeDocumentInstance().set(procInstance, "", officeDocInstance);
		pm.applyChanges();
		//pm.importProcessDefinition(is, (String)parameterMap.get("definitionId"));
		//if(f.exists()) {			
		//	f.deleteOnExit();
		//}
	}catch(Exception e){
	    throw e;
	}finally{
	  	try{
			pm.cancelChanges();
			pm.remove();
		}catch(Exception ex){}
	}
%>
ProcessDefinition has been successfully imported.<br>
<!--script-->
<!--location="processDefinitionList.jsp";-->