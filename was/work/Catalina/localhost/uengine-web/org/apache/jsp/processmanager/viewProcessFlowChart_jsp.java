package org.apache.jsp.processmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.kernel.viewer.ViewerOptions;
import java.text.SimpleDateFormat;
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

public final class viewProcessFlowChart_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(5);
    _jspx_dependants.add("/processmanager/../common/header.jsp");
    _jspx_dependants.add("/processmanager/../common/headerMethods.jsp");
    _jspx_dependants.add("/processmanager/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/processmanager/../common/styleHeader.jsp");
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
try{
    pm = processManagerFactory.getProcessManagerForReadOnly();

    String pd = (request.getParameter("processDefinition"));
    String pdVer = (request.getParameter("processDefinitionVersionID"));
    String folder = (request.getParameter("folder"));
    //  String pi = (request.getParameter("instanceId"));
    String pi = null;   //  SubProcess ? ??.
    String instanceIds = (request.getParameter("instanceId"));
    String selectedInstanceId = (request.getParameter("selectedInstanceId"));
    String[] arrInstanceIds = null;
    if (instanceIds != null && instanceIds.indexOf(";") > -1) {
        arrInstanceIds = instanceIds.split(";");
        if (selectedInstanceId != null && !"".equals(selectedInstanceId)) {
            pi = selectedInstanceId;
        } else {
            pi = arrInstanceIds[0];
        }
    } else {
        pi = instanceIds;
    }

    String locale = (request.getParameter("locale"));
    if (!UEngineUtil.isNotEmpty(pi)) pi = null;
    if (!UEngineUtil.isNotEmpty(locale)) locale = loggedUserLocale;
    String chart ="no chart is available";
    
    /***********************************************************************/
    /*                            Get version list                         */
    /***********************************************************************/

    ProcessDefinitionRemote[] arrPdr = null;
    if (pi == null) {
        if (pd == null) {
            return;
        }
        
        arrPdr = pm.findAllVersions(pd);
        
        if (arrPdr != null) {
            String versionID = null;
            int version = -1;
            for (int i=0; i<arrPdr.length; i++) {
                versionID = arrPdr[i].getId();
                version = arrPdr[i].getVersion();
                if (arrPdr[i].isProduction()) {
                    if (pdVer == null || "".equals(pdVer) || "null".equals(pdVer)) {
                        pdVer = versionID;
                    }
                }
            }
            if (pdVer == null || "".equals(pdVer) || "null".equals(pdVer)) {
                pdVer = versionID;
            }
        }
    }
    
    ProcessDefinitionRemote pdr;    
    if (pi != null) {
        pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
    } else {
        pdr = pm.getProcessDefinitionRemote(pdVer);
    }
    
    ProcessInstance instance = null;
    if (pi != null) {
        instance = pm.getProcessInstance(pi);
    }
    
    String title = pdr.getName().getText(locale);
    
    ViewerOptions options = new ViewerOptions();
    
    options.setViewType(options.VERTICAL, options.VERTICAL);
    options.put("flowControl", new Boolean(true));
//  options.put("dontCollapseScopes", new Boolean(true));
    options.put("decorated", new Boolean(true));
    options.put("show hidden activity", new Boolean(true));
    options.put("ShowAllComplexActivities", new Boolean(true));
//  options.put("enableEvent_onActivityClicked", new Boolean(true));
    options.put("align", "center");
    options.put("locale", loggedUserLocale);
    
    if (pi != null) {
        options.put("enableUserEvent_compensateTo", "Back to here");
        options.put("enableUserEvent_refreshMultipleInstances_org.uengine.kernel.SubProcessActivity", "Refresh Multiple Instances");
        options.put("enableUserEvent_showLog", "See Execution Log");
        //options.put("enableUserEvent_locateWorkItem", "Work Item Handler");
        options.put("enableUserEvent_locateWorkItem_org.uengine.kernel.ReceiveActivity", "Work Item Handler");
    }
    
    options.put("enableUserEvent_viewFormDefinition_org.uengine.kernel.FormActivity", "View Form Definition");
    options.put("enableUserEvent_drillInto_org.uengine.kernel.SubProcessActivity", "Drill Into");
    //options.put("show active activity count", Boolean.TRUE);
    if (locale != null)
        options.put("locale", locale);
    
    if (pi != null) {
        chart = pm.viewProcessInstanceFlowChart(pi, options);
    } else {
        if (pdVer != null) {
            chart = pm.viewProcessDefinitionFlowChart(pdVer, options);
        }
    }

    String pin = request.getParameter("pin"); //process instance name
    String belongingDefId = pdr.getBelongingDefinitionId();
    String srAlias = pdr.getAlias();
    AclManager acl = AclManager.getInstance();
    HashMap permission = acl.getPermission(Integer.parseInt(pdr.getBelongingDefinitionId()), loggedUserId);

      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
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
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/lib/raphael/raphael-min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/crossBrowser/elementControl.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/loopDraw.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/flowchart/flowchartDefinition.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/flowchart/flowchartUtil.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/scripts/popupTooltip.js\"></script>\r\n");
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("<link type=\"text/css\" rel=\"stylesheet\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/style/popupTooltip.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/style/portlet.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/style/portal.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/style/groupware.css\" />\r\n");
      out.write("<LINK type=\"text/css\" rel=\"stylesheet\" href=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/style/flowchart.css\">\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("var WEB_CONTEXT_ROOT = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("\";\r\n");
      out.write("\r\n");
      out.write("var tmp = [\r\n");
      out.write("           {title : \"");
      out.print(GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) );
      out.write("\", onclick : \"changeDisplayDraw(true)\"},\r\n");
      out.write("           {title : \"");
      out.print(GlobalContext.getMessageForWeb("Process Variables", loggedUserLocale) );
      out.write("\", onclick : \"changeDisplayDraw(false)\"},\r\n");
      out.write("           {title : \"");
      out.print(GlobalContext.getMessageForWeb("Roles", loggedUserLocale) );
      out.write("\", onclick : \"changeDisplayDraw(false)\"}\r\n");
      out.write("        ];\r\n");
      out.write("        \r\n");
      out.write("$(document).ready(function() {\r\n");
      out.write("\tenableTooltips();\r\n");
      out.write("\tdrawAll();\r\n");
      out.write("\tsetTimeout(\"drawAll()\", 1000);\r\n");
      out.write("\t\r\n");
      out.write("\t$(window).bind(\"resize\", function() {\r\n");
      out.write("\t\t// ìë ê°ì ì ì¬ì§ê° íì\r\n");
      out.write("\t\t// resizeì drawë¡ ì¸íì¬ ìëê° í¬ê² ì íë¨. \r\n");
      out.write("\t\tdrawAll();\r\n");
      out.write("\t}).trigger(\"resize\");\r\n");
      out.write("\t\r\n");
      out.write("\t$('blink').blink();\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function changeDisplayDraw(booleanValue) {\r\n");
      out.write("    if (booleanValue) {\r\n");
      out.write("        drawAll();\r\n");
      out.write("    } else {\r\n");
      out.write("        cleanAll();\r\n");
      out.write("    }\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function viewTaskInfo(pdVer) {\r\n");
      out.write("\tvar option = \"width=900,height=550,scrollbars=yes,resizable=yes\";\r\n");
      out.write("\tvar url = \"initiateForm.jsp?processDefinition=\" + pdVer;\r\n");
      out.write("\twindow.open(url, \"taskInfo\", option);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function viewProcessVariableInXML(variableName){\r\n");
      out.write("\twindow.open('viewProcessVariableInXML.jsp?instanceId=");
      out.print(pi);
      out.write("&variableName='+variableName, 'processVariable', 'width=700,height=500,scrollbars=yes,resizable=yes');\r\n");
      out.write("}\r\n");
      out.write("function showProcessVariableChangeForm(variableName, variableType){\r\n");
      out.write("\twindow.open('processVariableChangeForm.jsp?instanceId=");
      out.print(pi);
      out.write("&variableName='+variableName+ '&dataClassName=' + variableType, 'processVariable', 'width=700,height=500,scrollbars=yes,resizable=yes');\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function showRoleMappingChangeForm(roleName, oldValue){\r\n");
      out.write("    window.open('roleMappingChangeForm.jsp?multiple=true&instanceId=");
      out.print(pi);
      out.write("&roleName=' + roleName + '&oldValue=' + oldValue, 'roleMapping', 'width=700,height=500,scrollbars=yes,resizable=yes');\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function showActivityDetails(processDefinition, instanceID, tracingTag){\r\n");
      out.write("\twindow.open('viewActivityDetails.jsp?processDefinition=' + processDefinition + '&instanceID=' + instanceID + '&tracingTag=' + tracingTag,'activitydetails','width=500,height=400,scrollbars=yes,resizable=yes');\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function resume(tracingTag) {\r\n");
      out.write("\tresult = confirm(\"Are you sure to resume this step?\");\r\n");
      out.write("\tif(result==true){\r\n");
      out.write("\t\tflowControl('resume', tracingTag);\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function suspend(tracingTag) {\r\n");
      out.write("\tresult = confirm(\"Are you sure to suspend this step?\");\r\n");
      out.write("\tif(result==true){\r\n");
      out.write("\t\tflowControl('suspend', tracingTag);\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function skip(tracingTag) {\r\n");
      out.write("\tresult = confirm(\"Are you sure to skip this step?\");\r\n");
      out.write("\tif(result==true){\r\n");
      out.write("\t\tflowControl('skip', tracingTag);\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function compensate(tracingTag) {\r\n");
      out.write("\tresult = confirm(\"Do you really compensate this step?\");\r\n");
      out.write("\tif(result==true){\r\n");
      out.write("\t\tflowControl('compensate', tracingTag);\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function flowControl(command, tracingTag) {\r\n");
      out.write("\tgo('flowControl.jsp?returnPage=viewProcessFlowChart.jsp&command='+ command + '&instanceId=");
      out.print(pi);
      out.write("' + '&tracingTag=' + tracingTag);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function go(urlToGo) {\r\n");
      out.write(" \tlocation = urlToGo;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function drillInto(defId, defVersionId, tracingTag, instanceId, propertyString) {\r\n");
      out.write("\tpropertyKeyAndValues = propertyString.split(\",\");\r\n");
      out.write("\tproperties = new Array();\r\n");
      out.write("\tfor (i = 0; i<propertyKeyAndValues.length; i++) {\r\n");
      out.write("\t\tif(propertyKeyAndValues[i]!=null){\r\n");
      out.write("\t\t\tkeyAndValue = propertyKeyAndValues[i].split(\"=\");\r\n");
      out.write("\t\t\tproperties[keyAndValue[0]] = keyAndValue[1];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t//var status = properties[\"status\"];\r\n");
      out.write("\tvar subProcessIds = properties[\"subInstanceId\"];\r\n");
      out.write("\tvar subDefinitionId = properties[\"subDefinitionId\"];\r\n");
      out.write("\tif ( subProcessIds != null ) {\r\n");
      out.write("\t\tgo('viewProcessInformation.jsp?instanceId=' + subProcessIds);\r\n");
      out.write("\t} else if( subDefinitionId != null ) {\r\n");
      out.write("\t\tgo('viewProcessInformation.jsp?processDefinition=' + subDefinitionId);\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function showLog(defId, defVersionId, tracingTag, instanceId, propertyString) {\r\n");
      out.write("\tpropertyKeyAndValues = propertyString.split(\",\");\r\n");
      out.write("\tproperties = new Array();\r\n");
      out.write("\tfor(i = 0; i<propertyKeyAndValues.length; i++){\r\n");
      out.write("\t\tif(propertyKeyAndValues[i]!=null){\r\n");
      out.write("\t\t\tkeyAndValue = propertyKeyAndValues[i].split(\"=\");\r\n");
      out.write("\t\t\tproperties[keyAndValue[0]] = keyAndValue[1];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar option = \"width=500,height=400,scrollbars=yes,resizable=yes\";\r\n");
      out.write("\t\r\n");
      out.write("\twindow.open('showExecutionLog.jsp?filePath=log/' + instanceId + '/' + tracingTag, \"wihspace\", option);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function locateWorkItem(defId, defVersionId, tracingTag, instanceId, propertyString){\r\n");
      out.write("\tpropertyKeyAndValues = propertyString.split(\",\");\r\n");
      out.write("\tproperties = new Array();\r\n");
      out.write("\tfor(i = 0; i<propertyKeyAndValues.length; i++){\r\n");
      out.write("\t\tif(propertyKeyAndValues[i]!=null){\r\n");
      out.write("\t\t\tkeyAndValue = propertyKeyAndValues[i].split(\"=\");\r\n");
      out.write("\t\t\tproperties[keyAndValue[0]] = keyAndValue[1];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar option = \"width=800,height=550,scrollbars=yes,resizable=yes\";\r\n");
      out.write("\t\r\n");
      out.write("\twindow.open('../processparticipant/worklist/workitemHandler.jsp?instanceId=' + instanceId + '&tracingTag=' + tracingTag + '&isViewMode=true', \"wihspace\", option);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function viewFormDefinition(defId, defVersionId, tracingTag, instanceId, propertyString){\r\n");
      out.write("\tpropertyKeyAndValues = propertyString.split(\",\");\r\n");
      out.write("\tproperties = new Array();\r\n");
      out.write("\tfor(i = 0; i<propertyKeyAndValues.length; i++){\r\n");
      out.write("\t\tif(propertyKeyAndValues[i]!=null){\r\n");
      out.write("\t\t\tkeyAndValue = propertyKeyAndValues[i].split(\"=\");\r\n");
      out.write("\t\t\tproperties[keyAndValue[0]] = keyAndValue[1];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t//var status = properties[\"status\"];\r\n");
      out.write("\tvar formDefinitionId = properties[\"formDefinitionId\"];\r\n");
      out.write("\tif( formDefinitionId != null ){\r\n");
      out.write("\t\tgo('viewFormDefinition.jsp?objectDefinitionId=' + formDefinitionId);\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function compensateTo(defId, defVersionId, tracingTag, instanceId, propertyString){\r\n");
      out.write("\tpropertyKeyAndValues = propertyString.split(\",\");\r\n");
      out.write("\tproperties = new Array();\r\n");
      out.write("\tfor(i = 0; i<propertyKeyAndValues.length; i++){\r\n");
      out.write("\t\tif(propertyKeyAndValues[i]!=null){\r\n");
      out.write("\t\t\tkeyAndValue = propertyKeyAndValues[i].split(\"=\");\r\n");
      out.write("\t\t\tproperties[keyAndValue[0]] = keyAndValue[1];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\tvar status = properties[\"status\"];\r\n");
      out.write("\r\n");
      out.write("\tif(status!=\"Completed\"){\r\n");
      out.write("\t\talert(\"Only completed activities can be target points for compensation\");\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tgo('flowControl.jsp?returnPage=viewProcessFlowChart.jsp&command=compensateTo&instanceId=' + instanceId + '&tracingTag=' + tracingTag);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function refreshMultipleInstances(defId, defVersionId, tracingTag, instanceId, propertyString){\r\n");
      out.write("\tpropertyKeyAndValues = propertyString.split(\",\");\r\n");
      out.write("\tproperties = new Array();\r\n");
      out.write("\tfor(i = 0; i<propertyKeyAndValues.length; i++){\r\n");
      out.write("\t\tif(propertyKeyAndValues[i]!=null){\r\n");
      out.write("\t\t\tkeyAndValue = propertyKeyAndValues[i].split(\"=\");\r\n");
      out.write("\t\t\tproperties[keyAndValue[0]] = keyAndValue[1];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tvar status = properties[\"status\"];\r\n");
      out.write("\t\r\n");
      out.write("\tgo('refreshMulipleInstances.jsp?returnPage=viewProcessFlowChart.jsp&instanceId=' + instanceId + '&tracingTag=' + tracingTag);\r\n");
      out.write("}\r\n");
      out.write("\t\r\n");
      out.write("function showDefinition(processDefinitionVersionId, language) {\r\n");
      out.write("    window.open('showDefinitionInLanguage.jsp?versionId=' + processDefinitionVersionId + '&language=' + language,'definitionInLanguage','width=700,height=500,scrollbars=yes,resizable=yes');\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function showWSDL(location) {\r\n");
      out.write("    window.open(location, 'wsdl', 'width=700,height=500,scrollbars=yes,resizable=yes')\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function removeDefinition(definition) {\r\n");
      out.write("    var answer = confirm(\"There may be a running instance with this process definition.\\nAre you sure to remove?\");\r\n");
      out.write("    if (answer) {\r\n");
      out.write("        location=\"removeProcessDefinition.jsp?processDefinition=\" + definition;\r\n");
      out.write("    }\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function makeProduction(){\r\n");
      out.write("    location=\"makeProduction.jsp?processDefinition=");
      out.print(pdVer == null ? "" : pdVer.replace(' ', '+'));
      out.write("\";\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function refresh(){\r\n");
      out.write("    var pdv = document.all.processDefinitionVersionID.value;\r\n");
      out.write("    location=\"?processDefinition=");
      out.print(pd);
      out.write("&folder=");
      out.print(folder);
      out.write("&processDefinitionVersionID=\" + pdv;\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/tabs.js\"></script>\r\n");
      out.write("<style type=\"text/css\"> \r\n");
      out.write("    body{ overflow:auto;}\r\n");
      out.write("</style>\r\n");
      out.write("<title>");
      out.print(GlobalContext.getMessageForWeb("Process Definition", loggedUserLocale) );
      out.write('-');
      out.print(pdr.getName().getText());
      out.write('(');
      out.print(GlobalContext.getMessageForWeb("Version", loggedUserLocale) );
      out.write(':');
      out.print(pdr.getVersion());
      out.write('/');
      out.print(GlobalContext.getMessageForWeb("Modified Date", loggedUserLocale) );
      out.write(':');
      out.print(pdr.getStrModifiedDate() );
      out.write(")</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div id=\"canvasForLoopLines\" style=\"position:absolute;left:0px;top:0px;z-index: -1\"></div>\r\n");
      out.write("\r\n");
      out.write("<div style=\" padding:15px;  width:98%\">\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td valign=\"middle\"><img src=\"../images/Common/I_info.gif\" align=\"middle\" border=\"0\" style=\"margin-top:-2px;\"> <strong >");
      out.print(GlobalContext.getMessageForWeb("Process Information", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("        <td>\r\n");
 
if (pdVer != null) { 

      out.write("\r\n");
      out.write("            <form name=\"actionForm\">\r\n");
      out.write("                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td align=\"right\" valign=\"middle\">\r\n");
      out.write("                            <table cellSpacing=\"0\" cellpadding=\"0\" align=\"right\"  style=\"margin-bottom:4px;\">\r\n");
      out.write("                                <tbody>\r\n");
      out.write("                                    <tr>\r\n");
      out.write("                                        <td class=\"gBtn\">\r\n");

    if (loggedUserIsAdmin) {
      	permission.put(AclManager.PERMISSION_MANAGEMENT, true);
    }
      
    if (
		   permission.containsKey(AclManager.PERMISSION_VIEW)
		|| permission.containsKey(AclManager.PERMISSION_INITIATE)
		|| permission.containsKey(AclManager.PERMISSION_EDIT)
        || permission.containsKey(AclManager.PERMISSION_MANAGEMENT)
    ) {

      out.write("\r\n");
      out.write("                                        \t<a href=\"javascript: viewTaskInfo('");
      out.print(pdVer);
      out.write("')\"> <span> ");
      out.print(GlobalContext.getMessageForWeb("Initiate", loggedUserLocale) );
      out.write(" </span> </a>\r\n");
 
    }
                                        
    if (
          permission.containsKey(AclManager.PERMISSION_EDIT)
        || permission.containsKey(AclManager.PERMISSION_MANAGEMENT)
    ) {

      out.write("\r\n");
      out.write("\t                                        <a href=\"javascript: location='ProcessDesigner.jnlp?defVerId=");
      out.print(pdVer);
      out.write("&folderId=");
      out.print(folder);
      out.write("&defId=");
      out.print(belongingDefId);
      out.write("';\"> \r\n");
      out.write("\t                                        <span>");
      out.print(GlobalContext.getMessageForWeb("Improve", loggedUserLocale) );
      out.write("</span></a>\r\n");

    }
                                        
    if (pdr.isProduction()) {

      out.write("\r\n");
      out.write("                                            <span style=\"line-height:23px; color:#F00\">[");
      out.print(GlobalContext.getMessageForWeb("This version is procuction", loggedUserLocale) );
      out.write("]</span>\r\n");

    } else if (loggedUserIsAdmin) {

      out.write("\r\n");
      out.write("                                            <a href=\"javascript: makeProduction();\"> <span> ");
      out.print(GlobalContext.getMessageForWeb("Set as production", loggedUserLocale));
      out.write(" </span> </a>\r\n");

    }

      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                </tbody>\r\n");
      out.write("                            </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                </table>\r\n");
      out.write("            </form>\r\n");

}

      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("        <td valign=\"middle\" align=\"right\" width=\"130\">\r\n");
      out.write("            <table style=\"margin-bottom:4px;\">\r\n");
      out.write("\t            <tr>\r\n");
      out.write("\t                <td class=\"gBtn\">\r\n");

if (permission.containsKey(AclManager.PERMISSION_MANAGEMENT)) {

      out.write("\r\n");
      out.write("                        <a href=\"javascript: window.location.href='processInstanceListDetail.jsp?defId=");
      out.print(pdr.getBelongingDefinitionId() );
      out.write("'\"> <span> ");
      out.print(GlobalContext.getMessageForWeb("Instance List", loggedUserLocale) );
      out.write(" </span> </a>\r\n");
 
} 

      out.write("\r\n");
      out.write("                \t</td>\r\n");
      out.write("                </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td class=\"formheadline\" height=\"2\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");

if (pdVer == null) { 

      out.write("\r\n");
      out.write("    <tr height=\"30\" >\r\n");
      out.write("\t    <td class=\"formtitle\" width=\"200\">&nbsp;<b>Instance Id</b></td>\r\n");
      out.write("\t    <td width=\"10\"></td>\r\n");
      out.write("\t    <td width=\"*\" align=\"left\">\r\n");

    if( arrInstanceIds != null ) {
		for( int i=0; i<arrInstanceIds.length; i++ ){
			if ( i > 0 ) {
				out.print(", ");
			}
			if ( pi.equals(arrInstanceIds[i]) ) {

      out.write("\r\n");
      out.write("            <font color=\"#FF0000\"><b>");
      out.print(pi);
      out.write("</b></font>\r\n");

            } else {

      out.write("\r\n");
      out.write("            <a href=\"javascript:go('viewProcessInformation.jsp?instanceId=");
      out.print(instanceIds);
      out.write("&selectedInstanceId=");
      out.print(arrInstanceIds[i]);
      out.write("');\">");
      out.print(arrInstanceIds[i]);
      out.write("</a>\r\n");

			}
		}
	} else {

      out.write("\r\n");
      out.write("            <font color=\"#FF0000\"><b>");
      out.print((pin !=null ? pin:""));
      out.write(' ');
      out.print(pi);
      out.write("</b></font>\r\n");

	}

      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td colspan=\"3\" class=\"formline\" height=\"1\"></td>\r\n");
      out.write("    </tr>\r\n");

}

      out.write("\r\n");
      out.write("    <tr height=\"30\" >\r\n");
      out.write("        <td class=\"formtitle\" width=\"200\">&nbsp;<b>");
      out.print(GlobalContext.getMessageForWeb("Definition", loggedUserLocale) );
      out.write("</b></td>\r\n");
      out.write("        <td width=\"10\"></td>\r\n");
      out.write("        <td width=\"*\" align=\"left\">");
      out.print(pdr.getName().getText());
      out.write(' ');
      out.write('(');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(pdr.getBelongingDefinitionId());
      out.write(' ');
      out.write(',');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("Alias", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(srAlias );
      out.write(" ) </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td colspan=\"3\" class=\"formline\" height=\"1\"></td>\r\n");
      out.write("    </tr>\r\n");

if (arrPdr != null) {

      out.write("\r\n");
      out.write("    <tr height=\"30\" >\r\n");
      out.write("        <td class=\"formtitle\">&nbsp;<strong>");
      out.print(GlobalContext.getMessageForWeb("Version", loggedUserLocale) );
      out.write("</strong></td>\r\n");
      out.write("        <td width=\"10\"></td>\r\n");
      out.write("        <td width=\"*\" align=\"left\">\r\n");
      out.write("            <select name=\"processDefinitionVersionID\" id=\"processDefinitionVersionID\" onchange=\"refresh();\">\r\n");
	
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
      out.write("                <option value=\"");
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
      out.write("            </select>\r\n");
      out.write("            ( ");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(pdVer);
      out.write(' ');
      out.write(',');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("Modified Date", loggedUserLocale) );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(pdr.getStrModifiedDate() );
      out.write(" ) \r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td colspan=\"3\" class=\"formline\" height=\"1\"></td>\r\n");
      out.write("    </tr>\r\n");

}

if (pdVer!=null) { 
	String desc = (pdr.getDescription()!=null ? pdr.getDescription().getText(locale) : null);
	if ( desc == null ) desc = "";

      out.write("\r\n");
      out.write("    <tr height=\"30\" >\r\n");
      out.write("        <td class=\"formtitle\">&nbsp;<b>");
      out.print(GlobalContext.getMessageForWeb("Description", loggedUserLocale) );
      out.write("</b></td>\r\n");
      out.write("        <td width=\"10\"></td>\r\n");
      out.write("        <td width=\"*\" align=\"left\">");
      out.print(desc);
      out.write("</td>\r\n");
      out.write("    </tr>\r\n");

}

      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td class=\"formheadline\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td height=\"15\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td class=\"formheadline\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("    createTabs(tmp);\r\n");
      out.write("</script>\r\n");
      out.write("<div id=\"divTabItem_");
      out.print(GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) );
      out.write("\" style=\"overflow: hidden;\">\r\n");
      out.write("    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("        <tr height=\"20\" >\r\n");
      out.write("            <td width=\"10\"></td>\r\n");
      out.write("            <td width=\"*\" align=\"left\" class=\"padding15\">\r\n");
      out.write("            \t<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td align=\"right\">\r\n");
      out.write("\t\t\t\t\t\t    <br />\r\n");
      out.write("\t                        <table align=\"right\">\r\n");
      out.write("\t                            <tr>\r\n");
      out.write("\t                               <td class=\"gBtn\">\r\n");

