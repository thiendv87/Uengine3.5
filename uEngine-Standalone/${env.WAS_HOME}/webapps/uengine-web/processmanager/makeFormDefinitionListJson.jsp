
<%@page import="org.uengine.ui.tree.json.FormListToJSON"%>
<%@page import="org.uengine.ui.tree.dao.ProcessDefinitionListDAO"%><%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="org.uengine.ui.tree.model.Item"%>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%
	DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
	ProcessDefinitionListDAO formListDAO = new ProcessDefinitionListDAO(dataSource); 
	List<Item> formDefinitionList = formListDAO.findAllFormListForParticipant(loggedUserId);
	FormListToJSON makeFormListToJSON = new FormListToJSON(); 
	out.print(makeFormListToJSON.toJSON(formDefinitionList));
%>