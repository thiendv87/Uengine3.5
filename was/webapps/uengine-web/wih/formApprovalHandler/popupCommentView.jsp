<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.*,
				javax.sql.*,
				javax.naming.*,
				org.uengine.util.dao.DefaultConnectionFactory" %>

<%@include file="../wihDefaultTemplate/header.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>결재의견</title>

</head>

<body bgcolor="#F7F7F7">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="bgcolor_head" align=center> 결재의견    </td>
  </tr>
  <tr> 
    <td > 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height=160 class="popup_box"> 
		  <div style="overflow-y:scroll; height:160;">           

            <table width="100%" border="1" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="20" nowrap></td>
                <td width="100" nowrap>성명/직위</td>
                <td width="110" nowrap>일자</td>
                <td width="400" nowrap >의견</td>
                <td width="80" nowrap >결재형태</td>
              </tr>
<%
    response.setHeader("Cache-Control", "no-cache");

	Connection 	    conn		= null;
	Statement 		stmt 		= null;
	ResultSet 		rs 			= null;
	StringBuffer 	sql 		= new StringBuffer();
	int 			rows 		= 0;
	
	String instanceId   =  request.getParameter("instanceId");
	
//	System.out.println(instanceId);
	
	String ID			= "";
	String INSTANCE_ID	= "";
	String CONTENTS		= "";
	String CONTENT_S	= "";
	String OPT_TYPE		= "";
	String EMPNO		= "";
	String EMPNAME		= "";
	String EMPTITLE		= "";
	String TRACINGTAG	= "";
	String CREATED_DATE	= "";
	String CREATED_BY	= "";
	String UPDATED_DATE	= "";
	String UPDATED_BY	= "";
	
	//인스턴스 ID에 해당하는 커멘트 들고오기 
	try
	{
		conn = DefaultConnectionFactory.create().getConnection();
	
		stmt = conn.createStatement();
	
		sql.append(" select ID, INSTANCE_ID, CONTENTS, OPT_TYPE, EMPNO,EMPNAME,	");
		sql.append(" EMPTITLE,TRACINGTAG,TO_CHAR(CREATED_DATE, 'YYYY-MM-DD'),	");
		sql.append(" CREATED_BY,TO_CHAR(UPDATED_DATE, 'YYYY-MM-DD'),UPDATED_BY	");
		sql.append(" from   doc_comments										");
		sql.append(" where  instance_id = '" + instanceId +					  "'");
	
		rs = stmt.executeQuery(sql.toString());

		while (rs.next()){
//			ID 				= rs.getString(1);
//			INSTANCE_ID		= rs.getString(2);
			CONTENTS		= rs.getString(3);
			if("".equals(CONTENTS) || CONTENTS==null){
				CONTENTS = "-";
			}else{
				if(CONTENTS.length() > 30){
					CONTENT_S = CONTENTS.substring(0, 29) + "...";
				}else{
					CONTENT_S = CONTENTS;
				}
			}
			OPT_TYPE		= rs.getString(4);
			if("".equals(OPT_TYPE) || OPT_TYPE==null)			OPT_TYPE = "-";
//			EMPNO			= rs.getString(5);
			EMPNAME			= rs.getString(6);
			if("".equals(EMPNAME) || EMPNAME==null)				EMPNAME = "-";
			EMPTITLE		= rs.getString(7);
			if("".equals(EMPTITLE) || EMPTITLE==null)			EMPTITLE = "-";
//			TRACINGTAG		= rs.getString(8);
			CREATED_DATE	= rs.getString(9);
			if("".equals(CREATED_DATE) || CREATED_DATE==null)	CREATED_DATE = "-";
//			CREATED_BY		= rs.getString(10);
//			UPDATED_DATE	= rs.getString(11);
//			UPDATED_BY		= rs.getString(12);
            
            out.println("<tr>																		"); 
            out.println("  <td colspan=4 class=list_tit_line_e></td>								"); 
            out.println("</tr>																		"); 
            out.println("<tr> 																		"); 
            out.println("   <td></td>												");
            out.println("   <td>" + EMPNAME + "/" + EMPTITLE + "</td>				"); 
            out.println("   <td>" + CREATED_DATE + "</td>							"); 
            out.println("   <td title='" + CONTENTS + "'>" + CONTENT_S + "</td>		");
            //out.println("   <td title=" + CONTENTS + ">" + CONTENT_S + "</td>		");
            out.println("   <td>" + OPT_TYPE + "</td>								");
            out.println("</tr>																		");
		}
		rs.close();
	}finally{
		if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
		if ( conn != null ) try { conn.close(); } catch (Exception e) {}
	}
%>  
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="list_tit_line_1px"></td>
              </tr>
            </table>
		  </div>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_p_btn"></td>
        </tr>
      </table>
      <table border="0" cellspacing="1" cellpadding="0" align="center">
        <tr> 
          <td><input type=button value="닫기" onclick="window.close();"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
