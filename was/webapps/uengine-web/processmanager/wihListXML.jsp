<?xml version="1.0" encoding="UTF-8"?>
<%
response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><%@page 
	pageEncoding="KSC5601" 
	import="javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException,javax.rmi.PortableRemoteObject,org.uengine.kernel.*,java.util.*,java.io.*,org.uengine.processmanager.*"
%><%

	String wihPath = System.getProperty(GlobalContext.PROPERTY_JBOSS_HOME_DIR, ".") 
					+ sep + "server" + sep + "default" + sep + "deploy" + sep + "ext.ear"+ sep +"portal-web-complete.war"+sep+"html"+sep+"uengine-web" + sep + "wih";
				
	File wihRootDir = new File(wihPath);
	Vector itemsVct = new Vector();

	File[] wihDirs = wihRootDir.listFiles();
	for(int i=0; i<wihDirs.length; i++){
		if(wihDirs[i].isDirectory()){
			itemsVct.add(wihDirs[i].getName());
		}
	}
%>