package org.apache.jsp.wih.formHandler.cachedForms;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.ui.taglibs.input.InputConstants;
import java.util.HashMap;
import java.util.Map;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;
import org.uengine.kernel.*;
import org.uengine.processmanager.*;

public final class _4_005fwrite_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/wih/formHandler/cachedForms/../../../common/commons.jsp");
    _jspx_dependants.add("/WEB-INF/tlds/taglibs_input.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005finput_005ftext_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005finput_005fselect_0026_005fviewMode_005foptionValues_005foptionLabels_005fname_005fmultiple_005fattributes_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005finput_005ftextarea_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005finput_005ftext_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005finput_005fselect_0026_005fviewMode_005foptionValues_005foptionLabels_005fname_005fmultiple_005fattributes_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005finput_005ftextarea_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005finput_005ftext_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.release();
    _005fjspx_005ftagPool_005finput_005fselect_0026_005fviewMode_005foptionValues_005foptionLabels_005fname_005fmultiple_005fattributes_005fnobody.release();
    _005fjspx_005ftagPool_005finput_005ftextarea_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.release();
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
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

response.setContentType("text/html; charset=UTF-8");
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

    boolean isCompleted =false;
    ProcessManagerRemote manager=null;
    ProcessInstance instance=null;
    RoleMapping loggedRoleMapping=null;
    FormActivity formActivity=null;
    try{
		formActivity = (FormActivity)request.getAttribute("formActivity");
		loggedRoleMapping = (RoleMapping)request.getAttribute("loggedRoleMapping");
		instance = (ProcessInstance)request.getAttribute("instance");
		manager = (ProcessManagerRemote)request.getAttribute("pm");
        isCompleted  ="Completed".equals( formActivity.getStatus(instance));
	}catch(Exception e){}

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("<p>\r\n");
      out.write("\tIssue Title : \r\n");

java.util.Hashtable fld_isu_title_5 = new java.util.Hashtable();
 fld_isu_title_5.put("size", "50");
 fld_isu_title_5.put("attrid", "TEMP_ATTR_ID"); 

      out.write('\r');
      out.write('\n');
      //  input:text
      org.uengine.ui.taglibs.input.Text _jspx_th_input_005ftext_005f0 = (org.uengine.ui.taglibs.input.Text) _005fjspx_005ftagPool_005finput_005ftext_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.get(org.uengine.ui.taglibs.input.Text.class);
      _jspx_th_input_005ftext_005f0.setPageContext(_jspx_page_context);
      _jspx_th_input_005ftext_005f0.setParent(null);
      // /wih/formHandler/cachedForms/4_write.jsp(11,0) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftext_005f0.setName("fld_isu_title");
      // /wih/formHandler/cachedForms/4_write.jsp(11,0) name = viewMode type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftext_005f0.setViewMode(0);
      // /wih/formHandler/cachedForms/4_write.jsp(11,0) name = attributes type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftext_005f0.setAttributes(fld_isu_title_5);
      // /wih/formHandler/cachedForms/4_write.jsp(11,0) name = default type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftext_005f0.setDefault("");
      int _jspx_eval_input_005ftext_005f0 = _jspx_th_input_005ftext_005f0.doStartTag();
      if (_jspx_th_input_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005finput_005ftext_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.reuse(_jspx_th_input_005ftext_005f0);
        return;
      }
      _005fjspx_005ftagPool_005finput_005ftext_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.reuse(_jspx_th_input_005ftext_005f0);
      out.write("</p>\r\n");
      out.write("<p>\r\n");
      out.write("\tIssue Class : \r\n");
      out.write(" ");
 
 java.util.Hashtable fld_isu_cls_0 = new java.util.Hashtable(); 
 java.util.List fld_isu_cls_1 = new java.util.Vector(); 
 java.util.List fld_isu_cls_2 = new java.util.Vector(); 
 fld_isu_cls_1.add("Software"); fld_isu_cls_2.add("sw"); 
 fld_isu_cls_1.add("Hardware"); fld_isu_cls_2.add("hw"); 
 fld_isu_cls_1.add("Etc"); fld_isu_cls_2.add("etc"); 
 fld_isu_cls_0.put("attrid", "TEMP_ATTR_ID"); 
 
      out.write(" \r\n");
      out.write(" ");
      //  input:select
      org.uengine.ui.taglibs.input.Select _jspx_th_input_005fselect_005f0 = (org.uengine.ui.taglibs.input.Select) _005fjspx_005ftagPool_005finput_005fselect_0026_005fviewMode_005foptionValues_005foptionLabels_005fname_005fmultiple_005fattributes_005fnobody.get(org.uengine.ui.taglibs.input.Select.class);
      _jspx_th_input_005fselect_005f0.setPageContext(_jspx_page_context);
      _jspx_th_input_005fselect_005f0.setParent(null);
      // /wih/formHandler/cachedForms/4_write.jsp(23,1) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005fselect_005f0.setName("fld_isu_cls");
      // /wih/formHandler/cachedForms/4_write.jsp(23,1) name = optionLabels type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005fselect_005f0.setOptionLabels(fld_isu_cls_1);
      // /wih/formHandler/cachedForms/4_write.jsp(23,1) name = optionValues type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005fselect_005f0.setOptionValues(fld_isu_cls_2);
      // /wih/formHandler/cachedForms/4_write.jsp(23,1) name = viewMode type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005fselect_005f0.setViewMode(0);
      // /wih/formHandler/cachedForms/4_write.jsp(23,1) name = attributes type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005fselect_005f0.setAttributes(fld_isu_cls_0);
      // /wih/formHandler/cachedForms/4_write.jsp(23,1) name = multiple type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005fselect_005f0.setMultiple(false);
      int _jspx_eval_input_005fselect_005f0 = _jspx_th_input_005fselect_005f0.doStartTag();
      if (_jspx_th_input_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005finput_005fselect_0026_005fviewMode_005foptionValues_005foptionLabels_005fname_005fmultiple_005fattributes_005fnobody.reuse(_jspx_th_input_005fselect_005f0);
        return;
      }
      _005fjspx_005ftagPool_005finput_005fselect_0026_005fviewMode_005foptionValues_005foptionLabels_005fname_005fmultiple_005fattributes_005fnobody.reuse(_jspx_th_input_005fselect_005f0);
      out.write(" </p>\r\n");
      out.write("<p>\r\n");
      out.write("\tIssue Note :\r\n");
      out.write(" ");
 
 java.util.Hashtable fld_isu_note_4 = new java.util.Hashtable(); 
 fld_isu_note_4.put("cols", "80"); 
 fld_isu_note_4.put("rows", "10"); 
 fld_isu_note_4.put("attrid", "TEMP_ATTR_ID"); 
 
      out.write(" \r\n");
      out.write(" ");
      //  input:textarea
      org.uengine.ui.taglibs.input.TextArea _jspx_th_input_005ftextarea_005f0 = (org.uengine.ui.taglibs.input.TextArea) _005fjspx_005ftagPool_005finput_005ftextarea_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.get(org.uengine.ui.taglibs.input.TextArea.class);
      _jspx_th_input_005ftextarea_005f0.setPageContext(_jspx_page_context);
      _jspx_th_input_005ftextarea_005f0.setParent(null);
      // /wih/formHandler/cachedForms/4_write.jsp(32,1) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftextarea_005f0.setName("fld_isu_note");
      // /wih/formHandler/cachedForms/4_write.jsp(32,1) name = viewMode type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftextarea_005f0.setViewMode(0);
      // /wih/formHandler/cachedForms/4_write.jsp(32,1) name = attributes type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftextarea_005f0.setAttributes(fld_isu_note_4);
      // /wih/formHandler/cachedForms/4_write.jsp(32,1) name = default type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_input_005ftextarea_005f0.setDefault("");
      int _jspx_eval_input_005ftextarea_005f0 = _jspx_th_input_005ftextarea_005f0.doStartTag();
      if (_jspx_th_input_005ftextarea_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005finput_005ftextarea_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.reuse(_jspx_th_input_005ftextarea_005f0);
        return;
      }
      _005fjspx_005ftagPool_005finput_005ftextarea_0026_005fviewMode_005fname_005fdefault_005fattributes_005fnobody.reuse(_jspx_th_input_005ftextarea_005f0);
      out.write("</p>\r\n");
      out.write("\n");
      out.write("<script language=\"javascript\"> \n");
      out.write("<!-- \n");
      out.write("function valid_check(){ \n");
      out.write("\n");
      out.write("\treturn true; \n");
      out.write("} \n");
      out.write("\n");
      out.write("//--> \n");
      out.write("</script> ");
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
