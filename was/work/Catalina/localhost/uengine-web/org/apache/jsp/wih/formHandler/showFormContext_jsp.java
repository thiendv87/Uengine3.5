package org.apache.jsp.wih.formHandler;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.contexts.HtmlFormContext;
import org.uengine.contexts.MappingContext;
import org.uengine.formmanager.FormUtil;
import org.uengine.util.*;
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
import org.uengine.kernel.SubProcessActivity;
import java.io.FileInputStream;
import java.net.URLEncoder;
import org.uengine.kernel.GlobalContext;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.Properties;
import org.uengine.kernel.ProcessInstance;
import java.io.FilenameFilter;
import java.io.File;
import org.uengine.kernel.HumanActivity;
import org.uengine.kernel.Activity;
import java.util.Calendar;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.net.URLDecoder;
import java.util.Date;
import org.uengine.util.UEngineUtil;
import com.defaultcompany.web.tag.TagDAO;
import org.uengine.util.*;
import org.uengine.processpublisher.graph.GraphActivity;

public final class showFormContext_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(17);
    _jspx_dependants.add("/wih/formHandler/../../common/header.jsp");
    _jspx_dependants.add("/wih/formHandler/../../common/headerMethods.jsp");
    _jspx_dependants.add("/wih/formHandler/../../common/getLoggedUser.jsp");
    _jspx_dependants.add("/wih/formHandler/../../common/styleHeader.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/definition.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/initialize.jsp");
    _jspx_dependants.add("/wih/formHandler/../../scripts/importCommonScripts.jsp");
    _jspx_dependants.add("/wih/formHandler/../../scripts/../lib/jquery/importJquery.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/showFormContextHeader.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/./returnIfNotRunning.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/showTags.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/showActions.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/cancleAction.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/findBackableActivities.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/possible_actions.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/passValues.jsp");
    _jspx_dependants.add("/wih/formHandler/../wihDefaultTemplate/errorpage.jsp");
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
      out.write(" \r\n");
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

      out.write('\r');
      out.write('\n');
      out.write('	');
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
      out.write('	');
