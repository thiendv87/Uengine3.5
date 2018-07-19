package org.apache.jsp.processparticipant.worklist;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import org.uengine.util.dao.*;
import org.uengine.persistence.dao.*;
import org.uengine.persistence.processinstance.*;
import org.uengine.ui.list.datamodel.DataMap;
import org.uengine.ui.list.datamodel.DataList;
import org.uengine.ui.list.datamodel.QueryCondition;
import org.uengine.ui.list.util.HttpUtils;
import org.uengine.ui.list.util.DAOListCursorUtil;
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

public final class wl2_005finstanceList_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants.add("/processparticipant/worklist/../../common/header.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/headerMethods.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/getLoggedUser.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../common/styleHeader.jsp");
    _jspx_dependants.add("/processparticipant/worklist/../../lib/jquery/importJquery.jsp");
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
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
      out.write("\r\n");
      out.write("\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../../scripts/formActivity.js.jsp" + (("../../scripts/formActivity.js.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("rmClsName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(rmClsName), request.getCharacterEncoding()), out, false);
      out.write('\r');
      out.write('\n');
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
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/instanceList.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("$(document).ready(function() {\r\n");
      out.write("\tsetCalender(\"");
      out.print(loggedUserLocale);
      out.write("\", {buttonImage:\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Icon/btn_calendar.gif\"});\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function changeView(objButton) {\r\n");
      out.write("\tvar divMainSearch = document.getElementById(\"divMainSearch\");\r\n");
      out.write("\tvar divSubSearch = document.getElementById(\"divSubSearch\");\r\n");
      out.write("\tif (divSubSearch.style.display == \"\") {\r\n");
      out.write("\t\t//divMainSearch.style.display = \"\";\r\n");
      out.write("\t\tdivSubSearch.style.display = \"none\";\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tobjButton.src = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/b_filteropen_");
      out.print(loggedUserLocale);
      out.write(".gif\";\r\n");
      out.write("\t\tobjButton.style.cursor=\"pointer\";\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\t//divMainSearch.style.display = \"none\";\r\n");
      out.write("\t\tdivSubSearch.style.display = \"\";\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tobjButton.src = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/images/Common/b_filterclose_");
      out.print(loggedUserLocale);
      out.write(".gif\";\r\n");
      out.write("\t\tobjButton.style.cursor=\"pointer\";\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\t\t\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");

	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	// Work List BF.
	//	WorkListBusinessFacade workListBF = null;

	// 占쏙옙占쏙옙占쏙옙 占쏙옙d.
	int intPageCnt = 50; // 占쏙옙 占쏙옙占쏙옙占쏙옙占� 10占쏙옙 占쏙옙
	int nPagesetSize = 10; // 占싹댐옙 占쏙옙占쏙옙占쏙옙 占쏙옙크 1~10占쏙옙占쏙옙
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	// 占싯삼옙 占쏙옙d.
	//String strTarget = reqMap.getString("TARGETCOND","procins.instancename");
	//String strKeyword = reqMap.getString("KEYWORDCOND", "");
	//String strDateKeyStart = reqMap.getString("INIT_START_DATE", "");
	//String strDateKeyEnd = reqMap.getString("INIT_END_DATE", "");
	//String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
	//String strDefTypeId = reqMap.getString("DEFTYPEID", "");

	// d占쏙옙 占쏙옙d.
	//String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	//String strSortCond = reqMap.getString("SORT_COND", "");
	
	//String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");
	//	String filtering = reqMap.getString("FILTERING","");
	//	RequestContext reqCtx = new RequestContext(request);
	//	User logdUser = reqCtx.getUser();
	//	loggedUserCompanyId=   logdUser.getCompanyId();

	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/
	//	reqMap.put("USER_ID",loggedUserId);
	//	reqMap.put("USER_LOGIN_NAME",loggedUserLoginName);
	//	reqMap.put("LOGGEDUSERCOMPANYID",loggedUserCompanyId);
	//reqMap.put("USER_ID","12345");	// test.
	//reqMap.put("FILTERING","");	// test.

	// Query Condition 占쏙옙d.
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);

	/***********************************************************************/
	/*                            Business Call & Data 占쏙옙占쏙옙			       */
	/***********************************************************************/
	// Work List 占쏙옙환.
	//	workListBF = new WorkListBusinessFacade();
	//	if("item_bpm".equals(menuItemId)){
	//		dl = workListBF.getWorkList(condition);
	//	}
	//}else {
	//dl = workListBF.getWorkListSON(condition);
	//}
	/***********************************************************************/
	/*                            Error Check	                           */
	/***********************************************************************/
	//	if( dl != null && dl.getErrCode() != null){
	//setError(request, dl.getErrCode());	// todo : Error 처占쏙옙.
	//	}

	/***********************************************************************/
	/*                            View Process	                           */
	/***********************************************************************/
	//	totalCount = (int)dl.getTotalCount();
	//	totalPageCount = dl.getTotalPageNo();

	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	String pd = reqMap.getString("processDefinition", "");
	//	if( pd == null ){
	//		return;
	//	}
	String folder = reqMap.getString("folder", "");
	String filtering = reqMap.getString("filtering", "0");
	String dispPdNameNId = "";
	if (!"".equals(folder)) {
		dispPdNameNId += folder;
	}
	if (!"".equals(pd)) {
		dispPdNameNId += "(" + pd + ")";
	}

	String search_user = reqMap.getString("search_user", "");
	String search_user_display = reqMap.getString("search_user_display", "");
	String processDefName = reqMap.getString("processDefName", "");
	String strDefinitionName = reqMap.getString("inputDefinitionName", "");
	String strInstanceName = reqMap.getString("inputInstanceName", "");
	String strWorkName = reqMap.getString("inputWorkName", "");
	String strWorkitemStartDate = reqMap.getString("workitem_start_date", "");
	String strWorkitemEndDate = reqMap.getString("workitem_end_date", "");
	String strWorkitemStartValueHandlerClass = reqMap.getString("workitem_start_value_handler_class", "");
	String strWorkitemEndValueHandlerClass = reqMap.getString("workitem_end_value_handler_class", "");
	String search_user__which_is_xml_value = reqMap.getString("search_user__which_is_xml_value", "");
	
	String p_initep = reqMap.getString("p_initep", "");

	// Filter
	//String processDefId = reqMap.getString("processDefId", "");
	String instanceInfo = reqMap.getString("instanceInfo", "");
	String endpointType = reqMap.getString("endpointType", "self");
	
	StringBuffer strAddWhere = new StringBuffer();
	
	// SimpleSearch
	String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
	if (UEngineUtil.isNotEmpty(simpleKeyWord)) {
		
		String lowerCaseFunctionName = "LCASE";
		String typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
		if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
		    lowerCaseFunctionName = "LOWER";
		}
		
		String simpleKeyWordLowerCase = UEngineUtil.searchStringFilter(simpleKeyWord.toLowerCase()); 
		
		strAddWhere.append(" AND ( ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.DEFNAME) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.INFO) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.NAME) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.INITEP)	 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.INITRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.CURREP)	 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.CURRRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ");
		strAddWhere.append(" ) ");
		
	} else {
		if (UEngineUtil.isNotEmpty(strDefinitionName)) {
			strAddWhere.append(" AND inst.defname LIKE '%").append(UEngineUtil.searchStringFilter(strDefinitionName)).append("%' ");
		}
	
		if (UEngineUtil.isNotEmpty(strInstanceName)) {
			strAddWhere.append(" AND inst.name LIKE '%").append(UEngineUtil.searchStringFilter(strInstanceName)).append("%' ");
		}
	
		if (UEngineUtil.isNotEmpty(strWorkitemStartDate)) {
			strAddWhere.append(" AND inst.starteddate >= '").append(UEngineUtil.searchStringFilter(strWorkitemStartDate)).append("' ");
		}
	
		if (UEngineUtil.isNotEmpty(strWorkitemEndDate)) {
			strAddWhere.append(" AND inst.starteddate <= '").append(UEngineUtil.searchStringFilter(strWorkitemEndDate)).append("' ");
		}
	
		if (UEngineUtil.isNotEmpty(search_user_display)) {
			strAddWhere.append(" AND inst.currrsnm LIKE '%").append(UEngineUtil.searchStringFilter(search_user_display)).append("%' ");
		}
	
		if (UEngineUtil.isNotEmpty(search_user)) {
			strAddWhere.append(" AND inst.currep LIKE '%").append(UEngineUtil.searchStringFilter(search_user)).append("%' ");
		}
		
		if (UEngineUtil.isNotEmpty(p_initep)) {
			strAddWhere.append(" AND inst.initep = '").append(UEngineUtil.searchStringFilter(p_initep)).append("' ");
		}
		
		
	}

	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	ProcessDefinitionRemote pdr = null;
	//replace with production version
	String pdver = null;
	String processName = "";
	//String pageType = "instance_view";
	
	ProcessManagerRemote pm = null;
	
	try {
		pm = processManagerFactory.getProcessManager();
		if (UEngineUtil.isNotEmpty(pd)) {
			pdver = pm.getProcessDefinitionProductionVersion(pd);
			pdr = pm.getProcessDefinitionRemote(pdver);
			processName = pdr.getName().getText();
		}
	} finally {
		pm.remove();
	}
	/*************************************************************************/
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
			GlobalContext.getMessageForWeb("Running", loggedUserLocale), "inst.status = 'Running'",
			GlobalContext.getMessageForWeb("Completed", loggedUserLocale), "inst.status = 'Completed'",
			GlobalContext.getMessageForWeb("Stopped", loggedUserLocale), "inst.status = 'Stopped'",
	//"Referencing",			"",
	};

	int filteringNo = 0;
	if (filtering != null && !"".equals(filtering) && !"undefined".equals(filtering)) {
		filteringNo = Integer.parseInt(filtering);
	}
	StringBuffer filter = new StringBuffer();
	
	if (!"".equals(filters[filteringNo * 2 + 1])) {
		filter.append(" and " + filters[filteringNo * 2 + 1]);
	}

	filter.append(" and inst.isdeleted=0");

	if (UEngineUtil.isNotEmpty(pd)) {
		filter.append(" and inst.defid=" + pd);
	}
	if (UEngineUtil.isNotEmpty(instanceInfo)) {
		filter.append(" and inst.info='" + instanceInfo + "'");
	}

	String filterName = null;
	if ("0".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Running Process", loggedUserLocale);
	} else if ("1".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Completed Process", loggedUserLocale);
	} else if ("2".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Stopped Process", loggedUserLocale);
	}

      out.write("\r\n");
      out.write("<title>");
      out.print(filterName);
      out.write("</title>\r\n");
      out.write("</head>                    \r\n");
      out.write("<body  alink=\"black\" vlink=\"black\" onLoad=\"setListForm(document.refreshForm);\" style=\"margin-left:10px;\">\r\n");
      out.write("<div id=\"divSubSearch\" class=\"divSubSearchStyle\" style=\"display: none;\" title=\"");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("\">\r\n");
      out.write("    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n");
      out.write("    \t<colgroup>\r\n");
      out.write("\t        <col span=\"1\" width=\"110\" style=\"font-weight: bold; font-size: 12pt;\">\r\n");
      out.write("\t        <col span=\"1\" width=\"220\">\r\n");
      out.write("\t        <col span=\"1\" width=\"110\">\r\n");
      out.write("\t        <col span=\"1\" width=\"*\">\r\n");
      out.write("    \t</colgroup>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" colspan=\"3\"><input type=\"text\" id=\"inputInstanceName\" value=\"");
      out.print(strInstanceName );
      out.write("\" size='28' /></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("            <td colspan=\"4\" height=\"1\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Period", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" >\r\n");
      out.write("                <input type='text' id=\"workitem_start_date\" value=\"");
      out.print(strWorkitemStartDate );
      out.write("\" size=\"9\" class='j_calendar' />\r\n");
      out.write("                ~ <input type='text' id=\"workitem_end_date\" value=\"");
      out.print(strWorkitemEndDate );
      out.write("\" size=\"9\" class='j_calendar'/>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("            <td class=\"formtitle\" >");
      out.print(GlobalContext.getMessageForWeb("ProcessDefinition", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" ><input type='text' id='processDefName' size='24' value=\"");
      out.print(processDefName );
      out.write("\" onKeyDown=\"javascript:resetHiddenValue('ProcessDefinition');\"/>\r\n");
      out.write("                <img align=\"middle\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processmanager/images/Toolbar-toblock.gif\" onClick=\"selectProcess();\" style=\"cursor: pointer;\" />\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("            <td colspan=\"4\" height=\"1\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\" >");
      out.print(GlobalContext.getMessageForWeb("Current Participant Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" >\r\n");
      out.write("            \t<input type=\"text\" id='search_user_display' name=\"search_user_display\" size='24' value=\"");
      out.print(search_user_display );
      out.write("\" />\r\n");
      out.write("            </td>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Current Participant Id", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" >\r\n");
      out.write("            \t<input type=\"hidden\" id='search_user__which_is_xml_value' name=\"search_user__which_is_xml_value\" value=\"");
      out.print(search_user__which_is_xml_value );
      out.write("\" />\r\n");
      out.write("                <input type=\"text\" id='search_user' name=\"search_user\" size='28' value=\"");
      out.print(search_user );
      out.write("\" />\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<form name=\"refreshForm\" method=\"post\" action=\"?\" />\r\n");
      out.write("\r\n");
      out.write("<fieldset class='block-labels' >\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td align=\"right\" style=\"padding:10px 0;\">\r\n");
      out.write("        \t<table width=\"*\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                <tr height=\"25\" valign=\"middle\">\r\n");
      out.write("                    <td>\r\n");
      out.write("                        <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitle.gif\" width=\"70\" height=\"25\"></td>\r\n");
      out.write("\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\" valign=\"middle\">                        \t\r\n");
      out.write("\t                    <input type=\"text\" name=\"simpleKeyWord\" value=\"");
      out.print(simpleKeyWord);
      out.write("\" size='15'  style=\"background:#FFF;\"/>\r\n");
      out.write("\t                </td>\r\n");
      out.write("\t                <td width=\"5\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\"></td>\r\n");
      out.write("\t                <td width=\"*\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\" valign=\"middle\">\r\n");
      out.write("\t                    <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchGo.gif\" \r\n");
      out.write("\t                    alt=\"Search\" align=\"middle\" onClick=\"searchSimple();\" style=\"cursor: pointer;\" />\r\n");
      out.write("\t                    <a href=\"wl2_instanceList.jsp?filtering=");
      out.print(filtering );
      out.write("\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchRefresh.gif\" \r\n");
      out.write("\t                    alt=\"reset\" align=\"middle\" /></a>\r\n");
      out.write("\t                </td>\r\n");
      out.write("\t                <td width=\"5\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\"></td>\r\n");
      out.write("\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\">\r\n");
      out.write("\t                    <a href=\"javascript: showDetailSearch('Participation', '750', '110', '");
      out.print(GlobalContext.getMessageForWeb("Search Button", loggedUserLocale));
      out.write("', '");
      out.print(GlobalContext.getMessageForWeb("Close Button", loggedUserLocale));
      out.write("');\" style=\"text-decoration:underline;\">");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("</a></td>\r\n");
      out.write("\t                <td>\r\n");
      out.write("\t                    <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleRight.gif\"></td>\r\n");
      out.write("                </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</fieldset>\r\n");

	if (UEngineUtil.isNotEmpty(pd)) {

      out.write("\r\n");
      out.write("<h3>");
      out.print(processName);
      out.write("</h3>\r\n");

	}

      out.write('\r');
      out.write('\n');

	String sql;
	ListField[] listFields = null;

	HashMap colors = new HashMap(10);
	colors.put("Failed", "red");
	colors.put("Suspended", "yellow");
	colors.put("Skipped", "blue");
	colors.put("Ready", "green");
	colors.put("Running", "green");

	// Default fields.
	ListField[] defListFields = new ListField[7];
	defListFields[0] = new ListField(GlobalContext.getMessageForWeb(
			"Instance Name", loggedUserLocale),
			new InstanceTableListFieldType("name")
	);
	defListFields[1] = new ListField(GlobalContext.getMessageForWeb(
			"Definition Name", loggedUserLocale),
			new InstanceTableListFieldType("defname")
	);
	defListFields[2] = new ListField(GlobalContext.getMessageForWeb(
			"Current Participant", loggedUserLocale),
			new InstanceTableListFieldType("currrsnm")
	);
	defListFields[3] = new ListField(GlobalContext.getMessageForWeb(
			"Start Date", loggedUserLocale),
			new InstanceTableListFieldType("startedDate")
	);
	defListFields[4] = new ListField(GlobalContext.getMessageForWeb(
			"Due Date", loggedUserLocale),
			new InstanceTableListFieldType("dueDate")
	);
	defListFields[5] = new ListField(GlobalContext.getMessageForWeb(
			"End Date", loggedUserLocale),
			new InstanceTableListFieldType("finisheddate")
	);
	defListFields[6] = new ListField(GlobalContext.getMessageForWeb(
			"Information", loggedUserLocale),
			new InstanceTableListFieldType("info")
	);
	
/*
	if (pdver != null) {
		ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
		if (pdObj.getInstanceListFields() != null && pdObj.getInstanceListFields().length > 0) {
			listFields = pdObj.getInstanceListFields();

			HashMap joiningTables = new HashMap();
			joiningTables.put("BPM_PROCINST", "inst");

			ArrayList whereClauses = new ArrayList();
			ArrayList selectItems = new ArrayList();
			StringBuffer selectClause = new StringBuffer();
			StringBuffer fromClause = new StringBuffer();
			StringBuffer whereClause = new StringBuffer();

			int tableCnt = 0;

			selectItems.add("inst.INSTID");
			selectItems.add("inst.STATUS");
			selectItems.add("inst.startedDate");
			selectItems.add("inst.currrsnm");
			for (int i = 0; i < listFields.length; i++) {
				ListFieldType listFieldType = listFields[i].getListFieldType();
				if (listFieldType instanceof VariablePointingListFieldType) {
					ProcessVariable pv = ((VariablePointingListFieldType) listFieldType).getVariable();
					org.uengine.contexts.DatabaseSynchronizationOption dso = pv.getDatabaseSynchronizationOption();

					String tableAlias;
					if (!joiningTables.containsKey(dso.getTableName().toUpperCase())) {
						tableAlias = "t" + (++tableCnt);
						joiningTables.put(dso.getTableName().toUpperCase(), tableAlias);
						fromClause.append(
								" LEFT OUTER JOIN "
								+ dso.getTableName().toUpperCase()
								+ " " + tableAlias
						);
						fromClause.append(
								" ON inst."
								+ dso.getCorrelatedFieldName() + "="
								+ tableAlias + "."
								+ dso.getCorrelationFieldName()
						);
					} else {
						tableAlias = (String) joiningTables.get(dso.getTableName().toUpperCase());
					}

					selectItems.add(tableAlias + "." + dso.getFieldName());
				} else if (listFieldType instanceof InstanceTableListFieldType) {
					String strFieldName = ((InstanceTableListFieldType) listFieldType).getFieldName();
					if (!"startedDate".equalsIgnoreCase(strFieldName)) {
						selectItems.add("inst." + strFieldName);
					}
				}
			}
			whereClauses.add("inst.defid=" + pdObj.getBelongingDefinitionId());
			whereClauses.add(filter);

			String sep = "";
			for (int i = 0; i < selectItems.size(); i++) {
				selectClause.append(sep + selectItems.get(i));
				sep = ", ";
			}

			sep = "";
			for (int i = 0; i < whereClauses.size(); i++) {
				whereClause.append(sep + whereClauses.get(i));
				sep = " and ";
			}

			sql = "select " + selectClause + " from bpm_procinst inst " + fromClause + " where " + whereClause;
		} else {
			listFields = defListFields;
			sql = "select * from bpm_procinst inst "
					+ " where inst.defid="
					+ pdObj.getBelongingDefinitionId() + " and "
					+ filter;
		}
	} else {
		*/
		listFields = defListFields;
		sql = "SELECT DISTINCT(inst.instid), inst.* FROM bpm_procinst inst INNER JOIN bpm_rolemapping role ON role.rootinstid=inst.instid ";
		if ("self".equals(endpointType)) {
			sql += " AND role.endpoint='" + loggedUserId + "' ";
		}
		sql += filter;
		
//	}

	sql += strAddWhere + " ORDER BY starteddate desc";

      out.write("\r\n");
      out.write("<table width=100% >\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td ><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"tableborder\" style=\"border-bottom:1px solid #C5D2E3;\">\r\n");
      out.write("                <tr class=\"tabletitle\">\r\n");
      out.write("                ");

                // Make Header.
                if (listFields != null) {
                	for (int i = 0; i < listFields.length; i++) {
                
      out.write("\r\n");
      out.write("                    \t<th nowrap=\"nowrap\" class=\"col-");
      out.print(i);
      out.write("\" align=\"center\"> ");
      out.print(listFields[i].getDisplayName().getText(loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                    \t<th width=\"1\"><img src=\"../../images/Common/tabletitleline.gif\" width=\"2\" height=\"27\"></th>\r\n");
      out.write("                ");

                	}
                
      out.write("\r\n");
      out.write("                </tr>\r\n");
      out.write("                ");

                	boolean isGray = false;
                		java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
                		
                		try {
                			dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
                			totalCount = (int) dl.getTotalCount();
                			totalPageCount = dl.getTotalPageNo();
                		} catch (Exception e) {
                			throw e;
                		} finally {
                			if (con != null) {
                				con.close();
                			}
                		}

                		if (totalCount > 0) {
                			for (int i = 0; i < dl.size(); i++) {
                				DataMap tmpMap = (DataMap) dl.get(i);
                				//				Long instId = piDAO.getInstId();
                				String instId = tmpMap.getString("INSTID", "-");
                				//				String bold = ( "NEW".equals(piDAO.getStatus()) ? "<b>":"");
                				String bold = ("NEW".equals(tmpMap.getString("STATUS", "-")) ? "<b>" : "");
                				String bgcolor = (
                						isGray
                						? "class=\"portlet-section-body\""
                								+ " onmouseover=\"this.className = 'portlet-section-body-hover';\""
                								+ " onmouseout=\"this.className = 'portlet-section-body';\""
                						: "class=\"portlet-section-alternate\""
                								+ " onmouseover=\"this.className = 'portlet-section-alternate-hover';\""
                								+ " onmouseout=\"this.className = 'portlet-section-alternate';\""
                				);
                				isGray = !isGray;
                
      out.write("\r\n");
      out.write("                <tr ");
      out.print(bgcolor);
      out.write(" onClick=\"viewProcInfo('");
      out.print(instId);
      out.write("')\" style=\"cursor:hand;\">\r\n");
      out.write("                    ");

                    	for (int j = 0; j < listFields.length; j++) {
                    					//					Object fieldValue = listFields[j].getFieldValue(piDAO, null);
                    					String fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-");
                    					if ("currrsnm".equals(listFields[j].getListFieldType().getFieldName())) {
                    						if (fieldValue.indexOf(";") != -1) {
                    							fieldValue = fieldValue.replace(";", ", ");
                    							fieldValue = fieldValue.trim();
                    							if (fieldValue.endsWith(",")) {
                    								fieldValue = fieldValue.substring(0, fieldValue.length() - 1);
                    							}
                    						}
                    					} else if (j >= 3 && j <= 5) {
                    						if (fieldValue.length() > 10) {
                    							fieldValue = fieldValue.substring(0,16);
                    						}
                    					}
                    
      out.write("\r\n");
      out.write("                    <td colspan=\"2\" align=\"center\">");
      out.print(bold);
      out.print(fieldValue == null ? "-" : fieldValue);
      out.write("</td>\r\n");
      out.write("                    ");

                    	}
                    
      out.write("\r\n");
      out.write("                </tr>\r\n");
      out.write("            ");

            		} // for( int j=0; j<dl.size(); j++ ){
            	} // if(totalCount > 0) {
            } // if( listFields != null ){
            
      out.write("\r\n");
      out.write("            </table></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td align=\"center\">");

        	if (totalCount > 0) {
        
      out.write("\r\n");
      out.write("            <!--\t#####\t占쌓븝옙占쏙옙抉占� start\t\t#####\t-->\r\n");
      out.write("            <br style=\"line-height:15px;\">\r\n");
      out.write("            ");
      //  bpm:page
      org.uengine.ui.taglibs.PagingTag _jspx_th_bpm_005fpage_005f0 = (org.uengine.ui.taglibs.PagingTag) _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.get(org.uengine.ui.taglibs.PagingTag.class);
      _jspx_th_bpm_005fpage_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bpm_005fpage_005f0.setParent(null);
      // /processparticipant/worklist/wl2_instanceList.jsp(586,12) name = link type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLink("");
      // /processparticipant/worklist/wl2_instanceList.jsp(586,12) name = totalcount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setTotalcount(totalCount);
      // /processparticipant/worklist/wl2_instanceList.jsp(586,12) name = pagecount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagecount(intPageCnt);
      // /processparticipant/worklist/wl2_instanceList.jsp(586,12) name = pagelimit type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagelimit(nPagesetSize);
      // /processparticipant/worklist/wl2_instanceList.jsp(586,12) name = currentpage type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setCurrentpage(currentPage);
      // /processparticipant/worklist/wl2_instanceList.jsp(586,12) name = locale type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLocale(loggedUserLocale);
      int _jspx_eval_bpm_005fpage_005f0 = _jspx_th_bpm_005fpage_005f0.doStartTag();
      if (_jspx_th_bpm_005fpage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
      out.write("\r\n");
      out.write("            <br>\r\n");
      out.write("            ");

            	}
            
      out.write("</td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");

	//	}

      out.write("\r\n");
      out.write("<!-- Paging -->\r\n");
      out.write("\t<input type=\"hidden\" name=\"currentPage\" value=\"");
      out.print(currentPage);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"listURL\" value=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/instancelist.jsp\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"processDefinition\" value=\"");
      out.print(pd);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"folder\" value=\"");
      out.print(folder);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"filtering\" value=\"");
      out.print(filtering);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"endpointType\" value=\"");
      out.print(endpointType );
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" nanme=\"p_initep\" value=\"");
      out.print(p_initep );
      out.write("\" />\r\n");
      out.write("\t\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"sort_column\" value=\"");
//=strSortColumn
      out.write("\" -->\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"sort_cond\" value=\"");
//=strSortCond
      out.write("\" -->\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"TARGETCOND\" value=\"");
//=strTarget
      out.write("\" -->\r\n");
      out.write("\t\r\n");
      out.write("\t<input type=\"hidden\" name=\"inputInstanceName\" value=\"");
      out.print(strInstanceName );
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"inputWorkName\" value=\"");
      out.print(strWorkName );
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"workitem_start_value_handler_class\" value=\"");
      out.print(strWorkitemStartValueHandlerClass);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"workitem_start_date\" value=\"");
      out.print(strWorkitemStartDate);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"workitem_end_value_handler_class\" value=\"");
      out.print(strWorkitemEndValueHandlerClass);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"workitem_end_date\" value=\"");
      out.print(strWorkitemEndDate);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"search_user__which_is_xml_value\" value=\"");
      out.print(search_user__which_is_xml_value);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"search_user_display\" value=\"");
      out.print(search_user_display);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"search_user\" value=\"");
      out.print(search_user);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"processDefName\" value=\"");
      out.print(processDefName);
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
