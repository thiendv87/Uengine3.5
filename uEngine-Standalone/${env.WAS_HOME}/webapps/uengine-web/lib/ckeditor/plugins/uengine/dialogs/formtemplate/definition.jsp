<%@page import="org.uengine.ui.tree.json.FormListToJSON"%>
<%@page import="org.uengine.ui.tree.dao.ProcessDefinitionListDAO"%><%@include file="../../../../../../common/header.jsp"%>
<%@include file="../../../../../../common/getLoggedUser.jsp"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="org.uengine.ui.tree.model.Item"%>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%
	SimpleTransactionContext stc = null;
	try {
		stc = new SimpleTransactionContext();
		ProcessDefinitionListDAO formListDAO = new ProcessDefinitionListDAO(stc); 
		List<Item> formDefinitionList = formListDAO.findAllFormListForParticipant(loggedUserId);
		FormListToJSON makeFormListToJSON = new FormListToJSON(); 
		out.print(makeFormListToJSON.toJSON(formDefinitionList));
	} finally {
		if (stc != null) {
			stc.releaseResources();
		}
	}
%>