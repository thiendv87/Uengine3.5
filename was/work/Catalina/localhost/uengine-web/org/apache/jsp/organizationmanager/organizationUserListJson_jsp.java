package org.apache.jsp.organizationmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.net.*;
import java.util.*;
import javax.naming.InitialContext;
import javax.transaction.*;
import javax.rmi.PortableRemoteObject;
import javax.naming.Context;
import javax.naming.NamingException;
import org.metaworks.*;
import org.metaworks.web.*;
import org.metaworks.inputter.*;
import org.uengine.ui.list.util.HttpUtils;
import org.uengine.ui.list.datamodel.DataMap;
import org.uengine.util.UEngineUtil;
import org.uengine.processmanager.*;
import org.uengine.kernel.*;
import org.uengine.webservices.worklist.*;
import org.uengine.webservice.*;
import org.uengine.security.AclManager;
import org.uengine.contexts.*;
import org.uengine.kernel.GlobalContext;
import com.defaultcompany.login.LoginService;
import org.uengine.util.dao.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public final class organizationUserListJson_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


	public String decode(String source) throws Exception{
		//if(source==null)
		//	return null;
		
		return source; //new String(source.getBytes("8859_1"), "UTF-8");
	}
	
	public Object notNull(Object value) throws Exception{
		if(value!=null) return value;
		else return "-";
	}
/*
	public String replaceAmp(String src){
		if(src!=null)
			return src.replaceAll("&", "&amp;");
		else
			return null;
	}
*/


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

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(3);
    _jspx_dependants.add("/organizationmanager/../common/header.jsp");
    _jspx_dependants.add("/organizationmanager/../common/headerMethods.jsp");
    _jspx_dependants.add("/organizationmanager/../common/getLoggedUser.jsp");
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
 
	request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");

	DataMap reqMap = HttpUtils.getDataMap(request, false);

      out.write('\r');
      out.write('\n');
      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");

boolean isRegUser = Boolean.parseBoolean(request.getParameter("regUser"));
boolean logged = (session.getAttribute("loggedUserId")!=null)?true:false;   
boolean isCookieLoggin = false;

if(!logged && Boolean.parseBoolean(GlobalContext.getPropertyString("web.cookie.use","false"))){
	LoginService loginService = new LoginService();
	String authenticationCondition = loginService.loginForCookie(request);
	if("Success".equals(authenticationCondition)){
		isCookieLoggin=true;
	}
}

//System.out.println("-----------------------------------------------------");
//System.out.println("getLoggedUser.jsp - logged : "+logged);
//System.out.println("getLoggedUser.jsp - isCookieLoggin : "+isCookieLoggin);
//System.out.println("-----------------------------------------------------");

if (isRegUser) {
	session.setAttribute("loggedUserId", "guest");
} else if (logged == false && isCookieLoggin == false ) {

      out.write("\r\n");
      out.write("<html><meta http-equiv=\"refresh\" content=\"0; url=");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/loginForm.jsp\"></meta></html>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\twindow.top.location.href = \"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/loginForm.jsp\";\r\n");
      out.write("</script>\r\n");

	return;
}
	String  loggedUserId       		= (String) session.getAttribute("loggedUserId");
	String  loggedUserFullName 		= (String) session.getAttribute("loggedUserFullName");
	String  loggedUserJikName  		= (String) session.getAttribute("loggedUserJikName");
	String  loggedUserEmail    		= (String) session.getAttribute("loggedUserEmail");
	String  loggedUserPartCode 		= (String) session.getAttribute("loggedUserPartCode");
	String  loggedUserPartName 		= (String) session.getAttribute("loggedUserPartName");
	String  loggedUserMsnId 		= (String) session.getAttribute("loggedUserMsnId");
	String  loggedUserNateonId 		= (String) session.getAttribute("loggedUserNateonId");
	String  loggedUserLocale 		= (String) session.getAttribute("loggedUserLocale");
	String  loggedUserGlobalCom		= (String) session.getAttribute("loggedUserGlobalCom");
	String  loggedUserComName 		= (String) session.getAttribute("loggedUserComName");
	boolean loggedUserIsAdmin  		= "1".equals((String) session.getAttribute("loggedUserIsAdmin"));
	boolean loggedUserIsMaster 		= loggedUserIsAdmin && !org.uengine.util.UEngineUtil.isNotEmpty(loggedUserGlobalCom);
	
	String loggedUserTimeZone		= null;

	org.uengine.kernel.RoleMapping loggedRoleMapping = null;
	String rmClsName = "";
	
	loggedRoleMapping = org.uengine.kernel.RoleMapping.create();
	loggedRoleMapping.setEndpoint(loggedUserId);
	loggedRoleMapping.setResourceName(loggedUserFullName);
	loggedRoleMapping.setEmailAddress(loggedUserEmail);
	loggedRoleMapping.setMale(true);
	loggedRoleMapping.setBirthday(new java.util.Date());
	loggedRoleMapping.setGroupId(loggedUserPartCode);
	loggedRoleMapping.setCompanyId(loggedUserGlobalCom);
	loggedRoleMapping.setLocale(loggedUserLocale);
	loggedRoleMapping.setTitle(loggedUserJikName);
	
	rmClsName = org.uengine.kernel.RoleMapping.USE_CLASS.getName();

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

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

      out.write('\r');
      out.write('\n');
      out.print(sw.toString());
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
