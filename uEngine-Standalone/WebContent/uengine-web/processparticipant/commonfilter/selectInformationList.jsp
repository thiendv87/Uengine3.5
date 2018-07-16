<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@ page import="java.sql.*" %>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Information List</title>
    <link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/uengine.css" />
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/en_US.css" />
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/classic/css/main.css" />
	
    <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/ie5.js"></script>
    <script>
		function returnSelectInformationList(informationListName) {
			var Result = informationListName;
			window.returnValue = Result;
			parent.close();
		}
    </script>    
</head>

<body>
<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
<font size=-1 face='Tahoma'><b>Information List</b></font>

<table width="100%">
  <tr class="portlet-section-header">
    <td>
	  <table border="0" cellpadding="4" cellspacing="0" width="100%">        	
<%
	Connection conn		= null;
    Statement stmt		= null;
    ResultSet rset		= null;
    
    try {
    	boolean oddLine = false;
    	
    	String sqlStmt="select distinct INFO from BPM_PROCINST where INFO is not NULL";
    	
    	conn = DefaultConnectionFactory.create().getConnection();
    	stmt = conn.createStatement();
        rset = stmt.executeQuery(sqlStmt);
        
        while(rset.next()) { 
        	String informationList = rset.getString("INFO");      
        	String classname = (oddLine ? 
        			"class=\"portlet-section-body\""+
                    " onmouseover=\"this.className = 'portlet-section-body-hover';\""+ 
                    " onmouseout=\"this.className = 'portlet-section-body';\""
					:
					"class=\"portlet-section-alternate\""+ 
                    " onmouseover=\"this.className = 'portlet-section-alternate-hover';\""+ 
                    " onmouseout=\"this.className = 'portlet-section-alternate';\"");
        	oddLine = !oddLine;
%>
			<tr <%=classname%> onClick="returnSelectInformationList('<%=informationList %>');" style="cursor:hand;">
				<td>
					<%=informationList %>
				</td>
			</tr>
<%
        }
    	
    } catch(SQLException e){
		
    }
    finally {
      if( rset != null ) try { rset.close(); } catch( SQLException ex ) {}
      if( stmt != null ) try { stmt.close(); } catch( SQLException ex ) {}
      if( conn != null ) try { conn.close(); } catch( SQLException ex ) {}
    }
 %>
       </table>
    </td>
  </tr>
</table>

</body>
</html>