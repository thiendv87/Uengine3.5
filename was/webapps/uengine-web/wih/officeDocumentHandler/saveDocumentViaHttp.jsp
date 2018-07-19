<%@include file="../common/header.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="org.uengine.util.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.io.*"%>
<%@page import="org.uengine.contexts.*"%>
	
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = null;
	try{
		pm = processManagerFactory.getProcessManagerForReadOnly();
	}finally{
		if(pm!=null) try{pm.remove();}catch(Exception e){}
	}
	String defId = null;
	String path = null;
	try{	
		path = File.separatorChar + "upload";
		Map parameterMap = new HashMap();
		
		//System.out.println("defId == " + defId + "  path == " + path);
		DiskFileUpload upload = new DiskFileUpload();
		
		File f = new File(path + File.separatorChar + "temp");
		if(!f.exists())
			f.mkdirs();
			
		upload.setSizeMax(10*1024*1024); //파일 업로드 최대 size 
		upload.setSizeThreshold(4096);//메모리에 저장할 최대 size 		
		upload.setRepositoryPath(path + File.separatorChar + "temp"); //파일 임시 저장소 		 
		 
		List items = upload.parseRequest(request); 
		Iterator iter = items.iterator(); 
		String fileName = null;
		//System.out.println(items.size() + "items.size()");
		String officeDocumentDefinitionInXML = null;
		while (iter.hasNext()) {		
			FileItem item = (FileItem)iter.next();
			if(item.isFormField()){	 
			    String name = item.getFieldName();// 필드 이름 
				System.out.println("name " + name);
			    String value = item.getString();// 필드 값
			    if(name.equals("officeDocumentDefinitionInXML")) {
			    	officeDocumentDefinitionInXML = value;
			    }
			}else{ //input type="file" 인경우 
			    String fileName = item.getName();
			    System.out.println("fileName = " + fileName );
			    long fileSize = item.getSize();//파일 사이즈 
			  
			  	String filePath = UEngineUtil.getCalendarDir();
				File dirToCreate = new File(FILE_SYSTEM_DIR + filePath);
				dirToCreate.mkdirs();
			
				String datePrefix = sdf.format(new Date());
				fileName = instance.getInstanceId() +"_"+datePrefix + "_" + fileName;
		
				
			    //실질적인 저장 
			    File file = new File(filePath + "/" + fileName);
			    item.write(file);
			}
		}
		
		OfficeDocumentInstance officeDocInst = (OfficeDocumentInstance)GlobalContext.deserialize(officeDocumentDefinitionInXML);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS", Locale.KOREA);
		
		
		
		officeDocInst.setFilePath(fileName);
		
		activity.getVaraibelFor....().set(pi, officeDocInst, "");

		pm.applyChanges();
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