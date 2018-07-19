package org.apache.jsp.monitor;

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
import org.uengine.persistence.dao.*;
import org.uengine.webservices.worklist.*;
import org.uengine.ui.list.datamodel.DataMap;
import org.uengine.ui.list.datamodel.DataList;
import org.uengine.ui.list.datamodel.QueryCondition;
import org.uengine.ui.list.util.HttpUtils;
import org.uengine.kernel.viewer.gantt.GanttChartUtil;
import com.defaultcompany.web.gantt.dao.GanttChartWebDAO;
import org.springframework.web.bind.ServletRequestUtils;

public final class ganttChart_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(6);
    _jspx_dependants.add("/monitor/../common/header.jsp");
    _jspx_dependants.add("/monitor/../common/headerMethods.jsp");
    _jspx_dependants.add("/monitor/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/monitor/../lib/jquery/importJquery.jsp");
    _jspx_dependants.add("/monitor/../common/styleHeader.jsp");
    _jspx_dependants.add("/WEB-INF/tlds/taglibs_bpm.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.release();
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
      org.uengine.processmanager.ProcessManagerFactoryBean processManagerFactory = null;
      synchronized (application) {
        processManagerFactory = (org.uengine.processmanager.ProcessManagerFactoryBean) _jspx_page_context.getAttribute("processManagerFactory", PageContext.APPLICATION_SCOPE);
        if (processManagerFactory == null){
          processManagerFactory = new org.uengine.processmanager.ProcessManagerFactoryBean();
          _jspx_page_context.setAttribute("processManagerFactory", processManagerFactory, PageContext.APPLICATION_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');

    String viewerType = reqMap.getString("viewerType", "day");
    String pdId = reqMap.getString("processDefinitionId", "");
    String pdName = reqMap.getString("processDefinitionName", "");
    String orderby = reqMap.getString("orderby", "instance");
    String endpoint = new String(reqMap.getString("endpoint", "").getBytes("ISO-8859-1"),"UTF-8");
    String endpoint_display= new String(reqMap.getString("endpoint_display", "").getBytes("ISO-8859-1"),"UTF-8");
    
    String strategyId = null;//reqMap.getString("strategyId", "-1");
    String isOnlyStrategyInstance = ServletRequestUtils.getStringParameter(request, "isOnlyStrategyInstance", "");
    
    // filter add start
    String status = reqMap.getString("status", "");
    String partCode = reqMap.getString("partCode", "");
    String roleCode = reqMap.getString("roleCode", "");
    //String tag = new String(reqMap.getString("tag", "").getBytes("ISO-8859-1"),"UTF-8");
    String tag = reqMap.getString("tag", "");
    String filter = reqMap.getString("filter", "");
    String filterName = reqMap.getString("filterName", "");
    // filter add end
    
    ProcessManagerRemote pm = processManagerFactory.getProcessManager();//ForReadOnly();
    if(isOnlyStrategyInstance.equals("on")){
        pdId = pm.getProcessDefinitionIdByAlias("delStrategy")+";"
           + pm.getProcessDefinitionIdByAlias("addStrategy")+";"
           + pm.getProcessDefinitionIdByAlias("editStrategy");
    }
    
    int intPageCnt = 10;
    int nPagesetSize = 10;
    int currentPage = reqMap.getInt("CURRENTPAGE", 1);
    int totalCount = 0; 
    
    int s_mondif = reqMap.getInt("mondif", -1);
    
    try{
        GanttChartWebDAO ganttChartWebDao = new GanttChartWebDAO(DefaultConnectionFactory.create());
        ganttChartWebDao.setStatus(status);
        ganttChartWebDao.setPartCode(partCode);
        ganttChartWebDao.setRoleCode(roleCode);
        ganttChartWebDao.setTag(tag);
        ganttChartWebDao.init(s_mondif, endpoint, pdId, loggedUserGlobalCom, orderby, loggedUserIsMaster,strategyId);
        totalCount = ganttChartWebDao.getGanttChartCount();
    }catch(Exception e){
        e.printStackTrace();
    }
    
    Calendar now = Calendar.getInstance();
    now.add(Calendar.YEAR, s_mondif+1); 

      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>");
      out.print(GlobalContext.getMessageForWeb("View the progress of the Instance", loggedUserLocale) );
      out.write("</title>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
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
      out.write("\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/style/ganttchart.css\" />\r\n");
      out.write("<style type=\"text/css\" rel=\"stylesheet\">\r\n");
      out.write("    a:link {color:#000;}\r\n");
      out.write("    html body {\r\n");
      out.write("        margin: 10px;\r\n");
      out.write("    }\r\n");
      out.write("</style>\r\n");
      out.write("<!-- CSS Files -->\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../scripts/formActivity.js.jsp" + (("../scripts/formActivity.js.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("rmClsName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(rmClsName), request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("$(document).ready(function() {\r\n");
      out.write("\tgetGanttCharTitleList(\"");
      out.print(pdId);
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(s_mondif);
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(orderby);
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(endpoint);
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(currentPage );
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(strategyId );
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(intPageCnt );
      out.write("\", \"");
      out.print(status);
      out.write("\", \"");
      out.print(partCode);
      out.write("\", \"");
      out.print(roleCode);
      out.write("\", \"");
      out.print(tag);
      out.write("\");\r\n");
      out.write("\tlistViewer(\"");
      out.print(viewerType);
      out.write("\");\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function searchGo( i ) {\r\n");
      out.write("\tdocument.refreshForm.mondif.value='");
      out.print((s_mondif));
      out.write("'*1 + i;\r\n");
      out.write("\tdocument.refreshForm.CURRENTPAGE.value=1;\r\n");
      out.write("\tdocument.refreshForm.submit();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function selectProcess() {\r\n");
      out.write("\tvar url = \"../processparticipant/commonfilter/selectProcessDefinition_frame.jsp\";\r\n");
      out.write("\tvar strOption = \"width=500,height=300\";\r\n");
      out.write("\tstrOption += \"center:on;scroll:no;status:off;resizable:no\";\r\n");
      out.write("\tvar arrResult = new Array(2);\r\n");
      out.write("\tarrResult = window.open(url , \"\", strOption);\r\n");
      out.write("}\r\n");
      out.write("\t\r\n");
      out.write("function setProcess(processDefinition, processDefName) {\r\n");
      out.write("\t$(\"input[name=processDefValue]\").val(processDefinition);\r\n");
      out.write("\t$(\"input[name=processDefName]\").val(processDefName);\r\n");
      out.write("}\r\n");
      out.write("\t\r\n");
      out.write("function search() {\r\n");
      out.write("\tvar processDefValue = document.getElementsByName(\"processDefValue\")[0];\r\n");
      out.write("\tvar displayEndpoints_display = document.getElementsByName(\"displayEndpoints_display\")[0];\r\n");
      out.write("\tvar endpoints=document.getElementsByName(\"displayEndpoints\")[0];\r\n");
      out.write("\r\n");
      out.write("\tif (displayEndpoints_display.value != \"\"){\r\n");
      out.write("\t\tdocument.refreshForm.endpoint.value = endpoints.value;\r\n");
      out.write("\t\tdocument.refreshForm.endpoint_display.value=displayEndpoints_display.value;\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\tdocument.refreshForm.endpoint.value = \"\";\r\n");
      out.write("        document.refreshForm.endpoint_display.value = \"\";\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tif (processDefValue.value != \"\"){\r\n");
      out.write("\t\tdocument.refreshForm.processDefinitionId.value = $(\"input[name=processDefValue]\").val();\r\n");
      out.write("\t\tdocument.refreshForm.processDefinitionName.value = $(\"input[name=processDefName]\").val();\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\tdocument.refreshForm.processDefinitionId.value = \"\";\r\n");
      out.write("\t\tdocument.refreshForm.processDefinitionName.value = \"\";\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tdocument.refreshForm.submit();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function goPage(page){\r\n");
      out.write("\trefreshForm.CURRENTPAGE.value = page;\r\n");
      out.write("\trefreshForm.submit();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function openProcess(instanceId){\r\n");
      out.write("\tvar option = \"width=950,height=650,scrollbars=yes,resizable=yes\";\r\n");
      out.write("\tvar url = \"../processparticipant/viewProcessInformation.jsp?omitHeader=yes&instanceId=\"+instanceId;\r\n");
      out.write("\twindow.open(url, \"\", option)\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function animateDiv(target,widthStr){\r\n");
      out.write("    $(target).animate( { width:widthStr }, { queue:false, duration:200 } )\r\n");
      out.write("        .animate( { fontSize:\"24px\" }, 2000 )\r\n");
      out.write("        .animate( { borderRightWidth:\"15px\" }, 2000);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function listViewer(type){\r\n");
      out.write("\t$(\"#viewerType\").val(type);\r\n");
      out.write("\tif(type==\"day\"){\t\t\t\r\n");
      out.write("\t\tdocument.getElementById(\"day\").style.backgroundImage = \"url(../images/Common/tabOn.gif)\";\r\n");
      out.write("\t\tdocument.getElementById(\"week\").style.backgroundImage = \"url(../images/Common/tabOff.gif)\";\r\n");
      out.write("\t\tdocument.getElementById(\"month\").style.backgroundImage = \"url(../images/Common/tabOff.gif)\";\r\n");
      out.write("\t\tgetGanttCharList('");
      out.print(pdId);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(s_mondif);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(orderby);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(endpoint);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(currentPage );
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(strategyId);
      out.write("','day','");
      out.print(intPageCnt );
      out.write("', \"");
      out.print(status);
      out.write("\", \"");
      out.print(partCode);
      out.write("\", \"");
      out.print(roleCode);
      out.write("\", \"");
      out.print(tag);
      out.write("\");\r\n");
      out.write("\t\t\r\n");
      out.write("\t}else if(type==\"week\"){\r\n");
      out.write("\t\tdocument.getElementById(\"day\").style.backgroundImage = \"url(../images/Common/tabOff.gif)\";\r\n");
      out.write("\t\tdocument.getElementById(\"week\").style.backgroundImage = \"url(../images/Common/tabOn.gif)\";\r\n");
      out.write("\t\tdocument.getElementById(\"month\").style.backgroundImage = \"url(../images/Common/tabOff.gif)\";\r\n");
      out.write("\t\tgetGanttCharList('");
      out.print(pdId);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(s_mondif);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(orderby);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(endpoint);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(currentPage );
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(strategyId);
      out.write("','week','");
      out.print(intPageCnt );
      out.write("', \"");
      out.print(status);
      out.write("\", \"");
      out.print(partCode);
      out.write("\", \"");
      out.print(roleCode);
      out.write("\", \"");
      out.print(tag);
      out.write("\");\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\tdocument.getElementById(\"day\").style.backgroundImage = \"url(../images/Common/tabOff.gif)\";\r\n");
      out.write("\t\tdocument.getElementById(\"week\").style.backgroundImage = \"url(../images/Common/tabOff.gif)\";\r\n");
      out.write("\t\tdocument.getElementById(\"month\").style.backgroundImage = \"url(../images/Common/tabOn.gif)\";\r\n");
      out.write("\t\tgetGanttCharList('");
      out.print(pdId);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(s_mondif);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(orderby);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(endpoint);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(currentPage );
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(strategyId);
      out.write("','month','");
      out.print(intPageCnt );
      out.write("', \"");
      out.print(status);
      out.write("\", \"");
      out.print(partCode);
      out.write("\", \"");
      out.print(roleCode);
      out.write("\", \"");
      out.print(tag);
      out.write("\");\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\t\r\n");
      out.write("function getGanttCharTitleList(\r\n");
      out.write("\t\ttempProcessDefinition,\r\n");
      out.write("\t\ttempMondif,\r\n");
      out.write("\t\ttempOrderby,\r\n");
      out.write("\t\ttempEndpoint,\r\n");
      out.write("\t\ttempCURRENTPAGE,\r\n");
      out.write("\t\ttempStrategyId,\r\n");
      out.write("\t\ttempPageCount,\r\n");
      out.write("\t\ttempStatus,\r\n");
      out.write("\t\ttempPartCode,\r\n");
      out.write("\t\ttempRoleCode,\r\n");
      out.write("\t\ttempTag\r\n");
      out.write(") {\r\n");
      out.write("\t$.post(\r\n");
      out.write("\t\t\t\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/ganttChartService\",\r\n");
      out.write("\t\t\t{\r\n");
      out.write("\t\t\t\t\"ProcessDefinition\" : tempProcessDefinition,\r\n");
      out.write("\t\t\t\t\"viewYear\"          : tempMondif,\r\n");
      out.write("\t\t\t\t\"Orderby\"           : tempOrderby,\r\n");
      out.write("\t\t\t\t\"Endpoint\"          : tempEndpoint,\r\n");
      out.write("\t\t\t\t\"CURRENTPAGE\"       : tempCURRENTPAGE,\r\n");
      out.write("\t\t\t\t\"strategyId\"\t\t: tempStrategyId,\r\n");
      out.write("\t\t\t\t\"type\"              : \"title\",\r\n");
      out.write("\t\t\t\t\"intPageCnt\"        : tempPageCount,\r\n");
      out.write("\t\t\t\t\"status\"            : tempStatus,\r\n");
      out.write("\t\t\t\t\"partCode\"          : tempPartCode,\r\n");
      out.write("\t\t\t\t\"roleCode\"          : tempRoleCode,\r\n");
      out.write("\t\t\t\t\"tag\"               : tempTag\r\n");
      out.write("\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tfunction(resultString) {\t\r\n");
      out.write("\t\t\t\t//drawProcessFlowchart(resultString, tmpViewOption, tmpInstanceId, tmpProcessDefinition, tmpDefinitionVersionId);\r\n");
      out.write("\t\t\t\tvar divChartArea = document.getElementById(\"ganttChartTitleArea\");\r\n");
      out.write("\t\t\t\tdivChartArea.innerHTML = resultString;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t);\r\n");
      out.write("}\r\n");
      out.write("\t\r\n");
      out.write("function getGanttCharList(\r\n");
      out.write("\t\ttempProcessDefinition,\r\n");
      out.write("\t\ttempMondif,\r\n");
      out.write("\t\ttempOrderby,\r\n");
      out.write("\t\ttempEndpoint,\r\n");
      out.write("\t\ttempCURRENTPAGE,\r\n");
      out.write("\t\ttempStrategyId,\r\n");
      out.write("\t\tviewMode,\r\n");
      out.write("\t\ttempPageCount,\r\n");
      out.write("\t\ttempStatus,\r\n");
      out.write("        tempPartCode,\r\n");
      out.write("        tempRoleCode,\r\n");
      out.write("        tempTag\r\n");
      out.write("\t) {\r\n");
      out.write("\t$.post(\r\n");
      out.write("\t\t\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/ganttChartService\",\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\t\"ProcessDefinition\" : tempProcessDefinition,\r\n");
      out.write("\t\t\t\"viewYear\"          : tempMondif,\r\n");
      out.write("\t\t\t\"Orderby\"           : tempOrderby,\r\n");
      out.write("\t\t\t\"Endpoint\"          : tempEndpoint,\r\n");
      out.write("\t\t\t\"CURRENTPAGE\"       : tempCURRENTPAGE,\r\n");
      out.write("\t\t\t\"strategyId\"\t\t: tempStrategyId,\r\n");
      out.write("\t\t\t\"type\"              : \"list\",\r\n");
      out.write("\t\t\t\"viewMode\"          : viewMode,\r\n");
      out.write("\t\t\t\"intPageCnt\"        : tempPageCount,\r\n");
      out.write("\t\t\t\"status\"            : tempStatus,\r\n");
      out.write("            \"partCode\"          : tempPartCode,\r\n");
      out.write("            \"roleCode\"          : tempRoleCode,\r\n");
      out.write("            \"tag\"               : tempTag\r\n");
      out.write("\t\t},\t\t\t\t\r\n");
      out.write("\t\tfunction(resultString) {\r\n");
      out.write("\t\t\tvar widthTemp=document.getElementById(\"ganttListParent\");\t\t\t\t\t\r\n");
      out.write("\t\t\tvar divChartArea = document.getElementById(\"idsu_map\");\t\t\t\t\t\r\n");
      out.write("\t\t\tdivChartArea.innerHTML = resultString;\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tdocument.getElementById(\"curBarDiv\").style.height=document.getElementById(\"ganttListParent\").offsetHeight-1;\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tif (viewMode != \"month\") {\r\n");
      out.write("\t\t\t\t$(\"#ganttable\").draggable({                                          \r\n");
      out.write("\t\t\t\t    axis: \"x\",\r\n");
      out.write("\t\t\t\t    containment:  [-6540, 0, 460, 0] // x1, y1, x2, y2 (1:start, 2:end)\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t\t$(\"#ganttChartTitleArea\").css(\"margin-right:1px;\");\r\n");
      out.write("\t\t\t} else {\r\n");
      out.write("\t\t\t\t$(\"#ganttChartTitleArea\").css(\"\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t);\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("<form name=\"form\" method=\"get\" action=\"\" target=\"\">\r\n");

if (filter.equals("yes")) {

      out.write("\r\n");
      out.write("    <span class=\"sectiontitle\"><b>Filter Name : ");
      out.print(filterName );
      out.write("</b></span>\r\n");
      out.write("    <table width=\"100%\" border=\"0\" cellpadding=\"0\"  cellspacing=\"0\" >\r\n");
      out.write("       <colgroup>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"18%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"9%\"/>\r\n");
      out.write("           <col width=\"*\"/>\r\n");
      out.write("       </colgroup>\r\n");
      out.write("        <tr>\r\n");
      out.write("             <td  colspan=\"10\" bgcolor=\"#97aac6\" height=\"2\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">Status</td>\r\n");
      out.write("            <td class=\"formcon\">\r\n");
      out.write("                ");
      out.print(status );
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("            <td class=\"formtitle\">Definition</td>\r\n");
      out.write("            <td class=\"formcon\">\r\n");
      out.write("                ");
      out.print(pdName );
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("            <td class=\"formtitle\">Part Code</td>\r\n");
      out.write("            <td class=\"formcon\">\r\n");
      out.write("                ");
      out.print(partCode );
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("            <td class=\"formtitle\">Role Code</td>\r\n");
      out.write("            <td class=\"formcon\">\r\n");
      out.write("                ");
      out.print(roleCode );
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("            <td class=\"formtitle\">Tag</td>\r\n");
      out.write("            <td class=\"formcon\">\r\n");
      out.write("                ");
      out.print(tag );
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("             <td  colspan=\"10\" bgcolor=\"#97aac6\" height=\"2\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");

} else {

      out.write("\r\n");
      out.write("\t<table width=\"100%\" border=\"0\" cellpadding=\"0\"  cellspacing=\"0\" >\r\n");
      out.write("\t   <colgroup>\r\n");
      out.write("\t\t   <col width=\"15%\"/>\r\n");
      out.write("\t\t   <col width=\"30%\"/>\r\n");
      out.write("\t\t   <col width=\"15%\"/>\r\n");
      out.write("\t\t   <col width=\"30%\"/>\r\n");
      out.write("\t\t   <col width=\"*\"/>\r\n");
      out.write("\t   </colgroup>\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t         <td  colspan=\"5\" bgcolor=\"#97aac6\" height=\"2\"></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("gantt_select_user", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\">\r\n");
      out.write("\t            <input type=\"hidden\" name=\"displayEndpoints__which_is_xml_value\" id=\"displayEndpoints__which_is_xml_value\" />\r\n");
      out.write("\t            <input type=\"hidden\" name=\"displayEndpoints\" id=\"displayEndpoints\" />\r\n");
      out.write("\t        \t<input type=\"text\" name=\"displayEndpoints_display\" id=\"displayEndpoints_display\" value='");
      out.print(endpoint_display);
      out.write("' style=\"border:#CCC 1px solid;background:#F3F3F3;\" readonly=\"readonly\"/>\r\n");
      out.write("\t\t\t\t<img name=\"displayEndpoints\" style=\"cursor:pointer;\" align=\"middle\"\r\n");
      out.write("\t\t\t\t\tsrc=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processmanager/images/Toolbar-toblock.gif\" onclick=\"searchPeopleObj(this, true);\" title=\"endpointer select\" />\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t        <td class=\"formtitle\" style=\"width:250px;\">");
      out.print(GlobalContext.getMessageForWeb("gantt_select_definition", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\">\t\r\n");
      out.write("\t            <input type=\"text\" name=\"processDefName\" id=\"processDefName\" value='");
      out.print(pdName);
      out.write("' style=\"border:#CCC 1px solid;background:#F3F3F3;\" readonly=\"readonly\"/>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"processDefValue\" id=\"processDefValue\" value='");
      out.print(pdId);
      out.write("' />\r\n");
      out.write("\t\t\t\t<img align=\"middle\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processmanager/images/Toolbar-toblock.gif\" onclick=\"selectProcess();\" style=\"cursor: pointer;\" title=\"definition select\" />\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t\t<td class=\"formcon\" width=\"100\" align=\"right\">\r\n");
      out.write("\t            <table>\r\n");
      out.write("\t                <tr>\r\n");
      out.write("\t                    <td class=\"gBtn\">\r\n");
      out.write("\t                        <a href=\"javascript:search()\" >\r\n");
      out.write("\t                        \t<span>");
      out.print(GlobalContext.getMessageForWeb("search", loggedUserLocale) );
      out.write("</span>\r\n");
      out.write("\t                        </a>\r\n");
      out.write("\t                    </td>\r\n");
      out.write("\t                </tr>\r\n");
      out.write("\t            </table>\r\n");
      out.write("\t\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t         <td  colspan=\"5\" bgcolor=\"#97aac6\" height=\"2\"></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t</table>\r\n");

}

      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("\t\r\n");
      out.write("<br />\r\n");
      out.write("\t\r\n");
      out.write("<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("        \t<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                 <tr>\r\n");
      out.write("                     <td><span onClick=\"searchGo(-1);\" style=\"cursor: pointer;\"><img src=\"../images/Common/skip-back.gif\" border=\"0\"></span>\r\n");
      out.write("                        <span style=\"font-size:18px; font-weight:bold; line-height:16px; letter-spacing:-1;\">");
      out.print(String.valueOf(now.get(Calendar.YEAR)) );
      out.write("</span>\r\n");
      out.write("                        <span onClick=\"searchGo(+1);\" style=\"cursor: pointer;\"><img src=\"../images/Common/skip.gif\" border=\"0\"></span></td>         \r\n");
      out.write("                 </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("       \t</td>\r\n");
      out.write("       \t<td align=\"right\">\r\n");
      out.write("       \t    <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\r\n");
      out.write("\t\t\t    <tr>\r\n");
      out.write("\t\t\t        <td align=\"right\">\r\n");
      out.write("\t\t\t            <table>\r\n");
      out.write("\t\t\t                <tr>\r\n");
      out.write("\t\t\t                    <td width=10 height=10><img src=\"../processmanager/images/ganttbar_greenBall.gif\"></td>\r\n");
      out.write("\t\t\t                    <td style=\"font-size:11px;\"> ");
      out.print(GlobalContext.getLocalizedMessageForWeb("Now_Working", loggedUserLocale, "Now Working") );
      out.write(" &nbsp;</td>\r\n");
      out.write("\t\t\t                    <td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_grayBall.gif\"></td>\r\n");
      out.write("\t\t\t                    <td style=\"font-size:11px;\"> ");
      out.print(GlobalContext.getLocalizedMessageForWeb("Work_Done", loggedUserLocale, "Work Done") );
      out.write(" &nbsp;</td>\r\n");
      out.write("\t\t\t                    <td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_orangeBall.gif\"></td>\r\n");
      out.write("\t\t\t                    <td style=\"font-size:11px;\"> ");
      out.print(GlobalContext.getLocalizedMessageForWeb("Delayed_Still_Working", loggedUserLocale, "Delayed/Still Working") );
      out.write(" &nbsp;</td>\r\n");
      out.write("\t\t\t                    <td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_blueBall.gif\"></td>\r\n");
      out.write("\t\t\t                    <td style=\"font-size:11px;\">");
      out.print(GlobalContext.getLocalizedMessageForWeb("Time_left_to_due_date", loggedUserLocale, "Time left to due date"));
      out.write("</td>\r\n");
      out.write("\t\t\t                    <td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_redBall.gif\"></td>\r\n");
      out.write("                                <td style=\"font-size:11px;\">");
      out.print(GlobalContext.getLocalizedMessageForWeb("Cancelled_Working", loggedUserLocale, "Cancelled Working"));
      out.write("</td>\r\n");
      out.write("\t\t\t                </tr>\r\n");
      out.write("\t\t\t            </table>\r\n");
      out.write("\t\t\t        </td>\r\n");
      out.write("\t\t\t    </tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("       \t</td>\r\n");
      out.write("\t\t<td align=\"right\">\r\n");
      out.write("\t\t\t<table>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td width=\"96\" height=\"23\" id=\"day\" style=\"background:url(../images/Common/tabOff.gif) no-repeat;cursor:pointer;\" onclick=\"listViewer('day');\" align=\"center\"><b>day</b></td>\r\n");
      out.write("\t\t\t\t\t<td width=\"96\" height=\"23\" id=\"week\" style=\"background:url(../images/Common/tabOn.gif) no-repeat;cursor:pointer;\" onclick=\"listViewer('week');\" align=\"center\"><b>week</b></td>\r\n");
      out.write("\t\t\t\t\t<td width=\"96\" height=\"23\" id=\"month\" style=\"background:url(../images/Common/tabOff.gif) no-repeat;cursor:pointer;\" onclick=\"listViewer('month');\" align=\"center\"><b>month</b></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\t\r\n");
      out.write("<!-- Gantt Chart Start -->\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <colgroup>\r\n");
      out.write("        <col width=\"450px\"/>\r\n");
      out.write("        <col width=\"1200px\"/>\r\n");
      out.write("    </colgroup>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\t\t\t\t\r\n");
      out.write("\t\t\t<div id=\"ganttChartTitleArea\"></div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td valign=\"top\" id=\"ganttListParent\">\r\n");
      out.write("\t\t\t<div style=\"position:relative; width:100%;\">\r\n");
      out.write("\t\t\t\t<div id=\"idsu_map\" style=\"position:absolute;left:0px;overflow:hidden;cursor:move;width:100%;\">\r\n");
      out.write("\t\t\t\t\t<!-- div id=\"ganttChartArea\"></div-->\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<!-- Gantt Chart End -->\r\n");
      out.write("\r\n");
      out.write("<br />\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td align=\"right\">\r\n");
      out.write("\t\t\t<table>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td width=10 height=10><img src=\"../processmanager/images/ganttbar_greenBall.gif\"></td>\r\n");
      out.write("\t\t\t\t\t<td style=\"font-size:11px;\"> ");
      out.print(GlobalContext.getLocalizedMessageForWeb("Now_Working", loggedUserLocale, "Now Working") );
      out.write(" &nbsp;</td>\r\n");
      out.write("\t\t\t\t\t<td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_grayBall.gif\"></td>\r\n");
      out.write("\t\t\t\t\t<td style=\"font-size:11px;\"> ");
      out.print(GlobalContext.getLocalizedMessageForWeb("Work_Done", loggedUserLocale, "Work Done") );
      out.write(" &nbsp;</td>\r\n");
      out.write("\t\t\t\t\t<td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_orangeBall.gif\"></td>\r\n");
      out.write("\t\t\t\t\t<td style=\"font-size:11px;\"> ");
      out.print(GlobalContext.getLocalizedMessageForWeb("Delayed_Still_Working", loggedUserLocale, "Delayed/Still Working") );
      out.write(" &nbsp;</td>\r\n");
      out.write("\t\t\t\t\t<td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_blueBall.gif\"></td>\r\n");
      out.write("\t\t\t\t\t<td style=\"font-size:11px;\">");
      out.print(GlobalContext.getLocalizedMessageForWeb("Time_left_to_due_date", loggedUserLocale, "Time left to due date"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td width=10 height=10 ><img src=\"../processmanager/images/ganttbar_redBall.gif\"></td>\r\n");
      out.write("                    <td style=\"font-size:11px;\">");
      out.print(GlobalContext.getLocalizedMessageForWeb("Cancelled_Working", loggedUserLocale, "Cancelled Working"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<br />\r\n");
      out.write("<!--    #####   Navigation start        #####   -->\r\n");
      out.write("<table width=\"100%\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td align=\"center\">\r\n");
      out.write("\t\t    <br style=\"line-height: 15px;\" />\r\n");
      out.write("\t\t\t");
      //  bpm:page
      org.uengine.ui.taglibs.PagingTag _jspx_th_bpm_005fpage_005f0 = (org.uengine.ui.taglibs.PagingTag) _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.get(org.uengine.ui.taglibs.PagingTag.class);
      _jspx_th_bpm_005fpage_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bpm_005fpage_005f0.setParent(null);
      // /monitor/ganttChart.jsp(463,3) name = link type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLink("");
      // /monitor/ganttChart.jsp(463,3) name = totalcount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setTotalcount(totalCount);
      // /monitor/ganttChart.jsp(463,3) name = pagecount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagecount(intPageCnt);
      // /monitor/ganttChart.jsp(463,3) name = pagelimit type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagelimit(nPagesetSize);
      // /monitor/ganttChart.jsp(463,3) name = currentpage type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setCurrentpage(currentPage);
      // /monitor/ganttChart.jsp(463,3) name = locale type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLocale(loggedUserLocale);
      int _jspx_eval_bpm_005fpage_005f0 = _jspx_th_bpm_005fpage_005f0.doStartTag();
      if (_jspx_th_bpm_005fpage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
      out.write("\r\n");
      out.write("\t\t\t<br />\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<form name=\"refreshForm\" method=\"post\" action=\"./ganttChart.jsp\" target=\"\">\r\n");
      out.write("\t<input type=\"hidden\" name=\"processDefinitionId\" value=\"");
      out.print(pdId);
      out.write("\"/>\r\n");
      out.write("\t<input type=\"hidden\" name=\"processDefinitionName\" value=\"");
      out.print(pdName);
      out.write("\"/>\r\n");
      out.write("\t<input type=\"hidden\" name=\"mondif\" value=\"");
      out.print(s_mondif);
      out.write("\"/>\r\n");
      out.write("\t<input type=\"hidden\" name=\"orderby\" value=\"");
      out.print(orderby);
      out.write("\"/>\r\n");
      out.write("\t<input type=\"hidden\" name=\"endpoint\" value=\"");
      out.print(endpoint);
      out.write("\"/>\r\n");
      out.write("\t<input type=\"hidden\" name=\"endpoint_display\" value=\"");
      out.print(endpoint_display);
      out.write("\"/>\r\n");
      out.write("\t<input type=\"hidden\" name=\"CURRENTPAGE\" value=\"");
      out.print(currentPage );
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"viewerType\" id=\"viewerType\" value=\"");
      out.print(viewerType );
      out.write("\" />\r\n");
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
