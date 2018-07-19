package org.apache.jsp.processmanager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.util.XMLUtil;
import org.uengine.util.UEngineUtil;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import org.uengine.kernel.*;
import java.util.*;
import java.io.*;
import org.uengine.processmanager.*;

public final class processDefinitionListXML_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {



	void printTree(Hashtable childs, Hashtable versions, String parent, PrintWriter pw, boolean omitVersion, boolean folderSelectable, boolean giveResourceURLAsValue, String objectType){
		try{	
			if(childs.containsKey(parent)){
				Vector childprocesses = (Vector)childs.get(parent);
				for(Iterator iter = childprocesses.iterator(); iter.hasNext(); ){
				
					String definitionId = (String)iter.next();	//first is definitionId
					ProcessDefinitionRemote process = (ProcessDefinitionRemote)iter.next(); //second is the object
					
					//filter with object types.
					if(!process.isFolder() && UEngineUtil.isNotEmpty(objectType) && !objectType.equals(process.getObjType())) continue;
					
					if(process.isFolder()){
						pw.print("<folder name='" + XMLUtil.encodeXMLReservedWords(process.getName().getText()) + "'");
						if(folderSelectable)
							pw.print(" value='folder=" + definitionId + "'");							
						pw.print(">");
						
						printTree(childs, versions, definitionId, pw, omitVersion, folderSelectable, giveResourceURLAsValue, objectType);
						pw.print("</folder>");
					}else{
						
						Vector versions_ = (Vector)versions.get(definitionId);
						
						pw.print("<definition name='" + XMLUtil.encodeXMLReservedWords(process.getName().getText()) + "'");
						if(omitVersion){
							pw.print(" value='");
														
							if(folderSelectable)
								pw.print("processdefinition=");
							
							if(process.getAlias()!=null) pw.print("[" + process.getAlias() + "]");
							else pw.print(definitionId);
							
							pw.print("'");
						}
						pw.print(">");
						
						if(!omitVersion)
						for(Iterator iter2 = versions_.iterator(); iter2.hasNext(); ){
							ProcessDefinitionRemote version = (ProcessDefinitionRemote)iter2.next();
							String pd = version.getId();
							int versionValue = version.getVersion();
							
							pw.print("<version name='"+ XMLUtil.encodeXMLReservedWords(process.getName().getText()) +" v");
							pw.print(versionValue);
							if(version.isProduction())
								pw.print("(production)");
							
							if(giveResourceURLAsValue)
								pw.print("' value='/html/uengine-web/processmanager/showDefinitionInLanguage.jsp?language=Bean&amp;isProcMgr=true&amp;versionId="+ pd +"'/>");
							else{
								if(process.getAlias()!=null) 
									pw.print("' value='["+ process.getAlias() + "]@" + pd +"'/>");
								else
									pw.print("' value='"+ definitionId + "@" + pd +"'/>");
							}
								
						}
						
						pw.print("</definition>");
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

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
      response.setContentType("text/html;charset=KSC5601");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");

response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

      org.uengine.processmanager.ProcessManagerFactoryBean processManagerFactory = null;
      synchronized (application) {
        processManagerFactory = (org.uengine.processmanager.ProcessManagerFactoryBean) _jspx_page_context.getAttribute("processManagerFactory", PageContext.APPLICATION_SCOPE);
        if (processManagerFactory == null){
          processManagerFactory = new org.uengine.processmanager.ProcessManagerFactoryBean();
          _jspx_page_context.setAttribute("processManagerFactory", processManagerFactory, PageContext.APPLICATION_SCOPE);
        }
      }


	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();
	ProcessDefinitionRemote[] pds = null;
	try{
		pds = pm.listProcessDefinitionRemotesLight();
	}finally{
		pm.remove();
	}
	
	Hashtable childs = new Hashtable();	
	Hashtable versions = new Hashtable();
	
	for(int i=0; i<pds.length; i++){
		ProcessDefinitionRemote definitionRemote = pds[i];
		String definitionId = definitionRemote.getId();
		String parent = definitionRemote.getParentFolder();
		
		//indexing the names for searching versions
		String definitionGroupId = definitionRemote.getBelongingDefinitionId();
		if(definitionGroupId==null)
			definitionGroupId = definitionRemote.getId();
		
		if(!versions.containsKey(definitionGroupId)){
			versions.put(definitionGroupId, new Vector());
		}
		
		Vector v = (Vector)(versions.get(definitionGroupId));
		v.add(definitionRemote);
		//

		//indexing the names for making tree
		if(!childs.containsKey(parent)){
			childs.put(parent, new Vector());
		}
		
		v = (Vector)(childs.get(parent));
		if(!v.contains(definitionGroupId)){
			v.add(definitionGroupId);
			v.add(definitionRemote);
		}
		//

	}

	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	spw.print("<folder name='Process Definitions'>");
	
	String omitVersionString = request.getParameter("omitVersion");
	String objectType = request.getParameter("objectType");
	boolean omitVersion = (omitVersionString!=null && omitVersionString.equals("true"));
	String folderSelectableString = request.getParameter("folderSelectable");
	boolean folderSelectable = (folderSelectableString!=null && folderSelectableString.equals("true"));
	boolean giveResourceURLAsValue = ("true".equals(request.getParameter("giveResourceURLAsValue")));
	
	printTree(childs, versions, "-1", spw, omitVersion, folderSelectable, giveResourceURLAsValue, objectType);
	spw.print("</folder>");

      out.print(sw.toString());
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
