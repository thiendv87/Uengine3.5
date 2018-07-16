<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>

<%
	String selectedRoleCode = request.getParameter("roleCode");
%>

<%
	String ROLECODE = null;
	String DESCRIPTION = null;

	String EMPCODE = null;
	String EMPNAME = null;
	String JIKNAME = null;
	String EMAIL = null;
	String PARTCODE = null;

	Connection conn = null;
	Statement stmt = null;
	Statement stmt2 = null;
	ResultSet rs = null;
	ResultSet joinRs = null;
	StringBuffer sql = new StringBuffer();
	String secondSql = "";

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

		sql.setLength(0);
		sql.append(" select *");
		sql.append(" from ROLEUSERTABLE R where R.ROLECODE ='" + selectedRoleCode + "'");
		rs = stmt.executeQuery(sql.toString());
		Vector empCodes = new Vector();
		while(rs.next()){
			empCodes.add(rs.getString("EMPCODE"));
		}
		if(empCodes.size() != 0){
			secondSql = "select * from EMPTABLE E where E.ISDELETED != '1' and";
			for(int i=0;i<empCodes.size();i++){			
				secondSql = secondSql + " E.EMPCODE != '" + (String)empCodes.get(i) + "'";
				if(i != empCodes.size()-1){
					secondSql = secondSql + " and ";
				}
			}
		}else{
			secondSql = "SELECT * FROM emptable WHERE isdeleted != '1'";
		}
		rs.close();
		joinRs = stmt2.executeQuery(secondSql);	
		int ids=0;
		while(joinRs.next()){
			EMPCODE = joinRs.getString("EMPCODE") == null ? "" : joinRs.getString("EMPCODE");
			EMPNAME = joinRs.getString("EMPNAME") == null ? "" : joinRs.getString("EMPNAME");
			JIKNAME = joinRs.getString("JIKNAME") == null ? "" : joinRs.getString("JIKNAME");
			EMAIL = joinRs.getString("EMAIL") == null ? "" : joinRs.getString("EMAIL");
			PARTCODE = joinRs.getString("PARTCODE") == null ? "" : joinRs.getString("PARTCODE");
			
			spw.append("{ type:'user', id:'" + ids 
				+ "', empcode:'" + EMPCODE 
				+ "', name:'"	+ EMPNAME 
				+ "',jikname:'" + JIKNAME	
				+ "',email:'" + EMAIL 
				+ "', partcode:'"	+ PARTCODE 
				+ "'}"
			);
			
			if(!joinRs.isLast()){
				spw.print(",");	
			}
			ids++;
		}
		joinRs.close();
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