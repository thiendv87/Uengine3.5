<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.*,
				javax.sql.*,
				javax.naming.*,
				org.uengine.util.dao.DefaultConnectionFactory" %>
<%@include file="../wihDefaultTemplate/header.jsp"%>
<%
    response.setHeader("Cache-Control", "no-cache");
	String instanceId	= request.getParameter("instanceId");
	String tracingTag	= request.getParameter("tracingTag");
	String approveType	= request.getParameter("approveType");
%>
<html>
<head>
<title>결재처리</title>
<script language="JavaScript">
	var opener = window.dialogArguments;
	function keyDown(){
		if(event.keyCode == 13) {
			submitOk();			
		}
	}	

	function submitOk(approvalType) {
	alert("결재");
		var confirmForm = document.confirmForm;
/*		for(var i=0; i< confirmForm.approveType.length; i++) {
			if ( confirmForm.approveType[i].checked ) {
				approvalType = confirmForm.approveType[i].value;
				break;
			}
		}
		if ( approvalType == "" ) {
			alert("결재형태를 선택하세요");
			return ;		
		}
*/
		passwd = confirmForm.passwd.value;
			
		if( passwd == "" ) {
			alert("패스워드를 입력하세요");
			confirmForm.passwd.focus();
			return;
		}else{
//			if(confirmForm.emppswd.value != passwd){
//				alert("패스워드가 일치하지 않습니다.");
//				confirmForm.passwd.focus();
//				return ;		
//			}
		}
		
		comment = confirmForm.comment.value;
		var commentLength = comment.length;
		
		if (commentLength == 0 && approvalType != "approve") {
			alert("의견을 입력하세요");
			confirmForm.comment.focus();
			return;
		}

		if ( commentLength > 500 ) {
			alert("문자가 500자를 초과하였습니다. 500자 이하로 입력하세요");
			return;
		}
		try{parent.opener.startWaitMsg();}catch(err){}
		parent.opener.document.forms[0].apprStat.value=approvalType;
		parent.opener.document.forms[0].action = "submit.jsp?comment="+encodeURIComponent(comment);
		parent.opener.document.forms[0].target="_self";
		parent.opener.document.forms[0].submit();
		window.close();
	}
</script>
</head>

<body  bgcolor="#F7F7F7">
<iframe id="hiddenframe" name="hiddenframe" width="0" height="0">
</iframe>

<form name="confirmForm" method="post">
<input type=hidden name=resultValue value="false">
<input type=hidden name=approvalType>
<%
//	String NETLOGINID = loggedUserId;
	
//	Connection 	    conn		= null;
//	Statement 		stmt 		= null;
//	ResultSet 		rs 			= null;
//	String		 	sql 		= "";
//	int 			rows 		= 0;
	
	//사원번호에 해당하는 패스워드 들고오기 
//	try
//	{
//		conn	= DefaultConnectionFactory.create().getConnection();
//		stmt	= conn.createStatement();
//		sql		= " select PASSWORD from TBL_SECCNTL_USERAUTH where NETLOGINID = '" + NETLOGINID + "' union select passwd from IS사원 where id = '" + NETLOGINID + "'";
//		rs		= stmt.executeQuery(sql);

//		if (rs.next()){
            out.println("<input type=hidden name=emppswd value=1111 >");
//		}
//		rs.close();
//	}finally{
//		if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
//		if ( conn != null ) try { conn.close(); } catch (Exception e) {}
//	}
%>
	<input type="hidden" name="instanceId" value="<%=instanceId %>">
	<input type="hidden" name="tracingTag" value="<%=tracingTag %>">
	
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_upperline"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="bgcolor_head" align=center> 결재처리   </td>
  </tr>
  <tr>
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>

            <table width="100%" border="1" cellspacing="0" cellpadding="0">
           	  <!-- 
              <tr>
                <td class="bgcolor_head" nowrap>제목</td>
                <td class="td_left">
                  <input type="text" name="title" value="ddfdfd" class="input" align="middle" style="width:250px;">
                </td>
              </tr>
              -->
              <tr>
                <td class="td_line" colspan="2"></td>
              </tr>
              <tr>
                <td class="bgcolor_head" nowrap class="td_left">결재형태</td>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="td_left">
                    <% if ("preConfirm".equals(approveType)){ %>
                        <input type="radio" name="approveType" value="arbitraryApprove" checked>전결
                        <input type="radio" name="approveType" value="approve">승인
                    <% }else{ %>
                        <input type="radio" name="approveType" value="approve" checked>승인
                    <% } %>
                    	<input type="radio" name="approveType" value="reject">부결
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="td_line" colspan="2"></td>
              </tr>
              <tr>
                <td class="bgcolor_head" nowrap>비밀번호</td>
                <td class="td_left">
                <input type="password" name="passwd" id="passwd" value="<%=(String)session.getAttribute("loggedUserPass")%>" style="width:27%" class="input" onKeyDown="keyDown();">
                	&spades;비밀번호는 로그인 비밀번호와 동일함
                </td>
              </tr>
              <tr>
                <td class="td_line" colspan="2"></td>
              </tr>
              <tr>
                <td class="bgcolor_head" nowrap>의견</td>
                <td class="td_left">
                <textarea name="comment" rows="15" style="width:100%;"></textarea>
				<p style="margin-top:5px"><font class="lnk_name">&spades;결재의견은 최대 한글(공백포함) 500자까지 가능합니다.
                </td>
              </tr>
      
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="list_btn_line_e"></td>
              </tr>
              <tr>
                <td class="list_line_light"></td>
              </tr>
            </table>
  
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_p_btn"></td>
        </tr>
      </table>
      <table border="0" cellspacing="0" cellpadding="0" align="center" class="btn_space">
        <tr>
          <td>
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
				<td><div id="gBtn21"><a href="javascript:submitOk('approve')"><span>승인</span></a></div></td>
              </tr>
            </table>
          </td>
          <td>&nbsp;</td>
          <td>
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
				<td><div id="gBtn21"><a href="javascript:submitOk('reject')"><span>반려</span></a></div></td>
              </tr>
            </table>
          </td>
          <td>&nbsp;</td>
          <td>
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><div id="gBtn21"><a href="javascript:window.close()"><span>취소</span></a></div></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</form>
</body>
</html>
