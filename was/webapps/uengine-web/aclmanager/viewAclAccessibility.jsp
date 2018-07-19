<%@ page pageEncoding="UTF-8" %>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@page import="java.util.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.persistence.processinstance.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	 DataMap reqMap = HttpUtils.getDataMap(request, true);
	 QueryCondition condition = new QueryCondition();
	 DataList dl = null;
	 int intPageCnt = 10;
	 int nPagesetSize = 10;
     int totalCount = 0;
	 int totalPageCount = 0;

	 String definitionId=reqMap.getString("definitionId", "");
	 int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	 String strTarget = reqMap.getString("TARGETCOND", "procins.instancename");
	 String strKeyword = reqMap.getString("KEYWORDCOND", "");
	 String strDateKeyStart=reqMap.getString("INIT_START_DATE", "");
	 String strDateKeyEnd=reqMap.getString("INIT_END_DATE", "");
	 String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
	 String strDefTypeId = reqMap.getString("DEFTYPEID", "");
	 String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	 String strSortCond = reqMap.getString("SORT_COND", "");
	 String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");
	 condition.setMap(reqMap);
	 condition.setOnePageCount(intPageCnt);
	 condition.setPageNo(currentPage);

%>
<form name="form">
<html>
	<head>
  <link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bbs.css">
	 <script language="JavaScript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/bbs.js"></script>
	 <LINK href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/uengine.css" type=text/css rel=stylesheet>
	 <LINK rel="stylesheet" href="../style/portlet.css" type="text/css"/>	
	 <LINK rel="stylesheet" href="../style/portal.css" type="text/css"/>	
	 <LINK rel="stylesheet" href="../style/groupware.css" type="text/css"/>
	</head>
<body>
	<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/icon_root.gif" align="middle" width="10" height="11" border="0">
	<b>Accessibility</b>
	<table width=100% border=0 cellspacing=0 cellpadding=0>
  <tr height=1>
   <td align=center colspan=3 height=1 bgcolor=#dddddd></td>
	 </tr>
 </table>
 <table width=100%>
 	<tr>
 		<td align=right>
 <input type=button name=List_Add value=ADD onclick="addColumn()" >&nbsp;
 <input type=button name=List_Update value=UPDATE onclick="modifyColumn(this)" >&nbsp;
 <input type=button name=List_Delete value=DELETE onclick="modifyColumn(this)" >
 		</td>
 	</tr>
 </table>

 
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="10"></td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_upperline"></td>
	</tr>
	<tr height="5">
		<td align="center" height="5" class="bgcolor_head"></td>
	</tr>
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
	
	<tr height="30" >
		<td width="150" align=left bgcolor="f4f4f4">
			&nbsp;<b>Definition Name</b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemoteByDefinitionId(definitionId);
	String pdName =pdr.getName().getText();

%>
		<%=pdName%>
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>				

	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
</table>
 
 <p>
 <table width=100%>
  <tr>
   <td bgcolor=#B6CBEB>
    <table border=0 cellspacing=1 cellpadding=4 width=100%>
     <tr>
      <td><center>column</td>
      <td><center>ACCESSIBILITY</td>
      <td><center>GROUP</td>
      <td><center>ROLE</td>
      <td><center>USER</td>
     </tr>
