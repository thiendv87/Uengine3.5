
<%@page import="org.uengine.ui.tree.json.FolderListToJSON"%>
<%@page import="org.uengine.ui.tree.json.ProcessDefinitionForParticipantListToJSON"%>
<%@page import="org.uengine.ui.tree.json.ProcessDefinitionListToJSON"%>
<%@page import="org.uengine.ui.tree.dao.ProcessDefinitionListDAO"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	boolean moveToDef = "Y".equals(request.getParameter("moveToDef")) ? true : false;
%>
<%@page import="javax.sql.DataSource"%>
<%@page import="org.uengine.ui.tree.model.Item"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%

	SimpleTransactionContext st = new SimpleTransactionContext();
	
	try{
		//DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		ProcessDefinitionListDAO processDefinitionListDAO = new ProcessDefinitionListDAO(st);
		List<Item> processDefinitionList = null;
		
		if (moveToDef == false) {
			processDefinitionList = processDefinitionListDAO.findFolderAuthorityProcessDefinitions(loggedUserId, loggedUserGlobalCom, AclManager.PERMISSION_VIEW);
			
			ProcessDefinitionListToJSON makeProcessDefinitionListJson = new ProcessDefinitionListToJSON();
			out.print(makeProcessDefinitionListJson.toJSON(processDefinitionList));
		} else {
			processDefinitionList = processDefinitionListDAO.findAllFolder(loggedUserId);
			FolderListToJSON f = new FolderListToJSON();
			out.print(f.toJSON(processDefinitionList));	
		}
	} finally{
		try {
			st.releaseResources();
		} catch (Exception e) {
		}
	}
%>