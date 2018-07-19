package org.apache.jsp.organizationmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.util.dao.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import org.uengine.util.dao.DefaultConnectionFactory;
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

public final class userInfo_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
 
	request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("\t\r\n");
      out.write("\t");
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
      out.write('	');
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
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t");

		String empCode = request.getParameter("empCode") == null ? loggedUserId : decode(request.getParameter("empCode"));
		boolean isModification = UEngineUtil.isTrue(request.getParameter("isModification"));
	
		Connection conn 	   = null;
		PreparedStatement stmt = null;
		ResultSet rs 		   = null;
		
		String partCode  = null;
		String partName  = null;
		String empName   = null;
		String email 	 = null;
		String jikName   = null;
		String globalCom = null;
		String nateOn 	 = null;
		String msn 	 	 = null;
		String locale 	 = null;
		String mobilecmp = null;
		String mobileno  = null;
		boolean isAdmin  = false;
		String password = null;

		String sPartOption = "";
		String sComOption  = "";
		String[][] localeValueList = {
				{"ko", "Korean"},
				{"en", "English"}/*,
				{"jp", "Japanese"},
				{"zh", "Chinese"}*/
		};
		
		try {
			String sql = " SELECT * FROM EMPTABLE WHERE EMPCODE = ? ";
			conn = DefaultConnectionFactory.create().getConnection();
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, empCode);
	
			rs = stmt.executeQuery();
	
			if (rs.next()) {
				empName 	= UEngineUtil.isNotEmpty(rs.getString("empname"))	?rs.getString("empname")	:"";
				isAdmin 	= rs.getInt("isAdmin") == 1;
				jikName 	= UEngineUtil.isNotEmpty(rs.getString("jikName"))	?rs.getString("jikName")	:"";
				email 		= UEngineUtil.isNotEmpty(rs.getString("email"))  	?rs.getString("email")  	:"";
				partCode 	= UEngineUtil.isNotEmpty(rs.getString("partCode"))	?rs.getString("partCode")	:"";
				globalCom 	= UEngineUtil.isNotEmpty(rs.getString("globalCom"))	?rs.getString("globalCom")	:"";
				locale 		= UEngineUtil.isNotEmpty(rs.getString("locale"))	?rs.getString("locale")		:"";
				nateOn 		= UEngineUtil.isNotEmpty(rs.getString("nateOn")) 	?rs.getString("nateOn") 	:"";
				msn 		= UEngineUtil.isNotEmpty(rs.getString("msn")) 		?rs.getString("msn") 		:"";
				mobilecmp 	= UEngineUtil.isNotEmpty(rs.getString("mobilecmp")) ?rs.getString("mobilecmp") 	:"";
				mobileno 	= UEngineUtil.isNotEmpty(rs.getString("mobileno")) 	?rs.getString("mobileno") 	:"";
				password 	= UEngineUtil.isNotEmpty(rs.getString("password")) 	?rs.getString("password") 	:"";

				sql = " SELECT PARTCODE, PARTNAME FROM PARTTABLE WHERE ISDELETED = '0' AND GLOBALCOM = ? ";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, globalCom);
				ResultSet rsPart = stmt.executeQuery();
				
				while (rsPart.next()) {
					String sSeleted = rsPart.getString("partcode").equals(partCode) ? " selected=\"selected\" " : "";
					sPartOption += "<option value=\"" + rsPart.getString("partcode") + "\" " + sSeleted + ">" + rsPart.getString("partname") + "</option>";
				}
				
				sql = " SELECT * FROM COMTABLE WHERE ISDELETED = '0' ";
				stmt = conn.prepareStatement(sql);
				ResultSet rsCom = stmt.executeQuery();
				
				while (rsCom.next()) {
					String sSeleted = rsCom.getString("comcode").equals(globalCom) ? " selected=\"selected\" " : "";
					sComOption += "<option value=\"" + rsCom.getString("comcode") + "\" " + sSeleted + ">" + rsCom.getString("comname") + "</option>";
				}
				
				try {
					if (rsPart != null) {
						rsPart.close();
						rsCom.close();
					}
				} catch (Exception e) {}
			}
		} finally {
    		if (rs != null) {
    			try { rs.close(); } catch (Exception e) { }
    		}
    		if (stmt != null) {
    			try { stmt.close(); } catch (Exception e) { }
    		}
    		if (conn != null) {
    			try { conn.close(); } catch (Exception e) { }
    		}
		}
		
		String imgPath="/images/portrait/" + empCode + ".gif";
		java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
   		if (!imgFile.exists()) imgPath = GlobalContext.WEB_CONTEXT_ROOT + "/images/main/NoIMG.gif";
   		else imgPath = GlobalContext.WEB_CONTEXT_ROOT + imgPath;
	
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t<link href=\"../style/default.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("\t<style type=\"text/css\">\r\n");
      out.write("\t@import \"../dojo/dojo/resources/dojo.css\";\r\n");
      out.write("\t@import \"../dojo/dijit/tests/css/dijitTests.css\";\r\n");
      out.write("\t@import \"../dojo/dojox/grid/_grid/soriaGrid.css\";\r\n");
      out.write("\t@import \"../dojo/dijit/themes/soria/soria.css\";\r\n");
      out.write("\t\r\n");
      out.write("\t/* NOTE: for a full screen layout, must set body size equal to the viewport. */\r\n");
      out.write("\tbody {\r\n");
      out.write("\t\theight: 100%;\r\n");
      out.write("\t\twidth: 100%;\r\n");
      out.write("\t\tmargin: 15px;\r\n");
      out.write("\t\tpadding: 0;\r\n");
      out.write("        overflow:hidden; \r\n");
      out.write("\t}\r\n");
      out.write("\t</style>\r\n");
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"../dojo/dojo/dojo.js\" djConfig=\"parseOnLoad: true, isDebug: false, defaultTestTheme: 'soria'\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"../dojo/dijit/tests/_testCommon.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/common.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("        dojo.require(\"dojo.parser\");\r\n");
      out.write("        dojo.require(\"dijit.form.TextBox\");\r\n");
      out.write("        dojo.require(\"dijit.form.CheckBox\"); \r\n");
      out.write("        dojo.require(\"dijit.form.Button\"); \r\n");
      out.write("\r\n");
      out.write("        function updateUserActionSubmit() {\r\n");
      out.write("            if (isEmpty(document.addUser.empName.value)) {\r\n");
      out.write("                alert(\"Name is required.\");\r\n");
      out.write("                return;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            if (isEmpty(document.addUser.password.value)) {\r\n");
      out.write("                alert(\"Password is required.\");\r\n");
      out.write("                return;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            if (!isEmpty(document.addUser.email.value) && !isEmail(document.addUser.email.value)) {\r\n");
      out.write("                alert(\"Invalid email format.\");\r\n");
      out.write("                return;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            if (!isEmpty(document.addUser.nateOn.value) && !isEmail(document.addUser.nateOn.value)) {\r\n");
      out.write("                alert(\"Invalid NateOn format.\");\r\n");
      out.write("                return;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            if (!isEmpty(document.addUser.msn.value) && !isEmail(document.addUser.msn.value)) {\r\n");
      out.write("                alert(\"Invalid MSN format.\");\r\n");
      out.write("                return;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            document.addUser.submit();\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("\t\tfunction changePicture() {\r\n");
      out.write("\t\t\tvar x= \"dialogWidth:300px; dialogHeight:350px; scrollbar:no; status:no; help:no;\";\r\n");
      out.write("\t\t\tvar umodal = window.showModalDialog(\"modalUserPicture.jsp?imgPath=");
      out.print(URLEncoder.encode(imgPath, GlobalContext.ENCODING) );
      out.write("\", document.addUser, x);\r\n");
      out.write("\t\t\tthis.location.reload();\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\tvar req = null;\r\n");
      out.write("\t\tvar partCode = \"");
      out.print(partCode );
      out.write("\";\r\n");
      out.write("\t\tvar WEB_ROOT = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("\";\r\n");
      out.write("\t</script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/ajax/ajaxCommon.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/ajax/department.js\"></script>\r\n");
      out.write("\t<title>");
      out.print(empName );
      out.print(GlobalContext.getMessageForWeb("'s Infomation", loggedUserLocale) );
      out.write("</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body class=\"soria\">\r\n");
      out.write("<form name=\"addUser\" action=\"addUserAction.jsp\" method=\"post\">\r\n");
      out.write("<br />\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t<col span=\"1\" width=\"130\">\r\n");
      out.write("\t<col span=\"1\" width=\"150\">\r\n");
      out.write("\t<col span=\"1\" width=\"\">\r\n");
      out.write("\t<col span=\"1\" width=\"150\">\r\n");
      out.write("\t<col span=\"1\" width=\"\">\r\n");
      out.write("\t<tr><td class=\"formheadline\" colspan=\"6\"></td></tr>\r\n");
      out.write("\t<tr height=\"25\">\r\n");
      out.write("\t\t<td rowspan=\"11\" align=\"center\">\r\n");
      out.write("\t\t\t<a href=\"javascript: changePicture();\"><img src=\"");
      out.print(imgPath );
      out.write("\" alt=\"변경하려면 클릭하세요.\" width=\"105\" height=\"135\" style=\"border:1px #CCCCCC solid;\" align=\"middle\" /></a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td class=\"formtitle\">\r\n");
      out.write("\t\t\t<strong>");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale) );
      out.write("</strong>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"hidden\" name=\"empCode\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(empCode );
      out.write("\" />");
      out.print(empCode );
      out.write("\r\n");
      out.write("\t\t\t<font color=\"#F58E03\">(");
      out.print(GlobalContext.getMessageForWeb("You can't change your ID", loggedUserLocale) );
      out.write(")</font>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Administrator", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"checkbox\" dojoType=\"dijit.form.CheckBox\" name=\"isAdmin\" ");
      out.print(isAdmin ? "checked=\"checked\" " : "");
      out.write(' ');
      out.print(loggedUserIsAdmin ? "" : " readonly=\"readonly\" " );
      out.write(" /></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("    <tr><td class=\"formline\" height=\"1\"  colspan=\"5\"></td></tr>\r\n");
      out.write("\t<tr height=\"25\">\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Name", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\">\r\n");
      out.write("\t\t\t<input type=\"text\" name=\"empName\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(empName );
      out.write("\" />\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Password", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"password\" name=\"password\"  dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(password );
      out.write("\" /></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("    <tr><td class=\"formline\" height=\"1\"  colspan=\"5\"></td></tr>\r\n");
      out.write("\t<tr height=\"25\">\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Email", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"text\" name=\"email\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(email );
      out.write("\"></td>\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Staff Level", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"text\" name=\"jikName\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(jikName );
      out.write("\" /></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td class=\"formline\" height=\"1\"  colspan=\"5\"></td></tr>\r\n");
      out.write("\t<tr height=\"25\">\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Mobile", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"text\" name=\"mobileno\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(mobileno );
      out.write("\" /></td>\r\n");
      out.write("\t\t<td class=\"formtitle\">\r\n");
      out.write("\t\t\t<strong>\r\n");
      out.write("\t\t\t\t");
      out.print(GlobalContext.getMessageForWeb("Company", loggedUserLocale) );
      out.write('/');
      out.print(GlobalContext.getMessageForWeb("Department", loggedUserLocale) );
      out.write("\r\n");
      out.write("\t\t\t</strong>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td class=\"formcon\">\r\n");
      out.write("\t\t\t<select name=\"globalCom\" onChange=\"changCompany(this);\">\r\n");
      out.write("\t\t\t\t");
      out.print(sComOption );
      out.write("\r\n");
      out.write("\t\t\t</select>\r\n");
      out.write("\t\t\t<select name=\"partCode\" id=\"selectPartCode\">\r\n");
      out.write("\t\t\t");
      out.print(sPartOption );
      out.write("\r\n");
      out.write("\t\t\t</select>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("     <tr><td class=\"formline\" height=\"1\"  colspan=\"5\"></td></tr>\r\n");
      out.write("\t<tr height=\"25\">\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("NateOn", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"text\" name=\"nateOn\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(nateOn );
      out.write("\" /></td>\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("MSN", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\"><input type=\"text\" name=\"msn\" dojoType=\"dijit.form.TextBox\" value=\"");
      out.print(msn );
      out.write("\" /></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td class=\"formline\" height=\"1\"  colspan=\"5\"></td></tr>\r\n");
      out.write("\t<tr height=\"25\">\r\n");
      out.write("\t\t<td class=\"formtitle\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Language", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("\t\t<td class=\"formcon\" colspan=\"3\"><select name=\"locale\">\r\n");
			
			for (int i=0; i<localeValueList.length;i++) {
				String[] localeValue = localeValueList[i];
				String sSeleted = localeValue[0].equals(locale) ? "selected=\"selected\"" : "";

      out.write("\r\n");
      out.write("\t\t\t\t<option value='");
      out.print(localeValue[0] );
      out.write('\'');
      out.write(' ');
      out.print(sSeleted );
      out.write('>');
      out.print(GlobalContext.getLocalizedMessageForWeb(localeValue[1].toLowerCase(), loggedUserLocale, localeValue[1]) );
      out.write("</option>\r\n");

			}

      out.write("\r\n");
      out.write("\t\t</select></td>\r\n");
      out.write("\t\t<td align=\"right\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td class=\"formheadline\" colspan=\"6\"></td></tr>\r\n");
      out.write("</table>\r\n");
      out.write("<br>\r\n");
      out.write("<table width=\"98%\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td align=\"center\">\r\n");
      out.write("            <table>\r\n");
      out.write("                <tr>\r\n");
      out.write("                    <td class=\"gBtn\">\r\n");
      out.write("                        <a onClick=\"updateUserActionSubmit();\" >\r\n");
      out.write("                        <span>");
      out.print(GlobalContext.getMessageForWeb("Update", loggedUserLocale));
      out.write("</span></a>\r\n");
      out.write("                    </td>\r\n");
      out.write("                </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<input type=\"hidden\" name=\"isModification\" value=\"true\">\r\n");
      out.write("</form>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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
