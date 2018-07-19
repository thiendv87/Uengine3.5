package org.apache.jsp.processparticipant.worklist;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.util.UEngineUtil;
import org.uengine.security.AclManager;
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
import org.uengine.kernel.GlobalContext;
import com.defaultcompany.web.acl.*;
import org.uengine.ui.worklist.filter.WorkListFilterList;
import org.uengine.ui.worklist.filter.WorkListFilter;
import org.uengine.util.UEngineUtil;

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

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(10);
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/indexHead.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/../header.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/../headerMethods.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/../getLoggedUser.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/../../lib/jquery/importJquery.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/indexBodyTop.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/topMenuList.jsp");
    _jspx_dependants.add("/processparticipant/worklist/wl2_menu.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/topFrame/titleBar.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/footer.jsp");
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

	String sUserLevel = null;
	if (loggedUserIsMaster)
	{
		sUserLevel = "platformmanager";
	}
	else if (loggedUserIsAdmin)
	{
		sUserLevel = "companymanager";
	}
	else
	{
		sUserLevel = "default";
	}


      out.write("\r\n");
      out.write("\r\n");
      out.write("<title>Welcome to uEngine BPM</title>\r\n");
      out.write("\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/dojo/dijit/tests/css/dijitTests.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/dojo/dojox/layout/tests/_expando.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/default.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/topmenu/topmenu.css\" />\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/common.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/dojo/dojo/dojo.js\" djConfig=\"parseOnLoad:true, isDebug:false\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/dojo/dijit/tests/_testCommon.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/dojo/dojox/layout/ExpandoPane.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/topmenu.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tdojo.require(\"dojo.data.ItemFileReadStore\");\r\n");
      out.write("\tdojo.require(\"dijit.form.ComboBox\");\r\n");
      out.write("\tdojo.require(\"dijit.Tree\");\r\n");
      out.write("\tdojo.require(\"dijit.layout.AccordionContainer\");\r\n");
      out.write("\tdojo.require(\"dijit.layout.BorderContainer\");\r\n");
      out.write("    dojo.require(\"dijit.Declaration\");\r\n");
      out.write("    dojo.require(\"dojo.data.ItemFileWriteStore\");\r\n");
      out.write("\tdojo.require(\"dijit.Menu\");\r\n");
      out.write("\tdojo.require(\"dojo.parser\");\t// scan page for widgets and instantiate them\r\n");
      out.write("\tdojo.require(\"dijit.layout.LayoutContainer\");   \r\n");
      out.write("    dojo.require(\"dijit.Dialog\");\r\n");
      out.write("    dojo.require(\"dijit.form.Button\");\r\n");
      out.write("    dojo.require(\"dijit.form.TextBox\");\r\n");
      out.write("        \r\n");
      out.write("\tvar global_tn = '';\r\n");
      out.write("\r\n");
      out.write("\tvar req = null;\r\n");
      out.write("\tvar WEB_CONTEXT_ROOT = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("\";\r\n");
      out.write("\tvar WEB_ROOT = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("\";\r\n");
      out.write("\r\n");
      out.write("\tvar getAuthorityList = function() {\r\n");
      out.write("\t\tvar url = WEB_CONTEXT_ROOT + \"/checkWork?userId=");
      out.print(session.getAttribute("loggedUserId"));
      out.write("&todo=newWork\";\r\n");
      out.write("\t\tsubmitAjaxServlet(url, \"Get\", alertNewWork)\r\n");
      out.write("\t}\r\n");
      out.write("\tvar urlNotice = \"http://uengine.org/notice_");
      out.print(loggedUserLocale);
      out.write(".jsp\";\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\tfunction resizeFrame(iframe)\r\n");
      out.write("\t{\r\n");
      out.write("\t\tvar titleBarHeight = 0;\r\n");
      out.write("\t\tif(isIE)\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\tiframe.height = \"100%\"\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\telse\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\ttitleBarHeight = iframe.parentNode.offsetHeight;\r\n");
      out.write("\t\t\tiframe.style.height = (titleBarHeight - 33) + \"px\";\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("</script>\r\n");
      out.write('\r');
      out.write('\n');
      out.write('	');

		int iMuneNum = 1;
		String type = request.getParameter("type");
		String filtering = request.getParameter("filtering");
		String src;
		if ("worklist".equals(type)) {
			src = "wl2_workList.jsp?filtering=" + filtering + "&currentPage=1";
		} else if ("instancelist".equals(type)) {
			src = "wl2_instanceList.jsp?filtering=" + filtering + "&currentPage=1";
		} else {
			src = "wl2_workList.jsp?filtering=0&currentPage=1";
		}
	
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div id=\"bc\" style=\"width:100%; height:100%;\" dojoType=\"dijit.layout.BorderContainer\">\r\n");
      out.write("\t");
      out.write('\r');
      out.write('\n');

