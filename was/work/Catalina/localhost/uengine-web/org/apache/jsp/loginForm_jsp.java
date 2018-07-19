package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.defaultcompany.login.LoginService;
import org.uengine.util.UEngineUtil;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import org.uengine.util.dao.DefaultConnectionFactory;
import org.uengine.kernel.GlobalContext;

public final class loginForm_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/./scripts/importCommonScripts.jsp");
    _jspx_dependants.add("/./scripts/../lib/jquery/importJquery.jsp");
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

	boolean useCookie = "true".equals(GlobalContext.getPropertyString("web.cookie.use","false"));
	String cookieExpires = GlobalContext.getPropertyString("web.cookie.expires", "1");
	
	response.setHeader ("Pragma", "No-cache"); 
	response.setDateHeader ("Expires", 0);
	response.setHeader ("Cache-Control", "no-cache");

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("    <title>Login Form</title>\r\n");
      out.write("    \r\n");
      out.write("\t<!-- import common libraries -->\r\n");
      out.write("\t");
      out.write("\r\n");
      out.write("\r\n");
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

String webContextRoot = org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT;
String defaultLocale = (String) session.getAttribute("loggedUserLocale");//org.uengine.kernel.GlobalContext.DEFAULT_LOCALE;
if (defaultLocale == null) {
	defaultLocale = org.uengine.kernel.GlobalContext.DEFAULT_LOCALE;	
}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvar WEB_CONTEXT_ROOT = \"");
      out.print(webContextRoot);
      out.write("\";\r\n");
      out.write("\tvar LOGGED_USER_LOCALE = \"");
      out.print(defaultLocale);
      out.write("\";\r\n");
      out.write("</script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(webContextRoot);
      out.write("/scripts/crossBrowser/elementControl.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(webContextRoot);
      out.write("/scripts/ajax/ajaxCommon.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(webContextRoot);
      out.write("/scripts/common.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(webContextRoot);
      out.write("/lib/ckeditor/ckeditor.js\"></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tvar USE_COOKIE = ");
      out.print(useCookie);
      out.write(";\r\n");
      out.write("\t\tvar COOKIE_EXPIRES = ");
      out.print(cookieExpires);
      out.write(";\r\n");
      out.write("\t\tvar COOKIE_KEY_SAVE_ID = \"");
      out.print(LoginService.COOKIE_SAVE_ID);
      out.write("\";\r\n");
      out.write("\t\tvar COOKIE_KEY_AUTO_LOGIN = \"");
      out.print(LoginService.COOKIE_AUTO_LOGIN);
      out.write("\";\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction formValidate(){\r\n");
      out.write("\t\t\treturn true;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\tfunction initateProcess(defverid) {\r\n");
      out.write("\t\t\tvar option = \"width=900,height=550,scrollbars=yes,resizable=yes\";\r\n");
      out.write("\t\t\tvar url = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/initiateForm.jsp?processDefinition=\" + defverid + \"&regUser=true\";\r\n");
      out.write("\t\t\twindow.open(url, \"wihspace\", option)\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction loginAction() {\r\n");
      out.write("\t\t\tvar userId = $(\"input[name=userId]\").val();\r\n");
      out.write("\t\t\tvar passWd = $(\"input[name=passWd]\").val(); \r\n");
      out.write("\t\t\tif (window.console)\tconsole.log(userId);\r\n");
      out.write("\t\t\tif (window.console)\tconsole.log(passWd);\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t$.ajax({\r\n");
      out.write("\t\t\t    type: \"GET\",\r\n");
      out.write("\t\t\t    data: {\"userId\":userId,\"passWd\":passWd},\r\n");
      out.write("\t\t\t    contentType: \"application/json;charset=utf-8\", \r\n");
      out.write("\t\t\t    url: WEB_CONTEXT_ROOT+\"/LoginNew.jsp\",\r\n");
      out.write("\t\t\t   //url: \"http://localhost:8080/uengine-web/LoginNew.jsp\",\r\n");
      out.write("\t\t\t    success: function(msg, status) {\r\n");
      out.write("\t\t\t    \tif(window.console)\tconsole.log(msg);\r\n");
      out.write("\t\t\t    \tjsonobj = eval(\"(\"+msg+\")\");\r\n");
      out.write("\t\t\t    \tif(jsonobj.condition==\"Success\"){\r\n");
      out.write("\t\t\t\t\t\tif (USE_COOKIE) {\r\n");
      out.write("\t\t\t\t\t\t\tif ($(\"input[name='chksaveid']\").attr(\"checked\")) {\r\n");
      out.write("\t\t\t\t\t\t\t\t$.cookie(COOKIE_KEY_SAVE_ID, $(\"input[name='userId']\").val(), {'expires':COOKIE_EXPIRES});\r\n");
      out.write("\t\t\t\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t\t\t\t\t$.cookie(COOKIE_KEY_SAVE_ID, \"\");\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t    \t\t\t\r\n");
      out.write("\t\t\t    \t\t\t$.cookie(COOKIE_KEY_AUTO_LOGIN, $(\"input[name=chkautologin]\").attr(\"checked\"), {'expires':COOKIE_EXPIRES});\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t    \t\t\r\n");
      out.write("\t\t\t    \t\tdocument.location.href=WEB_CONTEXT_ROOT+\"/index.jsp\";\r\n");
      out.write("\t\t\t    \t}else if(jsonobj.condition==\"Fail\"){\r\n");
      out.write("\t\t\t    \t\talert(jsonobj.msg);\r\n");
      out.write("\t\t\t    \t}\r\n");
      out.write("\t\t\t    },\t\t\t\r\n");
      out.write("\t\t\t    error: function(msg, status) {\r\n");
      out.write("\t\t\t    \tif ( window.console ) console.log(msg);\r\n");
      out.write("\t\t\t    }\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t");
if(useCookie){ 
      out.write("\r\n");
      out.write("\t\t$(document).ready(function(){\r\n");
      out.write("\t\t\tif (!isEmpty(COOKIE_KEY_SAVE_ID)) {\r\n");
      out.write("\t\t\t\tsetSaveId();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tif (!isEmpty(COOKIE_KEY_AUTO_LOGIN)) {\r\n");
      out.write("\t\t\t\tsetAutoLogin();\r\n");
      out.write("\t\t\t\tsetSaveId();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t$(\"#divCookie\").toggle();\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction setSaveId() {\r\n");
      out.write("\t\t\tvar cookieUidValue = $.cookie(COOKIE_KEY_SAVE_ID);\r\n");
      out.write("\t\t\tif (!isEmpty(cookieUidValue)) {\r\n");
      out.write("\t\t\t\t$(\"input[name='chksaveid']\").attr({\r\n");
      out.write("\t\t\t\t\t\"checked\":true\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t$(\"input[name='userId']\").attr({\r\n");
      out.write("\t\t\t\t\t\"value\":cookieUidValue\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction setAutoLogin() {\r\n");
      out.write("\t\t\tvar cookieAutoLogin = $.cookie(COOKIE_KEY_AUTO_LOGIN);\r\n");
      out.write("\t\t\tif (!isEmpty(cookieAutoLogin)) {\r\n");
      out.write("\t\t\t\t$($(\"input[name='chkautologin']\")).attr({\r\n");
      out.write("\t\t\t\t\t\"checked\":cookieAutoLogin\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t");
 } 
      out.write("\r\n");
      out.write("\t</script>\r\n");
      out.write("\r\n");
      out.write("\t<link href=\"style/uengine.css\" type=\"text/css\" rel=\"stylesheet\">\r\n");
      out.write("\r\n");
      out.write("    <style>\r\n");
      out.write("\t    p { font-family: georgia, sans-serif; font-size: 11px; }\r\n");
      out.write("\t\thtml, body {\r\n");
      out.write("\t\t\theight: 100%;\r\n");
      out.write("\t\t\tmargin:0;\r\n");
      out.write("\t\t\tpadding:0;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t* {\r\n");
      out.write("\t\t\tmargin:0;\r\n");
      out.write("\t\t\tpadding:0;\r\n");
      out.write("\t\t\tfont-family:\"돋움\", Dotum, \"굴림\", Gulim, AppleGothic, Sans-serif;\r\n");
      out.write("\t\t\tfont-size:11px;\r\n");
      out.write("\t\t\tcolor:#333333;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</style>\r\n");
      out.write("\t\r\n");
      out.write("\t</head>\r\n");
      out.write("\r\n");
      out.write("<body >\r\n");
      out.write("\r\n");
      out.write("<div style=\"height:518px; width:896px; background:url(images/login/1.gif) no-repeat; top:50%; left:50%; margin-left:-448px; margin-top:-309px; position:absolute; border:0px\">\r\n");
      out.write("\t<div style=\"margin:90px 0 0 194px; height:61px;\">\r\n");
      out.write("    \t<div style=\"float:left;\"><img src=\"images/login/logo_new.gif\" border=\"0\"></div>\r\n");
      out.write("    \t<!-- <div style=\"float:left;\"><img src=\"images/login/logo.gif\" border=\"0\"></div>  -->\r\n");
      out.write("        <div style=\"float:left; margin-top:28px;\"><span style=\"font-size:11px; color:#999; \">Ver 3.5.5 standalone</span></div>    \r\n");
      out.write("    </div>\r\n");
      out.write("  \r\n");
      out.write("    <div style=\" height:50px; width:369px; margin:53px 0 0 250px;\">\r\n");
      out.write("        <!-- login form -->\r\n");
      out.write("    \t<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td width=\"15%\" height=\"30\"><img src=\"images/login/i_id.gif\" width=\"41\" height=\"13\"></td>\r\n");
      out.write("                <td width=\"69%\" rowspan=\"2\">\r\n");
      out.write("                    <input type=\"hidden\" name=\"return_to\" value=\"\" />\r\n");
      out.write("                    <input type=\"hidden\" name=\"login\" value=\"Login\">\r\n");
      out.write("\t\t\t\t\t<input name=\"userId\" style=\"width:190px;ime-mode:inactive\"/>\r\n");
      out.write("                    <br />\r\n");
      out.write("                    <span><input type=\"password\" name=\"passWd\" style=\"width:190px; margin-top:8px;\"/></span>\r\n");
      out.write("                    <br />\r\n");
      out.write("                   </td>\r\n");
      out.write("                <td width=\"16%\" rowspan=\"2\"><input type=\"image\" src=\"images/login/b_login.gif\" title=\"click is login\" alt=\"click is login\" onclick=\"javascript:loginAction();\"/></td> </form>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height=\"30\"><img src=\"images/login/i_pw.gif\" width=\"41\" height=\"13\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("        </table>\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- login option -->\r\n");
      out.write("    <div id=\"divCookie\" style=\"display:none; background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:14px 0 0 250px; width:380px; color:#808080 \">Save Id <input type=\"checkbox\" name=\"chksaveid\" />&nbsp;&nbsp;&nbsp;Auto Login <input type=\"checkbox\" name=\"chkautologin\" /></div>\r\n");
      out.write("    <div style=\" background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:");
      out.print(useCookie ? "7" : "28");
      out.write("px 0 0 250px; width:380px; color:#808080 \">Administrator (<b>EN</b>) User/Password is <span style=\"color:#09C;\">test / test</span></div>\r\n");
      out.write("    <div style=\" background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:7px 0 0 250px; width:380px; color:#808080 \">Administrator (<b>KO</b>) User/Password is <span style=\"color:#09C;\">test_ko / test</span>\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- div style=\" background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:28px 0 0 250px; width:380px; color:#808080 \">If you want registration new company <strong><span style=\"color:#09C;\"><a href=\"javascript: initateProcess('812');\">CLICK HERE</a></span></strong></div -->\r\n");
      out.write("</div>\r\n");
      out.write("    \r\n");
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
