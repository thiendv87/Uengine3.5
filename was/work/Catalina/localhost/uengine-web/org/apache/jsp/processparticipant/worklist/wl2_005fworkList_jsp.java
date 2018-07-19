package org.apache.jsp.processparticipant.worklist;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.util.dao.*;
import org.uengine.persistence.dao.*;
import org.uengine.webservices.worklist.*;
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

public final class wl2_005fworkList_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
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
      out.write('\r');
      out.write('\n');

	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	int intPageCnt = 50;
	int nPagesetSize = 10;
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	//String strTarget = reqMap.getString("TARGETCOND", "procins.instancename", loggedUserLocale, loggedUserTimeZone);
	//String strKeyword = reqMap.getString("KEYWORDCOND", "", loggedUserLocale, loggedUserTimeZone);
	//String strDateKeyStart=reqMap.getString("INIT_START_DATE", "", loggedUserLocale, loggedUserTimeZone);
	//String strDateKeyEnd=reqMap.getString("INIT_END_DATE", "", loggedUserLocale, loggedUserTimeZone);
	//String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "", loggedUserLocale, loggedUserTimeZone);
	//String strDefTypeId = reqMap.getString("DEFTYPEID", "", loggedUserLocale, loggedUserTimeZone);

	
	//String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	//String strSortCond = reqMap.getString("SORT_COND", "");
	//String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");

	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/
	// Query Condition.
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);
	
	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	String pd = reqMap.getString("processDefinition", "");
	//String folder = reqMap.getString("folder", "");
	String filtering = reqMap.getString("filtering", "0");
	//String dispPdNameNId = "";
	
	String processDefName = reqMap.getString("processDefName", "");
	String strWorkName = reqMap.getString("inputWorkName", "");
	String strInstanceName = reqMap.getString("inputInstanceName", "");
	String strWorkitemStartDate = reqMap.getString("workitem_start_date", "");
	String strWorkitemStartValueHandlerClass = reqMap.getString("workitem_start_value_handler_class", "");
	String strWorkitemEndDate = reqMap.getString("workitem_end_date", "");
	String strWorkitemEndValueHandlerClass = reqMap.getString("workitem_end_value_handler_class", "");
	String search_user_display = reqMap.getString("search_user_display", "");
	String search_user__which_is_xml_value = reqMap.getString("search_user__which_is_xml_value", "");
	String search_user = reqMap.getString("search_user", "");

	// Filter
	String processDefId = reqMap.getString("processDefId", "");
	String instanceInfo = reqMap.getString("instanceInfo", "");
	String endpointType = reqMap.getString("endpointType", "self");
	
	// Filter
	/*
	if ( !"".equals(folder) ) {
		dispPdNameNId += folder;
	}
	if ( !"".equals(pd) ) {
		dispPdNameNId += "("+pd+")";
	}
	*/

	StringBuffer strAddWhere = new StringBuffer();

	String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
	if (UEngineUtil.isNotEmpty(simpleKeyWord)) {
		
		String lowerCaseFunctionName = "LCASE";
		String typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
		if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
		    lowerCaseFunctionName = "LOWER";
		}
		
		String simpleKeyWordLowerCase = UEngineUtil.searchStringFilter(simpleKeyWord.toLowerCase()); 
		
		strAddWhere.append("\r\n AND ( ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(wl.TITLE) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.DEFNAME) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.INFO) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.NAME) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.INITEP) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.INITRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.CURREP) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.CURRRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ");
		strAddWhere.append("\r\n ) ");
		
	} else {
		if (UEngineUtil.isNotEmpty(strWorkName)) {
			strAddWhere.append("\r\n AND wl.title LIKE '%").append(UEngineUtil.searchStringFilter(strWorkName)).append("%' "); 
		}

		if (UEngineUtil.isNotEmpty(strInstanceName)) {
			strAddWhere.append("\r\n AND inst.name LIKE '%").append(UEngineUtil.searchStringFilter(strInstanceName)).append("%' "); 
		}

		if (UEngineUtil.isNotEmpty(strWorkitemStartDate)) {
			strAddWhere.append("\r\n AND inst.starteddate >= '").append(UEngineUtil.searchStringFilter(strWorkitemStartDate)).append("' "); 
		}

		if (UEngineUtil.isNotEmpty(strWorkitemEndDate)) {
			strAddWhere.append("\r\n AND inst.starteddate <= '").append(UEngineUtil.searchStringFilter(strWorkitemEndDate)).append("' "); 
		}
		
		if (UEngineUtil.isNotEmpty(search_user_display)) {
			strAddWhere.append("\r\n AND inst.initrsnm LIKE '%").append(UEngineUtil.searchStringFilter(search_user_display)).append("%' "); 
		}
		
		if (UEngineUtil.isNotEmpty(search_user)) {
			strAddWhere.append("\r\n AND inst.initep LIKE '%").append(UEngineUtil.searchStringFilter(search_user)).append("%' "); 
		}

		if(UEngineUtil.isNotEmpty(processDefName)){
			strAddWhere.append("\r\n AND inst.defname LIKE '%").append(UEngineUtil.searchStringFilter(processDefName)).append("%'");
		}
	}
	
	
	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	ProcessDefinitionRemote pdr = null;
	//replace with production version
	String pdver = null;
	String processName = "";
	//String pageType = "workitem_view";
	
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
    /*                        DB Function set                                */
    /*************************************************************************/
	String typeOfDBMS = DAOFactory.getInstance().getDBMSProductName().toUpperCase();
    String sysdate = "SYSDATE";
    
    if ("ORACLE".equals(typeOfDBMS)) {
        sysdate = "SYSDATE";
    } else if ("HSQL".equals(typeOfDBMS)) {
        sysdate = "CURRENT_TIMESTAMP";
    } else if ("MYSQL".equals(typeOfDBMS)) {
        sysdate = "now()";
    } else if ("POSTGRES".equals(typeOfDBMS)) {
        sysdate = "CURRENT_TIMESTAMP";
    }
	
	/*************************************************************************/
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
		GlobalContext.getMessageForWeb("New Work", loggedUserLocale),
		"wl.status in ('NEW', 'CONFIRMED')",
		GlobalContext.getMessageForWeb("Completed Work", loggedUserLocale),
		"wl.status = 'COMPLETED'",
		GlobalContext.getMessageForWeb("Cancelled Work", loggedUserLocale),
		"wl.status = 'CANCELLED'",
		GlobalContext.getMessageForWeb("Reserved Work", loggedUserLocale),
		"wl.status = 'RESERVED'",
		GlobalContext.getMessageForWeb("Delayed Work", loggedUserLocale),
		"(wl.status = 'NEW' or wl.status = 'CONFIRMED' or wl.status = 'DRAFT') AND WL.DUEDATE<="+sysdate,
		GlobalContext.getMessageForWeb("Saved Work", loggedUserLocale),
		"wl.status = 'DRAFT'"
		
		//"In Progress", 			"(wl.status='COMPLETE' and pi.status <> 'Completed')",
		//"Reference",			"wl.status = 'REFERENCE'",
	};
	
	/*
	Properties removableStatus = new Properties();{
		removableStatus.setProperty("REFERENCE","".intern());
		removableStatus.setProperty("CANCELLED","".intern());
		removableStatus.setProperty("COMPLETED","".intern());
	}
	*/
	
	//boolean useOracle = (DAOFactory.getInstance().getDBMSProductName().startsWith("Oracle"));
	//boolean useDB2 = (DAOFactory.getInstance().getDBMSProductName().startsWith("DB2"));
	
	int filteringNo = 0;
	if( filtering != null && !"".equals(filtering) && !"undefined".equals(filtering) ){
		filteringNo = Integer.parseInt(filtering);
	}
	
	if (filteringNo == 4) {
		if ("ORACLE".equals(typeOfDBMS))
			filters[filters.length-1] += " and (TO_CHAR(wl.duedate,'yyyy-MM-dd HH24:mm:ss') < TO_CHAR("+sysdate+",'yyyy-MM-dd HH24:mm:ss'))";
		else if ("HSQL".equals(typeOfDBMS))
			filters[filters.length-1] += " and (TO_CHAR(wl.duedate,'yyyy-MM-dd HH24:mm:ss') < TO_CHAR("+sysdate+",'yyyy-MM-dd HH24:mm:ss'))";
		else if ("MYSQL".equals(typeOfDBMS))
			filters[filters.length-1] += " and wl.duedate < "+sysdate;
		else if ("POSTGRES".equals(typeOfDBMS))
			filters[filters.length-1] += " and wl.duedate < "+sysdate;
	}

	
	String filter = "";
	
	if( !"".equals(filters[filteringNo*2 + 1]) ){
		filter += filters[filteringNo*2 + 1] ;
	}
	
	if (UEngineUtil.isNotEmpty(processDefId)) {
		filter += " and inst.defid=" + processDefId;
	}
	if (UEngineUtil.isNotEmpty(instanceInfo)) {
		filter += " and inst.info='"+instanceInfo+"'";
	}
	
	String filterName = "";
	if ("0".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("New Work", loggedUserLocale);
	} else if ("1".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Completed Work", loggedUserLocale);
	} else if ("2".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Cancelled Work", loggedUserLocale);
	} else if ("3".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Reserved Work", loggedUserLocale);
	} else if ("4".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Delayed Work", loggedUserLocale);
	} else if ("5".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Saved Work", loggedUserLocale);
	}

      out.write("\r\n");
      out.write("<title>");
      out.print(filterName );
      out.write("</title>\r\n");
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
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body  alink=\"black\" vlink=\"black\" onLoad=\"setListForm(document.refreshForm);\">\r\n");
      out.write("<div id=\"divSubSearch\" style=\"display: none;\" title=\"");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("\">\r\n");
      out.write("    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n");
      out.write("        <colgroup>\r\n");
      out.write("\t        <col span=\"1\" width=\"110\" style=\"font-weight: bold; font-size: 12pt;\">\r\n");
      out.write("\t        <col span=\"1\" width=\"220\">\r\n");
      out.write("\t        <col span=\"1\" width=\"110\">\r\n");
      out.write("\t        <col span=\"1\" width=\"*\">\r\n");
      out.write("        </colgroup>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\"><input type=\"text\" id=\"inputInstanceName\" value=\"");
      out.print(strInstanceName );
      out.write("\" size='28' /></td>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Work Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\"><input type=\"text\" id=\"inputWorkName\" value=\"");
      out.print(strWorkName );
      out.write("\" size='24' /></td>\r\n");
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
      out.write("\" size=\"10\" class='j_calendar' />\r\n");
      out.write("                ~ <input type='text' id=\"workitem_end_date\" value=\"");
      out.print(strWorkitemEndDate );
      out.write("\" size=\"10\" class='j_calendar' />\r\n");
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
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Initiator Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" >\r\n");
      out.write("            \t<input type=\"hidden\" id='search_user__which_is_xml_value' name=\"search_user__which_is_xml_value\" value=\"");
      out.print(search_user__which_is_xml_value );
      out.write("\" />\r\n");
      out.write("                <input type=\"text\" id='search_user_display' name='search_user_display' size='28' value=\"");
      out.print(search_user_display);
      out.write("\" />\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("            <td class=\"formtitle\" >");
      out.print(GlobalContext.getMessageForWeb("Initiator Id", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\" >\r\n");
      out.write("            \t<input type=\"text\" id='search_user' name='search_user' size='24' value=\"");
      out.print(search_user );
      out.write("\" />\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</div>\r\n");
      out.write("<form name=\"refreshForm\" method=\"post\" action=\"wl2_workList.jsp\">\r\n");
      out.write("    <table border='0' width='98%' align=\"center\" cellpadding='0' cellspacing='0'>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td valign='top'>\r\n");
      out.write("            \t<fieldset class='block-labels' >\r\n");
      out.write("                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                    \t<td>\r\n");
      out.write("                ");

                if (UEngineUtil.isNotEmpty(pd)) {
				
      out.write("\r\n");
      out.write("                \t<h3>");
      out.print(processName);
      out.write("</h3>\r\n");
      out.write("                ");

				}
				
      out.write("\r\n");
      out.write("                    \t</td>\r\n");
      out.write("                        <td align=\"right\" style=\"padding:10px 0;\">\r\n");
      out.write("                        \t<table width=\"*\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                <tr height=\"25\" valign=\"middle\">\r\n");
      out.write("                                    <td>\r\n");
      out.write("                                        <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitle.gif\" width=\"70\" height=\"25\"></td>\r\n");
      out.write("                                    <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\" valign=\"middle\">                        \t\r\n");
      out.write("                                        <input type=\"text\" name=\"simpleKeyWord\" value=\"");
      out.print(simpleKeyWord);
      out.write("\" size='15'  style=\"background:#FFF;\"/>\r\n");
      out.write("                                    </td>\r\n");
      out.write("                                    <td width=\"5\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\"></td>\r\n");
      out.write("                                    <td width=\"*\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\" valign=\"middle\">\r\n");
      out.write("                                        <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchGo.gif\" \r\n");
      out.write("                                        alt=\"Search\" align=\"middle\" onClick=\"searchSimple();\" style=\"cursor: pointer;\" />\r\n");
      out.write("                                        <a href=\"wl2_workList.jsp?filtering=");
      out.print(filtering );
      out.write("\"><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchRefresh.gif\" \r\n");
      out.write("                                        alt=\"reset\" align=\"middle\" /></a>\r\n");
      out.write("                                    </td>\r\n");
      out.write("                                    <td width=\"5\" background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\"></td>\r\n");
      out.write("                                    <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\">\r\n");
      out.write("                                        <a href=\"javascript: showDetailSearch('WorkList', '750', '100', '");
      out.print(GlobalContext.getMessageForWeb("Search Button", loggedUserLocale));
      out.write("', '");
      out.print(GlobalContext.getMessageForWeb("Close Button", loggedUserLocale));
      out.write("');\" style=\"text-decoration:underline;\">");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("</a></td>\r\n");
      out.write("                                    <td>\r\n");
      out.write("                                        <img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleRight.gif\"></td>\r\n");
      out.write("                                </tr>\r\n");
      out.write("                            </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                </table>\r\n");
      out.write("\r\n");
      out.write("                \r\n");
      out.write("                </fieldset>\r\n");

	String sql;
	ListField[] listFields = null;
	/*
	HashMap colors = new HashMap(10);
	colors.put("Failed", "red");
	colors.put("Suspended", "yellow");
	colors.put("Skipped", "blue");
	colors.put("Ready", "green");
	colors.put("Running", "green");
	*/
	
	// Default fields.
	ListField[] defListFields = new ListField[8];
	defListFields[0] = new ListField(GlobalContext.getMessageForWeb("msg.Task", loggedUserLocale) , new InstanceTableListFieldType("title"));
	defListFields[1] = new ListField(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale) , new InstanceTableListFieldType("procinstnm"));
	defListFields[2] = new ListField(GlobalContext.getMessageForWeb("Initiator", loggedUserLocale) , new InstanceTableListFieldType("initrsnm"));
	defListFields[3] = new ListField(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale), new InstanceTableListFieldType("startdate"));
	defListFields[4] = new ListField(GlobalContext.getMessageForWeb("Due Date", loggedUserLocale), new InstanceTableListFieldType("duedate"));
	defListFields[5] = new ListField(GlobalContext.getMessageForWeb("End Date", loggedUserLocale), new InstanceTableListFieldType("enddate"));
	defListFields[6] = new ListField(GlobalContext.getMessageForWeb("Priority", loggedUserLocale), new InstanceTableListFieldType("priority"));
	defListFields[7] = new ListField(GlobalContext.getMessageForWeb("Status", loggedUserLocale) , new InstanceTableListFieldType("status"));

