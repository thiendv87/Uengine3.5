package org.apache.jsp.processparticipant.worklist;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.uengine.util.UEngineUtil;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import org.uengine.util.dao.DefaultConnectionFactory;

public final class wl2_005fworkList_005fnotification_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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

	String  loggedUserId       		= (String) session.getAttribute("loggedUserId");
	
	StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ");
		sql.append(" 	INSTLIST.INSTID, ");
		sql.append(" 	WORKLIST.TASKID, ");
		sql.append(" 	WORKLIST.TRCTAG, ");
		sql.append(" 	INSTLIST.NAME, ");
		sql.append(" 	WORKLIST.TITLE "); 
		sql.append(" FROM BPM_WORKLIST WORKLIST LEFT JOIN BPM_PROCINST INSTLIST ON WORKLIST.INSTID = INSTLIST.INSTID ");
		sql.append(" 	, (SELECT MAX(TASKID) ID FROM BPM_WORKLIST WORKLIST WHERE ENDPOINT = ? AND STATUS = ? ) MAXTASK ");
		sql.append(" WHERE ");
		sql.append(" 	INSTLIST.ISDELETED = 0 ");
		sql.append(" 	AND ");
		sql.append(" 	WORKLIST.TASKID = MAXTASK.ID ");
		sql.append(" ORDER BY TASKID DESC ");

		/*******************************
		SELECT WORKLIST.TITLE, WORKLIST.TASKID, WORKLIST.TRCTAG, INSTLIST.NAME, INSTLIST.INSTID
			FROM BPM_WORKLIST WORKLIST LEFT JOIN BPM_PROCINST INSTLIST ON WORKLIST.INSTID = INSTLIST.INSTID AND INSTLIST.ISDELETED = 0
			, (SELECT MAX(TASKID) ID FROM BPM_WORKLIST WORKLIST WHERE ENDPOINT = 'KBS' AND STATUS = 'NEW') MAXTASK
		WHERE 
			WORKLIST.TASKID=MAXTASK.ID
		ORDER BY TASKID DESC
		********************************/
	StringBuilder json = new StringBuilder();
		
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		conn = DefaultConnectionFactory.create().getConnection();
		
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1,loggedUserId);
		pstmt.setString(2,"NEW");
				
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			json.append("{'RESULT':'TRUE'");
			json.append(",'INSTID':'").append(rs.getString("INSTID")).append("'");
			json.append(",'TASKID':'").append(rs.getString("TASKID")).append("'");
			json.append(",'TRCTAG':'").append(rs.getString("TRCTAG")).append("'");
			json.append(",'NAME':'").append(rs.getString("NAME")).append("'");
			json.append(",'TITLE':'").append(rs.getString("TITLE")).append("'");
			json.append("}");
		}else{
			json.append("{'RESULT':'FALSE'}");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs!=null){
			try{rs.close();}catch(Exception e){}
		}
		if(pstmt!=null)
		{
			try{pstmt.close();}catch(Exception e){}
		}
		if(conn!=null)
		{
			try{conn.close();}catch(Exception e){}	
		}
	}

      out.print(json);
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