String logoName = UEngineUtil.isNotEmpty(loggedUserGlobalCom) ? loggedUserGlobalCom : "bpmass";
String notifiedTaskIdStr = (String)session.getAttribute("notifiedTaskId");
String notifiedTaskId = "";
if(notifiedTaskId!=null){
	notifiedTaskId = notifiedTaskIdStr;
}


      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("#notification{ position:absolute; right:10px; bottom:0px; background-color:white; border:1px solid #9ca3af; border-bottom:none; width:244px; display:none; z-index:99999;}\r\n");
      out.write("#notification #slide_head{ height:26px; background:url(/uengine-web/images/topmenu/slideup_title.gif) no-repeat; padding:5px; color:#484e58; position:relative; z-index:100000;}\r\n");
      out.write("#notification #slide_head #slide_toggle{position:absolute; top:0px; right:25px; width:22px; height:15px;  background:url(/uengine-web/images/topmenu/slideup_title_bt.gif) no-repeat; cursor:pointer;z-index:100001;}\r\n");
      out.write("#notification #slide_head #slide_close{position:absolute; top:0px; right:5px; width:22px; height:15px;  background:url(/uengine-web/images/topmenu/slideup_title_bt02.gif) no-repeat; cursor:pointer;z-index:100001;}\r\n");
      out.write("#notification #slide_body{ display:block;  padding:5px; color:#484e58;}\r\n");
      out.write("</style>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tfunction viewTaskInfo(taskid, instanceId, tracingTag) {\r\n");
      out.write("\t\tvar screenWidth = screen.width;\r\n");
      out.write("\t\tvar screenHeight = screen.Height;\r\n");
      out.write("\t\tvar windowWidth = 950;\r\n");
      out.write("\t\tvar windowHeight = 650;\r\n");
      out.write("\t\tvar window_left = (screenWidth - windowWidth) / 2;\r\n");
      out.write("\t\tvar window_top = (screenHeight - windowHeight) / 2;\r\n");
      out.write("\t\r\n");
      out.write("\t\tvar option = \"left=\" + window_left \r\n");
      out.write("\t\t\t\t+ \", top=\" + window_top \r\n");
      out.write("\t\t\t\t+ \", width=\"+ windowWidth \r\n");
      out.write("\t\t\t\t+ \", height=\" + windowHeight\r\n");
      out.write("\t\t\t\t+ \" ,scrollbars=yes,resizable=yes\";\r\n");
      out.write("\t\tvar url = \"/uengine-web/processparticipant/worklist/workitemHandler.jsp?taskId=\" + taskid \r\n");
      out.write("\t\t\t\t+\"&instanceId=\" + instanceId \r\n");
      out.write("\t\t\t\t+\"&tracingTag=\" + tracingTag;\r\n");
      out.write("\t\tvar openedWih = window.open(url, \"processView\", option);\r\n");
      out.write("\t\topenedWih.onclose = refresh;\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvar USE_NOTIFICATION = true;\r\n");
      out.write("\tvar COOKIE_KEY_NEW_TASKID = \"uEngine.Standalone.newTaskId\";\r\n");
      out.write("\tvar COOKIE_KEY_MSG_VIEW = \"uEngine.Standalone.msgView\";\r\n");
      out.write("\tvar historyTaskId = 0;\r\n");
      out.write("\tvar historyMsgView = true;\r\n");
      out.write("\tvar notificationMessage = null;\r\n");
      out.write("\t\r\n");
      out.write("\tfunction initNotificationMessage(){\r\n");
      out.write("\t\thistoryTaskId = $.cookie(COOKIE_KEY_NEW_TASKID);\r\n");
      out.write("\t\tif(historyTaskId!=null){\r\n");
      out.write("\t\t\thistoryTaskId = parseInt(historyTaskId);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\thistoryMsgView = $.cookie(COOKIE_KEY_MSG_VIEW);\r\n");
      out.write("\t\tif(historyMsgView==null){\r\n");
      out.write("\t\t\thistoryMsgView = true;\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\thistoryMsgView = (historyMsgView == \"true\")?true:false;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$('#notification').find(\"div[id='slide_head']\").find(\"div[id='slide_toggle']\").click(function(){\r\n");
      out.write("\t\t\tvar parent = $(this).parent().parent();\r\n");
      out.write("\t\t\tvar bodyheight = parent.height() - $(this).parent().height();\r\n");
      out.write("\t\t\tvar bottom = parent.css(\"bottom\");\r\n");
      out.write("\t\t\tif(parseInt(bottom) < 0){\r\n");
      out.write("\t\t\t\tparent.animate({\"bottom\": \"+=\"+bodyheight+\"px\"}, \"slow\");\r\n");
      out.write("\t\t\t}else{\r\n");
      out.write("\t\t\t\tparent.animate({\"bottom\": \"-=\"+bodyheight+\"px\"}, \"slow\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$('#notification').find(\"div[id='slide_head']\").find(\"div[id='slide_close']\").click(function(){\r\n");
      out.write("\t\t\tvar parent = $(this).parent().parent();\r\n");
      out.write("\t\t\tif(!parent.is('hidden')){\r\n");
      out.write("\t\t\t\tparent.hide();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tsaveHistoryMsgView(false);\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar jsonObj = loadNotificationMessage();\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(jsonObj){\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\tvar newTaskId = parseInt(jsonObj.TASKID);\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tif((historyTaskId != null && newTaskId == historyTaskId) && historyMsgView == true){\r\n");
      out.write("\t\t\t\tsaveHistoryTaskId(newTaskId);\r\n");
      out.write("\t\t\t\tvar contentData = makeNotificationMessage(jsonObj);\r\n");
      out.write("\t\t\t\tupdateNotificationMessage(contentData);\r\n");
      out.write("\t\t\t\tshowNotificationMessage();\r\n");
      out.write("\t\t\t\t/*\r\n");
      out.write("\t\t\t\tvar notiHead = $('#notification').find(\"div[id='head']\");\r\n");
      out.write("\t\t\t\tvar bodyheight = notiHead.parent().height() - notiHead.height();\r\n");
      out.write("\t\t\t\tnotiHead.parent().css({\"bottom\": \"-\"+bodyheight+\"px\"});\r\n");
      out.write("\t\t\t\t*/\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tsetTimeout('reloadNotificationMessage()',3000);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction saveHistoryTaskId(taskId){\r\n");
      out.write("\t\tif($.cookie(COOKIE_KEY_NEW_TASKID)==null){\r\n");
      out.write("\t\t\t$.cookie(COOKIE_KEY_NEW_TASKID, taskId, {'expires':7,'path':\"/\"});\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\t$.cookie(COOKIE_KEY_NEW_TASKID, null);\r\n");
      out.write("\t\t\t$.cookie(COOKIE_KEY_NEW_TASKID, taskId, {'expires':7,'path':\"/\"});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tsaveHistoryMsgView(true);\r\n");
      out.write("\t\thistoryTaskId = taskId;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction saveHistoryMsgView(bool){\r\n");
      out.write("\t\tif($.cookie(COOKIE_KEY_MSG_VIEW)==null){\r\n");
      out.write("\t\t\t$.cookie(COOKIE_KEY_MSG_VIEW, bool, {'expires':7,'path':\"/\"});\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\t$.cookie(COOKIE_KEY_MSG_VIEW, null);\r\n");
      out.write("\t\t\t$.cookie(COOKIE_KEY_MSG_VIEW, bool, {'expires':7,'path':\"/\"});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction updateNotificationMessage(htmlData){\r\n");
      out.write("\t\tnotificationMessage = htmlData;\r\n");
      out.write("\t\t$('#notification').find(\"div[id='slide_body']\").html(notificationMessage);\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction showNotificationMessage(){\r\n");
      out.write("\t\tif($('#notification').is('hidden')){\r\n");
      out.write("\t\t\t$('#notification').fadeIn(100);\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\t$('#notification').hide();\r\n");
      out.write("\t\t\t$('#notification').fadeIn(100);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction hideNotificationMessage(){\r\n");
      out.write("\t\tif(!$('#notification').is('hidden')){\r\n");
      out.write("\t\t\t$('#notification').fadeOut(100);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction loadNotificationMessage(){\r\n");
      out.write("\t\tvar bodyContent = $.ajax({\r\n");
      out.write("\t\t      url: \"/uengine-web/processparticipant/worklist/wl2_workList_notification.jsp\",\r\n");
      out.write("\t\t      global: false,\r\n");
      out.write("\t\t      type: \"POST\",\r\n");
      out.write("\t\t      dataType: \"json\",\r\n");
      out.write("\t\t      async:false,\r\n");
      out.write("\t\t      success: function(msg){\r\n");
      out.write("\t\t         alert(msg);\r\n");
      out.write("\t\t      }\r\n");
      out.write("\t\t   }\r\n");
      out.write("\t\t).responseText;\r\n");
      out.write("\t\t\r\n");
      out.write("\t\treturn eval(\"(\"+bodyContent+\")\");\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction makeNotificationMessage(jsonObj){\r\n");
      out.write("\t\tvar contentData = \"새로운 업무가 도착하였습니다. <br/><strong>\"\r\n");
      out.write("\t\t\t+jsonObj.NAME+\"-\"+jsonObj.TITLE+\"</strong><br/> 시작하려면 \"\r\n");
      out.write("\t\t\t+\"<a href=javascript:viewTaskInfo('\"+jsonObj.TASKID+\"','\"+jsonObj.INSTID+\"','\"+jsonObj.TRCTAG+\"','NEW');>\"\r\n");
      out.write("\t\t\t+\"여기</a>를 클릭하세요.\"\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\treturn contentData;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction reloadNotificationMessage(){\r\n");
      out.write("\t\t//#notification\r\n");
      out.write("\t\tsetTimeout('reloadNotificationMessage()', 60 * 1000);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar jsonObj = loadNotificationMessage();\r\n");
      out.write("\t\tvar contentData = makeNotificationMessage(jsonObj);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(jsonObj.RESULT==\"TRUE\"){\r\n");
      out.write("\t\t\tvar newTaskId = parseInt(jsonObj.TASKID);\r\n");
      out.write("\r\n");
      out.write("\t\t\tif(historyTaskId < newTaskId){\r\n");
      out.write("\t\t\t\tsaveHistoryTaskId(newTaskId);\r\n");
      out.write("\t\t\t\tupdateNotificationMessage(contentData);\r\n");
      out.write("\t\t\t\tshowNotificationMessage();\r\n");
      out.write("\t\t\t} else if(historyTaskId > newTaskId){\r\n");
      out.write("\t\t\t\thideNotificationMessage();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\thideNotificationMessage();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\tjQuery(document).ready(function(){\r\n");
      out.write("\t\tinitNotificationMessage();\r\n");
      out.write("\t});\r\n");
      out.write("</script>\r\n");
      out.write("<div class=\"loadframe\">\r\n");
      out.write("\t<div class=\"loadinner\">\r\n");
      out.write("\t\t<div class=\"loadbar\">\r\n");
      out.write("\t\t\t<img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/i_dash_load.gif\">\r\n");
      out.write("\t\t</div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	String language = (String)session.getAttribute("loggedUserLocale");
	Authority authority = new Authority();
	
	boolean  isEdition = false;
	if(session.getAttribute("loggedUserIsEdition")!=null){
		isEdition = (Boolean) session.getAttribute("loggedUserIsEdition");
	}

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("var topMenuNum = ");
      out.print(iMuneNum);
      out.write(";\r\n");
      out.write("$(document).ready(function(){\r\n");
      out.write("\t\r\n");
      out.write("\tif(topMenuNum == 0){\r\n");
      out.write("\t\t$(\"#topMenuList > li.back\").hide();\r\n");
      out.write("\t\t$(\"#topMenuItem_1\").removeClass(\"current\");\r\n");
      out.write("\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t$(\"#topMenuList > li\").mouseover(function(){\r\n");
      out.write("\t\tvar targetObj = $(this);\r\n");
      out.write("\t\ttargetObj.addClass(\"current\");\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(topMenuNum == 0){\r\n");
      out.write("\t\t\t$(\"#topMenuList > li.back\").show();\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tif(\"topMenuItem_\"+topMenuNum != targetObj.attr(\"id\")){\r\n");
      out.write("\t\t\t\t$(\"#topMenuItem_\"+topMenuNum).removeClass(\"current\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}).mouseout(function(){\r\n");
      out.write("\t\tvar targetObj = $(this);\r\n");
      out.write("\t\ttargetObj.removeClass(\"current\");\r\n");
      out.write("\t\tif(topMenuNum == 0){\r\n");
      out.write("\t\t\t$(\"#topMenuList > li.back\").hide();\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tif(\"topMenuItem_\"+topMenuNum != targetObj.attr(\"id\")){\r\n");
      out.write("\t\t\t\t$(\"#topMenuItem_\"+topMenuNum).addClass(\"current\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t});\r\n");
      out.write("});\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<div id=\"flashArea\">\r\n");
      out.write("\t<div style=\"width:100%; height:1px; line-height:1px;\"></div>\r\n");
      out.write("\t<div id=\"menu\">\r\n");
      out.write("\t    <ul class=\"menu\" id=\"topMenuList\">\r\n");
      out.write("\t    ");

			if(sUserLevel.equals("default")){
		
      out.write("\r\n");
      out.write("\t        <li id=\"topMenuItem_1\" class=\"");
      out.print((iMuneNum==1)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.worklist", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_2\" class=\"");
      out.print((iMuneNum==2)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/participationProcess/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.participation", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_3\" class=\"");
      out.print((iMuneNum==3)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.process", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        ");
      out.write("\r\n");
      out.write("\t        ");
 if(isEdition){
      out.write("\r\n");
      out.write("\t\t        <li id=\"topMenuItem_4\" class=\"");
      out.print((iMuneNum==4)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processmanager/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.processmanager", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        ");
 }
			}if(sUserLevel.equals("platformmanager")){
			
      out.write("\r\n");
      out.write("\t        <li id=\"topMenuItem_1\" class=\"");
      out.print((iMuneNum==1)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processmanager/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.processmanager", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_2\" class=\"");
      out.print( (iMuneNum==2)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/organizationmanager/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.organization", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t\t");

			}if(sUserLevel.equals("companymanager")){
		
      out.write("\r\n");
      out.write("\t        <li id=\"topMenuItem_1\" class=\"");
      out.print((iMuneNum==1)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.worklist", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_2\" class=\"");
      out.print((iMuneNum==2)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/participationProcess/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.participation", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_3\" class=\"");
      out.print((iMuneNum==3)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.process", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_7\" class=\"");
      out.print((iMuneNum==7)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/monitor/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.monitor", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_4\" class=\"");
      out.print((iMuneNum==4)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processmanager/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.processmanager", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        <li style=\"width:2px; height:40px; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/topmenu/menuLine.gif) no-repeat 0 15px;\"></li>\r\n");
      out.write("\t        <li id=\"topMenuItem_5\" class=\"");
      out.print((iMuneNum==5)? "current": "");
      out.write("\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/organizationmanager/index.jsp\" class=\"parent\"><span>");
      out.print(GlobalContext.getMessageForWeb("title.organization", loggedUserLocale));
      out.write("</span></a></li>\r\n");
      out.write("\t        ");
      out.write("\r\n");
      out.write("\t    ");
	} 
      out.write("\r\n");
      out.write("\t    </ul>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"copyright\" style=\"display:none;\">Copyright &copy; 2010 <a href=\"http://apycom.com/\">Apycom jQuery Menus</a></div>\r\n");
      out.write("\r\n");
      out.write("<div id=\"header\" dojoType=\"dijit.layout.ContentPane\" region=\"top\" style=\"height:74px; border:none; background:url(");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/topbg_default.gif);\">\r\n");
      out.write("\t<div id=\"logo\">\r\n");
      out.write("\t<!--<a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/index.jsp\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/portrait/groups/");
      out.print(logoName );
      out.write("_logo.gif\" width=\"197\" height=\"74\"></a>-->\t\r\n");
      out.write("\t<a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/index.jsp\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/portrait/groups/gpmEngine_logo.png\" width=\"197\" height=\"74\"></a>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<form id=\"titleform\" name=\"titleform\" action=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/logout.jsp\" target=\"_top\" method=\"post\">\r\n");
      out.write("\t\t<div id=\"topline\">\r\n");
      out.write("\t        <div class=\"userbtn\"><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/organizationmanager/userInfoByself.jsp\" target=\"innerworkarea\" class=\"rollover\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/B_EditInfo_");
      out.print(loggedUserLocale);
      out.write(".gif\" /><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/B_EditInfo_on_");
      out.print(loggedUserLocale);
      out.write(".gif\" class=\"over\" /></a>&nbsp;<a href=\"javascript:titleform.submit();\" class=\"rollover\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/B_LogoOut_");
      out.print(loggedUserLocale);
      out.write(".gif\" /><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/B_LogoOut_on_");
      out.print(loggedUserLocale);
      out.write(".gif\" class=\"over\"/></a>\r\n");
      out.write("\t        </div>\r\n");
      out.write("\t        <div class=\"userinfo\">\r\n");
      out.write("\t        \t<span class=\"fontbold\">");
      out.print(loggedUserComName);
      out.write(' ');
      out.write('-');
      out.write(' ');
      out.print(loggedUserFullName);
      out.write("</span>\r\n");
      out.write("\t        </div>\r\n");
      out.write("\t    </div>\r\n");
      out.write("\t</form>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- Notification Message Div -->\r\n");
      out.write("<div id=\"notification\">\r\n");
      out.write("\t<div id=\"slide_head\"><div id=\"slide_toggle\"></div><div id=\"slide_close\"></div><div>알립니다.</div></div>\r\n");
      out.write("\t<div id=\"slide_body\"></div>\r\n");
      out.write("</div>");
      out.write("\r\n");
      out.write("\t<div dojoType=\"dojox.layout.ExpandoPane\" \r\n");
      out.write("\t\t\t\t\tsplitter=\"true\" \r\n");
      out.write("\t\t\t\t\tduration=\"125\"\r\n");
      out.write("\t\t\t\t\tregion=\"left\" \r\n");
      out.write("\t\t\t\t\ttitle=\"");
      out.print(GlobalContext.getMessageForWeb("WorkList", loggedUserLocale));
      out.write("\" \r\n");
      out.write("\t\t\t\t\tid=\"leftPane\" \r\n");
      out.write("\t\t\t\t\tmaxWidth=\"275\" \r\n");
      out.write("\t\t\t\t\tstyle=\"width: 250px; background: #fafafa;\">\r\n");
      out.write("\t\t");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	//WorkListFilterList wfl = WorkListFilterList.load();
	//WorkListFilter[] workitemFilters = wfl.getWorkItemFilters();

      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("/*remove Add filter*/\r\n");
      out.write("/* \r\n");
      out.write("\tfunction addFilter(type){\r\n");
      out.write("\t\tvar url = \"../commonfilter/dlgAddFilter.jsp?type=\"+type;\r\n");
      out.write("\t\twindow.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');\r\n");
      out.write("\t}\r\n");
      out.write("*/\r\n");
      out.write("\t\r\n");
      out.write("\tfunction deleteFilter(UID){\r\n");
      out.write("\t\tresult = confirm(\"Are you sure to delete this filter?\");\r\n");
      out.write("\t\tif(result==true){\r\n");
      out.write("\t\t\tvar url = \"../commonfilter/deleteFilter.jsp?filterUID=\"+UID;\r\n");
      out.write("\t\t\twindow.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("$(function() {\t\r\n");
      out.write("    $(\"#accordion\").accordion({\r\n");
      out.write("    \tfillSpace: true\r\n");
      out.write("    });\r\n");
      out.write("});\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<div style=\"width: 100%; height:100%; overflow: hidden; border:none; margin:0px; padding:0px;\">\r\n");
      out.write("\t<div class=\"menuList\">\r\n");
      out.write("\t<!-- accordion title 제거\r\n");
      out.write("\t<h3><a href=\"#\">");
      out.print(GlobalContext.getMessageForWeb("msg.work_items", loggedUserLocale));
      out.write("</a></h3>\r\n");
      out.write("\t-->\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<ul>\r\n");
      out.write("\t\t    \t<li><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/wl2_workList.jsp?filtering=0&currentPage=1\" target=\"innerworkarea\">");
      out.print(GlobalContext.getMessageForWeb("msg.open", loggedUserLocale));
      out.write("</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t\t<ul>\r\n");
      out.write("\t\t    \t<li><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/wl2_workList.jsp?filtering=5&currentPage=1\" target=\"innerworkarea\">");
      out.print(GlobalContext.getMessageForWeb("msg.save", loggedUserLocale));
      out.write("</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t\t<ul>\r\n");
      out.write("\t\t    \t<li><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/wl2_workList.jsp?filtering=1&currentPage=1\" target=\"innerworkarea\">");
      out.print(GlobalContext.getMessageForWeb("msg.Closed", loggedUserLocale));
      out.write("</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t\t<ul>\r\n");
      out.write("\t\t    \t<li><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/wl2_workList.jsp?filtering=2&currentPage=1\" target=\"innerworkarea\">");
      out.print(GlobalContext.getMessageForWeb("msg.Cancelled", loggedUserLocale));
      out.write("</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t\t<ul>\r\n");
      out.write("\t\t    \t<li><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/wl2_workList.jsp?filtering=3&currentPage=1\" target=\"innerworkarea\">");
      out.print(GlobalContext.getMessageForWeb("msg.Reserved", loggedUserLocale));
      out.write("</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t\t<ul>\r\n");
      out.write("\t\t    \t<li><a href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/wl2_workList.jsp?filtering=4&currentPage=1\" target=\"innerworkarea\">");
      out.print(GlobalContext.getMessageForWeb("msg.Time Over", loggedUserLocale));
      out.write("</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>");
      out.write("\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div dojoType=\"dijit.layout.ContentPane\" region=\"center\" id=\"centerPane\" style=\"overflow: hidden;\">\r\n");
      out.write("\t\t");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tfunction changeTitle(iframe)\r\n");
      out.write("\t{\r\n");
      out.write("\t\tdocument.getElementById(\"divPageTitle\").innerHTML = iframe.contentWindow.document.title;\r\n");
      out.write("\t\tvar navi = iframe.contentWindow.document.navigation;\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(navi)\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\tvar navis = navi.split(\";\");\r\n");
      out.write("\t\t\tvar sNavi = \"\";\r\n");
      out.write("\r\n");
      out.write("\t\t\tfor(var i = 0; i < navis.length; i++)\r\n");
      out.write("\t\t\t{\r\n");
      out.write("\t\t\t\tsNavi += \" <img src=\\\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/i_blue03.gif\\\"> \" + navis[i];\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tdocument.getElementById(\"divPageNavi\").innerHTML = sNavi;\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\tresizeFrame(iframe);\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("<div class=\"pagrtitlebg\" id=\"divPageTitleBar\">\r\n");
      out.write("\t<div class=\"pagetitleicon\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/lc05711.gif\"></div>\r\n");
      out.write("\t<div class=\"pagetitletitle\" id=\"divPageTitle\"></div>\r\n");
      out.write("\t<div class=\"pagrtitlenavi\" id=\"divPageNavi\"></div>\r\n");
      out.write("</div>");
      out.write("\r\n");
      out.write("\t    <iframe onresize=\"resizeFrame(this);\" onload=\"changeTitle(this);\" style=\"width: 100%; height: 100%; padding-bottom: 30px;\" src=\"");
      out.print(src );
      out.write("\" name=\"innerworkarea\" frameborder=\"0\"></iframe>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div id=\"footer\" style=\"border:solid 0px white; background-color: #F0F0F0;\" dojotype=\"dijit.layout.ContentPane\" region=\"bottom\">\r\n");
      out.write("        ");
      out.write("\r\n");
      out.write("<div style=\"margin-top: -5px; margin-right:30; text-align: right;\"><!-- position:absolute; bottom:-2px; right:30px; border:solid 0px white; -->\r\n");
      out.write("<img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/tailbtn.gif\" width=\"398\" height=\"30\" usemap=\"#Map\" />\r\n");
      out.write("<map name=\"Map\" id=\"Map\"><area shape=\"rect\" coords=\"295,7,388,24\" href=\"http://uengine.org/web/guest/home\" target=\"_blank\" /></map>\r\n");
      out.write("</div>");
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
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
