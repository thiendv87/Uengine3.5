package org.apache.jsp.processparticipant;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.persistence.dao.*;
import org.uengine.ui.list.datamodel.DataList;
import org.uengine.ui.list.util.DAOListCursorUtil;
import org.uengine.ui.list.datamodel.QueryCondition;
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

public final class viewProcessMain_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants.add("/processparticipant/../common/header.jsp");
    _jspx_dependants.add("/processparticipant/../common/headerMethods.jsp");
    _jspx_dependants.add("/processparticipant/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/processparticipant/../common/styleHeader.jsp");
    _jspx_dependants.add("/processparticipant/../lib/jquery/importJquery.jsp");
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

DataList dl = null;
QueryCondition condition = new QueryCondition();

int totalCount = 0;
int intPageCnt = 50;
int currentPage = reqMap.getInt("CURRENTPAGE", 1);
int nPagesetSize = 10;
int totalPageCount = 0;

String userId = (String)session.getAttribute("loggedUserId");

String pd = reqMap.getString("processDefinition", "");
String filtering = reqMap.getString("filtering", "0");
String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
String definitionName = reqMap.getString("inputDefinitionName", "");
String definitionAlias = reqMap.getString("inputDefinitionAlias", "");
String parentFolderName = reqMap.getString("inputParentFolderName", "");

reqMap.put("userId" ,userId);
reqMap.put("simpleKeyWord" ,simpleKeyWord.toLowerCase());
reqMap.put("definitionName" ,definitionName);
reqMap.put("definitionAlias" ,definitionAlias);
reqMap.put("parentFolderName" ,parentFolderName);

condition.setMap(reqMap);
condition.setOnePageCount(intPageCnt);
condition.setPageNo(currentPage);

StringBuffer strAddWhere = new StringBuffer();
StringBuffer sql = new StringBuffer();

String lowerCaseFunctionName = "LCASE";
String concatFunctionString = "CONCAT(CONCAT('%', ?), '%')";
String typeOfDBMS = "";
try{
	typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
}catch (Exception e) {
    e.printStackTrace();
}

if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
    lowerCaseFunctionName = "LOWER";
}

if ("POSTGRES".equals(typeOfDBMS)) {
	concatFunctionString = "'%'||?||'%'";
}

if (UEngineUtil.isNotEmpty(simpleKeyWord)) {
     
    strAddWhere.append(" AND (");
    strAddWhere.append("     ").append(lowerCaseFunctionName).append("(PDEF.NAME) LIKE ").append(concatFunctionString).append(" OR ");
    strAddWhere.append("     ").append(lowerCaseFunctionName).append("(DEF.NAME)  LIKE ").append(concatFunctionString).append(" OR ");
    strAddWhere.append("     ").append(lowerCaseFunctionName).append("(DEF.ALIAS) LIKE ").append(concatFunctionString);
    strAddWhere.append(" )   ");
    
} else {
    if (UEngineUtil.isNotEmpty(parentFolderName)) {
    	strAddWhere.append(" AND ")
    	.append(lowerCaseFunctionName)
    	.append("(PDEF.NAME) LIKE ").append(concatFunctionString); 
    }
    
    if (UEngineUtil.isNotEmpty(definitionName)) {
    	strAddWhere.append(" AND ")
    	.append(lowerCaseFunctionName)
    	.append("(DEF.NAME) LIKE ").append(concatFunctionString);
    }

    if (UEngineUtil.isNotEmpty(definitionAlias)) {
    	strAddWhere.append(" AND ")
    	.append(lowerCaseFunctionName)
    	.append("(DEF.ALIAS) LIKE ").append(concatFunctionString);
    }
}

sql.append("SELECT \r\n") 
.append("	DEF.DEFID, \r\n") 
.append("	DEF.PRODVER, \r\n") 
.append("	DEF.PRODVERID, \r\n") 
.append("	DEF.NAME, \r\n") 
.append("	DEF.ALIAS, \r\n") 
.append("	PDEF.NAME AS PARENTFOLDERNAME, \r\n") 
.append("	COUNT(INST.INSTID) AS INITCOUNT, \r\n") 
.append("	( \r\n") 
.append("		SELECT COUNT(*) \r\n") 
.append("		FROM BPM_PROCINST INST \r\n") 
.append("		WHERE INST.STATUS='Running' \r\n") 
.append("		AND INST.DEFVERID=DEF.PRODVERID \r\n") 
.append("		AND INST.ISSUBPROCESS='0' \r\n") 
.append("	)AS INSTCOUNT \r\n") 
.append(" FROM \r\n") 
.append("	BPM_PROCDEf DEF \r\n") 
.append("	LEFT JOIN BPM_PROCDEF PDEF ON DEF.PARENTFOLDER = PDEF.DEFID \r\n") 
.append("	,BPM_PROCINST INST \r\n") 
.append(" WHERE \r\n") 
.append("	DEF.DEFID = INST.DEFID \r\n") 
.append("	AND DEF.ISDELETED='0' \r\n") 
.append("	AND DEF.OBJTYPE='process' \r\n") 
.append("	AND INST.ISSUBPROCESS = '0' \r\n") 
.append("	AND INST.INITEP = ? \r\n") 
.append("	AND INST.STATUS='Running' \r\n")
.append(strAddWhere.toString()) //검색조건
.append(" GROUP BY DEF.DEFID, DEF.PRODVER, DEF.PRODVERID, DEF.NAME, DEF.ALIAS, PDEF.NAME ");

