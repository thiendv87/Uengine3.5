<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@page import="org.uengine.util.dao.*"
%><%@page import="org.uengine.persistence.dao.*"
%><%@page import="org.uengine.webservices.worklist.*"
%><%@page import="org.uengine.ui.list.datamodel.DataMap"
%><%@page import="org.uengine.ui.list.datamodel.DataList"
%><%@page import="org.uengine.ui.list.datamodel.QueryCondition"
%><%@page import="org.uengine.ui.list.util.HttpUtils"
%><%@page import="org.uengine.ui.list.util.DAOListCursorUtil"
%><%@page import="org.uengine.util.dao.DefaultConnectionFactory"%><%!

	interface ValueDAO extends IDAO{
		String getValue();
		void setValue(String value);	
	}


%><%

String sql =request.getParameter("sql");
sql= sql.replace("$","'");
String dsn =request.getParameter("dsn");

if(dsn==null) dsn = org.uengine.kernel.GlobalContext.DATASOURCE_JNDI_NAME;
dsn="java:/seoul";

String ctrlName = request.getParameter("ctrlName");

ValueDAO dao=(ValueDAO)GenericDAO.createDAOImpl(dsn, sql, ValueDAO.class);

boolean isCall = sql.startsWith("{");

if(isCall)
	dao.call();
else{
	dao.select();
	dao.next();
}

	Object o = dao.getValue();
%><%=o%>