/*
if (UEngineUtil.isNotEmpty(pdver)) {
	ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
	if (pdObj.getWorkListFields() != null && pdObj.getWorkListFields().length > 0) {
		listFields = pdObj.getWorkListFields();
		
		HashMap joiningTables = new HashMap();
		joiningTables.put("BPM_PROCINST", "inst");

		ArrayList whereClauses = new ArrayList();
		ArrayList selectItems = new ArrayList();
		StringBuffer selectClause = new StringBuffer();
		StringBuffer fromClause = new StringBuffer();
		StringBuffer whereClause = new StringBuffer();
		
		int tableCnt = 0;
		
		selectItems.add("inst.name as procinstnm");
		selectItems.add("inst.initrsnm");
		selectItems.add("wl.taskId");
		selectItems.add("wl.status");
		selectItems.add("wl.startdate");
		
		for(int i=0; i<listFields.length; i++){
			ListFieldType listFieldType = listFields[i].getListFieldType();
			if(listFieldType instanceof VariablePointingListFieldType){
				ProcessVariable pv = ((VariablePointingListFieldType)listFieldType).getVariable();
				org.uengine.contexts.DatabaseSynchronizationOption dso = pv.getDatabaseSynchronizationOption();
				
				String tableAlias;
				if (!joiningTables.containsKey(dso.getTableName().toUpperCase())) {
					tableAlias = "t"+(++tableCnt);
					joiningTables.put(dso.getTableName().toUpperCase(), tableAlias);
					fromClause.append(" LEFT OUTER JOIN " + dso.getTableName().toUpperCase() + " " + tableAlias);
					fromClause.append(" ON inst." + dso.getCorrelatedFieldName() + "=" + tableAlias + "." + dso.getCorrelationFieldName());
				} else {
					tableAlias = (String)joiningTables.get(dso.getTableName().toUpperCase());
				}
				
				selectItems.add(tableAlias + "." + dso.getFieldName());
				
			} else if (listFieldType instanceof WorkListTableListFieldType) {
				String strFieldName = ((WorkListTableListFieldType)listFieldType).getFieldName();		
				if ( !"startdate".equalsIgnoreCase(strFieldName) ) {
					selectItems.add("wl." + strFieldName);
				}
			} else if (listFieldType instanceof InstanceTableListFieldType) {
				String strFieldName = ((InstanceTableListFieldType)listFieldType).getFieldName();		
				//if( !"startedDate".equalsIgnoreCase(strFieldName) ){
					selectItems.add("inst." + strFieldName);
				//}
			}
		}
		
		whereClauses.add("inst.defid=" + pdObj.getBelongingDefinitionId() );
		whereClauses.add(filter);
		
		String sep = "";
		for(int i=0; i<selectItems.size(); i++){
			selectClause.append(sep + selectItems.get(i));
			sep = ", ";
		}

		sep = "";
		for(int i=0; i<whereClauses.size(); i++){
			whereClause.append(sep + whereClauses.get(i));
			sep = " and ";
		}
		
		sql = "select "
			+ selectClause
			+ " from bpm_procinst inst, bpm_worklist wl  "
			+ fromClause 
			+ " where " 
			+ whereClause 
			+ " and inst.instid = wl.instid";
	} else {
		listFields = defListFields;
		sql = "select inst.name as procinstnm, inst.initrsnm, wl.*"
			+ " from bpm_procinst inst, bpm_worklist wl"
			+ " where " + filter 
			+ " and inst.instid = wl.instid"
			+ " and inst.defid=" + pdObj.getBelongingDefinitionId();
	}
} else {
*/	
	listFields = defListFields;
	sql = "\r\n select DISTINCT INST.NAME as procinstnm, INST.initrsnm, INST.INFO, WL.* FROM BPM_PROCINST INST, ";
	sql += "\r\n BPM_WORKLIST WL INNER JOIN BPM_ROLEMAPPING ROLE ON (WL.ROLENAME=ROLE.ROLENAME OR WL.REFROLENAME=ROLE.ROLENAME) ";
	if ("self".equals(endpointType)) {
		sql += "\r\n OR WL.ENDPOINT='" + loggedUserId + "' ";
	}
	sql += "\r\n where " + filter;
	sql += "\r\n AND WL.INSTID=INST.INSTID AND WL.INSTID=ROLE.INSTID AND INST.ISDELETED=0 AND INST.STATUS NOT IN ('Stopped', 'Failed') ";
	if ("self".equals(endpointType)) {
		sql += "\r\n AND ROLE.ENDPOINT='" + loggedUserId + "' ";
	}
