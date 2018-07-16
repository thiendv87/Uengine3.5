<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
//String uploadDir = "/innorix/AP/test/data";
String uploadDir = "D:/uploadTest";
try
{
	MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "euc-kr", new DefaultFileRenamePolicy());
%>
<table border="0" cellspacing="1" cellpadding="2" bgColor="#C0C0C0">
<tr>
  <td bgColor="#EFEFEF">input name</td>
  <td bgColor="#EFEFEF">file system name</td>
  <td bgColor="#EFEFEF">original name</td>
</tr>
<%
	for (Enumeration e = multi.getFileNames(); e.hasMoreElements() ; ) {
		String formName = (String)e.nextElement();
		String sysName = (String)multi.getFilesystemName(formName);
		String orgName = (String)multi.getOriginalFileName(formName);

		out.println("<tr>");
		out.println("<td bgColor='#FFFFFF'>" + formName +"</td>");
		out.println("<td bgColor='#FFFFFF'>" + sysName +"</td>");
		out.println("<td bgColor='#FFFFFF'>" + orgName +"</td>");
		out.println("</tr>");
	} 
%>
</table>
<% } catch(Exception e) { } %>
