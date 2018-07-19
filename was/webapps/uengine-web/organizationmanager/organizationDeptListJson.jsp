<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>

<%!
private String comCode;
private String comName;
private void setCompany(String comcode, String comname) {
	comCode = comcode;
	comName = comname;
}

private StringBuffer getChildrenOfPart(String parentPart, String parentName, String parent, StringBuffer sbParentReference) {
	StringBuffer sbValues = new StringBuffer();
	StringBuffer sbReference = new StringBuffer();
	
	String partSql = "SELECT globalcom, partcode, partname FROM parttable WHERE isdeleted = '0' AND parent_partcode = ? ORDER BY partname";
	ResultSet partRs = null;
	PreparedStatement partPstmt = null;
	Connection conn = null;
	
	try {
		sbParentReference.append(
				"\n\t{ type:'dept', objType: 'group', comid:'" + comCode
				+ "', comname:'" + comName
				+ "', id:'" + parentPart
				+ "', name:'" + parentName
				+ "', children:["
		);
		
		conn = DefaultConnectionFactory.create().getConnection();
		partPstmt = conn.prepareStatement(partSql);
		partPstmt.setString(1, parentPart);
		partRs = partPstmt.executeQuery();
		
		boolean isFirstCom = true;
		StringBuffer sbChildrenParts = new StringBuffer();
		while (partRs.next()) {
			if (isFirstCom) {
				isFirstCom = false;
			} else {
				sbParentReference.append(", ");
				sbValues.append(", ");
			}

			String partcode, partname, jikname, email, isadmin, password, nateon, msn, locale;

			partcode = partRs.getString("partcode") == null ? "" : partRs.getString("partcode");
			partname = partRs.getString("partname") == null ? "" : partRs.getString("partname");

			sbParentReference.append("\n\t\t{_reference:'" + partcode + "'}");
			sbValues.append(getChildrenOfPart(partcode, partname, parentPart, sbValues));
		}

		sbParentReference.append("\n\t]}");
		if (UEngineUtil.isNotEmpty(sbValues.toString())) {
			sbParentReference.append("," + sbValues);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (partRs != null) try { partRs.close(); } catch (Exception e) { }
		if (partPstmt != null) try { partPstmt.close(); } catch (Exception e) { }
		if (conn != null) try { conn.close(); } catch (Exception e) { }
	}
	
	return sbReference;
}
%>

<%
	String EMPCODE = null;
	String EMPNAME = null;
	String JIKNAME = null;
	String EMAIL = null;
	String PARTCODE = null;
	String PARTNAME = null;
	String isAdmin = null;
	String passWord = null;
	String nateOn = null;
	String msn = null;
	String locale = null;
	String comcode = null;
	String comname = null;
	
	int authenticationCondition = 0 ;
	
	Connection 	conn			= null;
	Statement 	stmt 			= null;
	Statement 	stmt2 			= null;
	Statement 	stmtCom 		= null;
	ResultSet 		rs 				= null;
	ResultSet 		partRs 		= null;
	ResultSet		userRs 		= null;
	String 		partSql 		= null;
	StringBuffer 	comSql 		= new StringBuffer();
	StringBuffer	userSql		= new StringBuffer();
	
	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	
	spw.println("{ identifier: 'id',");
    spw.println("  label: 'name',");
    spw.println("  items: [");
	
	try {
		conn = DefaultConnectionFactory.create().getConnection();
		
		DatabaseMetaData dmd = conn.getMetaData();
		//int checkDatabaseTypeIsOracle = dmd.getURL().toLowerCase().indexOf("oracle:");
		
		///if (checkDatabaseTypeIsOracle == -1 ) {
			stmt = conn.createStatement();
			stmt2 = conn.createStatement();
			stmtCom = conn.createStatement();
		//} else {
		//	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//	stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//}
		

		comSql.append("SELECT * FROM comtable WHERE isdeleted = '0' ");
		
		if (UEngineUtil.isNotEmpty(loggedUserGlobalCom)) {
			comSql.append(" AND comcode = '" + loggedUserGlobalCom + "'");
		}
		comSql.append(" ORDER BY comname");
		
		partRs = stmtCom.executeQuery(comSql.toString());
		
		int iComCount = 0;
		while (partRs.next()) {
			if (iComCount == 0) {
				iComCount++;
			} else {
				spw.print(",");	
			}
			
			comname = partRs.getString("comname") == null ? "" : partRs.getString("comname");
			comcode = partRs.getString("comcode") == null ? "" : partRs.getString("comcode");

			partSql = " select P.GLOBALCOM, P.PARTCODE, P.PARTNAME from PARTTABLE P where P.GLOBALCOM = '" + comcode + "' AND parent_partcode is null and P.ISDELETED = '0' order by partname ";
			rs = stmt.executeQuery(partSql);
			
			spw.print("\n\t{ type:'com', objType: 'group', id:'" + comcode + "', name:'" + comname + "'");
			spw.print(", children:[");
			StringBuffer tmpParent = new StringBuffer();
			
			setCompany(comcode, comname);
			
			int iPartCount = 0;
			while (rs.next()) {
				if (iPartCount == 0) {
					iPartCount++;
				} else {
					spw.print(",");	
					tmpParent.append(",");
				}
				
				PARTCODE = rs.getString("PARTCODE") == null ? "" : rs.getString("PARTCODE");
				PARTNAME = rs.getString("PARTNAME") == null ? "" : rs.getString("PARTNAME");
				
				spw.print("\n\t\t{_reference:'" + PARTCODE + "'}");
				tmpParent.append(getChildrenOfPart(PARTCODE, PARTNAME, "", tmpParent));
			}
			rs.close();
			spw.print("\n\t]}");
			
			if (UEngineUtil.isNotEmpty(tmpParent.toString())) {
				spw.print(",");
				spw.println(tmpParent);
			}
		}
		partRs.close();
		
	} finally {
		if (stmt != null) try { stmt.close(); } catch (Exception e) { }
		if (stmt2 != null) try { stmt2.close(); } catch (Exception e) { }
		if (conn != null) try { conn.close(); } catch (Exception e) { }
	}
	spw.print("\n]}");
%>
<%=sw.toString()%>