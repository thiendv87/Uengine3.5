package org.apache.jsp.wih.formHandler;

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
import org.uengine.security.AclManager;
import org.uengine.kernel.GlobalContext;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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


private String createTabMenuItem(String strMenuId, String loggedUserLocale, String strActionUrl) {
	String strTempHtml = "";
	if (UEngineUtil.isNotEmpty(strMenuId)) {
		String strMenuText = GlobalContext.getMessageForWeb(strMenuId, loggedUserLocale);
		strTempHtml += "<li id=\"" + strMenuId + "_menuItem\">"
				+ "<a href=\"javascript:changeDisplayMenuItem('" + strActionUrl + "', '" + strMenuId + "')\">"
				+ strMenuText + "</a></li>"
				+ "<script>listStrMenuText['" + strMenuId + "'] = '" + strMenuText + "'</script>";
	}
	return strTempHtml;
}

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(12);
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/index.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/header.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../../common/header.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../../common/headerMethods.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../../common/getLoggedUser.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../../common/styleHeader.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../../scripts/importCommonScripts.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../../scripts/../lib/jquery/importJquery.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/definition.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/showTabs.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../wihDefaultTemplate/passValues.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/../wihDefaultTemplate/addIndexPassValues.jsp");
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
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
      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("<link rel='stylesheet' type='text/css' href='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/css/smoothness/jquery-ui-1.8.7.custom.css' /> \r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery-1.4.4.min.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery-ui-1.8.7.custom.min.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jcalendar.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/i18n/jquery-ui-i18n.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery.cookie.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/ajaxfileupload.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/lib/jquery/jquery.blink.min.js'></script>");

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
      out.write('\r');
      out.write('\n');
      out.write('	');

	ProcessManagerRemote pm = null;
	String instanceId = null;
	ProcessInstance piRemote = null;
	ProcessInstance initiationPiRemote = null;
	String processDefinition = null;
	String tracingTag = null;
	String initiationProcessDefinition = null;
	boolean initiate;
	boolean isViewMode;
	String dispatchingOption = null;
	boolean isRacing;	
	ProcessDefinitionRemote pdr = null;
	Properties scriptSet = new Properties();
	HumanActivity initiationActivity=null;
	String pdver=null;
	
	ProcessDefinition currentProcessDefinition = null;
	Activity currentActivity = null;

      out.write('\r');
      out.write('\n');
      out.write('	');
      out.write("\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/formdefault.css\" />\r\n");
      out.write("</head>\r\n");
      out.write("<body style=\"overflow:hidden;\">\r\n");
      out.write("\t");

		try{
	
      out.write("\r\n");
      out.write("\t<table height=\"100%\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t\t<thead>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td width=\"100%\" height=\"70\"><div id=\"divTabMenus\">\r\n");
      out.write("\t\t\t\t");
      out.write("\r\n");
      out.write("\r\n");

	//ProcessInstance instance = piRemote;

	//String keyword = initiationActivity.getKeyword().getText();	
	//if (!UEngineUtil.isNotEmpty(keyword)) {
	//	keyword = initiationActivity.getName().getText();
	//}
	
	//keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
	java.util.Hashtable<String, String> mapPageName4Url = new java.util.Hashtable<String, String>();
	AclManager acl = AclManager.getInstance();
	//java.util.HashMap permission = acl.getPermission(Integer.parseInt(pdr.getBelongingDefinitionId()), loggedUserId);
	java.util.HashMap permission = acl.getPermission(Integer.parseInt(request.getParameter("processDefinition")), loggedUserId);
	
	mapPageName4Url.put("Workitem Page", "showFormContext.jsp");
	mapPageName4Url.put("Workitem Information", GlobalContext.WEB_CONTEXT_ROOT + "/wih/wihDefaultTemplate/showFlowChart.jsp");
	
	/*
	* ê°ì  ê´ë ¨ì§ì í ì­ì  ê´ë ¨
	* Author: CJS
	*/
	//mapPageName4Url.put("Definition Improve", GlobalContext.WEB_CONTEXT_ROOT + "/wih/wihDefaultTemplate/showImproveDefinition.jsp");
	//mapPageName4Url.put("Related Knowledge", "http://www.google.com/search?hl="+loggedUserLocale+"&q=" + keyword + "&lr=");

	String strContentPageName = request.getParameter("contentPageName");
	
	if (!UEngineUtil.isNotEmpty(strContentPageName)) {
		strContentPageName = "Workitem Page";
	}
	
	String strContentUrl = mapPageName4Url.get(strContentPageName);

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("var listStrMenuText = new Array();\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<ul class=\"tabs\">\r\n");

	StringBuffer strJsAllElement = new StringBuffer();
	out.println(createTabMenuItem("Workitem Page", loggedUserLocale, mapPageName4Url.get("Workitem Page")));
	strJsAllElement.append("Workitem Page;");
	
	if (permission.containsKey(AclManager.PERMISSION_VIEW)) {
		out.println(createTabMenuItem("Workitem Information", loggedUserLocale, mapPageName4Url.get("Workitem Information")));
		strJsAllElement.append("Workitem Information;");
	}
/*
	* ê°ì  ê´ë ¨ì§ì í ì­ì  ê´ë ¨
	* Author: CJS
	
	out.println(createTabMenuItem("Definition Improve", loggedUserLocale, mapPageName4Url.get("Definition Improve")));
	strJsAllElement.append("Definition Improve;");
	
	out.println(createTabMenuItem("Related Knowledge", loggedUserLocale, mapPageName4Url.get("Related Knowledge")));
	strJsAllElement.append("Related Knowledge");
*/

      out.write("\r\n");
      out.write("</ul>\r\n");
      out.write("<div id=\"topbtnline\">\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" >\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td height=\"27\">\r\n");
      out.write("\t\t\t\t&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t<img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Icon/arw_gray2.gif\"  align=\"middle\"  border=\"0\" style=\"padding:0 0 3px 0;\">\r\n");
      out.write("\t\t\t\t");
      out.print(request.getParameter("definitionName"));
      out.write("<span id=\"spanInstanceName\"></span><!-- (");
      out.write(") -->\r\n");
      out.write("\t\t\t\t&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t<img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Icon/i_tr.gif\"  align=\"middle\"  border=\"0\">\r\n");
      out.write("\t\t\t\t&nbsp;\r\n");
      out.write("\t\t\t\t");
      out.print(request.getParameter(KeyedParameter.TITLE));
      out.write("\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/wih/wihDefaultTemplate/dis.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvar allElements = \"");
      out.print(strJsAllElement.toString().trim());
      out.write("\";\r\n");
      out.write("/*\r\n");
      out.write("\tif (window.attachEvent) {\r\n");
      out.write("\t\twindow.attachEvent(\r\n");
      out.write("\t\t\t\t\"onload\", \r\n");
      out.write("\t\t\t\tfunction() {\r\n");
      out.write("\t\t\t\t\tchangeDisplayMenuItem(\"");
      out.print(strContentUrl.trim());
      out.write("\", \"");
      out.print(strContentPageName.trim());
      out.write("\"); \r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t);\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\twindow.addEventListener(\"load\", \r\n");
      out.write("\t\t\t\tfunction() { changeDisplayMenuItem(\"");
      out.print(strContentUrl.trim());
      out.write("\", \"");
      out.print(strContentPageName.trim());
      out.write("\"); }, \r\n");
      out.write("\t\t\t\tfalse\r\n");
      out.write("\t\t\t\t);\r\n");
      out.write("\t}\r\n");
      out.write("*/\r\n");
      out.write("\t$(document).ready(function(){\r\n");
      out.write("\t\tchangeDisplayMenuItem(\"");
      out.print(strContentUrl.trim());
      out.write("\", \"");
      out.print(strContentPageName.trim());
      out.write("\"); \r\n");
      out.write("\t});\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\t\t\t</div></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t</thead>\r\n");
      out.write("\t\t<tbody>\r\n");
      out.write("\t\t\t<tr><td height=\"*\" width=\"100%\" valign=\"top\" align=\"center\">\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t<div id=\"divMassageBackGroundArea\"\r\n");
      out.write("\t\t\t\tstyle=\"position: absolute; display:none; width:100%; background-color: #F7F7F7; z-index: 1\"\r\n");
      out.write("\t\t\t\t><iframe  style=\"width: 100%\" height=\"100%\" frameborder=\"0\" scrolling=\"no\" id=\"iframeMassageBackGround\"\r\n");
      out.write("\t\t\t\t></iframe></div>\r\n");
      out.write("\t\t\t\t<div id=\"divMassageArea\" align=\"center\"\r\n");
      out.write("\t\t\t\tstyle=\"position: absolute; display:none; width:100%; background-color: #F7F7F7; z-index: 2\"\r\n");
      out.write("\t\t\t\t></div>\r\n");
      out.write("\t\t\t\t<div id=\"divMassageButton\" align=\"center\" onclick=\"showMassge();\" \r\n");
      out.write("\t\t\t\tstyle=\"position: absolute; display: none; bottom: 20px; right: 20px; color: #FFFFFF; background-color: maroon; \r\n");
      out.write("\t\t\t\tcursor: pointer; z-index: 2; width: 100px;\"\r\n");
      out.write("\t\t\t\t><strong>메시지열기</strong> </div>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<iframe width=\"100%\" height=\"100%\" name=\"iframeWihContent\" id=\"iframeWihContent\"\r\n");
      out.write("\t\t\t\t\tscrolling=\"auto\" marginheight=\"0\" marginwidth=\"0\" frameborder=\"0\" src=\"about:blank\">\r\n");
      out.write("\t\t\t\t</iframe>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t</td></tr>\r\n");
      out.write("\t\t</tbody>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t\r\n");
      out.write("\t<form name=\"formIndexPassValues\" method=\"POST\"  target=\"iframeWihContent\">\r\n");
      out.write("\t\t");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("instanceId"));
      out.write("' name='instanceId' id=\"instanceId\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("executionScope"));
      out.write("' name='executionScope' id=\"executionScope\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("processDefinition"));
      out.write("' name='processDefinition' id=\"processDefinition\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("processDefinition"));
      out.write("' name='definitionVersionId' id=\"definitionVersionId\" />\r\n");
      out.write("\r\n");
      out.write("<input type=hidden value='");
      out.print(initiationProcessDefinition);
      out.write("' name='initiationProcessDefinition' id=\"initiationProcessDefinition\" />\r\n");
      out.write("\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("message"));
      out.write("' name='message' id=\"message\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("tracingTag"));
      out.write("' name='tracingTag' id=\"tracingTag\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("initiatorHumanActivityTracingTag"));
      out.write("' name='initiatorHumanActivityTracingTag'>\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isEventHandler"));
      out.write("' name='isEventHandler' id=\"isEventHandler\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("mainInstanceId"));
      out.write("' name='mainInstanceId' id=\"mainInstanceId\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("eventName"));
      out.write("' name='eventName' id=\"eventName\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("triggerActivityTracingTag"));
      out.write("' name='triggerActivityTracingTag' id=\"triggerActivityTracingTag\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("approvalLineActivityTT"));
      out.write("' name='approvalLineActivityTT' id=\"approvalLineActivityTT\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("mainProcessDefinition"));
      out.write("' name='mainProcessDefinition' id=\"mainProcessDefinition\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("strategyId"));
      out.write("' name='strategyId' id=\"strategyId\" />\r\n");
      out.write("\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getAttribute("taskId") != null ? request.getAttribute("taskId") : request.getParameter("taskId"));
      out.write("' name='taskId' id=\"taskId\" />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getAttribute("initiate") != null ? request.getAttribute("initiate") : request.getParameter("initiate"));
      out.write("' name='initiate' id=\"initiate\" />\r\n");
      out.write("\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("workitemHandler"));
      out.write("' name='workitemHandler' id=\"workitemHandler\" />\r\n");
      out.write("\r\n");
      out.write("\t\t");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isViewMode"));
      out.write("' name='isViewMode' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isCustomizing"));
      out.write("' name='isCustomizing' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isMine"));
      out.write("' name='isMine' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("cus_com"));
      out.write("' name='cus_com' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("editAble"));
      out.write("' name='editAble' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("currentPage"));
      out.write("' name='currentPage' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("type"));
      out.write("' name='type' />\r\n");
      out.write("\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isHistoryView"));
      out.write("' name='isHistoryView' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isExtInitiate"));
      out.write("' name='isExtInitiate' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("fckEditorContents"));
      out.write("' name='fckEditorContents'/>\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("isCopyInitiate"));
      out.write("' name='isCopyInitiate' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("copyProcInstId"));
      out.write("' name='copyProcInstId' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("copyTracingTag"));
      out.write("' name='copyTracingTag' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("requester"));
      out.write("' name='requester' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("form_name"));
      out.write("' name='form_name' />\r\n");
      out.write("\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter("improve_process_defverid"));
      out.write("' name='improve_process_defverid' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter(KeyedParameter.TITLE));
      out.write("' name='");
      out.print(KeyedParameter.TITLE );
      out.write("' />\r\n");
      out.write("<input type=hidden value='");
      out.print(request.getParameter(KeyedParameter.DISPATCHINGOPTION));
      out.write("' name='");
      out.print(KeyedParameter.DISPATCHINGOPTION );
      out.write("' />\r\n");
      out.write("\r\n");
      out.write("\t</form>\r\n");
      out.write("\t");

		} catch(Exception e){
			throw e;
		} finally {
			try {pm.cancelChanges();} catch(Exception ex) { }
			try {pm.remove();} catch(Exception ex) { }
		}
	
      out.write("\r\n");
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