//@include file="../wihDefaultTemplate/header.jsp"
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

	String executionScope = request.getParameter("executionScope");
	String eventName = request.getParameter("eventName");
	String mainInstanceId = request.getParameter("instanceId");
	String strIsNew = request.getParameter("isNew");
	String initiatorHumanActivityTracingTag = request.getParameter("initiatorHumanActivityTracingTag");

	pm = processManagerFactory.getProcessManager();//ForReadOnly();

	instanceId = (request.getParameter("instanceId"));

	processDefinition = (request.getParameter("processDefinition"));
	initiationProcessDefinition = processDefinition;
	
	if(!UEngineUtil.isNotEmpty(instanceId) && !UEngineUtil.isNotEmpty(processDefinition)) return;

	tracingTag = request.getParameter("tracingTag");
	
	boolean isEventHandler = UEngineUtil.isTrue(request.getParameter("isEventHandler"));
	initiate = UEngineUtil.isTrue(request.getParameter("initiate")) || isEventHandler;
	isViewMode = UEngineUtil.isTrue(request.getParameter("isViewMode"));
	boolean isCustomizing = UEngineUtil.isTrue(request.getParameter("isCustomizing"));
	boolean isMine = isCustomizing || initiate || UEngineUtil.isTrue(request.getParameter("isMine"));
	
	String workitemHandler = request.getParameter("workitemHandler");
	
	dispatchingOption = request.getParameter(KeyedParameter.DISPATCHINGOPTION);
	
	isRacing = (""+org.uengine.kernel.Role.DISPATCHINGOPTION_RACING).equals(dispatchingOption);
	
	if(!isEventHandler && !initiate && UEngineUtil.isNotEmpty(instanceId)){
		piRemote = pm.getProcessInstance(instanceId);
		if(UEngineUtil.isNotEmpty(executionScope)){
			piRemote.setExecutionScope(executionScope);
		}
		
		initiationActivity = (HumanActivity)piRemote.getProcessDefinition().getActivity(tracingTag);
	}else
		piRemote = null;
		
	boolean isAllowAnonymous = true;
	boolean isFantomInstance = false;
	
	if(piRemote==null && !isViewMode){
		Map genericContext = new HashMap();
		genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
		genericContext.put("request", request);
		genericContext.put("response", response);
		genericContext.put("servlet", this);
		pm.setGenericContext(genericContext);
		
					
		Vector vector=new Vector();
		
		if(isEventHandler){

			ProcessInstance mainInstance = pm.getProcessInstance(mainInstanceId);

			ProcessDefinition mainProcessDefinition = mainInstance.getProcessDefinition();
			EventMessagePayload eventMessagePayload = new EventMessagePayload();
			eventMessagePayload.setEventName(eventName);
			mainProcessDefinition.fireMessage("event", mainInstance, eventMessagePayload);
			
			//get the initiated sub process instance
			EventHandler[] ehs = pm.getEventHandlersInAction(mainInstanceId);
			EventHandler theEventHandler = null;

			if(ehs!=null)
			for(int i=0; i<ehs.length; i++){
				if(ehs[i].getName().equals(eventName)){
					theEventHandler = ehs[i];
					break;
				}
			}
			
			Activity handlerActivity = theEventHandler.getHandlerActivity();
			
			if(handlerActivity instanceof SubProcessActivity){
				SubProcessActivity subProcessActivity = (SubProcessActivity)theEventHandler.getHandlerActivity();
				ArrayList escList = mainInstance.getExecutionScopeContexts();
				ExecutionScopeContext esc = null;
				if(escList != null){
					for(int i=0; i<escList.size();i++){
						esc = (ExecutionScopeContext)escList.get(i);
						if(eventName.equals(esc.getName())) break;
					}
				}
				mainInstance.setExecutionScopeContext(esc);
				Vector idVt = subProcessActivity.getSubprocessIds(mainInstance);
				String subInstanceId = (String)idVt.get(0);
		 		piRemote = pm.getProcessInstance(subInstanceId);
				
				isFantomInstance = true;
			}
			
			vector= piRemote.getCurrentRunningActivitiesDeeply();

	}else if(UEngineUtil.isNotEmpty(instanceId) && !"true".equals(strIsNew)){
			piRemote = pm.getProcessInstance(instanceId);	
			vector= piRemote.getCurrentRunningActivitiesDeeply();
	}else{

		    ActivityReference initiatorHumanActivityReference = pm.getInitiatorHumanActivityReference(processDefinition);
		    String initiatorDefVerId = initiatorHumanActivityReference.getActivity().getProcessDefinition().getId();
			String fantomInstanceId = pm.initialize(processDefinition, instanceId, loggedRoleMapping);
	 		piRemote = pm.getProcessInstance(fantomInstanceId);
			isFantomInstance = true;
			pm.executeProcess(fantomInstanceId);
		
			vector= piRemote.getCurrentRunningActivitiesDeeply();
		}

		ActivityInstanceContext aic = (ActivityInstanceContext)vector.get(vector.size()-1);
		
		initiationActivity = (HumanActivity)aic.getActivity();
		
		initiationProcessDefinition = aic.getActivity().getProcessDefinition().getId();
		
		
		//System.out.println("initiationProcessDefinition=" + initiationProcessDefinition);
		
		
		
		//tracingTag = aic.getActivity().getTracingTag();
		piRemote = aic.getInstance();
				
		isAllowAnonymous = initiationActivity.isAllowAnonymous();
	}
	
	if(piRemote!=null){
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(piRemote.getInstanceId());
		pdver = pdr.getId();
	}
	
	/* ========================================================================================== */
	if (initiate)
		currentProcessDefinition = (ProcessDefinition) pm.getProcessDefinition(initiationProcessDefinition);
	else
		currentProcessDefinition = piRemote.getProcessDefinition();
	
	currentActivity = currentProcessDefinition.getActivity(tracingTag);
	/* ========================================================================================== */


      out.write('\r');
      out.write('\n');
      out.write('	');
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
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"../../scripts/formValidation.js\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../../scripts/formActivity.js.jsp" + (("../../scripts/formActivity.js.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("rmClsName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(rmClsName), request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"../../scripts/showFormContext.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t");
 if (!piRemote.isNew()) { 
      out.write("\r\n");
      out.write("\t\t$(\"#spanInstanceName\", top.document).html(\"(");
      out.print(piRemote.getName());
      out.write(")\");\r\n");
      out.write("\t");
 } 
      out.write("\r\n");
      out.write("\t\t$(document).ready(function(){\r\n");
      out.write("\t\t\tsetDefaultValue();\r\n");
      out.write("\t\t\tsetMainFormTarget();\r\n");
      out.write("\t\t\tsetCalender(LOGGED_USER_LOCALE);\r\n");
      out.write("\t\t\ttry {\r\n");
      out.write("\t\t\t\t");
 if (!isViewMode && isRacing) { 
      out.write("\r\n");
      out.write("\t\t\t\t$(\"#disableLayer\").dialog({\r\n");
      out.write("\t\t\t\t\tautoOpen : false,\r\n");
      out.write("\t\t\t\t\tmodal : true,\r\n");
      out.write("\t\t\t\t\tresizable : true,\r\n");
      out.write("\t\t\t\t\twidth : '600px',\r\n");
      out.write("\t\t\t\t\t//height : '200px',\r\n");
      out.write("\t\t\t\t\tcloseOnEscape : false,\r\n");
      out.write("\t\t\t\t\tbuttons : {\r\n");
      out.write("\t\t\t\t\t\t'Accept' : function() { acceptWorkitem(); },\r\n");
      out.write("\t\t\t\t\t\t'Cancel' : function() { window.parent.close(); }\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t$(\"#disableLayer\").dialog(\"open\");\r\n");
      out.write("\t\t\t\t$(\".ui-dialog-titlebar-close\").bind('click', function(){\r\n");
      out.write("\t\t\t\t\twindow.parent.close();\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t\t");
 } 
      out.write("\r\n");
      out.write("\t\t\t\tonLoadForm();\r\n");
      out.write("\t\t\t} catch(e) {}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body style=\"overflow:auto; text-align: center;\">\r\n");
      out.write("\t");
 
		String width = GlobalContext.getPropertyString("wih.content.width");
		String divWidth = UEngineUtil.isNotEmpty(width) ? (Integer.parseInt(width) + 60) + "px" : "98%"; 
	
      out.write("\r\n");
      out.write("\t<div align=\"center\"><div style=\"width: ");
      out.print(divWidth );
      out.write(";\">\r\n");
      out.write("\t\r\n");
      out.write("\t<iframe name=\"messageFrameName\" id=\"messageFrame\" width=\"100%\" height=\"0\" border=\"0\" \r\n");
      out.write("\t\tframeborder=\"0\" scrolling=\"auto\" marginheight=\"0\" marginwidth=\"0\"  src=\"about:blank\">\r\n");
      out.write("\t</iframe>\r\n");
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
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvar loggedUserId = \"");
      out.print(loggedUserId);
      out.write("\";\r\n");
      out.write("\tvar loggedUserName = \"");
      out.print(loggedUserFullName);
      out.write("\";\r\n");
      out.write("\tvar loggedUserPartCode = \"");
      out.print(loggedUserPartCode);
      out.write("\";\r\n");
      out.write("\r\n");
      out.write("\tfunction showHistoryContent(tag) {\r\n");
      out.write("\t\t$(\"#btnShowHistory_\" + tag).hide();\r\n");
      out.write("\t\t$(\"#btnHideHistory_\" + tag).show();\r\n");
      out.write("\t\t$('#tableHistoryContent_' + tag).show('normal');\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction hideHistoryContent(tag) {\r\n");
      out.write("\t\t$(\"#btnShowHistory_\" + tag).show();\r\n");
      out.write("\t\t$(\"#btnHideHistory_\" + tag).hide();\r\n");
      out.write("\t\t$('#tableHistoryContent_' + tag).hide('normal');\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction resizeFrame(size, tag){\r\n");
      out.write("\t\tdocument.getElementById(\"historyContentArea_\"+tag).height=size;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction getFormContext(tag,src){\r\n");
      out.write("\t\t$(\"#btnGetHistory_\" + tag).hide();\r\n");
      out.write("\t\t$(\"#historyContentArea_\"+tag).attr({\r\n");
      out.write("\t\t\t\"src\":src\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\tshowHistoryContent(tag);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tjQuery(document).ready(function() {\r\n");
      out.write("\t\ttry { \r\n");
      out.write("\t\t\tif (window.top.opener.document.refreshForm != null && window.top.opener.document.refreshForm != undefined) {\r\n");
      out.write("\t\t\t\twindow.top.opener.document.refreshForm.submit();\r\n");
      out.write("\t\t\t} else {\r\n");
      out.write("\t\t\t\twindow.top.opener.location.reload(true);\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t} catch (e) {}\r\n");
      out.write("\t});\r\n");
      out.write("</script>");

int activityCount = 1;

