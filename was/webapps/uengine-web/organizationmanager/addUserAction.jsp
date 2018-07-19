<%//@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	String empName = request.getParameter("empName") == null ? "" : request.getParameter("empName");
	String empCode = request.getParameter("empCode") == null ? "" : request.getParameter("empCode");
	String password = request.getParameter("password") == null ? "" : request.getParameter("password");
	String email = request.getParameter("email") == null ? "" : request.getParameter("email");
	String isAdmin = request.getParameter("isAdmin");
	String department = request.getParameter("department") == null ? "" : request.getParameter("department");
	String partCode = request.getParameter("partCode") == null ? "" : request.getParameter("partCode");
	String jikName = request.getParameter("jikName") == null ? "" : request.getParameter("jikName");
	String globalCom = request.getParameter("globalCom") == null ? "" : request.getParameter("globalCom");
	String nateOn = request.getParameter("nateOn") == null ? "" : request.getParameter("nateOn");
	String msn = request.getParameter("msn") == null ? "" : request.getParameter("msn");
	String locale = request.getParameter("locale") == null ? "" : request.getParameter("locale");
	String mobilecmp = request.getParameter("mobilecmp") == null ? "" : request.getParameter("mobilecmp");
	String mobileno = request.getParameter("mobileno") == null ? "" : request.getParameter("mobileno");
	String isModification = request.getParameter("isModification");

	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = null;
	
	if (isModification.equals("false")) {
		if (loggedUserIsAdmin) {
			if(isAdmin != null && isAdmin.equalsIgnoreCase("on")){
				isAdmin = "1";
			} else {
				isAdmin = "0";
			}
			
			conn = DefaultConnectionFactory.create().getConnection();
			
			sql = "insert into emptable(empcode, empname, password, isadmin, jikname, email, partcode, globalcom, nateOn, msn, locale, mobilecmp, mobileno) "
					+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?)";
	
			stmt = conn.prepareStatement(sql);
				stmt.setString(1, empCode);
				stmt.setString(2, empName);
				stmt.setString(3, password);
				stmt.setInt(4, Integer.parseInt(isAdmin));
				stmt.setString(5, jikName);
				stmt.setString(6, email);
				stmt.setString(7, partCode);
				stmt.setString(8, globalCom);
				stmt.setString(9, nateOn);
				stmt.setString(10, msn);
				stmt.setString(11, locale);
				stmt.setString(12, mobilecmp);
				stmt.setString(13, mobileno);
			stmt.execute();	
%>
			User information has been successfully registered.
<%
		} else {
%>
			Sorry, you are not administrator.
<%			
		}
	} else {
		
		if (loggedUserId.equals(empCode) || loggedUserIsAdmin) {
			if(isAdmin != null && isAdmin.equalsIgnoreCase("on")){
				isAdmin = "1";
			} else {
				isAdmin = "0";
			}
			
			conn = DefaultConnectionFactory.create().getConnection();
			
			if (UEngineUtil.isNotEmpty(password)) {
				sql = "UPDATE emptable SET empname=?, password=?, isadmin=?, jikname=?, email=?, partcode=?, nateon=?, msn=?, locale=?, mobilecmp=?, mobileno=? WHERE empcode=? ";
				
				stmt = conn.prepareStatement(sql);
					stmt.setString(1, empName);
					stmt.setString(2, password);
					stmt.setInt(3, Integer.parseInt(isAdmin));
					stmt.setString(4, jikName);
					stmt.setString(5, email);
					stmt.setString(6, partCode);
					stmt.setString(7, nateOn);
					stmt.setString(8, msn);
					stmt.setString(9, locale);
					stmt.setString(10, mobilecmp);
					stmt.setString(11, mobileno);
					stmt.setString(12, empCode);
				stmt.execute();
			} else {
				sql = "UPDATE emptable SET empname=?, isadmin=?, jikname=?, email=?, partcode=?, nateon=?, msn=?, locale=?, mobilecmp=?, mobileno=? WHERE empcode=? ";
				
				stmt = conn.prepareStatement(sql);
					stmt.setString(1, empName);
					stmt.setInt(2, Integer.parseInt(isAdmin));
					stmt.setString(3, jikName);
					stmt.setString(4, email);
					stmt.setString(5, partCode);
					stmt.setString(6, nateOn);
					stmt.setString(7, msn);
					stmt.setString(8, locale);
					stmt.setString(9, mobilecmp);
					stmt.setString(10, mobileno);
					stmt.setString(11, empCode);
				stmt.execute();
			}
			
			if (loggedUserId.equals(empCode)) {
				session.setAttribute("loggedUserIsAdmin",  isAdmin);
				session.setAttribute("loggedUserFullName", empName);
				session.setAttribute("loggedUserJikName",  jikName);
				session.setAttribute("loggedUserEmail",    email);
				session.setAttribute("loggedUserPartCode", partCode);
				session.setAttribute("loggedUserLocale", locale);
				session.setAttribute("loggedUserNateonId", nateOn);
				session.setAttribute("loggedUserMsnId", msn);
				session.setAttribute("loggedUserMobileCmp", mobilecmp);
				session.setAttribute("loggedUserMobileNo", mobileno);
			}
%>
User information has been successfully updated.
<%
		} else {
%>
			Sorry, you are not administrator or <%=empName %>.
<%
		}
	}
	
	if (stmt != null) { try { stmt.close(); } catch (Exception e) {} }
	if (conn != null) { try { conn.close(); } catch (Exception e) {} }
%>
<script type="text/javascript">
	//window.location.href = "userInfo.jsp";
	window.location.href = "<%=request.getHeader("referer")%>";
</script>