<%
  String sql="select * from bpm_ex_acl where defid="+definitionId;
  String[] columnName={"ACCESSIBILITY","GROUPID","ROLEID","USERID"};
   
  java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
  try{
      dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
      totalCount = (int)dl.getTotalCount();
      totalPageCount = dl.getTotalPageNo();
  }catch(Exception e){
      throw e;
  }finally{
      if( con != null ){con.close();}
  }
  String style="bg";
  boolean isGray = false;
  String bgcolor;
  if(totalCount > 0){
    for( int i=0; i<dl.size(); i++ ){
     bgcolor = (isGray ? "#e9e9e9":"white");
     isGray = !isGray;
%>
    <tr>
     <td bgcolor=<%=bgcolor%> width=20><input type="checkbox" name="List_CheckBox"></td>
<%
     DataMap tmpMap = (DataMap)dl.get(i);
     for(int j=0 ; j < columnName.length ; j++){
      Object fieldValue = tmpMap.getString(columnName[j],"");
      String inputName = "field_"+columnName[j]+"_"+i;
      
      String displayFieldValue="";
      if(!"".equals((String)fieldValue)){
      	if("USERID".equals(columnName[j])){
			com.liferay.portal.model.User user = UserLocalServiceUtil.getUserById(loggedUser.getCompanyId(),Long.parseLong((String)fieldValue));
			displayFieldValue = user.getFullName();
		}else if("ROLEID".equals(columnName[j])){
			com.liferay.portal.model.Role role = RoleLocalServiceUtil.getRole(Long.parseLong((String)fieldValue));
			displayFieldValue =role.getName();
		}else if("GROUPID".equals(columnName[j])){
			com.liferay.portal.model.UserGroup userGroup = UserGroupLocalServiceUtil.getUserGroup(Long.parseLong((String)fieldValue));
			displayFieldValue =userGroup.getName();
		}else if("ACCESSIBILITY".equals(columnName[j])){
			if("v".equals((String)fieldValue)) displayFieldValue="View";
			else if("r".equals((String)fieldValue)) displayFieldValue="Running";
			else if("e".equals((String)fieldValue)) displayFieldValue="Edit";
		}
	 }
	 
%>
 	<td bgcolor=<%=bgcolor%> width=200 align=center><%=displayFieldValue%><input type="hidden" name="<%=inputName%>" value="<%=fieldValue%>"></td>
<%
 	}
%>
    </tr>
<%
	   }
	}
%>
   </table>
  </td>
 </tr>
 <tr>
  <td align=center>
<%
	if(totalCount>0){
%>
	<br style="line-height:15px;">
	<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" />
	<br>
<%
	}
%>
  </td>
 </tr>
</table>

<script>

function addColumn(){
	url = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/aclmanager/addAclAccessibility.jsp?definitionId=<%=definitionId%>";
	window.open(url,'AddList','width=400,height=300,resizable=yes,scrollbars=yes');
}


function modifyColumn(obj){
   
	var fieldName="";
	var isSelect=false;
	if(document.form.List_CheckBox.length==undefined){
		if(document.form.List_CheckBox.checked==true){
			i=0;
		    
			var DEFID = <%=definitionId%>;
		    fieldName="field_ACCESSIBILITY_"+i;
			var ACCESSIBILITY = document.form.all[fieldName].value;
		    fieldName="field_GROUPID_"+i;
			var GROUPID = document.form.all[fieldName].value;
		    fieldName="field_ROLEID_"+i;
			var ROLEID = document.form.all[fieldName].value;
		    fieldName="field_USERID_"+i;
			var USERID = document.form.all[fieldName].value;
	        
	        isSelect=true;
		}
	}else{
		for(i=0;i<document.form.List_CheckBox.length;i++){
			if(document.form.List_CheckBox[i].checked==true){
			    var DEFID = <%=definitionId%>;
			    fieldName="field_ACCESSIBILITY_"+i;
				var ACCESSIBILITY = document.form.all[fieldName].value;
			    fieldName="field_GROUPID_"+i;
				var GROUPID = document.form.all[fieldName].value;
			    fieldName="field_ROLEID_"+i;
				var ROLEID = document.form.all[fieldName].value;
			    fieldName="field_USERID_"+i;
				var USERID = document.form.all[fieldName].value;
		        isSelect=true;
			}
		}
	}
	if(isSelect==true){
		if(obj.value=="UPDATE"){
			url = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/aclmanager/updateAclAccessibility.jsp?DEFID="+DEFID+"&ACCESSIBILITY="+ACCESSIBILITY+"&GROUPID="+GROUPID+"&ROLEID="+ROLEID+"&USERID="+USERID;
			window.open(url,'UpdateList','width=400,height=300,resizable=yes,scrollbars=yes');
		}
		else{
			url = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/aclmanager/deleteAclAccessibility.jsp?DEFID="+DEFID+"&ACCESSIBILITY="+ACCESSIBILITY+"&GROUPID="+GROUPID+"&ROLEID="+ROLEID+"&USERID="+USERID;
			window.open(url,'DeleteList','width=400,height=300,resizable=yes,scrollbars=yes');
		}
	}
}

</script>

</form>
<form name="listForm" method="POST" action="?" onactivate="setListForm(this);">
	<input type="hidden" name="currentPage" value="<%=currentPage%>">
 <input type="hidden" name="sort_column" value="<%=strSortColumn%>">
	<input type="hidden" name="sort_cond" value="<%=strSortCond%>">
	<input type="hidden" name="listURL" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/processInstanceListDetail.jsp">
	<input type="hidden" name="TARGETCOND" value="<%=strTarget%>">
</form>
</body>
</html>