//}

	sql += strAddWhere + "\r\n order by wl.startdate desc";

      out.write("\r\n");
      out.write("                <table width=\"100%\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"tableborder\" style=\"border-bottom:1px solid #C5D2E3;\">\r\n");
      out.write("                                <tr class=\"tabletitle\" align=\"center\">\r\n");
      out.write("                                ");

								// Make Header.
								boolean isGray = false;
								if (listFields != null) {
									for (int i = 0; i < listFields.length; i++) {
								
      out.write("\r\n");
      out.write("\t                                <th nowrap=\"nowrap\" class=\"col-");
      out.print(i);
      out.write("\" align=\"center\"> ");
      out.print(listFields[i].getDisplayName().getText(loggedUserLocale));
      out.write("</th>\r\n");
      out.write("\t                                <th width=\"1\"><img src=\"../../images/Common/tabletitleline.gif\" width=\"2\" height=\"27\"></th>\r\n");
      out.write("\t                            ");
 } 
      out.write("\r\n");
      out.write("                                </tr>\r\n");
      out.write("                                ");

		java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
		try {
			dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
			totalCount = (int)dl.getTotalCount();
			totalPageCount = dl.getTotalPageNo();
		} catch(Exception e) {
			throw e;
		} finally {
			if ( con != null ){con.close();}
		}
	
		//while(wl.next()){
		if(totalCount > 0) {
			for ( int i=0; i<dl.size(); i++ ) {
				DataMap tmpMap = (DataMap)dl.get(i);
				String taskId = tmpMap.getString("taskid", "-");
				String bold = "NEW".equals(tmpMap.getString("status", "-")) ? "<b>" : "";
				String status = tmpMap.getString("status", "");
				String bgcolor = (isGray ? 
								"class=\"portlet-section-body\"" +
                                " onmouseover=\"this.className = 'portlet-section-body-hover';\"" + 
                                " onmouseout=\"this.className = 'portlet-section-body';\""
                                :
                                "class=\"portlet-section-alternate\"" +
                                " onmouseover=\"this.className = 'portlet-section-alternate-hover';\"" + 
                                " onmouseout=\"this.className = 'portlet-section-alternate';\""
                );
		        isGray = !isGray;

      out.write("\r\n");
      out.write("                                <tr ");
      out.print(bgcolor);
      out.write(" style=\"cursor: pointer;\"\r\n");
      out.write("\t    onClick=\"viewTaskInfo('");
      out.print(taskId);
      out.write("', '");
      out.print( tmpMap.getString("instId",""));
      out.write("', '");
      out.print( tmpMap.getString("TrcTag",""));
      out.write("', '");
      out.print(status);
      out.write("')\" >\r\n");
      out.write("                                    ");

				for(int j=0; j<listFields.length; j++){
					String fieldValue = "";
					fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-", loggedUserLocale, loggedUserTimeZone);
					
					//add start : YYYY-MM-DD HH:MM:SS to YYYY-MM-DD HH:MM by grayspec
					if (j >= 3 && j <= 5) {
						if (fieldValue.length() > 10) {
							fieldValue = fieldValue.substring(0,16);
						}
					}
					boolean delay = false;
					if (j == 4) {
						
						String endDate = tmpMap.getString(listFields[5].getListFieldType().getFieldName(), "-", loggedUserLocale, loggedUserTimeZone);
						if ("0".equals(filtering) || "4".equals(filtering)) {
							java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM");
							String todayDate = sdf.format(new java.util.Date());
							int dateCompare = fieldValue.compareTo(todayDate);
							if (dateCompare < 0)
								delay = true;
						}
					}
					//add end 

      out.write("\r\n");
      out.write("                                    <td colspan=\"2\" align=\"center\">");
      out.print(bold);
      out.write("<font color=\"");
      out.print( (j==4) && (delay == true) ? "red" : "" );
      out.write('"');
      out.write('>');
      out.print((fieldValue == null) ? "-" : fieldValue);
      out.write("</font></td>\r\n");
      out.write("                                    ");
	
				}

      out.write("\r\n");
      out.write("                                </tr>\r\n");
      out.write("                                ");


			}	// for( int i=0; i<dl.size(); i++ ){
		}	// if(totalCount > 0) {
	}	// if( listFields != null ){

      out.write("\r\n");
      out.write("                            </table></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td align=\"center\">");
 if (totalCount > 0) { 
      out.write("\r\n");
      out.write("                            <!--\t#####\t????? start\t\t#####\t-->\r\n");
      out.write("                            <br style=\"line-height:15px;\">\r\n");
      out.write("                            ");
      //  bpm:page
      org.uengine.ui.taglibs.PagingTag _jspx_th_bpm_005fpage_005f0 = (org.uengine.ui.taglibs.PagingTag) _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.get(org.uengine.ui.taglibs.PagingTag.class);
      _jspx_th_bpm_005fpage_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bpm_005fpage_005f0.setParent(null);
      // /processparticipant/worklist/wl2_workList.jsp(574,28) name = link type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLink("");
      // /processparticipant/worklist/wl2_workList.jsp(574,28) name = totalcount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setTotalcount(totalCount);
      // /processparticipant/worklist/wl2_workList.jsp(574,28) name = pagecount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagecount(intPageCnt);
      // /processparticipant/worklist/wl2_workList.jsp(574,28) name = pagelimit type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagelimit(nPagesetSize);
      // /processparticipant/worklist/wl2_workList.jsp(574,28) name = currentpage type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setCurrentpage(currentPage);
      // /processparticipant/worklist/wl2_workList.jsp(574,28) name = locale type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLocale(loggedUserLocale);
      int _jspx_eval_bpm_005fpage_005f0 = _jspx_th_bpm_005fpage_005f0.doStartTag();
      if (_jspx_th_bpm_005fpage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
      out.write("\r\n");
      out.write("                            <br>\r\n");
      out.write("                            ");
 } 
      out.write("</td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                </table>\r\n");
      out.write("                </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("    \r\n");
      out.write("\t<input type=\"hidden\" name=\"currentPage\" value=\"");
      out.print(currentPage);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"listURL\" value=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/processparticipant/worklist/workllist.jsp\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"processDefinition\" value=\"");
      out.print(pd);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"filtering\" value=\"");
      out.print(filtering);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"endpointType\" value=\"");
      out.print(endpointType );
      out.write("\" />\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"sort_column\" value=\"");
//=strSortColumn
      out.write("\" -->\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"sort_cond\" value=\"");
//=strSortCond
      out.write("\" -->\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"TARGETCOND\" value=\"");
//=strTarget
      out.write("\" -->\r\n");
      out.write("\t<!-- input type=\"hidden\" name=\"folder\" value=\"");
//=folder
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
      out.write("\r\n");
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
