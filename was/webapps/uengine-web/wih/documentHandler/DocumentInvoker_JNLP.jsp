<%@page contentType="application/x-java-jnlp-file; charset=UTF-8"%>
<%	response.setContentType("application/x-java-jnlp-file; charset=UTF-8");
	response.setHeader("Cache-Control", "public");
	response.setHeader("Expires", "0");

        String url = request.getRequestURL().toString();
        String codebase = url.substring( 0, url.lastIndexOf( "/" ) );
%><%@ page import="java.util.*,javax.naming.InitialContext"%><%@
 page import="javax.rmi.PortableRemoteObject"%><%@  
 page import="javax.naming.Context"%><%@
 page import="javax.naming.NamingException"%><%@ 
 page import="org.uengine.processmanager.*"%><%@ 
 page import="org.uengine.kernel.*"%><%@ 
 page import="org.uengine.util.UEngineUtil"%><%@ 
 page import="org.metaworks.*"%><%@ 
 page import="org.metaworks.web.*"%><%@ 
 page import="org.metaworks.inputter.*"%><%@ 
 page import="java.io.*"%><%@ 
 page import="org.uengine.webservices.worklist.*"%><%@ 
 page import="org.uengine.webservice.*"%><%@
 page import="org.uengine.contexts.*"%><%@
 page import="javax.transaction.*"%><%@include file="../../common/headerMethods.jsp"%>
<%
	String defVerId = request.getParameter("defVerId");
	String instanceId = request.getParameter("instanceId");
	String variableName = request.getParameter("variableName");
	String documentFile = request.getParameter("documentFile");
	
	
	
	if(variableName!=null){
		InitialContext context = new InitialContext();
		%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

		ProcessManagerRemote pm = processManagerFactory.getProcessManager();
		ProcessDefinition pd = pm.getProcessDefinition(defVerId);
		ProcessVariable theVariable = pd.getProcessVariable(variableName);
		
		FileContext theValue = null;

		UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

		try{
			if(tx!=null) tx.begin();
			
	
			if(theVariable.getDefaultValue() instanceof FileContext){
				FileContext defaultValue = (FileContext)theVariable.getDefaultValue();
//System.out.println("defaultValue ---- " + defaultValue);	
				if(defaultValue.isFtpFile() && defaultValue.getTemplateFilePath()!=null && defaultValue.getTemplateFilePath().endsWith(".xls")){
					ProcessInstance instance = (UEngineUtil.isNotEmpty(instanceId) ? pm.getProcessInstance(instanceId) : null);
					if(instance!=null) theValue = (FileContext)instance.get("", theVariable.getName());
//System.out.println("theValue ---- " + theValue);	
					if(theValue == defaultValue || theValue == null){
						theValue = (FileContext)defaultValue.clone();
					}
					
					theValue.beforeOpen(instance, theVariable.getName());
					instance.set("", theVariable.getName(), (Serializable)theValue);
					
					pm.applyChanges();
					
					documentFile = theValue.getPath();
				}
			}

			if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
				tx.commit();

		}catch(Exception e){
			e.printStackTrace();
		
			if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
				tx.rollback();
			throw e;
		}		
	}

%>
<?xml version="1.0" encoding="utf-8"?> 
	<jnlp 
  	  spec="1.0+" 
	  codebase="<%=codebase%>"> 
  	  <information> 
    	    <title>File launcher for u|Engine</title> 
    	    <vendor>uEngine.org</vendor> 
    	      <homepage href="http://www.uengine.org"/> 
    	      <description>File launcher for u|Engine</description> 
    	      <description kind="short">File launcher for u|Engine.</description> 
    	    <offline-allowed/> 
  	  </information> 
	  <security> 
	    <all-permissions/> 
	  </security>   	  
  	  <resources> 
	    <j2se version="1.4+ 1.3+"/> 
            <jar href="SignedDocumentInvoker.jar"/> 
          </resources> 
          <application-desc main-class="DocumentInvoker"> 
		    <argument><%=documentFile%></argument> 
		    <argument><%=decode(request.getParameter("uploadFTPAddress"))%></argument> 
		    <argument><%=decode(request.getParameter("uploadFTPDirectory"))%></argument> 
		    <argument><%=decode(request.getParameter("FTPid"))%></argument> 
		    <argument><%=decode(request.getParameter("FTPpw"))%></argument> 

		    <!--argument>localhost</argument> 
		    <argument>uengine_upload</argument> 
		    <argument>administrator</argument> 
		    <argument>18925</argument--> 
	  </application-desc> 
</jnlp>