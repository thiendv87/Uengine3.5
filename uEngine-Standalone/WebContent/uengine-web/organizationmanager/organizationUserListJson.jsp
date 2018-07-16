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
	String userSql = "SELECT * FROM emptable WHERE isdeleted = '0' AND partcode = ? ORDER BY empname";
	ResultSet partRs = null;
	ResultSet userRs = null;
	PreparedStatement partPstmt = null;
	PreparedStatement userPstmt = null;
	Connection conn = null;
	
	try {
		sbParentReference.append(
				"\n\t{ type:'dept', objType: 'group', code:'" + parentPart 
				+ "', parent:'" + parent 
				+ "', comname:'" + comName 
				+ "', comcode:'" + comCode 
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
		
		userPstmt = conn.prepareStatement(userSql);
		userPstmt.setString(1, parentPart);
		userRs = userPstmt.executeQuery();
		
		boolean isUserFirst = true;
		while (userRs.next()) {
			if (isUserFirst) {
				isUserFirst = false;
				
				if (sbValues.length() > 0) {
					sbValues.append(", ");
					sbParentReference.append(", ");
				}
			} else {
				sbValues.append(", ");
				sbParentReference.append(", ");
			}
			
			String empcode, empname, jikname, email, isadmin, password, nateon, msn, locale;
			
			empcode = userRs.getString("empcode") == null ? "" : userRs.getString("empcode");
			empname = userRs.getString("empname") == null ? "" : userRs.getString("empname");
			jikname = userRs.getString("jikname") == null ? "" : userRs.getString("jikname");
			email = userRs.getString("email") == null ? "" : userRs.getString("email");
			isadmin = userRs.getString("isadmin") == null ? "" : userRs.getString("isadmin");
			password = userRs.getString("password") == null ? "" : userRs.getString("password");
			nateon = userRs.getString("nateon") == null ? "" : userRs.getString("nateon");
			msn = userRs.getString("msn") == null ? "" : userRs.getString("msn");
			locale = userRs.getString("locale") == null ? "" : userRs.getString("locale");
			
			sbParentReference.append("\n\t\t{_reference: '" + empcode + "'}");
			sbValues.append(
						"\n\t{ type:'user', code:'" + empcode 
						+ "', name:'" + empname 
						+ "', jikname:'"+ jikname 
						+ "', email:'"+ email 
						+ "', partcode:'" + parentPart 
						+ "', partname:'" + parentName 
						+ "', isadmin:'" + isadmin 
						+ "', password:'" + password 
						+ "', nateOn:'" + nateon 
						+ "', msn:'" + msn 
						+ "', locale:'" + locale 
						+ "', comcode:'" + comCode 
						+ "', comname:'" + comName 
						+ "'}"
			);
		}

		sbParentReference.append("\n\t]}");
		if (UEngineUtil.isNotEmpty(sbValues.toString())) {
			sbParentReference.append("," + sbValues);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (userRs != null) try { userRs.close(); } catch (Exception e) { }
		if (partRs != null) try { partRs.close(); } catch (Exception e) { }
		if (userPstmt != null) try { userPstmt.close(); } catch (Exception e) { }
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
	StringBuffer 	comSql 		= new StringBuffer();
	String 		partSql 		= null;
	StringBuffer	userSql		= new StringBuffer();
	
	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	
	spw.println("{ identifier: 'code',");
    spw.println("  label: 'name',");
    spw.println("  items: [");
	
	try {
		conn = DefaultConnectionFactory.create().getConnection();
		
		DatabaseMetaData dmd = conn.getMetaData();
		stmt = conn.createStatement();
		stmt2 = conn.createStatement();
		stmtCom = conn.createStatement();

		comSql.append("SELECT * FROM comtable WHERE isdeleted = '0' ");
		
		if (!loggedUserIsMaster) {
			comSql.append(" AND comcode = '" + loggedUserGlobalCom + "'");
		}
		comSql.append(" ORDER BY comname");
		partRs = stmtCom.executeQuery(comSql.toString());
		
		
		boolean isFirstCom = true;
		while (partRs.next()) {
			if (isFirstCom) {
				isFirstCom = false;
			} else {
				spw.print(",");	
			}
			
			comname = partRs.getString("comname") == null ? "" : partRs.getString("comname");
			comcode = partRs.getString("comcode") == null ? "" : partRs.getString("comcode");

			partSql = " SELECT globalcom, partcode, parent_partcode, partname FROM parttable where globalcom = '" + comcode + "' AND parent_partcode is null AND isdeleted = '0' ORDER BY partname ";
			rs = stmt.executeQuery(partSql);
			
			spw.print("\n\t{ type:'com', objType: 'group', code:'" + comcode + "', name:'" + comname + "'");
			spw.print(", children:[");

			setCompany(comcode, comname);
			StringBuffer tmpParent = new StringBuffer();
			
			boolean isFirstPart = true;
			while (rs.next()) {
				if (isFirstPart) {
					isFirstPart = false;
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
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch (Exception e) { }
		if (partRs != null) try { partRs.close(); } catch (Exception e) { }
		if (stmt != null) try { stmt.close(); } catch (Exception e) { }
		if (stmt2 != null) try { stmt2.close(); } catch (Exception e) { }
		if (conn != null) try { conn.close(); } catch (Exception e) { }
	}
	spw.print("\n]}");
%>
<%=sw.toString()%>