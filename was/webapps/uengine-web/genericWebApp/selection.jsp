<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>


<%
	String _tableName = ""+request.getParameter("_tableName");

	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	String url="jdbc:oracle:thin:@172.16.2.163:1521:demoora"; 
	Connection conn = DriverManager.getConnection(url, "renewal", "renewal");
	
	IDAO tables = GenericDAO.createDAOImpl(conn, "select table_name as TNAME from user_tab_columns group by table_name", IDAO.class);
	tables.select();
	
%>

<h1>Select source generator</h1>

<form target="workarea">

Choose table:
<select name="_tableName">
<%
	while(tables.next()){
		String tableName = (String)tables.get("TNAME");
		%><option<%if (_tableName.equals(tableName)){%> selected<%}%> value=<%=tableName%>><%=tableName%></option><br>
		<%
	}
%>
</select><br>

Choose source generator:
<select name="generator">
<%
	String realPath=pageContext.getServletContext().getRealPath("html/uengine-web/genericWebApp/sourceGenerator");
	String[] generatorList = new File(realPath).list();
	
	for(int i=0; i<generatorList.length; i++){
		%><option value="<%=generatorList[i]%>"><%=generatorList[i]%></option><br><%
	}
%>
</select>
<p>
<input type=button value="Next" onclick="document.forms[0].action='sourceGenerator/' + document.forms[0].generator.value;document.forms[0].submit()">
</form>