ProcessManagerRemote pm = null;
ProcessDefinitionRemote pdr = null;
String pdver = null;
String processName = "";

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

ListField[] listFields = null;

ListField[] defListFields = new ListField[6];
defListFields[0] = new ListField(GlobalContext.getMessageForWeb("Folder Name", loggedUserLocale), new InstanceTableListFieldType("parentfoldername"));
defListFields[1] = new ListField(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale) , new InstanceTableListFieldType("name"));
defListFields[2] = new ListField(GlobalContext.getMessageForWeb("Alias", loggedUserLocale) , new InstanceTableListFieldType("alias"));
defListFields[3] = new ListField(GlobalContext.getMessageForWeb("Version", loggedUserLocale) , new InstanceTableListFieldType("prodver"));
defListFields[4] = new ListField(GlobalContext.getMessageForWeb("Running Instance(count)", loggedUserLocale), new InstanceTableListFieldType("instcount"));
defListFields[5] = new ListField(GlobalContext.getMessageForWeb("Executed Instance(count)", loggedUserLocale), new InstanceTableListFieldType("initcount"));

listFields = defListFields;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("\r\n");
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
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/instanceList.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("$(document).ready(function() {\r\n");
      out.write("\tsetListForm(document.refreshForm);\r\n");
      out.write("});\r\n");
      out.write("</script>\r\n");
      out.write("<title>");
      out.print(GlobalContext.getLocalizedMessageForWeb("process_index_title", loggedUserLocale, "Frequently Executed Processes") );
      out.write("</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("<div id=\"divSubSearch\" style=\"display: none; height:100%;\" title=\"");
      out.print(GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) );
      out.write("\">\r\n");
      out.write("    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" height=\"100%\">\r\n");
      out.write("        <colgroup>\r\n");
      out.write("\t        <col span=\"1\" width=\"150\" style=\"font-weight: bold; font-size: 12pt;\">\r\n");
      out.write("\t        <col span=\"1\" width=\"*\">\r\n");
      out.write("        </colgroup>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Folder Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\"><input type=\"text\" id=\"inputParentFolderName\" value=\"");
      out.print(parentFolderName );
      out.write("\" size='25' /></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("            <td colspan=\"4\" height=\"1\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\"><input type=\"text\" id=\"inputDefinitionName\" value=\"");
      out.print(definitionName);
      out.write("\" size='25' /></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr bgcolor=\"#b9cae3\">\r\n");
      out.write("            <td colspan=\"4\" height=\"1\"></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td class=\"formtitle\">");
      out.print(GlobalContext.getMessageForWeb("Alias", loggedUserLocale) );
      out.write("</td>\r\n");
      out.write("            <td class=\"formcon\"><input type=\"text\" id=\"inputDefinitionAlias\" value=\"");
      out.print(definitionAlias);
      out.write("\" size='25' /></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</div>\r\n");
      out.write("<form name=\"refreshForm\" method=\"post\" action=\"viewProcessMain.jsp?userId=");
      out.print(userId);
      out.write("\">\r\n");
      out.write("    <table border='0' width='98%' align=\"center\" cellpadding='0' cellspacing='0'>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td valign='top'>\r\n");
      out.write("            \t<fieldset class='block-labels' >\r\n");
      out.write("                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                \t<tr>\r\n");
      out.write("                    \t<td>\r\n");
      out.write("\t\t\t            ");
