package org.apache.jsp;

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

public final class main_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(3);
    _jspx_dependants.add("/common/header.jsp");
    _jspx_dependants.add("/common/headerMethods.jsp");
    _jspx_dependants.add("/common/getLoggedUser.jsp");
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

      out.write('\r');
      out.write('\n');
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("<title>Untitled Document</title>\r\n");
      out.write("<link href=\"style/main.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvar WEB_CONTEXT_ROOT = \"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT);
      out.write("\";\r\n");
      out.write("\tvar endpoint = \"");
      out.print(loggedUserId);
      out.write("\";\r\n");
      out.write("\tvar notExistOpenWork = \"");
      out.print(GlobalContext.getMessageForWeb("Workitem does not exist", loggedUserLocale));
      out.write("\";\r\n");
      out.write("\tvar notExistRunningProcess = \"");
      out.print(GlobalContext.getMessageForWeb("Running the Process does not exist", loggedUserLocale));
      out.write("\";\r\n");
      out.write("\tvar notExistCompletedProcess =  \"");
      out.print(GlobalContext.getMessageForWeb("Completed the Process does not exist", loggedUserLocale));
      out.write("\";\r\n");
      out.write("</script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/crossBrowser/elementControl.js\" ></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(GlobalContext.WEB_CONTEXT_ROOT );
      out.write("/scripts/ajax/dashboard.js\" ></script>\r\n");
      out.write("</head>\r\n");
      out.write("<body onLoad=\"init();\">\r\n");
      out.write("<div class=\"wrap\">\r\n");
      out.write("    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td width=\"245\" valign=\"top\"><div id=\"leftsec\">\r\n");
      out.write("                    <table width=\"225\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td width=\"3\" height=\"3\"><img src=\"images/main/GrayBoxMo01.gif\" width=\"3\" height=\"3\" /></td>\r\n");
      out.write("                            <td background=\"images/main/GrayBoxLine01.gif\"></td>\r\n");
      out.write("                            <td width=\"3\" height=\"3\"><img src=\"images/main/GrayBoxMo02.gif\" width=\"3\" height=\"3\" /></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td background=\"images/main/GrayBoxLine04.gif\"></td>\r\n");
      out.write("                            <td width=\"225\" style=\"padding:0px 3px;\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                    <tr>\r\n");
      out.write("                                        <td height=\"18\"><img src=\"images/main/LogonInfo_");
      out.print(loggedUserLocale);
      out.write(".gif\" width=\"74\" height=\"15\" /></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                    <tr>\r\n");
      out.write("                                        <td bgcolor=\"e9e9e9\" height=\"1\"></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                    <tr>\r\n");
      out.write("                                        <td><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:4px 0px; overflow:\">\r\n");
      out.write("                                                <tr>\r\n");
      out.write("                                                    ");

														String imgPath="images/portrait/"+loggedUserId+".gif";
                                                    	
														java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
														if (!imgFile.exists()) imgPath="images/main/NoIMG.gif";
													
      out.write("\r\n");
      out.write("                                                    <td width=\"95\" rowspan=\"7\" valign=\"middle\"><a href=\"");
      out.print(imgPath );
      out.write("\" target=\"blank\"><img src=\"");
      out.print(imgPath );
      out.write("\" width=\"89\" height=\"100\" style=\"border:1px #CCCCCC solid;\"/></a></td>\r\n");
      out.write("                                                    <td  style=\"font-size:11px; letter-spacing:-0.1em;\"><img src=\"images/main/i_blue3.gif\" alt=\"\" width=\"4\" height=\"4\"  /> ");
      out.print(GlobalContext.getMessageForWeb("ID", loggedUserLocale));
      out.write(" : <strong>");
      out.print(loggedUserId);
      out.write("</strong></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr>\r\n");
      out.write("                                                    <td style=\"font-size:11px; letter-spacing:-0.1em;\"><img src=\"images/main/i_blue3.gif\" alt=\"\" width=\"4\" height=\"4\"/> ");
      out.print(GlobalContext.getMessageForWeb("Name", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(loggedUserFullName);
      out.write("</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr>\r\n");
      out.write("                                                    <td style=\"font-size:11px; letter-spacing:-0.1em;\"><img src=\"images/main/i_blue3.gif\" alt=\"\" width=\"4\" height=\"4\"/> ");
      out.print(GlobalContext.getMessageForWeb("msg.Title", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(loggedUserJikName);
      out.write("</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr>\r\n");
      out.write("                                                    <td style=\"font-size:11px; letter-spacing:-0.1em;\"><img src=\"images/main/i_blue3.gif\" alt=\"\" width=\"4\" height=\"4\"/> ");
      out.print(GlobalContext.getMessageForWeb("Department", loggedUserLocale));
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(loggedUserPartName);
      out.write("</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr>\r\n");
      out.write("                                                    <td></td>\r\n");
      out.write("                                                </tr>  \r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                            <td background=\"images/main/GrayBoxLine02.gif\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td width=\"3\" height=\"3\"><img src=\"images/main/GrayBoxMo04.gif\" width=\"3\" height=\"3\" /></td>\r\n");
      out.write("                            <td background=\"images/main/GrayBoxLine03.gif\"></td>\r\n");
      out.write("                            <td width=\"3\" height=\"3\"><img src=\"images/main/GrayBoxMo03.gif\" width=\"3\" height=\"3\" /></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <br />\r\n");
      out.write("                    <table width=\"225\" height=\"195\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" background=\"images/main/BusinessBox_");
      out.print(loggedUserLocale);
      out.write(".jpg\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td height=\"34\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td valign=\"top\"><table>\r\n");
      out.write("                            <tbody id=\"dashboardCount\"></tbody>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <br />\r\n");
      out.write("                </div></td>\r\n");
      out.write("            <td width=\"100%\" valign=\"top\"><div id=\"centersec\">\r\n");
      out.write("                    <!-- 처리할 업무함 -->\r\n");
      out.write("                    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td width=\"9\" height=\"9\"><img src=\"images/main/dsNewworkMo01.gif\" width=\"9\" height=\"9\"></td>\r\n");
      out.write("                            <td  width=\"100%\" background=\"images/main/dsNewworkLineT.gif\"></td>\r\n");
      out.write("                            <td width=\"9\" height=\"9\"><img src=\"images/main/dsNewworkMo02.gif\" width=\"9\" height=\"9\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td><img src=\"images/main/dsNewworkLineTbl.gif\" width=\"9\" height=\"27\"></td>\r\n");
      out.write("                            <td background=\"images/main/dsNewworkLineTB.gif\" valign=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                    <tr>\r\n");
      out.write("                                        <td valign=\"top\"><img src=\"images/main/process01_");
      out.print(loggedUserLocale);
      out.write(".gif\"></td>\r\n");
      out.write("                                        <td align=\"right\" style=\"padding-right:33px;\"><a href=\"processparticipant/worklist/index.jsp?type=worklist&filtering=0\" target=\"_parent\"><img src=\"images/main/b_more02.gif\"></a></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                            <td><img src=\"images/main/dsNewworkLineTbR.gif\" width=\"9\" height=\"27\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td background=\"images/main/dsNewworkLineL.gif\"></td>\r\n");
      out.write("                            <td class=\"padding10\"><table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                                    <thead>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"25\" width=\"40%\" align=\"left\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Work Name", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                            <td align=\"left\" width=\"50%\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                            <td align=\"center\" width=\"80\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"1\" colspan=\"3\" bgcolor=\"e5e5e5\"></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                    </thead>\r\n");
      out.write("                                    <tbody id=\"openWorkList\">\r\n");
      out.write("                                    </tbody>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                            <td background=\"images/main/dsNewworkLineR.gif\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td height=\"9\"><img src=\"images/main/dsNewworkMo04.gif\" width=\"9\" height=\"9\"></td>\r\n");
      out.write("                            <td background=\"images/main/dsNewworkLineB.gif\"></td>\r\n");
      out.write("                            <td><img src=\"images/main/dsNewworkMo03.gif\" width=\"9\" height=\"9\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td colspan=\"3\"><img src=\"images/main/Shadow.gif\" width=\"100%\" height=\"18\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <!-- 진행중인 프로세스 -->\r\n");
      out.write("                    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td class=\"padding19\"><table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                                    <thead>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td width=\"40%\" height=\"25\" valign=\"top\" align=\"left\" ><img src=\"images/main/process02_");
      out.print(loggedUserLocale);
      out.write(".gif\"></td>\r\n");
      out.write("                                            <td width=\"50%\" align=\"left\" >&nbsp;</td>\r\n");
      out.write("                                            <td width=\"80\" align=\"right\" valign=\"top\" style=\"padding:5px 0 0 0;\"><a href=\"processparticipant/participationProcess/index.jsp?type=instancelist&filtering=0\" target=\"_parent\"><img src=\"images/main/b_more.gif\" width=\"41\" height=\"14\"></a></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"2\" colspan=\"3\" bgcolor=\"bbbbbb\"></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"25\" align=\"left\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                            <td align=\"left\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                            <td align=\"center\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"1\" colspan=\"3\" bgcolor=\"e5e5e5\"></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                    </thead>\r\n");
      out.write("                                    <tbody id=\"runningProcessList\">\r\n");
      out.write("                                    </tbody>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <!-- 완료된 프로세스 출력 -->\r\n");
      out.write("                    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td class=\"padding19\"><table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                                    <thead>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td width=\"40%\" height=\"25\" valign=\"top\" align=\"left\" ><img src=\"images/main/process03_");
      out.print(loggedUserLocale);
      out.write(".gif\"></td>\r\n");
      out.write("                                            <td width=\"50%\" align=\"left\" >&nbsp;</td>\r\n");
      out.write("                                            <td width=\"80\" align=\"right\" valign=\"top\" style=\"padding:5px 0 0 0;\"><a href=\"processparticipant/participationProcess/index.jsp?type=instancelist&filtering=1\" target=\"_parent\"><img src=\"images/main/b_more.gif\" width=\"41\" height=\"14\"></a></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"2\" colspan=\"3\" bgcolor=\"bbbbbb\"></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"25\" align=\"left\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                            <td align=\"left\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                            <td align=\"center\" class=\"999font\"><strong>");
      out.print(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale));
      out.write("</strong></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td height=\"1\" colspan=\"3\" bgcolor=\"e5e5e5\"></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                    </thead>\r\n");
      out.write("                                    <tbody id=\"completedProcessList\">\r\n");
      out.write("                                    </tbody>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                </div></td>\r\n");
      out.write("            <td width=\"245\" valign=\"top\"><div id=\"rightsec\">\r\n");
      out.write("                    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border:1px solid #CCCCCC; \">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td><img src=\"images/main/5app_");
      out.print(loggedUserLocale);
      out.write(".gif\" width=\"137\" height=\"15\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td align=\"center\"><table width=\"187\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" background=\"images/main/GRbg.gif\">\r\n");
      out.write("                                    <tr align=\"center\" valign=\"bottom\">\r\n");
      out.write("                                        <td width=\"37\" height=\"123\" ><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>1230</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/GRbar.gif\" id=\"chart0\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"37\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>125</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/GRbar.gif\" id=\"chart1\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"37\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>256</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/GRbar.gif\" id=\"chart2\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"34\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>984</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/GRbar.gif\" id=\"chart3\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"42\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>85</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/GRbar.gif\" id=\"chart4\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                    <tr align=\"center\">\r\n");
      out.write("                                        <td height=\"33\" class=\"monthfont\">11 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">12 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">1 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">2 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">3 &nbsp;Mon</td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                    <tr align=\"center\">\r\n");
      out.write("                                        <td height=\"10\" colspan=\"5\"></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <br>\r\n");
      out.write("                    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border:1px solid #CCCCCC; \">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td><img src=\"images/main/5app2_");
      out.print(loggedUserLocale);
      out.write(".gif\" width=\"140\" height=\"15\"></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td align=\"center\"><table width=\"187\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" background=\"images/main/GRbg.gif\">\r\n");
      out.write("                                    <tr align=\"center\" valign=\"bottom\">\r\n");
      out.write("                                        <td width=\"37\" height=\"123\" ><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>1223</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/wrGRbar.gif\" id=\"wrchart0\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"37\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>1021</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/wrGRbar.gif\" id=\"wrchart1\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"37\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>568</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/wrGRbar.gif\" id=\"wrchart2\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"34\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>120</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/wrGRbar.gif\" id=\"wrchart3\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                        <td width=\"42\"><table width=\"12\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td>685</td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                                <tr align=\"center\">\r\n");
      out.write("                                                    <td><img src=\"images/main/wrGRbar.gif\" id=\"wrchart4\" height=\"0\" width=\"12\" align=\"middle\"></td>\r\n");
      out.write("                                                </tr>\r\n");
      out.write("                                            </table></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                    <tr align=\"center\">\r\n");
      out.write("                                        <td height=\"33\" class=\"monthfont\">11 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">12 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">1 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">2 Mon</td>\r\n");
      out.write("                                        <td class=\"monthfont\">3 &nbsp;Mon</td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                    <tr align=\"center\">\r\n");
      out.write("                                        <td height=\"10\" colspan=\"5\"></td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                                </table></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <script language=javascript> \r\n");
      out.write("                        <!--\r\n");
      out.write("                        var data=new Array(100,32,59,98,13); \r\n");
      out.write("                        \r\n");
      out.write("                        for(i=0;i<5;i++){ \r\n");
      out.write("                            if(eval(\"chart\" + i + \".height\") < data[i]){ \r\n");
      out.write("                                gph(\"chart\" + i,data[i]); \r\n");
      out.write("                            } \r\n");
      out.write("                        } \r\n");
      out.write("                        \r\n");
      out.write("                        function gph(what,limit){ \r\n");
      out.write("                            if(eval(what + \".height\") < limit){ \r\n");
      out.write("                            if(eval(what + \".height\")+5 > limit) \r\n");
      out.write("                                eval(what +\".height=\" + limit); \r\n");
      out.write("                            else \r\n");
      out.write("                                eval(what +\".height=\" + what + \".height + 5\"); \r\n");
      out.write("                                setTimeout(\"gph('\"+ what + \"',\" + limit + \")\",0); \r\n");
      out.write("                            } \r\n");
      out.write("                        }\r\n");
      out.write("                        //-->\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t <!--\r\n");
      out.write("                        var data=new Array(100,82,40,10,57); \r\n");
      out.write("                        \r\n");
      out.write("                        for(i=0;i<5;i++){ \r\n");
      out.write("                            if(eval(\"wrchart\" + i + \".height\") < data[i]){ \r\n");
      out.write("                                gph2(\"wrchart\" + i,data[i]); \r\n");
      out.write("                            } \r\n");
      out.write("                        } \r\n");
      out.write("                        \r\n");
      out.write("                        function gph2(what,limit){ \r\n");
      out.write("                            if(eval(what + \".height\") < limit){ \r\n");
      out.write("                            if(eval(what + \".height\")+5 > limit) \r\n");
      out.write("                                eval(what +\".height=\" + limit); \r\n");
      out.write("                            else \r\n");
      out.write("                                eval(what +\".height=\" + what + \".height + 5\"); \r\n");
      out.write("                                setTimeout(\"gph2('\"+ what + \"',\" + limit + \")\",0); \r\n");
      out.write("                            } \r\n");
      out.write("                        }\r\n");
      out.write("                        //-->\r\n");
      out.write("                        </script>\r\n");
      out.write("                </div></td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
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