if ( pdVer == null) {
	StringBuilder tempLocation = new StringBuilder();
	StringBuilder tempString = new StringBuilder();
	if(pdr.isAdhoc()) { 

      out.write("\r\n");
      out.write("                                        <a onClick=\"location='ProcessDesigner.jnlp?instanceId=");
      out.print(pi);
      out.write("&defId=");
      out.print(pdr.getId());
      out.write("'\"><span>");
      out.print(GlobalContext.getMessageForWeb("Instance Level Definition Change", loggedUserLocale) );
      out.write("</span></a>\r\n");
      out.write("                            \r\n");

    }
										
	if(instance.isRunning("")){
		tempLocation.append("stopProcessInstance.jsp?processInstance=" + pi);
		tempString.append("Stop");
	}else{
		tempLocation.append("startProcessInstance.jsp?processInstance=" + pi);
		tempString.append("Start");
	}

      out.write("\r\n");
      out.write("                                        <a onClick=\"location='");
      out.print(tempLocation );
      out.write("'\"><span>");
      out.print(tempString );
      out.write("</span></a>\r\n");

}

      out.write("\r\n");
      out.write("                                    </td>\r\n");
      out.write("                                </tr>\r\n");
      out.write("                            </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("<!-- Flow Chart Start -->\r\n");

if(instance != null && instance.getMainProcessInstanceId()!=null){

      out.write("\r\n");
      out.write("                            <a href=\"?instanceId=");
      out.print(instance.getMainProcessInstanceId());
      out.write("\"><img src=\"../images/up_back.gif\"></a>\r\n");
	
} 

      out.write("\r\n");
      out.write("                            ");
      out.print(chart);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<select onchange=\"changeLocale(this)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"\">");
      out.print(GlobalContext.getMessageForWeb("Language", loggedUserLocale) );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"ko\">");
      out.print(GlobalContext.getMessageForWeb("Korean", loggedUserLocale) );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"en\">");
      out.print(GlobalContext.getMessageForWeb("English", loggedUserLocale) );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"jp\">");
      out.print(GlobalContext.getMessageForWeb("Japanese", loggedUserLocale) );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"zh\">");
      out.print(GlobalContext.getMessageForWeb("Chinese", loggedUserLocale) );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t\t\t<script type=\"text/javascript\">\r\n");
      out.write("\t\t\t\t\t\t\tfunction changeLocale(option){\r\n");
      out.write("\t\t\t\t\t\t\t\t");