if (UEngineUtil.isNotEmpty(pd)) {
      out.write("\r\n");
      out.write("\t\t\t            \t<h3>");
      out.print(processName);
      out.write("</h3>\r\n");
      out.write("\t\t\t            ");
}
      out.write("\r\n");
      out.write("                    \t</td>\r\n");
      out.write("                        <td align=\"right\" style=\"padding:10px 0;\">\r\n");
      out.write("                        \t<table width=\"*\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                            \t<tr height=\"25\" valign=\"middle\">\r\n");
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
      out.write("                                        <a href=\"viewProcessMain.jsp?filtering=");
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
      out.write("                                        <a href=\"javascript: showDetailSearch('Process', '400', 100, '");
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
      out.write("                </fieldset>\r\n");
      out.write("\t\t\t\t<table width=\"100%\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("                        \t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"tableborder\" style=\"border-bottom:1px solid #C5D2E3;\">\r\n");
      out.write("                            <colgroup>\r\n");
      out.write("                            \t<col width=\"150px\" height=\"27px\">\r\n");
      out.write("\t\t\t                    <col width=\"2px\">\r\n");
      out.write("\t\t\t                    <col width=\"*px\">\r\n");
      out.write("\t\t\t                    <col width=\"2px\">\r\n");
      out.write("\t\t\t                    <col width=\"200px\" align=\"left\">\r\n");
      out.write("\t\t\t                    <col width=\"2px\">\r\n");
      out.write("\t\t\t                    <col width=\"80px\" align=\"left\">\r\n");
      out.write("\t\t\t                    <col width=\"2px\">\r\n");
      out.write("\t\t\t                    <col width=\"180px\">\r\n");
      out.write("\t\t\t                    <col width=\"2px\">\r\n");
      out.write("\t\t\t                    <col width=\"180px\">\r\n");
      out.write("                            </colgroup>\r\n");
      out.write("                                <tr class=\"tabletitle\" align=\"center\">\r\n");
      out.write("                                ");

								// Make Header.
								boolean isGray = false;
								if (listFields != null){
									for (int i = 0; i < listFields.length; i++) {
								
      out.write("\r\n");
      out.write("\t                                <th nowrap=\"nowrap\" class=\"col-");
      out.print(i);
      out.write("\" align=\"center\"> ");
      out.print(listFields[i].getDisplayName().getText(loggedUserLocale));
      out.write(" </th>\r\n");
      out.write("\t                                <th width=\"2\"><img src=\"../images/Common/tabletitleline.gif\" width=\"2\" height=\"27\"></th>\r\n");
      out.write("\t                            ");
	}
      out.write("\r\n");
      out.write("                                </tr>\r\n");
      out.write("                               ");

									java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
                               		
                               		ArrayList pstmtValues = new ArrayList();
                               	 	pstmtValues.add(0, "userId");
                               	 	
                               	 	if(UEngineUtil.isNotEmpty(simpleKeyWord)){
	                               	 	pstmtValues.add("simpleKeyWord");
	                               	 	pstmtValues.add("simpleKeyWord");
	                               	 	pstmtValues.add("simpleKeyWord");
                               	 	}else{
                               	 		if(UEngineUtil.isNotEmpty(parentFolderName)){
		                               	 	pstmtValues.add("parentFolderName");
                               	 		}
                               	 		if(UEngineUtil.isNotEmpty(definitionName)){
		                               	 	pstmtValues.add("definitionName");
                               	 		}
                               	 		if(UEngineUtil.isNotEmpty(definitionAlias)){
		                               	 	pstmtValues.add("definitionAlias");
                               	 		}
                               	 	}
                               	 	
                               	 	try {
										dl = DAOListCursorUtil.executeList(sql.toString(), condition, pstmtValues, con);
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
											String defId = tmpMap.getString("defid", "-");
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
      out.write("\t\t\t\t\t\t\t\t<tr ");
      out.print(bgcolor);
      out.write(" style=\"cursor: pointer;\" onClick=\"viewObjectType('");
      out.print(defId);
      out.write("')\" >\r\n");
      out.write("\t\t\t\t\t\t\t\t");

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
									//add end 
									
      out.write("\r\n");
      out.write("                                    <td colspan=\"2\" align=\"center\">");
      out.print(bold);
      out.write("<font color=\"");
      out.print( (delay == true) ? "red" : "" );
      out.write('"');
      out.write('>');
      out.print((fieldValue == null) ? "-" : fieldValue);
      out.write("</font></td>\r\n");
      out.write("                                ");
	
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
      out.write("                            <!--    #####    paging start    #####    -->\r\n");
      out.write("                            <br style=\"line-height:15px;\">\r\n");
      out.write("                            ");
      //  bpm:page
      org.uengine.ui.taglibs.PagingTag _jspx_th_bpm_005fpage_005f0 = (org.uengine.ui.taglibs.PagingTag) _005fjspx_005ftagPool_005fbpm_005fpage_0026_005ftotalcount_005fpagelimit_005fpagecount_005flocale_005flink_005fcurrentpage_005fnobody.get(org.uengine.ui.taglibs.PagingTag.class);
      _jspx_th_bpm_005fpage_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bpm_005fpage_005f0.setParent(null);
      // /processparticipant/viewProcessMain.jsp(341,28) name = link type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setLink("");
      // /processparticipant/viewProcessMain.jsp(341,28) name = totalcount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setTotalcount(totalCount);
      // /processparticipant/viewProcessMain.jsp(341,28) name = pagecount type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagecount(intPageCnt);
      // /processparticipant/viewProcessMain.jsp(341,28) name = pagelimit type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setPagelimit(nPagesetSize);
      // /processparticipant/viewProcessMain.jsp(341,28) name = currentpage type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bpm_005fpage_005f0.setCurrentpage(currentPage);
      // /processparticipant/viewProcessMain.jsp(341,28) name = locale type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
      out.write("        \t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t<input type=\"hidden\" name=\"currentPage\" value=\"");
      out.print(currentPage);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"processDefinition\" value=\"");
      out.print(pd);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"inputDefinitionName\" value=\"");
      out.print(definitionName);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"inputDefinitionAlias\" value=\"");
      out.print(definitionAlias);
      out.write("\" />\r\n");
      out.write("\t<input type=\"hidden\" name=\"inputParentFolderName\" value=\"");
      out.print(parentFolderName);
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
