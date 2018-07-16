<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>

<%
	String EMPCODE = null;
	String EMPNAME = null;
	String JIKNAME = null;
	String EMAIL = null;
	String PARTCODE = null;
	String PARTNAME = null;
	
	int authenticationCondition = 0 ;
	
	Connection 	    conn	= null;
	Statement 		stmt 	= null;
	Statement 		stmt2 	= null;
	ResultSet 		rs 		= null;
	ResultSet		userRs = null;
	StringBuffer 	partSql 	= new StringBuffer();
	StringBuffer	userSql		= new StringBuffer();
	
	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	
	spw.println("{ identifier: 'id',");
    spw.println("  label: 'name',");
    spw.println("  items: [");
	
	try {
		conn = DefaultConnectionFactory.create().getConnection();
		
		DatabaseMetaData dmd = conn.getMetaData();
		int checkDatabaseTypeIsOracle = dmd.getURL().toLowerCase().indexOf("oracle:");
		
		if (checkDatabaseTypeIsOracle == -1 ) {
			stmt = conn.createStatement();
			stmt2 = conn.createStatement();
		} else {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		}
		
		partSql.setLength(0);
		partSql.append(" select P.GLOBALCOM, P.PARTCODE, P.PARTNAME");
		partSql.append(" from PARTTABLE P");
		rs = stmt.executeQuery(partSql.toString());
		
		while(rs.next()){
			PARTCODE = rs.getString("PARTCODE") == null ? "" : rs.getString("PARTCODE");
			PARTNAME = rs.getString("PARTNAME") == null ? "" : rs.getString("PARTNAME");
			
			userSql.setLength(0);
			userSql.append(" select E.EMPCODE,E.ISADMIN,E.EMPNAME,E.JIKNAME,E.EMAIL");
			userSql.append(" from EMPTABLE E where E.PARTCODE='" + PARTCODE + "'");
			userRs = stmt2.executeQuery(userSql.toString());
			
			spw.print("{ type:'main', objType: 'group', id:'" + PARTCODE + "', name:'" + PARTNAME + "'}");
			String tempElement = "";
			while(userRs.next()){
				EMPCODE = userRs.getString("EMPCODE") == null ? "" : userRs.getString("EMPCODE");
				EMPNAME = userRs.getString("EMPNAME") == null ? "" : userRs.getString("EMPNAME");
				JIKNAME = userRs.getString("JIKNAME") == null ? "" : userRs.getString("JIKNAME");
				EMAIL = userRs.getString("EMAIL") == null ? "" : userRs.getString("EMAIL");

				tempElement = tempElement 
							+ "{ type:'user', id:'" + EMPCODE + "', name:'" + EMPNAME + "',jikname:'"+ JIKNAME +"',email:'"+ EMAIL +"',partcode:'" + PARTCODE + "',partname:'" + PARTNAME + "'}";
				if(!userRs.isLast()){
					tempElement = tempElement + ",";
				}				
			}
			userRs.close();
			if(!tempElement.equals("")){
				spw.print(",");
				spw.println(tempElement);
			}
			
			if(!rs.isLast()){
				spw.print(",");	
			}
		}
		rs.close();
	} finally {
		if (stmt != null)
			try {
				stmt.close();
			} catch (Exception e) {
			}
		if (stmt2 != null)
			try {
				stmt2.close();
			} catch (Exception e) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (Exception e) {
			}
	}
	spw.print("]}");
%>
<%=sw.toString()%>