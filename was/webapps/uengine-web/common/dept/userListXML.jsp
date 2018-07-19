<?xml version="1.0" encoding="UTF-8"?>
<%
response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><jsp:useBean id="_rdm" type="com.woorifis.srms.core.result.ResultDataManager" scope="request"/><%@page import="com.woorifis.srms.common.bean.DeptBean"
%><%@page import="com.woorifis.srms.common.controller.CommonController"
%><%@page import="java.util.List"
%><%@page import="java.util.Hashtable"
%><%@page import="java.util.*,java.io.*"
%><%@page import="com.woorifis.srms.util.StringUtil"
%><%@page import="com.woorifis.srms.util.EncodeUtil"
%><%@page import="com.woorifis.srms.util.DateUtil"
%><%!


%><%
	List<DeptBean> dept1LvList = (List<DeptBean>) _rdm.getData("DeptLv1");

	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	spw.println("<folder name='Process Definitions'>");
	for(DeptBean data : dept1LvList){
		spw.print("<folder name='"+data.getDeptNm()+"'></folder>");
	}
	spw.println("</folder>");

%><%=sw.toString()%>