if("true".equals(org.uengine.kernel.GlobalContext.getPropertyString("wih.display.thread"))){
	ProcessInstance rootInstance = pm.getProcessInstance(piRemote.getRootProcessInstanceId());
	
	if (!initiate) {
		String roleName = "";
		String startTime = "";
		String endTime = "";
		String workTime = "";
		String workTitle = "";
		String resourceName = "";
		String taskId = null;
		String rootInstId = null;
		String iframeUrl = null;
		String statusMsg = "";
		ProcessInstance historyRootInstance = null;
		int year = 0;
		
		String viewTaskId = request.getParameter("taskId");
		
		if(!UEngineUtil.isNotEmpty(viewTaskId) && initiationActivity instanceof HumanActivity){
			String[] taskIds = ((HumanActivity)initiationActivity).getTaskIds(piRemote);
			if(taskIds!=null && taskIds.length > 1){
				viewTaskId = taskIds[0];
			}
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT wl.* "); 
		sql.append("   FROM bpm_worklist wl LEFT JOIN bpm_procinst pi ON wl.instid = pi.instid "); 
		sql.append("  WHERE pi.rootinstid = ").append(piRemote.getRootProcessInstanceId()); 
		sql.append("   AND wl.status NOT IN ( 'NEW' , 'CONFIRMED', 'DRAFT') "); 
		sql.append(" ORDER BY wl.startdate, wl.taskid "); 
		
		
		org.uengine.processmanager.ProcessTransactionContext ptc = piRemote.getProcessTransactionContext();
		org.uengine.util.dao.IDAO idao = org.uengine.util.dao.ConnectiveDAO.createDAOImpl(ptc, sql.toString(), org.uengine.util.dao.IDAO.class);
		idao.select();
		
		while(idao.next()){
			statusMsg = "";
			taskId = idao.getString("taskid");
			rootInstId = idao.getString("rootinstid");
			workTitle = idao.getString("title");
			resourceName = idao.getString("resname");
			
			if ("DELEGATED".equals(idao.getString("status"))) {
				statusMsg = "[" + GlobalContext.getMessageForWeb("Delegate", loggedUserLocale) + "] ";
			} 
			
			if (UEngineUtil.isNotEmpty(idao.getString("rolename"))) {
				roleName = idao.getString("rolename");
			}
			
			if(idao.get("enddate") != null){
				endTime = sdf.format(idao.getDate("enddate"));	
			}
			
			startTime = sdf.format(idao.getDate("startdate"));
			workTime = startTime + " ~ " + endTime; 
			
			historyRootInstance = pm.getProcessInstance(rootInstId);
			year = rootInstance.getProcessDefinition().getStartedTime(rootInstance).get(Calendar.YEAR);
			
			iframeUrl = GlobalContext.WEB_CONTEXT_ROOT + "/wih/defaultHandler/historyWorkItem.jsp?tag=" + activityCount + "&htmlPath=" 
						+ URLEncoder.encode(year + "/" + rootInstance.getInstanceId() + "/" + taskId + ".html", GlobalContext.ENCODING);
			
			if(!taskId.equals(viewTaskId)){
				
      out.write("<div class=\"formcontextwrap\">\r\n");
      out.write("\t\t            <div class=\"formcontexticon\">");
      out.print((activityCount < 10) ? "0" + activityCount : activityCount);
      out.write("</div>\r\n");
      out.write("\t\t            <div class=\"formcontexttitle\">");
      out.print(statusMsg + workTitle );
      out.write(' ');
      out.write('(');
      out.print(roleName );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(resourceName );
      out.write(")</div>\r\n");
      out.write("\t\t            <div class=\"formcontext\">\r\n");
      out.write("\t\t                <div id=\"btnGetHistory_");
      out.print(activityCount );
      out.write("\" onclick=\"getFormContext('");
      out.print(activityCount );
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(iframeUrl );
      out.write("');\" class=\"formcontextshowpane\"><div class=\"endtime\">");
      out.print(workTime );
      out.write("</div></div>\r\n");
      out.write("\t\t                <div id=\"btnShowHistory_");
      out.print(activityCount );
      out.write("\" onclick=\"showHistoryContent('");
      out.print(activityCount );
      out.write("');\" class=\"formcontexthidepane\" ><div class=\"endtime\">");
      out.print(workTime );
      out.write("</div></div>\r\n");
      out.write("\t\t                <div id=\"btnHideHistory_");
      out.print(activityCount );
      out.write("\" onclick=\"hideHistoryContent('");
      out.print(activityCount );
      out.write("');\" class=\"formcontextshowpanedisnone\" ><div class=\"endtime\" ><!-- style=\"float:right; padding:8px 90px 0 0;\" -->");
      out.print(workTime );
      out.write("</div></div>\r\n");
      out.write("\t\t            </div>\r\n");
      out.write("\t\t        </div>\r\n");
      out.write("\t\t        <table id=\"tableHistoryContent_");
      out.print(activityCount );
      out.write("\" align=\"center\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"display:none; margin-bottom:35px;\">\r\n");
      out.write("\t\t            <tr>\r\n");
      out.write("\t\t                <td width=\"26\" height=\"14\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo01.gif\" /></td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"4\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineT.gif\"></td>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineT.gif\"></td>\r\n");
      out.write("\t\t                <td width=\"30\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo02.gif\" /></td>\r\n");
      out.write("\t\t            </tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineL.gif\"></td>\r\n");
      out.write("\t\t                <td></td>\r\n");
      out.write("\t\t                <td align=\"left\" >\r\n");
      out.write("\t\t                <iframe frameborder=\"0\" id=\"historyContentArea_");
      out.print(activityCount );
      out.write("\" src=\"\" width=\"100%;\"></iframe>\r\n");
      out.write("\t\t                </td>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineR.gif\"></td>\r\n");
      out.write("\t\t            </tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t                <td height=\"4\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo04.gif\"  /></td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"4\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineB.gif\"></td>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineB.gif\"></td>\r\n");
      out.write("\t\t                <td><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo03.gif\"  /></td>\r\n");
      out.write("\t\t            </tr>\r\n");
      out.write("\t\t        </table>");

			}else{
				
      out.write("<div class=\"formcontextwrap\">\r\n");
      out.write("\t\t            <div class=\"formcontexticon\">");
      out.print((activityCount < 10) ? "0" + activityCount : activityCount);
      out.write("</div>\r\n");
      out.write("\t\t            <div class=\"formcontexttitle\">");
      out.print(statusMsg + workTitle );
      out.write(' ');
      out.write('(');
      out.print(roleName );
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(resourceName );
      out.write(")</div>\r\n");
      out.write("\t\t            <div class=\"formcontext\">\r\n");
      out.write("\t\t                <div id=\"btnShowHistory_");
      out.print(activityCount );
      out.write("\" onclick=\"showHistoryContent('");
      out.print(activityCount );
      out.write("');\" class=\"formcontexthidepane\" style=\"display:none;\"><div class=\"endtime\">");
      out.print(workTime );
      out.write("</div></div>\r\n");
      out.write("\t\t                <div id=\"btnHideHistory_");
      out.print(activityCount );
      out.write("\" onclick=\"hideHistoryContent('");
      out.print(activityCount );
      out.write("');\" class=\"formcontextshowpanedisnone\" style=\"display:block;\"><div class=\"endtime\" ><!-- style=\"float:right; padding:8px 90px 0 0;\" -->");
      out.print(workTime );
      out.write("</div></div>\r\n");
      out.write("\t\t            </div>\r\n");
      out.write("\t\t        </div>\r\n");
      out.write("\t\t        <table id=\"tableHistoryContent_");
      out.print(activityCount );
      out.write("\" align=\"center\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin-bottom:35px;\">\r\n");
      out.write("\t\t        \t<tr>\r\n");
      out.write("\t\t        \t\t<td colspan=\"4\">");

	if(!initiate){
		String status = pm.getActivityStatus(instanceId, tracingTag);
		if(status!=null && !status.equals("Running") && !status.equals("Timeout")){
			isViewMode=true;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"4\">\r\n");
      out.write("\t<tr height=\"1\">\r\n");
      out.write("\t\t<td align=\"center\" height=\"1\" class=\"bgcolor_head_underline\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td align=\"center\">\r\n");
      out.write("\t\t\tThe work item has been closed (<b>");
      out.print(status);
      out.write("</b>)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");

		}
	}

      out.write('\r');
      out.write('\n');
      out.write("</td>\r\n");
      out.write("\t\t        \t</tr>\r\n");
      out.write("\t\t            <tr>\r\n");
      out.write("\t\t                <td width=\"26\" height=\"14\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo01.gif\" /></td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"4\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineT.gif\"></td>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineT.gif\"></td>\r\n");
      out.write("\t\t                <td width=\"30\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo02.gif\" /></td>\r\n");
      out.write("\t\t            </tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineL.gif\"></td>\r\n");
      out.write("\t\t                <td></td>\r\n");
      out.write("\t\t                <td align=\"left\" >\r\n");
      out.write("\t\t                <iframe frameborder=\"0\" id=\"historyContentArea_");
      out.print(activityCount );
      out.write("\" src=\"");
      out.print(iframeUrl);
      out.write("\" width=\"100%;\"></iframe>\r\n");
      out.write("\t\t                </td>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineR.gif\"></td>\r\n");
      out.write("\t\t            </tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t                <td height=\"4\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo04.gif\"  /></td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"4\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineB.gif\"></td>\r\n");
      out.write("\t\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxLineB.gif\"></td>\r\n");
      out.write("\t\t                <td><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/formContextConBoxMo03.gif\"  /></td>\r\n");
      out.write("\t\t            </tr>\r\n");
      out.write("\t\t        </table>");
				
			}
			
			activityCount ++;
		}
		
		if(Activity.STATUS_RUNNING.equals(initiationActivity.getStatus(piRemote))){  
	   
      out.write("<div class=\"runformcontextwrap\">\r\n");
      out.write("           <div class=\"runformcontexticon\">");
      out.print((activityCount < 10) ? "0" + activityCount : "" + activityCount);
      out.write("</div>\r\n");
      out.write("           <div class=\"runformcontexttitle\">");
      out.print( piRemote.getProcessDefinition().getActivity(tracingTag).getName() );
      out.write("</div>\r\n");
      out.write("           <div class=\"runformcontext\"><div class=\"starttime\">");
      out.print(initiationActivity.getStartedTime(piRemote).getTime().toLocaleString() );
      out.write("</div></div>\r\n");
      out.write("       </div>");

		}
	}
}

      out.write("\r\n");
      out.write("\t<form name=\"mainForm\" action=\"submit.jsp\" method=\"post\" onsubmit=\"checkTitles(this);\"  target=\"messageFrameName\">\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");

