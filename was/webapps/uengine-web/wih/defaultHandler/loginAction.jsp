<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@include file="../../common/header.jsp"%>

<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("P3P", "CP='NOI DEVa TAIa OUR BUS UNI'");
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	
	String userId = decode(request.getParameter("userId") == null ? "" : request.getParameter("userId"));
	String passWd = decode(request.getParameter("passWd") == null ? "" : request.getParameter("passWd"));
	String taskId = decode(request.getParameter("taskId") == null ? "" : request.getParameter("taskId"));
	
	// 0  : Don't Input userId
	// -1 : Not Found user
	// -2 : No Match Password
	// 1  : Success Authentication
	// 2  : Success Authentication & Require Input Password
	
	String PASSWORD = null;
	String ISADMIN  = null;
	String EMPNAME  = null;
	String JIKNAME  = null;
	String EMAIL    = null;
	String PARTCODE = null;
	String LOCALE 	= null;
	String GLOBALCOM = null;
	String NATEON = null;
	String MSN = null;
	
	int authenticationCondition = 0 ;
	
	if (!userId.equals("")) {
		Connection 	    conn	= null;
		Statement 		stmt 	= null;
		ResultSet 		rs 		= null;
		StringBuffer 	sql 	= new StringBuffer();
		int 			rows 	= 0;
		try {
			conn = DefaultConnectionFactory.create().getConnection();
			stmt = conn.createStatement();
	
			sql.setLength(0);
			sql.append(" select * from   EMPTABLE E ");
			sql.append(" where  E.EMPCODE = '").append(userId).append("'");
			rs = stmt.executeQuery(sql.toString());
			rows = 0;
			while (rs.next()) {
				rows++;
				if (rows == 1) {
					PASSWORD 		= rs.getString("PASSWORD") 		== null ? "RIP" : rs.getString("PASSWORD");
					ISADMIN  		= rs.getString("ISADMIN") 		== null ? "" : rs.getString("ISADMIN");
					EMPNAME  		= rs.getString("EMPNAME")		== null ? "" : rs.getString("EMPNAME");
					JIKNAME  		= rs.getString("JIKNAME") 		== null ? "" : rs.getString("JIKNAME");
					EMAIL    			= rs.getString("EMAIL") 			== null ? "" : rs.getString("EMAIL");
					PARTCODE 		= rs.getString("PARTCODE") 		== null ? "" : rs.getString("PARTCODE");
					LOCALE			= rs.getString("LOCALE") 			== null ? "" : rs.getString("LOCALE");
					GLOBALCOM		= rs.getString("GLOBALCOM") 	== null ? "" : rs.getString("GLOBALCOM");
					NATEON 			= rs.getString("NATEON") 			== null ? "" : rs.getString("NATEON");
					MSN 				= rs.getString("MSN") 				== null ? "" : rs.getString("MSN");
				}
			}
			rs.close();
			
			if (rows == 0) {
				authenticationCondition = -1;
			}
		} finally {
			if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
			if ( conn != null ) try { conn.close(); } catch (Exception e) {}
	    }
	}
	
	if (authenticationCondition != -1 && PASSWORD.equals(passWd)) {
		authenticationCondition = 1;
		
		session.setAttribute("loggedUserId", userId);
		session.setAttribute("loggedUserFullName", EMPNAME);
		session.setAttribute("loggedUserIsAdmin",  ISADMIN);
		session.setAttribute("loggedUserJikName",  JIKNAME);
		session.setAttribute("loggedUserEmail",    EMAIL);
		session.setAttribute("loggedUserPartCode", PARTCODE);
		session.setAttribute("loggedUserLocale", LOCALE);
		session.setAttribute("loggedUserGlobalCom", GLOBALCOM);
		session.setAttribute("loggedUserNateonId", NATEON);
		session.setAttribute("loggedUserMsnId", MSN);
		
	} else if (authenticationCondition != -1 && PASSWORD.equals("RIP")) {
		authenticationCondition = 2;
		
		session.setAttribute("loggedUserId", userId);
		session.setAttribute("loggedUserFullName", EMPNAME);
		session.setAttribute("loggedUserIsAdmin",  ISADMIN);
		session.setAttribute("loggedUserJikName",  JIKNAME);
		session.setAttribute("loggedUserEmail",    EMAIL);
		session.setAttribute("loggedUserPartCode", PARTCODE);
		session.setAttribute("loggedUserLocale", LOCALE);
		session.setAttribute("loggedUserGlobalCom", GLOBALCOM);
		session.setAttribute("loggedUserNateonId", NATEON);
		session.setAttribute("loggedUserMsnId", MSN);
	} else {
		authenticationCondition = -2;
	}
%>

<script>
var authenticationCondition = <%=authenticationCondition%>;
if (authenticationCondition == 1) {
	var screenWidth = screen.width;
	var screenHeight = screen.Height;
	var windowWidth = 950;
	var windowHeight = 650;
	var window_left = (screenWidth-windowWidth)/2; 
	var window_top = (screenHeight-windowHeight)/2;
	
	var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
	var url = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/workitemHandler.jsp?taskId=<%=taskId %>";
	window.open(url, "", option);
	window.top.location.href = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/index.jsp";
} else {
	window.top.location.href = "forwardWork.jsp?userId=<%=userId%>&taskId=<%=taskId%>";
}
</script>

