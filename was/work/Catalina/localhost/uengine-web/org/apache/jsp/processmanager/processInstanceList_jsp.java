package org.apache.jsp.processmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
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

public final class processInstanceList_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(7);
    _jspx_dependants.add("/processmanager/processInstanceListDetail.jsp");
    _jspx_dependants.add("/processmanager/../common/header.jsp");
    _jspx_dependants.add("/processmanager/../common/headerMethods.jsp");
    _jspx_dependants.add("/processmanager/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/processmanager/../lib/jquery/importJquery.jsp");
    _jspx_dependants.add("/processmanager/../common/styleHeader.jsp");
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");

	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/
	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	// Work List BF.
	//	WorkListBusinessFacade workListBF = null;

	int intPageCnt = 20;
	int nPagesetSize = 10;
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	String strTarget = reqMap.getString("TARGETCOND", "procins.instancename");
	String strKeyword = reqMap.getString("KEYWORDCOND", "");
	String strDateKeyStart = reqMap.getString("INIT_START_DATE", "");
	String strDateKeyEnd = reqMap.getString("INIT_END_DATE", "");
	String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
	String strDefTypeId = reqMap.getString("DEFTYPEID", "");

	String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	String strSortCond = reqMap.getString("SORT_COND", "");
	String menuItemId = reqMap.getString("MENU_ITEMID", "item_bpm");
	//	String filtering = reqMap.getString("FILTERING","");
	//	RequestContext reqCtx = new RequestContext(request);
	//	User logdUser = reqCtx.getUser();
	//	loggedUserCompanyId=   logdUser.getCompanyId();

	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);

	HashMap colors = new HashMap(10);
	colors.put("Failed", "red");
	colors.put("Suspended", "yellow");
	colors.put("Skipped", "blue");
	colors.put("Ready", "green");
	colors.put("Running", "green");
	colors.put("Complete", "gray");
	colors.put("Stopped", "black");

	StringBuffer condStr = new StringBuffer();

	String _status = request.getParameter("status");
	String _Instance = request.getParameter("Instance");
	String complete_end_date = request.getParameter("complete_end_date");
	String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
	String docTitle = request.getParameter("docTitle");
	String _Initiator = request.getParameter("Initiator");
	String _Initiator_display = request.getParameter("Initiator_display");
	String _Initiator__which_is_xml_value = request.getParameter("Initiator__which_is_xml_value");
	String _Nowperson = request.getParameter("Nowperson");
	String _Nowperson_display = request.getParameter("Nowperson_display");
	String _Nowperson__which_is_xml_value = request.getParameter("Nowperson__which_is_xml_value");
	String complete_start_date = request.getParameter("complete_start_date");
	String init_start_date = request.getParameter("init_start_date");
	String init_end_date = request.getParameter("init_end_date");
	
	
	if (UEngineUtil.isNotEmpty(_status) && !_status.equals("All")) {
		condStr.append("AND a.status = '" + _status + "' ");
	} else {
		_status = "";
	}
	
	String _defId = request.getParameter("defId");
	if (UEngineUtil.isNotEmpty(_defId)) {
		condStr.append(" AND a.defid = " + UEngineUtil.searchStringFilter(_defId) + " ");
	} else {
		_defId = "";
	}
	
	if (UEngineUtil.isNotEmpty(simpleKeyWord)) {

		String typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
		String lowerCaseFunctionName = "LCASE";
		if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
		    lowerCaseFunctionName = "LOWER";
		}
		
		String simpleKeyWordLowerCase = UEngineUtil.searchStringFilter(simpleKeyWord).toLowerCase(); 
		
		condStr.append(" AND ( ");
		condStr.append("	").append(lowerCaseFunctionName).append("(a.DEFNAME) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		condStr.append("	").append(lowerCaseFunctionName).append("(a.INFO)		 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		condStr.append("	").append(lowerCaseFunctionName).append("(a.NAME)		 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		condStr.append("	").append(lowerCaseFunctionName).append("(a.INITEP)	 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		condStr.append("	").append(lowerCaseFunctionName).append("(a.INITRSNM)	 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		condStr.append("	").append(lowerCaseFunctionName).append("(a.CURREP)		 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		condStr.append("	").append(lowerCaseFunctionName).append("(a.CURRRSNM)		LIKE '%").append(simpleKeyWordLowerCase).append("%' ");
		try {
			Integer.parseInt(simpleKeyWordLowerCase);
			condStr.append(" OR ").append(" 	instid = ").append(simpleKeyWordLowerCase);
		} catch(Exception e) { }
		condStr.append(" ) ");
		
	} else {
		if (UEngineUtil.isNotEmpty(docTitle)) {
			//docTitle = decode(docTitle);
			condStr.append("AND a.name like '%" + UEngineUtil.searchStringFilter(docTitle) + "%' ");
		} else {
			docTitle = "";
		}
		
		//2009-08-04 InitiatorName start
		if (UEngineUtil.isNotEmpty(_Initiator)) {
			/*
			condStr.append(" AND a.initep in ( ");
			StringBuffer searchInitiatorString = new StringBuffer();
			for (String initiator : _Initiator.split(";")) {
				if (searchInitiatorString.length() > 0) searchInitiatorString.append(",");
				searchInitiatorString.append("'").append(initiator).append("'");
			}
			condStr.append(searchInitiatorString).append(" ) ");
			*/
			condStr.append(" AND a.initep LIKE '%").append(UEngineUtil.searchStringFilter(_Initiator)).append("%' ");
		} else {
			_Initiator = "";
		}
	
		if (!UEngineUtil.isNotEmpty(_Initiator_display)) {
			_Initiator_display = "";
		} else {
			condStr.append(" AND a.initrsnm LIKE '%").append(UEngineUtil.searchStringFilter(_Initiator_display)).append("%' ");
		}
	
		if (!UEngineUtil.isNotEmpty(_Initiator__which_is_xml_value)) {
			_Initiator__which_is_xml_value = "";
		}
		//2009-08-04 InitiatorName end
		
		
		//2009-08-04 NowPersonName start
		if(UEngineUtil.isNotEmpty(_Nowperson)){
			/*			
			condStr.append(" AND a.currep in ( ");
			StringBuffer searchNowpersonString = new StringBuffer();
			for (String nowperson : _Nowperson.split(";")) {
				if (searchNowpersonString.length() > 0) searchNowpersonString.append(",");
				searchNowpersonString.append("'").append(nowperson).append("'");
			}
			condStr.append(searchNowpersonString).append(" ) ");
			*/
			condStr.append(" AND a.currep LIKE '%").append(UEngineUtil.searchStringFilter(_Nowperson)).append("%' ");
		} else {
			_Nowperson = "";
		}
	
		if(!UEngineUtil.isNotEmpty(_Nowperson_display)){
			_Nowperson_display = "";
		} else {
			condStr.append(" AND a.currrsnm LIKE '%").append(UEngineUtil.searchStringFilter(_Nowperson_display)).append("%' ");
		}
	
		if(!UEngineUtil.isNotEmpty(_Nowperson__which_is_xml_value)){
			_Nowperson__which_is_xml_value = "";
		}
		//2009-08-04 NowPersonName end
	
		if (UEngineUtil.isNotEmpty(init_start_date)) {
			condStr.append("AND a.StartedDATE >= '" + UEngineUtil.searchStringFilter(init_start_date) + "' ");
		} else {
			init_start_date = "";
		}
	
		if (UEngineUtil.isNotEmpty(init_end_date)) {
			condStr.append("AND a.StartedDATE <= '" + UEngineUtil.searchStringFilter(init_end_date) + "' ");
		} else {
			init_end_date = "";
		}
	
		if (UEngineUtil.isNotEmpty(complete_start_date)) {
			condStr.append("AND a.finishedDATE >= '" + UEngineUtil.searchStringFilter(complete_start_date) + "' ");
		} else {
			complete_start_date = "";
		}
	
		if (UEngineUtil.isNotEmpty(complete_end_date)) {
			condStr.append("AND a.finishedDATE <= '" + UEngineUtil.searchStringFilter(complete_end_date) + "' ");
		} else {
			complete_end_date = "";
		}
	
		// 2009-08-05 add
		if(UEngineUtil.isNotEmpty(_Instance)){
			condStr.append(" AND instid = " + UEngineUtil.searchStringFilter(_Instance) + " ");
		} else {
			_Instance = "";
		}
	}
	
	String sqlFrom = null;

	if(!loggedUserIsMaster)
	{
		String dBMSProductName = null;
		try {
			dBMSProductName = DAOFactory.getInstance().getDBMSProductName();
		} catch (Exception e) {
			e.printStackTrace();
		}

		if ("MySQL".equals(dBMSProductName)) {
			sqlFrom = " FROM bpm_procinst a, bpm_procdef b WHERE a.defid = b.defid AND b.comcode = '" + loggedUserGlobalCom + "' AND ";
		} else {
			sqlFrom = " FROM bpm_procinst a LEFT JOIN bpm_procdef b ON a.defid = b.defid WHERE b.comcode = '" + loggedUserGlobalCom + "' AND ";
		}
	}
	else
	{
		sqlFrom = " FROM bpm_procinst a WHERE ";
	}

	String sql = "SELECT a.instid, a.defname, a.startedDate, a.finishedDate, a.status, a.info, a.name, a.isDeleted, a.ext1, a.defid, "
			+ " a.initep, a.initrsnm, a.currep, a.currrsnm " // add view column
			+ sqlFrom + " a.instid = rootinstid "
			+ " AND a.isDeleted = 0 "
			+ condStr
			+ " ORDER BY a.starteddate DESC";

	System.out.println("[ SQL : "+ sql +" ]");

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
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("th {\r\n");
      out.write("\tfont-size: 9pt;\r\n");
      out.write("}\r\n");
      out.write("td {\r\n");
      out.write("\tfont-size: 8pt;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</style>\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../scripts/formActivity.js.jsp" + (("../scripts/formActivity.js.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("rmClsName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(rmClsName), request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/instanceList.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("$(document).ready(function() {\r\n");
      out.write("\tcheckItem();\r\n");
      out.write("\tsetCalender(\"");
      out.print(loggedUserLocale);
      out.write("\", {buttonImage:\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Icon/btn_calendar.gif\"});\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function checkItem() {\r\n");
      out.write("\tvar options = document.getElementById(\"status\").options;\r\n");
      out.write("\tfor (var i = 0; i < options.length; i++) {\r\n");
      out.write("\t\toption = options[i];\r\n");
      out.write("\t\tif (option.value == \"");
      out.print(_status);
      out.write("\") {\r\n");
      out.write("\t\t\toption.selected = true;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function resetSubmit() {\r\n");
      out.write("\tvar inputs = document.refreshForm.elements;\r\n");
      out.write("\tfor (var i = 0; i < inputs.length; i++) {\r\n");
      out.write("\t\tinputs[i].value = \"\";\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tdocument.refreshForm.submit();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function searchDetail() {\r\n");
      out.write("\tvar mainForm = document.refreshForm;\r\n");
      out.write("\r\n");
      out.write("\tmainForm.Nowperson_display.value = $(\"#Nowperson_display\").val();\r\n");
      out.write("\tmainForm.Nowperson.value = $(\"#Nowperson\").val();\r\n");
      out.write("\tmainForm.Initiator.value = $(\"#Initiator\").val();\r\n");
      out.write("\tmainForm.Initiator_display.value = $(\"#Initiator_display\").val();\r\n");
      out.write("\tmainForm.Instance.value = $(\"#Instance\").val();\r\n");
      out.write("\tmainForm.docTitle.value = $(\"#docTitle\").val();\r\n");
      out.write("\tmainForm.init_start_date.value = $(\"#init_start_date\").val();\r\n");
      out.write("\tmainForm.init_end_date.value = $(\"#init_end_date\").val();\r\n");
      out.write("\tmainForm.complete_start_date.value = $(\"#complete_start_date\").val();\r\n");
      out.write("\tmainForm.complete_end_date.value = $(\"#complete_end_date\").val();\r\n");
      out.write("\r\n");
      out.write("\tmainForm.simpleKeyWord.value = \"\";\r\n");
      out.write("\tmainForm.submit();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<title>");
      out.print(GlobalContext.getMessageForWeb("Instance List", loggedUserLocale));
      out.write("</title>\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\thtml body {\r\n");
      out.write("\t\tmargin: 10px;\r\n");
      out.write("\t}\r\n");
      out.write("</style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("<!-- Start Detail Search Layer -->\r\n");
      out.write("<div id=\"divSubSearch\" class=\"divSubSearchStyle\" style=\"display: none;\" title=\"");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("\">\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" >\r\n");
      out.write("\t<colgroup>\r\n");
      out.write("\t    <col span=\"1\" width=\"110\" style=\"font-weight: bold; font-size: 12pt;\">\r\n");
      out.write("        <col span=\"1\" width=\"220\">\r\n");
      out.write("        <col span=\"1\" width=\"110\">\r\n");
      out.write("        <col span=\"1\" width=\"*\">\r\n");
      out.write("\t</colgroup>\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\"><input type=\"text\" id=\"docTitle\" value=\"");
      out.print(docTitle);
      out.write("\" size='28' /></td>\r\n");
      out.write("\t        <!-- 2009-08-05 update start -->\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Instance_Id", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\"><input type=\"text\" id=\"Instance\" value=\"");
      out.print(_Instance);
      out.write("\" onBlur=\"validate_Number(this);\" size='28'/></td>\r\n");
      out.write("\t        <!-- 2009-08-05 update end -->\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <!-- 2009-08-05 start -->\r\n");
      out.write("\t    <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("\t        <td colspan=\"5\"  height=\"1\"></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print( GlobalContext.getMessageForWeb("Initiator Name", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\">\r\n");
      out.write("\t        \t<input type=\"hidden\" id='Initiator__which_is_xml_value' name=\"Initiator__which_is_xml_value\" value=\"");
      out.print(_Initiator__which_is_xml_value );
      out.write("\" />\r\n");
      out.write("\t            <input type=\"text\" name=\"Initiator_display\" id=\"Initiator_display\" size='28' value=\"");
      out.print(_Initiator_display);
      out.write("\" />\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print( GlobalContext.getMessageForWeb("Initiator Id", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\"><input type=\"text\" name=\"Initiator\"  id=\"Initiator\" size='28' value=\"");
      out.print(_Initiator);
      out.write("\" /></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("\t        <td colspan=\"5\"  height=\"1\"></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Current Participant Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\">\r\n");
      out.write("\t        \t<input type=\"hidden\" id='Nowperson__which_is_xml_value' name=\"Nowperson__which_is_xml_value\" value=\"");
      out.print(_Nowperson__which_is_xml_value );
      out.write("\" />\r\n");
      out.write("\t            <input type=\"text\" name=\"Nowperson_display\" id=\"Nowperson_display\" size='28' value=\"");
      out.print(_Nowperson_display);
      out.write("\"/>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Current Participant Id", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\"><input type=\"text\" name=\"Nowperson\" id=\"Nowperson\" size='28' value=\"");
      out.print(_Nowperson);
      out.write("\"/></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("\t        <td colspan=\"5\"  height=\"1\"></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t    <!-- 2009-08-05 end -->\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\">\r\n");
      out.write("\t        \t<input type=\"text\" id=\"init_start_date\" value=\"");
      out.print(init_start_date);
      out.write("\" class='j_calendar' size=\"8\"/>\r\n");
      out.write("\t        \t~ <input type=\"text\" id=\"init_end_date\" value=\"");
      out.print(init_end_date);
      out.write("\" class='j_calendar' size=\"8\"/>\r\n");
      out.write("\t        </td>\r\n");
      out.write("\t        <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("End Date", loggedUserLocale));
      out.write("</td>\r\n");
      out.write("\t        <td class=\"formcon\">\r\n");
      out.write("\t        \t<input type=\"text\" id=\"complete_start_date\" value=\"");
      out.print(complete_start_date);
      out.write("\" class='j_calendar' size=\"8\"/>\r\n");
      out.write("\t        \t~ <input type=\"text\" id=\"complete_end_date\" value=\"");
      out.print(complete_end_date);
      out.write("\" class='j_calendar' size=\"8\"/>\r\n");
      out.write("\t        </td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- End Detail Search Layer -->\r\n");
      out.write("\r\n");
      out.write("<form name=\"refreshForm\" method=\"post\" action=\"processInstanceList.jsp\" onSubmit=\"document.refreshForm.currentPage.value=1;\">\r\n");
      out.write("<fieldset class='block-labels' >\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td align=\"right\" style=\"padding:0 0 10px 0;\">\r\n");
      out.write("        \t<table width=\"*\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                <tr height=\"25\" valign=\"middle\">\r\n");
      out.write("                    <td><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitle.gif\" width=\"70\" height=\"25\"></td>\r\n");
      out.write("\t                <td background=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleCenter.gif\" valign=\"middle\">\r\n");
      out.write("                    \t<select name=\"status\" id=\"status\" style=\"width: 120px\">\r\n");
      out.write("                            <option value=\"All\">");
      out.print(GlobalContext.getMessageForWeb("Status", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("All", loggedUserLocale));
      out.write("</option>\r\n");
      out.write("                            <option value=\"Running\">");
      out.print(GlobalContext.getMessageForWeb("Status", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("Running", loggedUserLocale));
      out.write("</option>\r\n");
      out.write("                            <option value=\"Completed\">");
      out.print(GlobalContext.getMessageForWeb("Status", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("Completed", loggedUserLocale));
      out.write("</option>\r\n");
      out.write("                            <option value=\"Stopped\">");
      out.print(GlobalContext.getMessageForWeb("Status", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("Stopped", loggedUserLocale));
      out.write("</option>\r\n");
      out.write("                            <option value=\"Failed\">");
      out.print(GlobalContext.getMessageForWeb("Status", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(GlobalContext.getMessageForWeb("Failed", loggedUserLocale));
      out.write("</option>\r\n");
      out.write("                        </select>\r\n");
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
      out.write("\t                    alt=\"Search\" align=\"middle\" onclick=\"searchSimple();\" style=\"cursor: pointer;\" />\r\n");
      out.write("\t                    <a href=\"processInstanceListDetail.jsp\"><img src=\"");
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
      out.write("\t                    <a href=\"javascript: showDetailSearch('ProcessManager', '750', '150', '");
      out.print(GlobalContext.getMessageForWeb("Search Button", loggedUserLocale));
      out.write("', '");
      out.print(GlobalContext.getMessageForWeb("Close Button", loggedUserLocale));
      out.write("');\" style=\"text-decoration:underline;\">");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("</a></td>\r\n");
      out.write("\t                <td><img src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("/images/Common/searchTitleRight.gif\"></td>\r\n");
      out.write("                </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<input type=\"hidden\" name=\"currentPage\" value=\"");
      out.print(currentPage);
      out.write("\">\r\n");
      out.write("<!-- Sort -->\r\n");
      out.write("<input type=\"hidden\" name=\"sort_column\" value=\"");
      out.print(strSortColumn);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"sort_cond\" value=\"");
      out.print(strSortCond);
      out.write("\">\r\n");
      out.write("<!-- Search -->\r\n");
      out.write("<input type=\"hidden\" name=\"TARGETCOND\" value=\"");
      out.print(strTarget);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"defId\" value=\"");
      out.print(_defId);
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("<input type=\"hidden\" name=\"Nowperson\" value=\"");
      out.print(_Nowperson);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"Nowperson_display\" value=\"");
      out.print(_Nowperson_display);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"Initiator\" value=\"");
      out.print(_Initiator);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"Initiator_display\" value=\"");
      out.print(_Initiator_display);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"Instance\" value=\"");
      out.print(_Instance);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"docTitle\" value=\"");
      out.print(docTitle);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"init_start_date\" value=\"");
      out.print(init_start_date);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"init_end_date\" value=\"");
      out.print(init_end_date);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"complete_start_date\" value=\"");
      out.print(complete_start_date);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"complete_end_date\" value=\"");
      out.print(complete_end_date);
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("<input type='hidden' name='Nowperson__which_is_xml_value' id=\"Nowperson__which_is_xml_value\" value=\"");
      out.print(_Nowperson__which_is_xml_value);
      out.write("\" />\r\n");
      out.write("<input type='hidden' name='Initiator__which_is_xml_value' id=\"Initiator__which_is_xml_value\" value=\"");
      out.print(_Initiator__which_is_xml_value);
      out.write("\" />\r\n");
      out.write("\r\n");
      out.write("</fieldset>\r\n");
      out.write("\r\n");

	if (UEngineUtil.isNotEmpty(_defId)) {

      out.write("\r\n");
      out.write("\tSearch for process definition : ");
      out.print(_defId );
      out.write('\r');
      out.write('\n');

	}

      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("    <table width=\"100%\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td>\r\n");
      out.write("            \t<table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" class=\"tableborder\">\r\n");
      out.write("                    <colgroup>\r\n");
      out.write("\t                    <col width=\"50px\" height=\"27px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"50px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"*\" align=\"left\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"155px\" align=\"left\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"60px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"70px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"130px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"100px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"100px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"30px\">\r\n");
      out.write("\t                    <col width=\"2px\">\r\n");
      out.write("\t                    <col width=\"50px\">\r\n");
      out.write("                    </colgroup>\r\n");
      out.write("                    <tr class=\"tabletitle\" align=\"center\" height=\"26\">\r\n");
      out.write("                    \t<th>");
      out.print(GlobalContext.getMessageForWeb("Status", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <!-- --------------------------add view column---------------------- -->\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Initiator", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Current Participant", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <!-- --------------------------------------------------------------- -->\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Info", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("End Date", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Ext1", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                        <th><img src=\"../images/Common/tabletitleline.gif\" width=\"2\"></th>\r\n");
      out.write("                        <th>");
      out.print(GlobalContext.getMessageForWeb("Remove", loggedUserLocale));
      out.write("</th>\r\n");
      out.write("                    </tr>\r\n");

				//	ProcessInstanceDAO procInst = (ProcessInstanceDAO)GenericDAO.createDAOImpl("java:/uEngineDS", sql, ProcessInstanceDAO.class);
				//	procInst.select();
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
				//int aclTotalCount = 0;
				//	while(procInst.next()){
				if (totalCount > 0) {
					boolean isGray = false;
					String bgcolor = " onmouseover=\"this.style.backgroundColor='#e7effa';\" onmouseout=\"this.style.backgroundColor = '';\" ";

					String strGrayStyle = " bgcolor=\"#F2F2F2\" ";

					String strNotGrayStyle = " bgcolor=\"#FFFFFF\" ";
					
					AclManager acl = AclManager.getInstance();
					
					for (int i = 0; i < dl.size(); i++) {
						DataMap tmpMap = (DataMap) dl.get(i);
						String pid = tmpMap.getString("instid", "-");
						String status = tmpMap.getString("status", "-");
						String instName = tmpMap.getString("name", "-");
						String initrsnm = tmpMap.getString("initrsnm", "-");
						String currrsnm = tmpMap.getString("currrsnm", "-");
						String defName = tmpMap.getString("defname", "-");
						String info = tmpMap.getString("info", "-");
						String startedDate = tmpMap.getString("startedDate", "-");
						if (startedDate.length() > 10) {
							startedDate = startedDate.substring(0,16);
						}
						String finishedDate = tmpMap.getString("finishedDate", "-");
						if (finishedDate.length() > 10) {
							finishedDate = finishedDate.substring(0,16);
						}
						String ext1 = tmpMap.getString("ext1", "-");
						String defId = tmpMap.getString("defid", "-");

						HashMap permission = null;
						if (loggedUserIsAdmin) {
                            permission = new HashMap();
							permission.put(AclManager.PERMISSION_MANAGEMENT, true);
						} else {
						    permission = acl.getPermission(Integer.parseInt(defId), loggedUserId);
						}
						
						String backGroundColor = bgcolor + (isGray ? strGrayStyle : strNotGrayStyle);
						isGray = !isGray;
						
						if (permission.containsKey(AclManager.PERMISSION_MANAGEMENT) || permission.containsKey(AclManager.PERMISSION_EDIT)) {

      out.write("\r\n");
      out.write("                    <tr align=\"center\" style=\"font-size: 9pt; height: 24px;\" ");
      out.print(backGroundColor);
      out.write(">\r\n");
      out.write("                        <td><font color=\"");
      out.print(colors.get(status));
      out.write('"');
      out.write('>');
      out.print(status);
      out.write("</font></td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(pid);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td><a href='viewProcessFlowChart.jsp?instanceId=");
      out.print(pid);
      out.write("'><strong>");
      out.print(instName);
      out.write("</strong></a></td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(defName);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(initrsnm);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(currrsnm);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(info);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(startedDate);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(finishedDate);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td>");
      out.print(ext1);
      out.write("</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                        <td><a href='removeProcessInstance.jsp?instanceId=");
      out.print(pid);
      out.write("&cp=");
      out.print(currentPage);
      out.write("'><img\r\n");
      out.write("\t\t\t\t\tsrc=\"../images/Common/b_delete02.gif\" alt=\"remove instance\"></a></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td colspan=\"121\" height=\"1\" bgcolor=\"#c7d3e4\"></td>\r\n");
      out.write("                    </tr>\r\n");

						}
					}
				}

      out.write("\r\n");
      out.write("                </table></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td align=\"center\">\r\n");

			if (totalCount > 0) {

      out.write("\r\n");
      out.write("                <!--\t#####\tNavigation start\t\t#####\t-->\r\n");
      out.write("                <br style=\"line-height: 15px;\">\r\n");
      out.write("                ");
      //  bpm:page
      org.uengine.ui.taglibs.PagingTag _jspx_th_bpm_005fpage_005f0 = (org.uengine.ui.taglibs.PagingTag) _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.get(org.uengine.ui.taglibs.PagingTag.class);
      _jspx_th_bpm_005fpage_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bpm_005fpage_005f0.setParent(null);
      // /processmanager/processInstanceListDetail.jsp(599,16) name = link type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLink("");
      // /processmanager/processInstanceListDetail.jsp(599,16) name = totalcount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setTotalcount(totalCount);
      // /processmanager/processInstanceListDetail.jsp(599,16) name = pagecount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagecount(intPageCnt);
      // /processmanager/processInstanceListDetail.jsp(599,16) name = pagelimit type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagelimit(nPagesetSize);
      // /processmanager/processInstanceListDetail.jsp(599,16) name = currentpage type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setCurrentpage(currentPage);
      // /processmanager/processInstanceListDetail.jsp(599,16) name = locale type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLocale(loggedUserLocale);
      int _jspx_eval_bpm_005fpage_005f0 = _jspx_th_bpm_005fpage_005f0.doStartTag();
      if (_jspx_th_bpm_005fpage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.reuse(_jspx_th_bpm_005fpage_005f0);
      out.write("\r\n");
      out.write("                <br>\r\n");

			}

      out.write("\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</form>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
      out.write('\r');
      out.write('\n');
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
