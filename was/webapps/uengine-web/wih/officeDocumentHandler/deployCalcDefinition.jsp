<%@include file="../../common/header.jsp"%>
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
	String path = null;
	String FILE_SYSTEM_DIR = GlobalContext.getPropertyString("filesystem.path", ProcessDefinitionFactory.DEFINITION_ROOT);	
	String defName = decode(request.getParameter("defName"));
	int version = Integer.parseInt(decode(request.getParameter("version")));
	String folder = decode(request.getParameter("folder"));
	String belongingDefId = decode(request.getParameter("defId"));
	String alias = decode(request.getParameter("alias"));
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
			    System.out.println("formField");
			}else{ //input type="file" 인경우 
			    fileName = item.getName();
			    System.out.println("fileName = " + fileName );
			    long fileSize = item.getSize();//파일 사이즈 
			  
			    System.out.println("fileName = " + FILE_SYSTEM_DIR + fileName);
			    //실질적인 저장 
			    File file = new File(FILE_SYSTEM_DIR + fileName);
			    item.write(file);
			}
		}
		OfficeDocumentDefinition officeDocDef = (OfficeDocumentDefinition)GlobalContext.deserialize(officeDocumentDefinitionInXML);
		String currentDir = FormActivity.FILE_SYSTEM_DIR+File.separatorChar;
		officeDocDef.setFilePath(fileName);
		
		officeDocumentDefinitionInXML = GlobalContext.serialize(officeDocDef, OfficeDocumentDefinition.class);
														//NEW			IMPROVE
		String defVerId = pm.addProcessDefinition(		//------------- -----------------------------
				defName, 								//UI*
				version, 								//1				기존값(main JWS*) + 1 -> UI*
				null, 									//무관			무관
				false, 									//false 고정		false 고정
				officeDocumentDefinitionInXML, 			
				folder, //savingFolder -1				//main(JWS)*	null
				belongingDefId, 	//belongingDefId, 	//null			main(JWS)*
				alias,	//definitionAlias,       		//UI*			null
				"excel");								//excel고정		excel고정
		pm.applyChanges();
		%>OK<%
	}catch(Exception e){
	%><%=e.getMessage()%><%
	}finally{		
	  	try{
			pm.cancelChanges();
			pm.remove();
		}catch(Exception ex){}
	}
%>