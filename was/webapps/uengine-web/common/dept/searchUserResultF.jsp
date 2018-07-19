<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="_rdm" type="com.woorifis.srms.core.result.ResultDataManager" scope="request"/>
<jsp:useBean id="_sm" type="com.woorifis.srms.util.SessionManager" scope="request" /> 
<%@page import="com.woorifis.srms.common.bean.UserBean"%>
<%@page import="java.util.List"%>
<%@page import="com.woorifis.srms.util.StringUtil"%>
<%@page import="com.woorifis.srms.util.EncodeUtil"%>
<%@page import="com.woorifis.srms.util.DateUtil"%>
<%
List<UserBean> list = (List<UserBean>) _rdm.getData("list");
String aa = request.getParameter("searchWord");
StringUtil su = new StringUtil();
%>   
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/style/formdefault.css" />
<link rel="stylesheet" href="/style/_expando.css" />
<link rel="stylesheet" href="/style/popup.css" />
<title>Insert title here</title>
<script type="text/javascript">
</script>

</head>

<body style="overflow:auto; margin: 0 0 0 0;">
 <table  cellspacing="0" cellpadding="0" width="100%" align="center" border="0" >
     <tr>
         <td class="tbllisttitle" align="center" height="24" width="26">선택</td>
         <td class="tbllistbg"></td>
         <td class="tbllisttitle" align="center" width="40">성명</td>
         <td class="tbllistbg"></td>      
         <td class="tbllisttitle" align="center" width="95">직위</td>
         <td class="tbllistbg"></td>
         <td align="center" class="tbllisttitle" width="95">부서명</td>
         <td class="tbllistbg"></td>
         <td align="center" class="tbllisttitle" width="95">회사명</td>
     </tr>
 	 <tr>
          <td colspan="11" class=" tblline"></td>
      </tr>
      <tr>
          <td colspan="11" height="2" bgcolor="#eaeaea"></td>
      </tr>
</table>
<table  cellspacing="0" cellpadding="0" width="100%" align="center" border="0" id="tbapprovalUser">
<%
	int i=0;
	String color="bgcolor=\"#F5F5F5\"";
	String deptLv1Nm="";
	String deptLv1Cd="";
	if(list.size() > 0){
	for(UserBean data : list){
		
		String [] splits = su.nvl(data.getDeptLv1()).split("\\^");
		if(splits.length > 1){
			deptLv1Cd = splits[0];
			deptLv1Nm = splits[1];
		}
		
%>                        
     <tr <%= (i%2==0) ? color : "" %> onMouseOver="tbapprovalUser.clickedRowIndex=this.rowIndex" name="urowId" id="urowId">
         <td class="tbllistcon" align="center" height="24" width="26"><input type="checkbox" name="checkbox" id="checkbox"></td>
         <td></td>
         		<input type="hidden" name="Y_EMPNO" value="<%= data.getUser_id() %>">
         		<input type="hidden" name="USER_NAME" value="<%= data.getUser_nm() %>">
         		<input type="hidden" name="POSTION" value="<%= data.getPosi_nm() %>">
         		<input type="hidden" name="POSTION_CD" value="<%= data.getPosi_cd() %>">
         		<input type="hidden" name="DEPT" value="<%= data.getDept_nm() %>">
         		<input type="hidden" name="GRP_CD" value="">
         		<input type="hidden" name="DEPT_CD" value="<%= data.getDept_cd() %>">
         		<input type="hidden" name="DEPTLV1_CD" value="<%= deptLv1Cd %>">
         		<input type="hidden" name="DEPTLV1_NM" value="<%= deptLv1Nm %>">
         		<input type="hidden" name="TEL_NO" value="<%= data.getTel_no() %>">
         		<input type="hidden" name="EMAIL" value="<%=data.getEmail() %>">
         <td class="tbllistcon" align="center" width="42"><%= data.getUser_nm() %></td>
         <td></td>
         <td class="tbllistcon" align="left" width="95">
         <%if (data.getPosi_nm().length() > 7){  %>
	        <%= data.getPosi_nm().substring(0,7) %><br><%= data.getPosi_nm().substring(7) %>
         <%}else{ %>
		     <%= data.getPosi_nm()%>
         <%} %>
         </td>
		 <td></td>
         <td class="tbllistcon" align="left" width="95">
         <%if (data.getDept_nm().length() > 7){  %>
	        <%= data.getDept_nm().substring(0,7) %><br><%= data.getDept_nm().substring(7) %>
         <%}else{ %>
		     <%= data.getDept_nm()%>
         <%} %>
         </td>
		 <td></td>
         <td class="tbllistcon" align="left" width="95">
         <%if (deptLv1Nm.length() > 7){  %>
	        <%= deptLv1Nm.substring(0,7) %><br><%= deptLv1Nm.substring(7) %>
         <%}else{ %>
		     <%=deptLv1Nm%>
         <%} %>
         </td>
     </tr>
<%i++;}
	}else{
		if(aa!=null&&!aa.equals("AA")){	
%>
	
	<br><br>
	<tr><td align="center" class="tbllistcon"><b>검색 결과가 없습니다.</b></td></tr>  
<%	
		}
	} 
%>
 </table>
 
</body>
</html>