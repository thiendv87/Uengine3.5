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

public final class organizationListDetail_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(4);
    _jspx_dependants.add("/organizationmanager/../common/header.jsp");
    _jspx_dependants.add("/organizationmanager/../common/headerMethods.jsp");
    _jspx_dependants.add("/organizationmanager/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/organizationmanager/../common/styleHeader.jsp");
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

      out.write('\r');
      out.write('\n');

	String type = request.getParameter("type");
	String objType = request.getParameter("objType");
	String code = request.getParameter("code");
	String comCode = request.getParameter("comCode");
	String itemName = reqMap.getString("itemName", "Organization Tree");

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\t<title>");
      out.print(GlobalContext.getMessageForWeb("Organization List", loggedUserLocale) );
      out.write("</title>\r\n");
      out.write("\t");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/default.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/uengine.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/en_US.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/bbs.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/classic/css/main.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/formdefault.css\" />\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/bbs.js\"></script>");
      out.write("\r\n");
      out.write("\t<style type=\"text/css\">\r\n");
      out.write("\t</style>\r\n");
      out.write("    <LINK rel=\"stylesheet\" href=\"../style/form.css\" type=\"text/css\"/>\r\n");
      out.write("    \r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tvar WEB_CONTEXT_ROOT = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("\";\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction init()\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\ttbodyUsers = document.getElementById(\"tbodyUsers\");\r\n");
      out.write("\t\t\ttbodyGroups = document.getElementById(\"tbodyGroups\");\r\n");
      out.write("\t\t\tgetGrouptList(\"");
      out.print(type);
      out.write("\", \"");
      out.print(code);
      out.write("\");\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/ajax/ajaxCommon.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/crossBrowser/elementControl.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/organizationScript.js\"></script>\r\n");
      out.write("\t<link href=\"../style/default.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("</head>\r\n");
      out.write("<body onLoad=\"init();\" style=\"padding: 15px;\">\r\n");
      out.write("<div id=\"divDescriptionForGroup\" onmouseout=\"hideElement(this);\" \r\n");
      out.write("style=\"background-color: white; display: none; position: absolute; padding:5px 15px 15px 15px; border:1px solid #666; z-index: 2;\"></div>\r\n");
      out.write("\r\n");
      out.write("\t<div id=\"idDivInformation\">\r\n");
      out.write("\t<span class=\"sectiontitle\" id=\"idSpanTitle\">");
      out.print(itemName );
      out.write(" Information</span>\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"  class=\"tableborder\">\r\n");
      out.write("\t\t<col span=\"1\" width=\"150\" />\r\n");
      out.write("\t\t<col span=\"1\" width=\"170\" />\r\n");
      out.write("\t\t<col span=\"1\" />\r\n");
      out.write("\t\t<col span=\"1\" />\r\n");
      out.write("\t\t<col span=\"1\" />\r\n");
      out.write("\t\t<col span=\"1\" />\r\n");
      out.write("\t\t<thead>\r\n");
      out.write("\t\t\t<tr><td class=\"formheadline\" colspan=\"6\"></td></tr>\r\n");
      out.write("\t\t</thead>\r\n");
      out.write("\t\t<tbody id=\"idRowLogoImage\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("LOGO IMAGE", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t\t\t\t<td class=\"formcon\" colspan=\"5\"><img onclick=\"changeGroupImage();\" alt=\"Click for change\" style=\"cursor: pointer;\" id=\"idImgLogo\" src=\"\" onerror=\"setNoImage(this);\" width=\"137\" height=\"49\" align=\"top\" /></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr><td class=\"formline\" colspan=\"6\" height=\"1\"></td></tr>\r\n");
      out.write("\t\t</tbody>\r\n");
      out.write("\t\t<tbody>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("NAME", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t\t\t\t<td class=\"formcon\"><span id=\"idSpanName\"></span></td>\r\n");
      out.write("\t\t\t\t<td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t\t\t\t<td class=\"formcon\"><span id=\"idSpanCode\"></span></td>\r\n");
      out.write("\t\t\t\t<td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("TYPE", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t\t\t\t<td class=\"formcon\"><span id=\"idSpanType\"></span></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr><td class=\"formline\" colspan=\"6\" height=\"1\"></td></tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("DESCRIPTION", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t\t\t\t<td class=\"formcon\" colspan=\"5\"><span id=\"idSpanDescription\"></span></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</tbody>\r\n");
      out.write("\t\t<tfoot>\r\n");
      out.write("\t\t\t<tr><td class=\"formheadline\" colspan=\"6\"></td></tr>\r\n");
      out.write("\t\t</tfoot>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t<br /><br />\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t<span class=\"sectiontitle\" id=\"span_child_grp_name\">Children groups of ");
      out.print(itemName );
      out.write("</span>\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"  class=\"tableborder\">\r\n");
      out.write("\t\t<thead  class=\"tabletitle\">\r\n");
      out.write("\t\t\t<tr height=\"25\">\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("GROUP NAME", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("GROUP CODE", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("GROUP DESC", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</thead>\r\n");
      out.write("\t\t<tbody id=\"tbodyGroups\"></tbody>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t\r\n");
      out.write("\t<br /><br />\r\n");
      out.write("\t<span class=\"sectiontitle\" id=\"span_child_usr_name\">Children users of ");
      out.print(itemName );
      out.write("</span>\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"  class=\"tableborder\">\r\n");
      out.write("\t\t<col span=\"1\" width=\"25%\" align=\"center\" />\r\n");
      out.write("\t\t<col span=\"1\" width=\"25%\" align=\"center\" />\r\n");
      out.write("\t\t<col span=\"1\" width=\"25%\" align=\"center\" />\r\n");
      out.write("\t\t<col span=\"1\" width=\"25%\" align=\"center\" />\r\n");
      out.write("\t\t<thead  class=\"tabletitle\">\r\n");
      out.write("\t\t\t<tr height=\"25\">\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("Name", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("Department", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("Company", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t\t<th>");
      out.print(GlobalContext.getMessageForWeb("Email", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</thead>\r\n");
      out.write("\t\t<tbody id=\"tbodyUsers\"></tbody>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
