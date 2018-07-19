<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@ page import="org.uengine.util.dao.*,java.sql.*,javax.sql.*,javax.naming.*" %>

<%
	String ROLECODE = null;
	String DESCRIPTION = null;
	String COMCODE = null;

	String EMPCODE = null;
	String EMPNAME = null;
	String JIKNAME = null;
	String EMAIL = null;
	String PARTCODE = null;
	String PARTNAME = null;
	String PASSWORD = null;
	String ISADMIN = null;
	String nateOn = null;
	String msn = null;
	String locale = null;
	String comcode = null;
	String comname = null;

	Connection conn = null;
	Statement stmt = null;
	Statement stmt2 = null;
	ResultSet rs = null;
	ResultSet joinRs = null;
	StringBuffer sql = new StringBuffer();
	StringBuffer joinSql = new StringBuffer();

	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);

	spw.println("{ identifier: 'code',");
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
		sql.append("SELECT rolecode, descr, comcode");
		sql.append(" FROM roletable WHERE isdeleted = '0'");
		
		if (!loggedUserIsMaster)
		{
			sql.append(" AND comcode = '" + loggedUserGlobalCom + "'");
		}
		
		rs = stmt.executeQuery(sql.toString());
		int iTmp1 = 0;

		while (rs.next()) {
			if (iTmp1 > 0) {
				spw.print(",");	
			}
			iTmp1++;
			
			ROLECODE = rs.getString("rolecode") == null ? "" : rs.getString("rolecode");
			DESCRIPTION = rs.getString("descr") == null ? "" : rs.getString("descr");
			COMCODE = rs.getString("comcode") == null ? "" : rs.getString("comcode");

			joinSql.setLength(0);
			joinSql.append("select E.*, R.rolecode, P.partname, C.comname from EMPTABLE E, ROLEUSERTABLE R, PARTTABLE P, COMTABLE C");
			joinSql.append(
					" where E.ISDELETED = '0' and P.ISDELETED = '0' and E.EMPCODE = R.EMPCODE and E.PARTCODE = P.PARTCODE and ROLECODE = '"
					+ ROLECODE + "' and E.globalcom = C.comcode"
			);
			joinRs = stmt2.executeQuery(joinSql.toString());
			
			spw.print(" {type:'role', objType: 'role', code :'" + ROLECODE	+ "', name:'" + DESCRIPTION + "', comcode : '" + COMCODE + "', children:[");
			String tempElement = "";
			int iTmp2 = 0;
			
			while (joinRs.next()) {
				if (iTmp2 > 0) {
					spw.print(",");
					tempElement = tempElement + ",";
				}
				iTmp2++;
				
				EMPCODE = joinRs.getString("EMPCODE") == null ? "" : joinRs.getString("EMPCODE");
				EMPNAME = joinRs.getString("EMPNAME") == null ? "" : joinRs.getString("EMPNAME");
				JIKNAME = joinRs.getString("JIKNAME") == null ? "" : joinRs.getString("JIKNAME");
				PASSWORD = joinRs.getString("PASSWORD") == null ? "" : joinRs.getString("PASSWORD");
				ISADMIN = joinRs.getString("ISADMIN") == null ? "" : joinRs.getString("ISADMIN");				
				EMAIL = joinRs.getString("EMAIL") == null ? "" : joinRs.getString("EMAIL");
				PARTCODE = joinRs.getString("PARTCODE") == null ? "" : joinRs.getString("PARTCODE");
				PARTNAME = joinRs.getString("PARTNAME") == null ? "" : joinRs.getString("PARTNAME");
				ROLECODE = joinRs.getString("ROLECODE") == null ? "" : joinRs.getString("ROLECODE");
				nateOn = joinRs.getString("nateOn") == null ? "" : joinRs.getString("nateOn");
				msn = joinRs.getString("msn") == null ? "" : joinRs.getString("msn");
				locale = joinRs.getString("locale") == null ? "" : joinRs.getString("locale");
				comcode = joinRs.getString("globalcom") == null ? "" : joinRs.getString("globalcom");
				comname = joinRs.getString("comname") == null ? "" : joinRs.getString("comname");

				spw.print("{_reference:'" + ROLECODE + ":" + EMPCODE + "'}");
				tempElement = tempElement 
							+ "{ type:'roleuser', code:'" + ROLECODE + ":" + EMPCODE + "', empcode: '" + EMPCODE + "', name:'" + EMPNAME 
							+ "',isadmin:'" + ISADMIN + "' ,jikname:'" + JIKNAME + "',email:'" + EMAIL + "',password:'" + PASSWORD 
							+ "', partcode:'"	+ PARTCODE + "',partname:'" + PARTNAME + "', rolecode:'" + ROLECODE	+ "' , rolename:'" + DESCRIPTION 
							+ "',nateOn:'" + nateOn + "',msn:'" + msn + "',locale:'" + locale + "', comcode:'" + comcode + "', comname:'" + comname + "'}";
			}
			joinRs.close();
			spw.print("]}");
			if(!tempElement.equals("")){
				spw.print(",");
				spw.println(tempElement);
			}
		}
		rs.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally
	{
		if (joinRs != null) try { joinRs.close(); } catch (Exception e) {}
		if (stmt != null) try { stmt.close(); } catch (Exception e) {}
		if (stmt2 != null) try { stmt2.close(); } catch (Exception e) { }
		if (conn != null) try { conn.close(); } catch (Exception e) { }
	}
	spw.print("]}");
%>
<%=sw.toString()%>