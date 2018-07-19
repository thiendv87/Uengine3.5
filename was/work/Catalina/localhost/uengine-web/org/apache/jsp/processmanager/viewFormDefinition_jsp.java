package org.apache.jsp.processmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import org.springframework.web.util.HtmlUtils;
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

public final class viewFormDefinition_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants.add("/processmanager/../common/header.jsp");
    _jspx_dependants.add("/processmanager/../common/headerMethods.jsp");
    _jspx_dependants.add("/processmanager/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/processmanager/../lib/jquery/importJquery.jsp");
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

    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"../style/uengine.css\" type=\"text/css\" />\r\n");
      out.write("<link rel=\"stylesheet\" href=\"../style/portlet.css\" type=\"text/css\"/>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"../style/portal.css\" type=\"text/css\"/>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"../style/groupware.css\" type=\"text/css\"/>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"../style/default.css\" />\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/ckeditor/ckeditor.js\"></script>\r\n");
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
      out.write("<link rel='stylesheet' type='text/css' href='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery-ui.css' />\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery-1.12.0.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery-ui.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery.cookie.js'></script>\r\n");
      out.write("<script>\r\n");
      out.write("jQuery.browser = {};\r\n");
      out.write("(function () {\r\n");
      out.write("    jQuery.browser.msie = false;\r\n");
      out.write("    jQuery.browser.version = 0;\r\n");
      out.write("    if (navigator.userAgent.match(/MSIE ([0-9]+)\\./)) {\r\n");
      out.write("        jQuery.browser.msie = true;\r\n");
      out.write("        jQuery.browser.version = RegExp.$1;\r\n");
      out.write("    }\r\n");
      out.write("})();\r\n");
      out.write("</script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jcalendar.js'></script>\r\n");
      out.write("\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/ajaxfileupload.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery.blink.min.js'></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      org.uengine.processmanager.ProcessManagerFactoryBean processManagerFactory = null;
      synchronized (application) {
        processManagerFactory = (org.uengine.processmanager.ProcessManagerFactoryBean) _jspx_page_context.getAttribute("processManagerFactory", PageContext.APPLICATION_SCOPE);
        if (processManagerFactory == null){
          processManagerFactory = new org.uengine.processmanager.ProcessManagerFactoryBean();
          _jspx_page_context.setAttribute("processManagerFactory", processManagerFactory, PageContext.APPLICATION_SCOPE);
        }
      }
      out.write("\r\n");
      out.write("\r\n");

	ProcessManagerRemote pm = null;
	
	String pd = request.getParameter("objectDefinitionId");
	String pdVer = request.getParameter("processDefinitionVersionID");
	String folder = request.getParameter("folder");
	
	try {
		pm = processManagerFactory.getProcessManagerForReadOnly();
		ProcessDefinitionRemote[] arrPdr = pm.findAllVersions(pd);
		
		int maxVersion = -1;
		if(arrPdr != null){
			String versionID = null;
			int version = -1;
			for(int i=0; i<arrPdr.length; i++){
				versionID = arrPdr[i].getId();
				version = arrPdr[i].getVersion();
				if (arrPdr[i].isProduction()) {
					if( !UEngineUtil.isNotEmpty(pdVer) ) {
						pdVer = versionID;
					}
				}
			}
			
			if( !UEngineUtil.isNotEmpty(pdVer) ) {
				pdVer = versionID;
			}
			maxVersion = version + 1;
		}
		
		ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(pdVer);
		
		//String title = pdr.getName().getText();
		String srAlias = pdr.getAlias();
		String belongingDefId = pdr.getBelongingDefinitionId();
		String formDefinitionValue = pm.getResource(pdVer);
	
		AclManager acl = AclManager.getInstance();
		HashMap permission = acl.getPermission(Integer.parseInt(pdr.getBelongingDefinitionId()), loggedUserId);
		if (loggedUserIsAdmin) {
	    	permission.put(AclManager.PERMISSION_MANAGEMENT, true);
	    	permission.put(AclManager.PERMISSION_EDIT, true);
	    	permission.put(AclManager.PERMISSION_INITIATE, true);
	    	permission.put(AclManager.PERMISSION_VIEW, true);
	    }

      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\tfunction makeProduction(){\r\n");
      out.write("\t\tlocation=\"makeProduction.jsp?processDefinition=");
      out.print(pdVer.replace(' ', '+'));
      out.write("\";\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction saveForm(){\r\n");
      out.write("\t\r\n");
      out.write("\t\tdocument.actionForm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction updateForm(){\r\n");
      out.write("\t\tdocument.actionForm.version.value = '");
      out.print(pdr.getVersion());
      out.write("';\r\n");
      out.write("\t\tdocument.actionForm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction refresh(){\r\n");
      out.write("\t\tvar pdv = document.all.processDefinitionVersionID.value;\r\n");
      out.write("\t\tlocation=\"?objectDefinitionId=");
      out.print(pd);
      out.write("&folder=");
      out.print(folder);
      out.write("&processDefinitionVersionID=\" + pdv;\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("<title>\r\n");
      out.write("\t");
      out.print(GlobalContext.getMessageForWeb("Form Definition", loggedUserLocale) );
      out.write(" -\r\n");
      out.write("\t");
      out.print(pdr.getName().getText());
      out.write(" (\r\n");
      out.write("\t");
      out.print(GlobalContext.getMessageForWeb("Version", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(pdr.getVersion());
      out.write(" / \r\n");
      out.write("\t");
      out.print(GlobalContext.getMessageForWeb("Modified Date", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(pdr.getStrModifiedDate() );
      out.write("\r\n");
      out.write("\t)\r\n");
      out.write("</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
 if (permission.containsKey(AclManager.PERMISSION_EDIT)) { 
      out.write("\r\n");
      out.write("<form name=\"actionForm\" action=\"saveFormDefinition.jsp\" method=\"post\">\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td valign=\"middle\">\r\n");
      out.write("\t\t\t<img src=\"../images/Common/I_info.gif\" align=\"middle\" border=\"0\" style=\"margin-top:-2px;\"> <strong>");
      out.print(GlobalContext.getLocalizedMessageForWeb("edit_page", loggedUserLocale, "Edit Page") );
      out.write("</strong>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("        <td>\r\n");
      out.write("        \t<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t\t\t\t");

                    if (pdVer != null) {
                
      out.write("\r\n");
      out.write("                    \r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>\t\r\n");
      out.write("                            \r\n");
      out.write("                            <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                                <tr>\r\n");
      out.write("                                    <td align=\"right\" valign=\"top\">\r\n");
      out.write("                                    <table cellSpacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                        <tBody>\r\n");
      out.write("                                            <tr>\r\n");
      out.write("                                                <td class=\"gBtn\">\r\n");
      out.write("                                                \t");
 if (
                                                    		permission.containsKey(AclManager.PERMISSION_MANAGEMENT)
                                                    		|| permission.containsKey(AclManager.PERMISSION_EDIT)
                                                    	) {
                                                    
      out.write("\r\n");
      out.write("                                                    <a href=\"javascript: saveForm();\"><span>\r\n");
      out.write("                                                        ");
      out.print(GlobalContext.getLocalizedMessageForWeb("save_new_version", loggedUserLocale, "Save New Version") );
      out.write("\r\n");
      out.write("                                                    </span></a>\r\n");
      out.write("                                                    ");
 } 
      out.write("\r\n");
      out.write("                                                    ");
 if (permission.containsKey(AclManager.PERMISSION_MANAGEMENT)	) { 
      out.write("\r\n");
      out.write("                                                    <a href=\"javascript: updateForm();\" key=\"button.update\"><span>\r\n");
      out.write("                                                        ");
      out.print(GlobalContext.getLocalizedMessageForWeb("update_for_this_version", loggedUserLocale, "Update for This Version") );
      out.write("\r\n");
      out.write("                                                    </span></a>\r\n");
      out.write("                                                    <!-- \r\n");
      out.write("                                                    <a href=\"javascript: removeDefinition('");
      out.print(belongingDefId);
      out.write("');\"><span>\r\n");
      out.write("                                                        ");
      out.print(GlobalContext.getLocalizedMessageForWeb("delete", loggedUserLocale, "Delete") );
      out.write("\r\n");
      out.write("                                                    </span></a>\r\n");
      out.write("                                                     -->\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");

                                                    }
                                                            if(pdr.isProduction()) {
                                                    
      out.write("\r\n");
      out.write("                                                    <span style=\"line-height:23px; color:#F00\">\r\n");
      out.write("                                                    [");
      out.print(GlobalContext.getLocalizedMessageForWeb("this_version_is_procuction", loggedUserLocale, "This version is production") );
      out.write("]\r\n");
      out.write("                                                    </span>\r\n");
      out.write("            \t\t\t\t\t\t\t\t\t\t");
 	} else if (loggedUserIsAdmin) { 
      out.write("\t\r\n");
      out.write("                                                    <a href=\"javascript: makeProduction();\"><span>\r\n");
      out.write("                                                        ");
      out.print(GlobalContext.getLocalizedMessageForWeb("set_as_production", loggedUserLocale, "Set As Production") );
      out.write("\r\n");
      out.write("                                                    </span></a>\r\n");
      out.write("            \t\t\t\t\t\t\t\t\t\t");
	} 
      out.write("\r\n");
      out.write("                                                </td>\r\n");
      out.write("                                            </tr>\r\n");
      out.write("                                        </tBody>\r\n");
      out.write("                                    </table>\r\n");
      out.write("                                    \r\n");
      out.write("                                    </td>\r\n");
      out.write("                                </tr>\r\n");
      out.write("                            </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\t\t\t\r\n");
      out.write("                ");

                    }
                
      out.write("\r\n");
      out.write("            </table>\t\r\n");
      out.write("        </td>\r\n");
      out.write("        \r\n");
      out.write("\t</tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    \t<td height=\"10\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("\t\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td height=\"5\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t<tr >\r\n");
      out.write("\t\t<td align=\"center\" colspan=\"3\" class=\"formheadline\"></td>\r\n");
      out.write("\t</tr>\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t<tr height=\"30\" >\r\n");
      out.write("\t\t<td width=\"150\" class=\"formtitle\">\r\n");
      out.write("\t\t\t&nbsp;<b>");
      out.print(GlobalContext.getMessageForWeb("Definition", loggedUserLocale) );
      out.write("</b>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td width=\"10\"></td>\r\n");
      out.write("\t\t<td width=\"*\" align=\"left\">\r\n");
      out.write("\t\t\t");
      out.print(pdr.getName().getText());
      out.write(" (\r\n");
      out.write("\t\t\t\t");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale) );
      out.write("  : ");
      out.print(pdr.getBelongingDefinitionId());
      out.write(" ,\r\n");
      out.write("\t\t\t\t");
      out.print(GlobalContext.getMessageForWeb("Alias", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(srAlias );
      out.write(" \r\n");
      out.write("\t\t\t)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr >\r\n");
      out.write("\t\t<td align=\"center\" colspan=\"3\" class=\"formline\" height=\"1\"></td>\r\n");
      out.write("\t</tr>\r\n");

	if(arrPdr != null){

      out.write("\t<tr height=\"30\" >\r\n");
      out.write("\t\t<td width=\"150\" class=\"formtitle\">\r\n");
      out.write("\t\t\t&nbsp;<strong>");
      out.print(GlobalContext.getMessageForWeb("Version", loggedUserLocale) );
      out.write("</strong>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td width=\"10\"></td>\r\n");
      out.write("\t\t<td width=\"*\" align=\"left\">\r\n");
      out.write("\t\t\t<select name=\"processDefinitionVersionID\" id=\"processDefinitionVersionID\" onChange=\"refresh();\">\t\r\n");
	
			String versionID = null;
			String version = "-1";
			String strModifiedDate = "";
			String sStyle = "";
			
			for(int i=0; i<arrPdr.length; i++){
				strModifiedDate = arrPdr[i].getStrModifiedDate();
				versionID = arrPdr[i].getId();
				version = "Ver : " + arrPdr[i].getVersion();
				
				if (arrPdr[i].isProduction()) {
					version =  version + "*";
					sStyle = " style=\"color: #FF0000;\" ";
				} else {
					sStyle = "";
				}

      out.write("\r\n");
      out.write("\t\t\t\t<option value=\"");
      out.print(versionID);
      out.write('"');
      out.write(' ');
      out.print(sStyle );
      out.write(' ');
      out.print((versionID.equals(pdVer)) ? "selected=\"selected\" " : "");
      out.write('>');
      out.print(version);
      out.write("</option>\r\n");
		} 
      out.write("\r\n");
      out.write("\t\t\t</select>\r\n");
      out.write("\t\t\t\t( ");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale) );
      out.write("  : ");
      out.print(pdVer);
      out.write(" ,\r\n");
      out.write("\t\t\t\t");
      out.print(GlobalContext.getMessageForWeb("Modified Date", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(pdr.getStrModifiedDate() );
      out.write(" )\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr height=\"1\">\r\n");
      out.write("\t\t<td align=\"center\" colspan=\"3\" class=\"formline\" height=\"1\"></td>\r\n");
      out.write("\t</tr>\r\n");

	}

	if (pdVer!=null) { 
		String desc = (pdr.getDescription()!=null ? pdr.getDescription().getText() : null);
		if ( desc == null ) desc = "";

      out.write("\t\r\n");
      out.write("\t<tr height=\"30\" >\r\n");
      out.write("\t\t<td width=\"150\" class=\"formtitle\">\r\n");
      out.write("\t\t\t&nbsp;<b>");
      out.print(GlobalContext.getLocalizedMessageForWeb("description", loggedUserLocale, "Description") );
      out.write("</b>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td width=\"10\"></td>\r\n");
      out.write("\t\t<td width=\"*\" align=\"left\">\r\n");
      out.write("\t\t\t");
      out.print(desc);
      out.write("\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr >\r\n");
      out.write("\t\t<td align=\"center\" colspan=\"3\" class=\"formheadline\"></td>\r\n");
      out.write("\t</tr>\t\t\t\r\n");

	}

      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td height=\"2\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- 폼 -->\r\n");
      out.write("<textarea id=\"CKeditor1\" name=\"CKeditor1\" >");
      out.print(HtmlUtils.htmlEscape(formDefinitionValue));
      out.write("</textarea>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("//<![CDATA[\r\n");
      out.write("\tCKEDITOR.replace('CKeditor1',\r\n");
      out.write("\t{\r\n");
      out.write("\t\tskin : '");
      out.print(GlobalContext.getPropertyString("ckeditor.skin", "kama"));
      out.write("', \r\n");
      out.write("\t\twidth : ($(\"iframe[name='innerworkarea']\").attr(\"width\") - 25) + \"px\", \r\n");
      out.write("\t\theight : ($(document).height() - 320) + \"px\"\r\n");
      out.write("\t});\r\n");
      out.write("\tCKEDITOR.config.protectedSource.push( /<%[\\s\\S]*?%>/g );\r\n");
      out.write("//]]>\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<span style=\"visibility:hidden;\"><textarea name=\"ValueContent\">");
      out.print(formDefinitionValue);
      out.write("</textarea></span>\r\n");
      out.write("\r\n");
      out.write("<input type=\"hidden\" name=\"defId\" \t\t\t\t\tvalue=\"");
      out.print(pd);
      out.write("\" />\r\n");
      out.write("<input type=\"hidden\" name=\"definitionName\" \t\tvalue=\"");
      out.print(pdr.getName().getText());
      out.write("\" />\r\n");
      out.write("<input type=\"hidden\" name=\"version\" \t\t\t\t\tvalue=\"");
      out.print(maxVersion);
      out.write("\" />\r\n");
      out.write("<input type=\"hidden\" name=\"objectType\" \t\t\t\tvalue=\"form\" />\r\n");
      out.write("</form>\r\n");
 } else { 
      out.write("\r\n");
      out.write(" You don't have permission view.\r\n");
 } 
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");

	} catch(Exception e) {
		e.printStackTrace();
		throw e;
	} finally {
		if (pm != null) pm.remove();
	}

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
