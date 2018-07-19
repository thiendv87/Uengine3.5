<?xml version="1.0" encoding="UTF-8"?>
<%
response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><%@ page import="com.liferay.portal.model.Role" 
%><%@ page import="com.liferay.portal.service.spring.*" 
%><%@ page import="com.liferay.portal.util.comparator.*" 
%><%@ page import="com.liferay.portal.util.PortalUtil" 
%><%@ page import="com.liferay.portal.NoSuchUserException" 
%><%@ page import="com.liferay.portal.model.User"
%><%@ page import="com.liferay.portlet.documentlibrary.service.spring.DLFolderLocalServiceUtil"
%><%@ page import="com.liferay.portlet.documentlibrary.model.DLFolder"
%><%@include file="../common/headerMethods.jsp"
%><folders><%
//	User user = UserServiceUtil.getUserById(getEndpoint());
	
//	int cnt = RoleLocalServiceUtil.searchCount("liferay.com", null, null);
//	java.util.List results = RoleLocalServiceUtil.search("liferay.com", null, null, 0, cnt);
	
	java.util.List folders = DLFolderLocalServiceUtil.getFolders("liferay.com");
	
	com.liferay.portlet.documentlibrary.model.DLFolder[] dlFolders = (DLFolder[]) folders.toArray(new com.liferay.portlet.documentlibrary.model.DLFolder[0]);

//	com.liferay.portal.model.Role[] roles = (Role[])results.toArray(new com.liferay.portal.model.Role[0]);
	
	for(int i=0; i<dlFolders.length; i++){
	%><folder value="<%= dlFolders[i].getFolderId() %>" name="<%=replaceAmp(dlFolders[i].getName()) %>"/><%
	}
%></folders>
