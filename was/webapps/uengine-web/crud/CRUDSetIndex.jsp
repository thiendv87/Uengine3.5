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

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<LINK rel="stylesheet" href="../style/portlet.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/portal.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/groupware.css" type="text/css"/>

<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bbs.css">
<script language="JavaScript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/bbs.js"></script>
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>


<form name=databaseRef action="CRUDGenerate.jsp">
<%
    String parentFolderID = request.getParameter("folderId");
%>
<html>
<head>
<script>
	function tableChange(selector){
		location="CRUDSetIndex.jsp?tableSelectedIndex=" + selector.selectedIndex+"&folderId="+<%=parentFolderID%>;
	}
</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="5" topmargin="0" marginwidth="0" marginheight="0" >
<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28" valign="bottom">
			<p><img src="../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
			
			<b>New CRUD Application</b>
		</td>
	</tr>
	<tr>
		<td height="1" class="path_underline"></td>
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
			&nbsp;<b>TableName</b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<select name=tableNameList size=1 onchange="tableChange(this)"> 
<%
String selectedTable = request.getParameter("tableSelectedIndex");
int indexOfSelectedTable = -1;

if(selectedTable!=null)	indexOfSelectedTable = Integer.parseInt(selectedTable);

if(indexOfSelectedTable == -1) indexOfSelectedTable=0;

List parameterList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getDatabaseDirectory();
for(int i=0 ; i < parameterList.size() ; i+=2){	
	
	String tableName = (String)parameterList.get(i);

%>
				<option value=<%=tableName %> <%=(indexOfSelectedTable*2)==i ? " selected":""%>><%= tableName %></option>
<%      
}
%>
			</select>		
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>				
	<tr height="30" >
		<td width="150" align=left bgcolor="f4f4f4">
			&nbsp;<b>Description</b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<input name=description size=80>
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20" >
		<td width="150" align=left bgcolor="f4f4f4">
			&nbsp;<b>Table Definition</b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>

<%
	String tableSelectName =(String)parameterList.get(indexOfSelectedTable*2);
%>
		<table width=100%>
			<td class="bgcolor_head_underline">
			<table border=0 cellspacing=1 cellpadding=1 width=100%>
				<tr >
					<td bgcolor=f4f4f4 align=center> FieldName </td>
					<td bgcolor=f4f4f4 align=center> DisplayName </td>
					<td bgcolor=f4f4f4 align=center> PK </td>
				</tr>		
<%
List fieldList = (List)parameterList.get(indexOfSelectedTable*2+1);
for(int i=0 ; i < fieldList.size() ; i++){	
	String fieldName = (String)fieldList.get(i);
%>
				<tr><td bgcolor=white><input type=hidden name=columnName_<%=i%> value=<%=fieldName%>> <%=fieldName%></td>
					<td bgcolor=white width=50><input type=text name=displayName_<%=i%> value=<%=fieldName%> size=50></td>
					<td bgcolor=white align=center><input type=checkbox name=pk_<%=i%> onClick="checkPK(this)" ></td>
				</tr>
<%    
}
%>
			</table>
			</td>
			</table>
		</td>		
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>		
			

	
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="10"></td>
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

<input type=hidden name=selectedTableName value=<%=tableSelectName%>>
<input type=hidden name=columnCount value=<%=fieldList.size()%>>
<input type=hidden name=parentFolderID value=<%=parentFolderID%>>
<input type=submit value="Generate">
</form>
