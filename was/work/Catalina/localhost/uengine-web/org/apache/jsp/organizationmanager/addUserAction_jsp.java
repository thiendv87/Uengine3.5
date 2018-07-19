package org.apache.jsp.organizationmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.util.dao.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
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

public final class addUserAction_jsp extends org.apache.jasper.runtime.HttpJspBase
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

//@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"
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

      out.write("\r\n");
      out.write("\t\t\tUser information has been successfully registered.\r\n");

		} else {

      out.write("\r\n");
      out.write("\t\t\tSorry, you are not administrator.\r\n");
			
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

      out.write("\r\n");
      out.write("User information has been successfully updated.\r\n");

		} else {

      out.write("\r\n");
      out.write("\t\t\tSorry, you are not administrator or ");
      out.print(empName );
      out.write('.');
      out.write('\r');
      out.write('\n');

		}
	}
	
	if (stmt != null) { try { stmt.close(); } catch (Exception e) {} }
	if (conn != null) { try { conn.close(); } catch (Exception e) {} }

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t//window.location.href = \"userInfo.jsp\";\r\n");
      out.write("\twindow.location.href = \"");
      out.print(request.getHeader("referer"));
      out.write("\";\r\n");
      out.write("</script>");
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
