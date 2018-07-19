<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.reflect.*"%>
<%
	String tableName = request.getParameter("_tableName");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@172.16.2.163:1521:demoora";
	Connection conn = DriverManager.getConnection(url, "renewal", "renewal");
	
	PreparedStatement pstmt = conn.prepareStatement("select * from " + tableName);
	ResultSet rs = pstmt.executeQuery();
	ResultSetMetaData rmd = rs.getMetaData();
%>

<h1>Create a DAO interface: <font color=green>1.Generate Interface</font> > 2.Compile</h1><form action="compile.jsp" method=POST>

File Name: <input name="_fileName" value="dao/<%=tableName%>.java"><p>
<textarea rows=30 cols=100 name="_source">
package dao;

public interface <%=tableName%> extends org.uengine.util.dao.IDAO{
<%
	for(int i=1; i<rmd.getColumnCount()+1; i++){
		String name = new String(rmd.getColumnName(i));
		int iType = rmd.getColumnType(i);
		int iSize = rmd.getColumnDisplaySize(i);

		name = name.substring(0,1).toUpperCase() + name.substring(1).toLowerCase();
		String type = new String(rmd.getColumnClassName(i));
		
		%>
	<%=type%> get<%=name%>();
	<%=type%> set<%=name%>(<%=type%> value);
	<%}
%>
}
</textarea>
<p>
<input type="submit" value="Compile">
<input type="hidden" name="_tableName" value="<%=tableName%>">
</form>
