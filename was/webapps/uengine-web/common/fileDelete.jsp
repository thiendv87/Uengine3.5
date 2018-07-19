<%@page import="java.net.URLDecoder"%>
<%@page import="org.uengine.kernel.ProcessDefinitionFactory"%>
<%@page import="org.uengine.kernel.FormActivity"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.uengine.util.UEngineUtil"%>
<%@page import="com.sun.xml.internal.ws.util.UtilException"%>
<%@page import="org.uengine.ui.taglibs.input.InputConstants"%>
<%@page import="org.uengine.contexts.FileContext"%>
<%@page import="java.net.URLEncoder"%>
<%--@page import="com.defaultcompany.util.FileUploadUtil"--%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@ page pageEncoding="UTF-8" language="java"
	contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding(GlobalContext.ENCODING);
	Logger logger = Logger.getLogger(this.getClass());
	boolean isSuccess = false;
	String fileInfo = request.getParameter("fileContext");

	if (fileInfo != null) {
		FileContext fc = (FileContext)GlobalContext.deserialize(URLDecoder.decode(fileInfo, GlobalContext.ENCODING));
		
		File file = new File(FormActivity.FILE_SYSTEM_DIR + "/" + fc.getPath());
		if (file.exists()) {
			isSuccess = file.delete();
		}
	}
%>
{"result":<%=isSuccess %>}