try {
	
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	ProcessInstance instance = piRemote;

//	ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
	FormActivity formActivity = (FormActivity)initiationActivity;
	
	if(Activity.STATUS_RUNNING.equals(formActivity.getStatus(instance)) || Activity.STATUS_TIMEOUT.equals(formActivity.getStatus(instance))){
	
		HtmlFormContext formContext = 
				initiate 
				? (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().getDefaultValue()) 
				: (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""))
		;
		String formDefId = formContext.getFormDefId();
		
		if (instance != null)
			request.setAttribute("instance", instance);
		if (pm != null)
			request.setAttribute("pm", pm);
		if (formActivity != null)
			request.setAttribute("formActivity", formActivity);
		if (loggedRoleMapping != null)
			request.setAttribute("loggedRoleMapping", loggedRoleMapping);
			
		String improve_process_defverid = request.getParameter("improve_process_defverid");
		String improve_process_name = "";
		if(UEngineUtil.isNotEmpty(improve_process_defverid)){
			request.setAttribute("improve_process_defverid", improve_process_defverid);
			ProcessDefinitionRemote processDefinitionRemote = pm.getProcessDefinitionRemote(improve_process_defverid);
			improve_process_name = processDefinitionRemote.getName().getText(loggedUserLocale);
			request.setAttribute("improve_process_name" , improve_process_name);
		}	
		
		//strategy
		String strategyId = request.getParameter("strategyId");
		if(UEngineUtil.isNotEmpty(strategyId)){
			request.setAttribute("strategyId", strategyId);
		}	
		
		final Map mappedResult = formActivity.getMappedResult(instance);
	/*	ForLoop loopForSettingAttributeValue = new ForLoop(){
			public void logic(Object value){
				String key = (String)value;
				request.setAttribute(key, mappedResult.get(key));
			}
		}.run(mappedResult.keySet());
		*/
		request.setAttribute("mappingResult", mappedResult);
		
		String[] defIdAndVersionId = formDefId.split("@");
		String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
		String formFileName = currProductionFormDefId; 
	
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\t<!-- ....Form Dispatch Part.... -->\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");
      out.write("\r\n");
      out.write("\t\t<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td width=\"26\" height=\"14\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxMo01.gif\"  /></td>\r\n");
      out.write("\t\t\t\t<td width=\"4\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxLineT.gif\"></td>\r\n");
      out.write("\t\t\t\t<td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxLineT.gif\"></td>\r\n");
      out.write("\t\t\t\t<td width=\"30\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxMo02.gif\"  /></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxLineL.gif\"></td>\r\n");
      out.write("\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t<td align=\"center\" style=\"padding:20px 0 ;\">\r\n");
      out.write("\t\t");
 
			divWidth = UEngineUtil.isNotEmpty(width) ? (Integer.parseInt(width)) + "px" : "98%"; 
		
      out.write("\r\n");
      out.write("\t\t\t\t\t<div id=\"inputLayer\" style=\"text-align: left;width: ");
      out.print(divWidth );
      out.write(";\">\r\n");
      out.write("\t\t");
 if (!isViewMode && isRacing) { 
      out.write("\r\n");
      out.write("\t\t\t\t<div id=\"disableLayer\" align=\"center\">\r\n");
      out.write("\t\t\t\t\t<strong>\r\n");
      out.write("\t\t\t\t\t");
      out.print(GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") );
      out.write("\r\n");
      out.write("\t\t\t\t\t</strong>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t");
 } 
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");

			out.flush();
			String cachedFormRoot = "/wih/formHandler/cachedForms/";
			File contextDir = new File(request.getRealPath(cachedFormRoot));
			
			FormUtil.copyToContext(contextDir, formFileName);
		
			RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot + formFileName + (isViewMode ? "_formview.jsp" : "_write.jsp"));
			request.setAttribute("isViewMode", isViewMode);
			rdIncludeAction.include(request, response);
			out.flush();
			
		
      out.write("\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t<td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxLineR.gif\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td height=\"4\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxMo04.gif\"  /></td>\r\n");
      out.write("\t\t\t\t<td width=\"4\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxLineB.gif\"></td>\r\n");
      out.write("\t\t\t\t<td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxLineB.gif\"></td>\r\n");
      out.write("\t\t\t\t<td><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/formContextConBoxMo03.gif\"  /></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t\r\n");
      out.write("\t    ");
      out.write("\r\n");
      out.write("\r\n");
      java.lang.String allTagArray = null;
      synchronized (application) {
        allTagArray = (java.lang.String) _jspx_page_context.getAttribute("allTagArray", PageContext.APPLICATION_SCOPE);
        if (allTagArray == null){
          allTagArray = new java.lang.String();
          _jspx_page_context.setAttribute("allTagArray", allTagArray, PageContext.APPLICATION_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');

String hiddenTag = "";
String defaultTagName = "{\"defaultTag\":\"\"}";
TagDAO dao = new TagDAO();

allTagArray = dao.getAllTag(allTagArray, loggedUserGlobalCom);

if (initiate) {
	defaultTagName = dao.getDefaultTagString(processDefinition, loggedUserGlobalCom);

      out.write("\r\n");
      out.write("<div style=\"width:100%;padding-left:30px;\">\r\n");
      out.write("\t<div style=\"float:left; padding-top:3px;\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/tag.gif\" width=\"28\" height=\"14\" align=\"absmiddle\" /></div>\r\n");
      out.write("\t<div id=\"divTag\" style=\"text-align:left; width:auto; float:left; padding-top:3px; padding-left:2px; padding-right:2px;\"></div>\r\n");
      out.write("\t<div style=\"float:left;\">\r\n");
      out.write("\t    <input type=\"text\" id=\"tagText\" name=\"tagText\" value=\"\" title=\"");
      out.print(GlobalContext.getMessageForWeb("tag.enter", loggedUserLocale) );
      out.write("\"/>\r\n");
      out.write("\t    <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/addtag.gif\" width=\"45\" height=\"18\" align=\"absmiddle\" id=\"tagAdd\" style=\"cursor:pointer;\"/>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");

/**
 * not initiator
 * 
 **/
} else if (piRemote != null) { // not initiate
    String[] result = dao.getTagList(loggedUserGlobalCom, piRemote.getInstanceId(), piRemote.getRootProcessInstanceId());
    String tags = result[0] == null ? "" : result[0];
    hiddenTag = result[1] == null ? "" : result[1];

      out.write("\r\n");
      out.write("\r\n");
      out.write("<div style=\"float:left; padding-top:3px;\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/tag.gif\" width=\"28\" height=\"14\" align=\"absmiddle\" /></div>\r\n");
      out.write("<div style=\"text-align:left; width:auto; float:left; padding-top:3px; padding-left:2px; padding-right:2px;\">\r\n");
      out.print(tags );
      out.write("&nbsp;\r\n");
      out.write("</div>\r\n");

    String status = pm.getActivityStatus(instanceId, tracingTag);
    if(status!=null && !status.equals("Completed") && !status.equals("Timeout")){

      out.write("\r\n");
      out.write("<div id=\"divTag\" style=\"text-align:left; width:auto; float:left; padding-top:3px; padding-left:2px; padding-right:2px;\"></div>\r\n");
      out.write("<div style=\"float:left;\">\r\n");
      out.write("    <input type=\"text\" id=\"tagText\" name=\"tagText\" value=\"\" title=\"");
      out.print(GlobalContext.getMessageForWeb("tag.enter", loggedUserLocale) );
      out.write("\" style=\"text-align:left;\"/>\r\n");
      out.write("    <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/addtag.gif\" width=\"45\" height=\"18\" align=\"absmiddle\" id=\"tagAdd\" style=\"cursor:pointer;\"/>\r\n");
      out.write("</div>\r\n");

    }
}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<input type=\"hidden\" id=\"tags\" name=\"tags\" value=\"");
      out.print(hiddenTag );
      out.write("\"/>\r\n");
      out.write("<style>\r\n");
      out.write("    .ui-autocomplete-loading { background: white url('");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/ui-anim_basic_16x16.gif') right center no-repeat; }\r\n");
      out.write("    #tagText { width: 10em; }\r\n");
      out.write("</style>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("var cnt = 0;\r\n");
      out.write("var availableTags = ");
      out.print(allTagArray );
      out.write(";\r\n");
      out.write("\r\n");
      out.write("$(\"#tagAdd\").click(function() {\r\n");
      out.write("    if($(\"#tagText\").val() == \"\") {\r\n");
      out.write("        alert(\"태그를 입력해 주세요.\");\r\n");
      out.write("        return;\r\n");
      out.write("    }\r\n");
      out.write("    \r\n");
      out.write("    addTag($(\"#tagText\").val());\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function addTag(message) {\r\n");
      out.write("    var tags = $(\"#tags\").val();\r\n");
      out.write("    \r\n");
      out.write("    var tagArray = tags.split(\";\");\r\n");
      out.write("    for (var i=0; i < tagArray.length; i++) {\r\n");
      out.write("    \tif (tagArray[i] == message) {\r\n");
      out.write("    \t\talert(\"이미 등록된 Tag 입니다.\");\r\n");
      out.write("    \t\treturn;\r\n");
      out.write("    \t}\r\n");
      out.write("    }\r\n");
      out.write("    \r\n");
      out.write("    if (message == \";\") {\r\n");
      out.write("        alert(\"특수문자 \\\";\\\"는 태그로 등록할수 없는 문자 입니다.\");\r\n");
      out.write("        return;\r\n");
      out.write("    }\r\n");
      out.write("    \r\n");
      out.write("    cnt++;\r\n");
      out.write("    \r\n");
      out.write("    var tagText = message.toLowerCase() + \";\";\r\n");
      out.write("    \r\n");
      out.write("    var spanTag = \"<span style=\\\"text-align:left; font-size:12px; color:#7b7b7b\\\" id=\\\"tag_\"+cnt+\"\\\">\" \r\n");
      out.write("                + message \r\n");
      out.write("                + \"<img src=\\\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/tag_del.gif\\\" onclick=\\\"tagDelete(\"+cnt+\", '\" + tagText + \"')\\\" style=\\\"cursor:pointer\\\"/>\"\r\n");
      out.write("                + \"</span>\";\r\n");
      out.write("    \r\n");
      out.write("    $(\"#divTag\").append(spanTag);\r\n");
      out.write("    $(\"#tags\").val($(\"#tags\").val() + tagText);\r\n");
      out.write("    $(\"input[name=tagText]\").val(\"\");\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function addText(message) {\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("$(\"#tagText\")\r\n");
      out.write("    .bind(\"keydown\", function() {\r\n");
      out.write("        if ( event.keyCode === $.ui.keyCode.ENTER) {\r\n");
      out.write("            if($(this).val() != \"\") {\r\n");
      out.write("                addTag($(\"#tagText\").val());\r\n");
      out.write("            }\r\n");
      out.write("           \r\n");
      out.write("            return false;\r\n");
      out.write("        }\r\n");
      out.write("    })\r\n");
      out.write("    .autocomplete({\r\n");
      out.write("        source: availableTags,\r\n");
      out.write("        \t//function( request, response ) {\r\n");
      out.write("            //$.ajax({\r\n");
      out.write("            //    url:\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/tagService\",\r\n");
      out.write("            //    dataType: \"json\",\r\n");
      out.write("            //    data: {\"tag\" : $(\"#tagText\").val(), \"type\" : \"json\"},\r\n");
      out.write("            //    type : \"post\",\r\n");
      out.write("            //    success: function( data ) {\r\n");
      out.write("            //        response( $.map( data.tagList, function( item ) {\r\n");
      out.write("            //            return {\r\n");
      out.write("            //                label: item.name,\r\n");
      out.write("            //                value: item.name\r\n");
      out.write("            //            }\r\n");
      out.write("            //        }));\r\n");
      out.write("            //    },\r\n");
      out.write("            //    error:function(){\r\n");
      out.write("            //        alert(\"Fail load Fire Action\");\r\n");
      out.write("            //        alert(this.url);\r\n");
      out.write("            //    }\r\n");
      out.write("            //});\r\n");
      out.write("        //},\r\n");
      out.write("        minLength: 1,\r\n");
      out.write("        select: function( event, ui ) {\r\n");
      out.write("        \tif ($(this).val() == \"\") return false;\r\n");
      out.write("            //addText( ui.item ? ui.item.label : this.value);\r\n");
      out.write("        },\r\n");
      out.write("        open: function() {\r\n");
      out.write("            $( this ).removeClass( \"ui-corner-all\" ).addClass( \"ui-corner-top\" );\r\n");
      out.write("        },\r\n");
      out.write("        close: function() {\r\n");
      out.write("            $( this ).removeClass( \"ui-corner-top\" ).addClass( \"ui-corner-all\" );\r\n");
      out.write("        }\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function tagDelete(num, text) {\r\n");
      out.write("    $(\"#tags\").val($(\"#tags\").val().replace(text, \"\"));\r\n");
      out.write("    $(\"#tag_\"+num).remove();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function tagValidation() {\r\n");
      out.write("    var racing = \"");
      out.print(isRacing);
      out.write("\";\r\n");
      out.write("    var inituser = \"");
      out.print(initiate);
      out.write("\";\r\n");
      out.write("\r\n");
      out.write("    if (racing == \"false\" && inituser == \"true\" && $(\"#tags\").val() == \"\") {\r\n");
      out.write("        alert(\"태그는 필수 입력사항 입니다. 하나 이상의 태그를 등록해 주십시요.\");\r\n");
      out.write("        return false;\r\n");
      out.write("    }\r\n");
      out.write("    \r\n");
      out.write("    return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("$(document).ready(function() {\r\n");
      out.write("\tvar tag = ");
      out.print(defaultTagName);
      out.write(";\r\n");
      out.write("\tif (tag.defaultTag != \"\") {\r\n");
      out.write("\t\taddTag(tag.defaultTag);\r\n");
      out.write("\t}\r\n");
      out.write("});\r\n");
      out.write("//-->\r\n");
      out.write("</script>");
      out.write("\r\n");
      out.write("\t\t");

if(!isViewMode) {

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvar msgCompleteWork = \"");
      out.print(GlobalContext.getMessageForWeb("Do you want complete work?", loggedUserLocale) );
      out.write("\";\r\n");
      out.write("\tvar msgDelegateWork = \"");
      out.print(GlobalContext.getMessageForWeb("Do you want to delegate?", loggedUserLocale) );
      out.write("\";\r\n");
      out.write("\tvar msgSaveWork = \"");
      out.print(GlobalContext.getMessageForWeb("Do you want to save work?", loggedUserLocale) );
      out.write("\";\r\n");
      out.write("</script>\r\n");
      out.write("<div id=\"bottombtnline\">\r\n");
      out.write("\t\t<br/>\r\n");
      out.write("\t\t");

				if (isRacing) {
		
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\t<table align=\"center\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td class=\"gBtn\">\r\n");
      out.write("                                <a onclick=\"javascript:acceptWorkitem()\" ><span>");
      out.print(GlobalContext.getMessageForWeb("Accept", loggedUserLocale) );
      out.write("</span></a>\r\n");
      out.write("                            </td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("\t\t\t\t\t<!--<a href=\"javascript:acceptWorkitem()\"><img src=\"../../images/Common/b_btm_acceptance.gif\" /></a>&nbsp;-->\r\n");
      out.write("\t\t");
		
				} else if (isMine) {
		
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\t<table align=\"center\" style=\"padding:30px;\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td class=\"gBtn\"  style=\"padding:0 30px;\" nowrap=\"nowrap\">\r\n");
      out.write("                            \t<a style=\"background:none\" ><span style=\"background:none\">&nbsp;&nbsp;&nbsp;</span></a>\r\n");
      out.write("                                <a onclick=\"javascript: submitMainForm();\" ><span>");
      out.print(GlobalContext.getMessageForWeb("Complete", loggedUserLocale) );
      out.write("</span></a>\r\n");
      out.write("                                <a onclick=\"javascript: window.parent.window.close();\" ><span>");
      out.print(GlobalContext.getMessageForWeb("Cancel", loggedUserLocale) );
      out.write("</span></a>\r\n");
      out.write("                                <a onclick=\"javascript: saveWorkitem();\" ><span>");
      out.print(GlobalContext.getMessageForWeb("Save", loggedUserLocale) );
      out.write("</span></a>\r\n");
      out.write("                             \r\n");
      out.write("                         \r\n");
      out.write("                            \r\n");
      out.write("\t\t");

					if (!initiate) {
		
      out.write("\t\t\t\t        \t\t\t\t\r\n");
      out.write("                                <a onclick=\"javascript:delegateWorkitem()\" ><span>");
      out.print(GlobalContext.getMessageForWeb("Delegate", loggedUserLocale) );
      out.write("</span></a> \r\n");
      out.write("                                <input name=\"delegateEndpoint\" id=\"delegateEndpoint\" type=\"hidden\">\r\n");
      out.write("                                <!-- <a onclick=\"javascript:showhideBackDiv('show');\"/><span>");
      out.print(GlobalContext.getMessageForWeb("Back", loggedUserLocale));
      out.write("</span></a> -->\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t    ");

					}
		
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t <a style=\"background:none\" ><span style=\"background:none\">&nbsp;&nbsp;&nbsp;</span></a>\r\n");
      out.write("\t\t\t\t\t");
if(!initiate){ 
      out.write("\r\n");
      out.write("\t\t\t\t\t");
      out.write("<!-- cancle Action -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	ProcessDefinition tempProcessDefinition = piRemote.getProcessDefinition();
	String tempInstanceId = piRemote.getInstanceId();
	
    final HumanActivity currentTempActivity = initiationActivity;
	final org.uengine.kernel.Role currentRoleMapping = currentTempActivity.getRole();
	final ProcessInstance pi = piRemote;
	final Vector backableActivity = new Vector();
	final Vector completedActivity = new Vector();	
	
	ActivityForLoop findBackableActivities = new ActivityForLoop(){
		public void logic(Activity activity) {
			if(activity != null){
	    		try{
		       		if(activity instanceof HumanActivity && 
		       		   activity.STATUS_COMPLETED.equals(activity.getStatus(pi))&&
		       		   ((HumanActivity)activity).getRole().getMapping(pi).getEndpoint().equals(currentRoleMapping.getMapping(pi).getEndpoint())){
		       		   
		        		backableActivity.add(activity);
		       		}
		       		
		       		if(activity instanceof HumanActivity && 
		       		   activity.STATUS_COMPLETED.equals(activity.getStatus(pi))){
		       		   
		        		completedActivity.add(activity);
		       		}
		       		
	       		}catch(Exception e){}
			}
	      }
	     
	  };	    
	  findBackableActivities.run(tempProcessDefinition);

      out.write('\r');
      out.write('\n');

	try{
		int backSize = backableActivity.size();
		StringBuffer backOption = null;
		if(backSize > 0){
			backOption = new StringBuffer();
			for(int i=backSize-1; i>-1; i--){
				HumanActivity bAct = (HumanActivity)backableActivity.get(i);
				backOption.append("<option value=\""+bAct.getTracingTag()+"\">"+bAct.getName().getText()+"</option>");
			}
			
      out.write("\r\n");
      out.write("\t\t\t<!-- Backable Activity start -->\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<script type=\"text/javascript\">\r\n");
      out.write("\t\t\t\tfunction showhideBackDiv(state){\r\n");
      out.write("\t\t\t\t\t//set state\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tvar backDiv = document.getElementById(\"back\");\r\n");
      out.write("\t\t\t\t\tif(state==\"hide\")\r\n");
      out.write("\t\t\t\t\t\tbackDiv.style.visibility = \"hidden\";\r\n");
      out.write("\t\t\t\t\telse if(state==\"show\"){\r\n");
      out.write("\t\t\t\t\t\tbackDiv.style.visibility = \"visible\";\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t</script>\r\n");
      out.write("\t\t\t<div id=\"back\" style=\"visibility: hidden; position: relative; \">\r\n");
      out.write("\t\t\t\t<table bgcolor=\"#efefef\" cellspacing=\"3\" align=\"right\">\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"2\" align=\"right\">\r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:showhideBackDiv('hide');\"><span>x</span></a>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<select id=\"tracingtag\">\r\n");
      out.write("\t\t\t\t\t\t");
      out.print(backOption);
      out.write("\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<a onclick=\"javascript:back(document.getElementById('tracingtag').value);\"/>\r\n");
      out.write("\t\t\t\t\t\t<span>");
      out.print(GlobalContext.getMessageForWeb("Back", loggedUserLocale));
      out.write("</span></a>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<!-- Backable Activity end -->\r\n");
      out.write("\t\t\t");

		}
	}catch(Exception e){}

      out.write("\r\n");
      out.write("\t\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t </td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("\t\t");

		
		
		
		 			//if(backableActivity.size() > 0){ %
					//<br/><br/><select id="tracingtag">
					//	%
						  //for(int i=backableActivity.size()-1; i>-1; i--){
						//	Activity act = (Activity)backableActivity.get(i);
						//%
						 // 	<option value="<=act.getTracingTag()>"><=act.getName()></option>
						//%
						 // }
					//	%
					//</select>
					//<input type="button" value="forword" onclick="javascript:back(document.getElementById('tracingtag').value);"/>
					//% }
		 			
				
			}
		
      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tfunction onEventButtonClicked(eventName){\r\n");
      out.write("\t\t\tdocument.forms[0].action = \"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/eventHandler.jsp\";\r\n");
      out.write("\t\t\tdocument.forms[0].eventName.value = eventName;\r\n");
      out.write("\t\t\tdocument.forms[0].submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("\r\n");

		org.uengine.kernel.EventHandler[] eventHandlersInAction = (org.uengine.util.UEngineUtil.isNotEmpty(instanceId) ? pm.getEventHandlersInAction(instanceId) : null);

		if(eventHandlersInAction!=null && eventHandlersInAction.length > 0){
			for(int i=0; i<eventHandlersInAction.length; i++){
				org.uengine.kernel.EventHandler theEventHandler = eventHandlersInAction[i];
				if (
						theEventHandler.getTriggeringMethod() == org.uengine.kernel.EventHandler.TRIGGERING_BY_EVENTBUTTON 
						//&& theEventHandler.getHandlerActivity() instanceof SubProcessActivity
				) {
					if (
							(theEventHandler.getOpenRoles() != null 
							&& !theEventHandler.getOpenRoles().containsMapping(piRemote, loggedRoleMapping))
							|| (isEventHandler && theEventHandler.getName().equals(eventName)) //ìê¸° ìì ì´ ì´ë²¤í¸ í¸ë¤ë¬ì´ê³ , ëì¼í ì´ë²¤í¸ ë¤ìì ê°ì§ê³  ìë¤ë©´ ì´ë²¤í¸ ë²í¼ì ì¶ë ¥íì§ ìëë¤.
					) continue;
					
					if("reject".equals(theEventHandler.getName())){
						
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:onEventButtonClicked('");
      out.print(theEventHandler.getName());
      out.write("');\"><img src=\"../../images/Common/b_btn_reject.gif\"></a>&nbsp;\r\n");
      out.write("\t\t\t\t\t\t");
							
					} else if ("reselect".equals(theEventHandler.getName())) {
						
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:onEventButtonClicked('");
      out.print(theEventHandler.getName());
      out.write("');\"><img src=\"../../images/Common/b_btm_reselect.gif\"></a>&nbsp;\r\n");
      out.write("\t\t\t\t\t\t");

					} else {
						
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<div class=\"gBtn1\"><a href=\"javascript:onEventButtonClicked('");
      out.print(theEventHandler.getName());
      out.write("')\">");
      out.print(theEventHandler.getDisplayName().getText(loggedUserLocale));
      out.write("</a></div>&nbsp;\r\n");
      out.write("\t\t\t\t\t\t");

					}
				}
			}	
		}else{
			
		}
		//<!-- a href="javascript:onEventButtonClicked('<!--%=theEventHandler.getName()%-->')"><!-- img src="/images/Common/b_btn_reject.gif"></a>&nbsp;-->

      out.write("\t\r\n");
      out.write("</div>\r\n");
      out.write("<br>\r\n");

}

      out.write("<br />\r\n");
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
      out.write("\t\t<input type=\"hidden\" value='");
      out.print(loggedUserId);
      out.write("' name='userId'/>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");

	
	}
	
}catch(Exception e){
	
/*	out.print("<b>Error Form, Modify the form.</b><br/><br/>");
	java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\d\\:");
    for ( String splittedString : e.getMessage().split(pattern.pattern()) ) {
        out.print(splittedString + "<br />");
    }*/
    Exception exception = e;

      out.write('\r');
      out.write('\n');

	Throwable orgErr = exception;			// 오류 객체.
	
	int errLevel = UEngineException.ERROR;
	String userMsg = "";

	Throwable finding = orgErr;
	
	while(!(finding instanceof UEngineException) && finding!=null){
		finding = finding.getCause();
	}
	
	if (finding instanceof UEngineException){
		errLevel = ((UEngineException)finding).getErrorLevel();
		orgErr = finding;
	}
	
	if (3 == errLevel) {
		userMsg = "올치 않은 데이터가 입력되었습니다. 다시한번 확인해 주십시오! (ERROR LEVEL : " + errLevel + ")<br />";
	} else {
		userMsg = "예외상황이 발생하였습니다. 아래 내용을 관리자에게 문의하세요! (ERROR LEVEL : " + errLevel + ")<br />";
	}
	
	
	String[] errIconForErrorLevels = new String[]{
			"bug.gif",
			"bug.gif",
			"bug.gif",
			"info.gif"
	};
	
	String errIcon = errIconForErrorLevels[errLevel];
	String errTitle = orgErr.getMessage().replace(">","&gt;").replace("<","&lt;").replace("\n","<br/>");	// 오류 제목.
	String errDesc = orgErr.toString().replace(">","&gt;").replace("<","&lt;").replace("\n","<br/>");		// 오류 설명.

	if( exception != null && exception instanceof ServletException ){
		if( ((ServletException)exception).getRootCause() != null ){
			orgErr = ((ServletException)exception).getRootCause();
			errTitle = orgErr.getMessage();	// 오류 제목.
			errDesc = orgErr.toString();		// 오류 설명.
		}
	}
	
	
	exception.printStackTrace();
	//errorLogger.error(errTitle, orgErr);
	// TODO : 관리자에게 메일 보내기.

      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>::: ERROR :::</title>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/common/callback/errorpage.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/common.css\" type=\"text/css\">\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\ttry {\r\n");
      out.write("\t\twindow.parent.closeLoadingLayer();\r\n");
      out.write("\t} catch (e) { }\r\n");
      out.write("</script>\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("body {\r\n");
      out.write("\tmargin: 0;\r\n");
      out.write("\toverflow: hidden;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body bgcolor=\"#F7F7F7\">\r\n");
      out.write("<div id=\"divErrorHeader\" style=\"display: none;\">\r\n");
 if (3 == errLevel) { 
      out.write("\r\n");
      out.write("\t<strong>");
      out.print(errTitle);
      out.write("</strong>\r\n");
 } else { 
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td align=\"center\"><table id=\"Table_01\" width=\"563\" height=\"94\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td rowspan=\"5\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/error01_01.jpg\" width=\"100\" height=\"94\" alt=\"\"></td>\r\n");
      out.write("                <td height=\"34\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorIMG.gif\" width=\"69\" height=\"18\"\r\n");
      out.write("                /><a href=\"javascript:\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/detailinfo.gif\" width=\"69\" height=\"18\"\r\n");
      out.write("                id=\"idBtnDetailinfo\" border=\"0\" /></a></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height=\"19\" style=\"font-size:12px;\">\r\n");
      out.write("                \t");
      out.print( userMsg );
      out.write("\r\n");
      out.write("                </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td background=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorlinedot.gif\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height=\"24\" style=\"color:#5a9aea; font-size:11px;\">\r\n");
      out.write("                \t");
      out.print(errTitle);
      out.write("\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height=\"16\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("        </table></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"divOrgBugDescript\" style=\"display: none;\">\r\n");
      out.write("<table width=\"720\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#FFFFFF\" align=\"center\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td width=\"3\" height=\"3\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxMo01.gif\" width=\"4\" height=\"4\"></td>\r\n");
      out.write("        <td background=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxLine01.gif\"></td>\r\n");
      out.write("        <td width=\"3\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxMo02.gif\" width=\"4\" height=\"4\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td background=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxLine04.gif\"></td>\r\n");
      out.write("        <td align=\"center\" style=\"padding:10px;\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td><table width=\"700\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td width=\"105\" height=\"40\" rowspan=\"2\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorIMG02.gif\" width=\"86\" height=\"37\"></td>\r\n");
      out.write("                        <td width=\"448\" height=\"20\" rowspan=\"2\" style=\"font-size:12px; color:#5a9aea; font-weight:bold;\">");
      out.print(errTitle);
      out.write("</td>\r\n");
      out.write("                        <td width=\"147\" rowspan=\"2\" align=\"right\">\r\n");
      out.write("                        \t<a href=\"javascript:\" name=\"btnCloseMsg\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/closeMsg.gif\" width=\"69\" height=\"18\" border=\"0\"></a>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                   \t");
/*
                    <tr>
                        <td height="20" style="font-size:12px;">
                        	%=errDesc%
                    	</td>
                    </tr>
                    */
      out.write("\r\n");
      out.write("                </table></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height=\"10\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td bgcolor=\"#333333\" height=\"1\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height=\"10\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td>\t\r\n");
      out.write("                \t<div style=\"width:100%; height:400px; font-size:11px;\">\r\n");
      out.write("                     \t<textarea name=\"stackTrace\" style=\"width:100%; height:400px;\">\r\n");

	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw);
	orgErr.printStackTrace(pw);
	out.print(sw);

	orgErr.printStackTrace();
	
	sw.close();
	pw.close();

      out.write("\r\n");
      out.write("\t\t\t\t\t    </textarea>\r\n");
      out.write("                \t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("            </tr>\r\n");
      out.write("        </table></td>\r\n");
      out.write("        <td background=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxLine02.gif\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td height=\"3\"><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxMo04.gif\" width=\"4\" height=\"4\"></td>\r\n");
      out.write("        <td background=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxLine03.gif\"></td>\r\n");
      out.write("        <td><img src=\"");
      out.print(org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/errorMsgBoxMo03.gif\" width=\"4\" height=\"4\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
 } 
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");

   	//e.printStackTrace(response.getWriter());
} finally {
	try { pm.cancelChanges(); } catch(Exception ex) {}
	try { pm.remove(); } catch(Exception ex) {}
}
	
      out.write("\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"saveOnly\">\r\n");
      out.write("\t</form>\r\n");
      out.write("\t\r\n");
      out.write("\t<form name='hiddenForm' id=\"hiddenForm\" method=\"post\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"value\">\r\n");
      out.write("\t</form>\r\n");
      out.write("</div></div>\r\n");
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
