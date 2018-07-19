package org.apache.jsp.processmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.net.*;
import org.uengine.kernel.*;
import org.uengine.kernel.GlobalContext;
import com.defaultcompany.login.LoginService;

public final class ProcessDesigner_005fJNLP_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/processmanager/../common/getLoggedUser.jsp");
    _jspx_dependants.add("/processmanager/../common/headerMethods.jsp");
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
      response.setContentType("application/x-java-jnlp-file; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
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

      out.write('\n');
      out.write('\r');
      out.write('\n');
      out.write('\n');

		response.setContentType("application/x-java-jnlp-file; charset=UTF-8");
		response.setHeader("Cache-Control", "public");
		response.setHeader("Expires", "0");

        String url = request.getRequestURL().toString();
        String codebase = url.substring( 0, url.lastIndexOf( "/" ) );
        URL urlURL = new java.net.URL(codebase);
       	String host = urlURL.getHost();
       	int port = urlURL.getPort();
       	
       	RevisionInfo revInfo = new RevisionInfo();
       	
       // if(loggedRoleMapping.getEmailAddress()==null) loggedRoleMapping.fill();
       	
       	revInfo.setAuthorName(loggedRoleMapping.getResourceName());
       	revInfo.setAuthorId(loggedUserId);
       	revInfo.setAuthorCompany(loggedUserGlobalCom);
       	revInfo.setAuthorEmailAddress(loggedRoleMapping.getEmailAddress());
       	revInfo.setChangeTime(Calendar.getInstance());
       	
       	String authorInfo = GlobalContext.serialize(revInfo, RevisionInfo.class);
       	authorInfo = authorInfo.replace("<", "&lt;").replace(">", "&gt;");

		//String authorInfo = loggedUserId;
 
      out.write("\n");
      out.write("\n");
      out.write("<?xml version=\"1.0\" encoding=\"utf-8\"?> \n");
      out.write("\t<!-- you should modify the ip address for 'codebase' with an actual IP address of web server -->\n");
      out.write("\t<jnlp spec=\"1.0+\" codebase=\"");
      out.print(codebase);
      out.write("\"> \n");
      out.write("  \t  <information> \n");
      out.write("    \t    <title>u|Engine Process Designer</title> \n");
      out.write("    \t    <vendor>uEngine.org</vendor> \n");
      out.write("    \t      <homepage href=\"http://www.uengine.org\"/> \n");
      out.write("    \t      <description>u|Engine Process Designer</description> \n");
      out.write("    \t      <description kind=\"short\">u|Engine Process Designer</description> \n");
      out.write("    \t    <offline-allowed/> \n");
      out.write("  \t  </information> \n");
      out.write("\t  <security> \n");
      out.write("\t    <all-permissions/> \n");
      out.write("\t  </security>   \t  \n");
      out.write("  \t  <resources> \n");
      out.write("\t    <j2se version=\"1.5+\" initial-heap-size=\"500M\" max-heap-size=\"1000M\"/>\n");
      out.write("            <jar href=\"signeduengine.jar\"/> \n");
      out.write("            <jar href=\"signedmetaworks.jar\"/> \n");
      out.write("            <jar href=\"signedcul4xdk.jar\"/> \n");
      out.write("            <jar href=\"signeddocsoapxdk.jar\"/> \n");
      out.write("            <jar href=\"signedwsdl4j.jar\"/>           \n");
      out.write("            <jar href=\"signedxmlapis.jar\"/> \n");
      out.write("            <jar href=\"signedxerces_dom.jar\"/>             \n");
      out.write("            <jar href=\"signeddom4j.jar\"/> \n");
      out.write("            <jar href=\"signedjdom.jar\"/> \n");
      out.write("            <jar href=\"signedtwister-engine.jar\"/> \n");
      out.write("            <jar href=\"signedbpel.jar\"/>\n");
      out.write("            <jar href=\"signedtinylaf.jar\"/> \n");
      out.write("            <jar href=\"signedaxis.jar\"/> \n");
      out.write("            <jar href=\"signedbsf.jar\"/> \n");
      out.write("            <jar href=\"signedjakarta-regexp.jar\"/> \n");
      out.write("            <jar href=\"signedjboss-client.jar\"/> \n");
      out.write("            <jar href=\"signedjboss-common-client.jar\"/> \n");
      out.write("            <jar href=\"signedjs.jar\"/> \n");
      out.write("            <jar href=\"signedjxl.jar\"/> \n");
      out.write("            <jar href=\"signedjaxrpc.jar\"/> \n");
      out.write("            <jar href=\"signedjboss-j2ee.jar\"/> \n");
      out.write("            <jar href=\"signedjboss-transaction-client.jar\"/> \n");
      out.write("            <jar href=\"signedjbossall-client.jar\"/> \n");
      out.write("            <jar href=\"signedjbossmq-client.jar\"/> \n");
      out.write("            <jar href=\"signedcommons-httpclient.jar\"/> \n");
      out.write("            <jar href=\"signedcommons-logging.jar\"/> \n");
      out.write("            <jar href=\"signedcommons-codec.jar\"/> \n");
      out.write("            <jar href=\"signedcommons-lang.jar\"/> \n");
      out.write("            <jar href=\"signedxpp3.jar\"/> \n");
      out.write("            <jar href=\"signedxstream.jar\"/>\n");
      out.write("            <jar href=\"signeddrools-core.jar\"/>\n");
      out.write("            <jar href=\"signedjanino.jar\"/>\n");
      out.write("            <jar href=\"signedservlet.jar\"/>\n");
      out.write("            <jar href=\"signedxml-apis-ext.jar\"/>\n");
      out.write("            <jar href=\"signedbatik-all.jar\"/>\n");
      out.write("            <jar href=\"signedflamingo.jar\"/>\n");
      out.write("            <jar href=\"signedsubstance.jar\"/>\n");
      out.write("            <jar href=\"signedsubstance-flamingo.jar\"/>\n");
      out.write("            <jar href=\"signedswingx.jar\"/>\n");
      out.write("                     \n");
      out.write("            <jar href=\"signeduengine_settings.jar\"/> \n");
      out.write("            \n");

	try{
		URL jlurl = new URL(codebase + "/jarlist.xml");
		ArrayList jarList = (ArrayList)GlobalContext.deserialize(jlurl.openStream(), String.class);
		for(Iterator iter = jarList.iterator(); iter.hasNext();){
			Object item = (Object)iter.next();
			
      out.write("\t\t<jar href=\"signed");
      out.print(item);
      out.write('"');
      out.write('/');
      out.write('>');

		}		
	}catch(Exception e){
		//e.printStackTrace();
	}

      out.write("\n");
      out.write("\n");
      out.write("\t\t<property name=\"bpm_host\" value=\"");
      out.print(host);
      out.write("\"/>\t\t\n");

		if(port > 0){

      out.write("\n");
      out.write("\t\t<property name=\"bpm_port\" value=\"");
      out.print(port);
      out.write("\"/>\t\t\n");

		}

      out.write("\n");
      out.write("      </resources> \n");
      out.write("      \n");

	String instanceId = request.getParameter("instanceId");
	String defId = request.getParameter("defId");
	String defVerId = request.getParameter("defVerId");
	String folderId = request.getParameter("folderId");
	String superDefId = request.getParameter("superDefId");
	if(folderId==null || folderId.trim().length()==0) folderId="null";
	System.out.println("--------------------------------------------------------------");
	System.out.println("defId " + defId);
	System.out.println("defVerId " + defVerId);
	System.out.println("folderId " + folderId);
	System.out.println("--------------------------------------------------------------");
	
	if(instanceId!=null){
      out.write("\n");
      out.write("      <application-desc main-class=\"org.uengine.processdesigner.ProcessDesigner\">\n");
      out.write("      \t\t<argument>");
      out.print(loggedUserLocale);
      out.write("</argument> \n");
      out.write("\t\t    <argument>@ADHOC</argument> \n");
      out.write("\t\t    <argument>");
      out.print(instanceId);
      out.write("</argument> \n");
      out.write("\t\t    <argument>");
      out.print(host);
      out.write("</argument> \n");
      out.write("\t\t    <argument>");
      out.print(defId);
      out.write("</argument> \n");
      out.write("\t  </application-desc>\t\t\n");
	}else{
      out.write("\n");
      out.write("      <application-desc main-class=\"org.uengine.processdesigner.ProcessDesigner\">\n");
      out.write("      \t\t<argument>");
      out.print(loggedUserLocale);
      out.write("</argument> \n");
      out.write("\t\t    <argument>");
      out.print(folderId);
      out.write("</argument> \r\n");
      out.write("\t\t    <argument>");
      out.print(defId);
      out.write("</argument> \n");
      out.write("\t\t    <argument>");
      out.print(defVerId);
      out.write("</argument> \r\n");
      out.write("\t\t    <argument>");
      out.print(authorInfo);
      out.write("</argument> \n");
      out.write("\t\t    <argument>");
      out.print(superDefId);
      out.write("</argument>\r\n");
      out.write("\t  </application-desc> \n");
	}
      out.write("\n");
      out.write("\t  \n");
      out.write("</jnlp>");
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