if(pi != null){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\tgo(\"viewProcessFlowChart.jsp?instanceId=");
      out.print(pi);
      out.write("&locale=\" + option.value);\r\n");
      out.write("\t\t\t\t\t\t\t\t");
} else {
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\tgo(\"viewProcessFlowChart.jsp?processDefinition=");
      out.print(pd);
      out.write("&processDefinitionVersionID=");
      out.print(pdVer);
      out.write("&locale=\" + option.value);\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t</script>\r\n");
      out.write("<!-- Flow Chart End -->\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                </table>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr height=\"1\">\r\n");
      out.write("            <td colspan=\"3\" class=\"formline\" height=\"1\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");

if (pdVer!=null) { 

      out.write("\r\n");
      out.write("    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("        <tr height=\"30\" >\r\n");
      out.write("            <td class=\"formtitle\" width=\"200\">&nbsp;<b>");
      out.print(GlobalContext.getMessageForWeb("See definition in", loggedUserLocale) );
      out.write("</b></td>\r\n");
      out.write("            <td width=\"10\"></td>\r\n");
      out.write("            <td width=\"*\" align=\"left\"  class=\"padding15\">\r\n");
      out.write("                <!--  a href=\"javascript:showDefinition('");
      out.print(pdVer);
      out.write("', 'BPEL')\">BPEL4WS</a -->\r\n");
      out.write("                <a href=\"javascript:showDefinition('");
      out.print(pdVer);
      out.write("', 'Bean')\">Bean</a>\r\n");
      out.write("                <!-- a href=\"javascript:showDefinition('");
      out.print(pdVer);
      out.write("', 'WSCI')\">WSCI</a-->\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");

}

      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"divTabItem_");
      out.print(GlobalContext.getMessageForWeb("Process Variables", loggedUserLocale) );
      out.write("\" style=\"display: none;\">\r\n");
      out.write("    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("        <tr height=\"30\" >\r\n");
      out.write("            <td width=\"5\" align=\"left\"></td>\r\n");
      out.write("            <td width=\"*\" align=\"left\"  class=\"padding15\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"tableborder\">\r\n");
      out.write("        <tr height=\"20\" >\r\n");
      out.write("            <td width=\"200\" align=\"center\" bgcolor=\"#DAE9F9\">Name/Type</td>\r\n");
      out.write("            <td width=\"*\" align=\"left\" bgcolor=\"#DAE9F9\">Value</td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr height=\"1\">\r\n");
      out.write("            <td colspan=\"3\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("        </tr>\r\n");

	ProcessVariable[] pvdrs = pdr.getProcessVariableDescriptors();
	if (pvdrs != null) {
		for(int i=0; i<pvdrs.length; i++) {
			ProcessVariable pvd = pvdrs[i];

      out.write("\r\n");
      out.write("                    <tr height=\"20\" >\r\n");
      out.write("                        <td width=\"200\" align=\"center\">");
      out.print(pvd.getDisplayName().getText(locale));
      out.write('/');
      out.print(pvd.getType() == null ? "" : pvd.getType().getName());
      out.write("</td>\r\n");
      out.write("                        <td width=\"*\" align=\"left\">");

			if (pi!=null) {
				Serializable data = pm.getProcessVariable(pi, "", pvd.getName());

      out.write("\r\n");
      out.write("                            <input type=\"button\" value='XML' onclick=\"viewProcessVariableInXML('");
      out.print(pvd.getName());
      out.write("')\">\r\n");
      out.write("                            <input type=\"button\" value='change' onclick=\"showProcessVariableChangeForm('");
      out.print(pvd.getName());
      out.write("', '");
      out.print(pvd.getType() == null ? "" : pvd.getType().getName());
      out.write("')\">\r\n");

				if(data instanceof HtmlFormContext){
					HtmlFormContext formContext = (HtmlFormContext)data;

      out.write("\r\n");
      out.write("                            <a href='showFormInstance.jsp?instanceId=");
      out.print(pi);
      out.write("&variableName=");
      out.print(pvd.getName());
      out.write("&filePath=");
      out.print(formContext.getFilePath());
      out.write("' target=_blank>");
      out.print(formContext.getFilePath() );
      out.write("</a>\r\n");

				}else{
				    out.println(data);
				}
					
			}

      out.write("\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr height=\"1\">\r\n");
      out.write("                        <td align=\"center\" colspan=\"3\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("                    </tr>\r\n");

		}
		
		if ( pvdrs.length == 0 ) {

      out.write("\r\n");
      out.write("                    <tr height=\"20\" >\r\n");
      out.write("                        <td align=\"left\" colspan=\"3\"> No process variables declared. </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr height=\"1\">\r\n");
      out.write("                        <td align=\"center\" colspan=\"3\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("                    </tr>\r\n");

		}
	} 

      out.write("\r\n");
      out.write("\r\n");
      out.write("                </table></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr height=\"1\">\r\n");
      out.write("            <td align=\"center\" colspan=\"3\" height=\"1\"class=\"formline\" height=\"1\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"divTabItem_");
      out.print(GlobalContext.getMessageForWeb("Roles", loggedUserLocale) );
      out.write("\" style=\"display: none;\">\r\n");
      out.write("    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("        <tr height=\"30\" >\r\n");
      out.write("         \r\n");
      out.write("            <td width=\"5\" align=\"left\"></td>\r\n");
      out.write("            <td width=\"*\" align=\"left\"  class=\"padding15\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"  class=\"tableborder\">\r\n");
      out.write("                    <col span=\"1\" width=\"200\" align=\"center\" />\r\n");
      out.write("                    <col span=\"1\" width=\"*\" align=\"left\" />\r\n");
      out.write("                    <tr height=\"20\" >\r\n");
      out.write("                        <td bgcolor=\"#DAE9F9\">Name</td>\r\n");
      out.write("                        <td bgcolor=\"#DAE9F9\">Binding</td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr height=\"1\">\r\n");
      out.write("                        <td align=\"center\" colspan=\"2\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    ");

    Role[] roles =null;
    if(instance != null){
    	roles = instance.getProcessDefinition().getRoles();
    }else{
		roles = pdr.getRoles();
    }
    
	if (roles != null ) {
		for(int i=0; i<roles.length; i++) {
			Role role = roles[i];

      out.write("\r\n");
      out.write("                    <tr height=\"20\" >\r\n");
      out.write("                        <td>");
      out.print(role.getDisplayName().getText(locale));
      out.write("</td>\r\n");
      out.write("                        <td>");

			if ( pi != null ) {
				RoleMapping roleMapping = pm.getRoleMappingObject(pi, role.getName());				

      out.write("\r\n");
      out.write("                            <input type=\"button\" value='");
      out.print(GlobalContext.getMessageForWeb("Change", loggedUserLocale) );
      out.write("' \r\n");
      out.write("\t\t\t\t\t\tonclick=\"showRoleMappingChangeForm('");
      out.print(role.getName());
      out.write("', '");
      out.print((roleMapping != null ? roleMapping.getEndpoint() : ""));
      out.write("')\">\r\n");
      out.write("                            ");
      out.print(roleMapping);
      out.write("\r\n");
      out.write("                            ");

			}

      out.write("</td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr height=\"1\">\r\n");
      out.write("                        <td colspan=\"2\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    ");

		}
		if ( roles.length == 0 ) {

      out.write("\r\n");
      out.write("                    <tr height=\"20\" >\r\n");
      out.write("                        <td align=\"left\" colspan=\"2\"> No Roles declared. </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr height=\"1\">\r\n");
      out.write("                        <td colspan=\"2\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("                    </tr>\r\n");

		}
	} 
	
} finally {
	if(pm!=null){
		try{
			pm.remove();
		}catch(Exception e){}
	}
}

      out.write("\r\n");
      out.write("\r\n");
      out.write("                </table></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</div>\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td class=\"formheadline\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td height=\"10\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
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
