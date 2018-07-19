<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<LINK rel="stylesheet" href="../style/portlet.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/portal.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/groupware.css" type="text/css"/>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="org.uengine.processmanager.*"%>
<%@ page import="org.uengine.kernel.*"%>
<%@ page import="org.uengine.util.UEngineUtil"%>
<%@ page import="java.io.*"%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="basic.css" rel="stylesheet" type="text/css">

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String pd = request.getParameter("objectDefinitionId");
	String pdVer = request.getParameter("processDefinitionVersionID");
	String folder = request.getParameter("folder");

	/***********************************************************************/
	/*                            Get version list                         */
	/***********************************************************************/

	ProcessDefinitionRemote[] arrPdr = null;
	
	try{
		arrPdr = pm.findAllVersions(pd);
		pm.applyChanges();
	}catch(Exception e){
		pm.cancelChanges();
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		throw e;
	}
	
	int maxVersion = -1;
	if(arrPdr != null){
		String versionID = null;
		int version = -1;
		for(int i=0; i<arrPdr.length; i++){
			versionID = arrPdr[i].getId();
			version = arrPdr[i].getVersion();
			//out.println("versionID=["+versionID+"]");
			//out.println("version=["+version+"]");
			//out.println("isProduction=["+arrPdr[i].isProduction()+"]");
			if(arrPdr[i].isProduction()){
				if( pdVer == null || "".equals(pdVer) || "null".equals(pdVer)){
					pdVer = versionID;
				}
			}
		}
		if( pdVer == null || "".equals(pdVer) || "null".equals(pdVer)){
			pdVer = versionID;
		}
		maxVersion = version + 1;
	}
	
	ProcessDefinitionRemote pdr;	
	
	try{
		pdr = pm.getProcessDefinitionRemote(pdVer);
		pm.applyChanges();
	}catch(Exception e){
		pm.cancelChanges();
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		throw e;
	}
	
		
	String title = pdr.getName().getText();
		
	String belongingDefId = pdr.getBelongingDefinitionId();
	String formDefinitionValue;
	
	try{
		formDefinitionValue = pm.getResource(pdVer);
		pm.applyChanges();
	}catch(Exception e){
		pm.cancelChanges();
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		throw e;
	}
%>

<script>
function init(){
	document.Wec.mimeValue = document.actionForm.ValueContent.value;
}

function removeDefinition(definition){
	answer = confirm("There may be a running instance with this process definition.\nAre you sure to remove?");
	if(answer){
		location="removeProcessDefinition.jsp?processDefinition=" + definition;
	}
}

function makeProduction(){
	location="makeProduction.jsp?processDefinition=<%=pdVer.replace(' ', '+')%>";
}

function saveForm(){
	document.actionForm.definition.value =  document.Wec.Value;
	document.actionForm.mimeContents.value =  document.Wec.mimeValue;
	document.actionForm.submit();
}

function updateForm(){
	document.actionForm.definition.value =  document.Wec.Value;
	document.actionForm.mimeContents.value =  document.Wec.mimeValue;
	document.actionForm.version.value = '<%=pdr.getVersion()%>';
	document.actionForm.submit();
}

function refresh(){
	var pdv = document.all.processDefinitionVersionID.value;
	location="?objectDefinitionId=<%=pd%>&folder=<%=folder%>&processDefinitionVersionID=" + pdv;
}


	function openCalendarDlg(){
		var newName = "";
		while(true) {
			newName = prompt("Enter new name.", "");
			if (newName != "" && newName != null) {
				setCalendarParam(newName);
				break;
			} else {
				break;
			} 
		} 
	}

	function setCalendarParam(calendarName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#calendar#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#calendar#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#calendar#".length, htmlSource.length);
		var expression = '<input type="text" id="' + calendarName + '" name="' + calendarName + '" value="" style="width:70" class="input" readonly="true" />\n';
		expression =  expression + '<img src="../../img/btn_cald.gif" width="18" height="18" border="0" align="absmiddle" style="cursor:hand" onclick="openCalendarPopup(\'' + calendarName + '\');" >';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}

	function openFormUserListDlg(){
		var newName = "";
		while(true) {
			newName = prompt("Enter new name.", "");
			if (newName != "" && newName != null) {
				setFormUserListParam(newName);
				break;
			} else {
				break;
			} 
		} 
	}

	function setFormUserListParam(formUserListName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#formUserList#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#formUserList#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#formUserList#".length, htmlSource.length);
		var expression = '<input readonly id="' + formUserListName + '_display" name="' + formUserListName + '_display" class="input" value=""/>\n';
		expression =  expression + '<input type=hidden id="' + formUserListName + '" name="' + formUserListName + '" value="">\n';
		expression =  expression + '<img src="../../img/btn_man.gif" width="18" height="18" border="0" align="absmiddle" style="cursor:hand" onclick="searchPeople(\'' + formUserListName + '\');" >';

		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}

	function openFileUploadDlg(){
		var newName = "";
		while(true) {
			newName = prompt("Enter new name.", "");
			if (newName != "" && newName != null) {
				setFileUploadParam(newName);
				break;
			} else {
				break;
			} 
		} 
	}

	function setFileUploadParam(fileUploadName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#fileUpload#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#fileUpload#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#fileUpload#".length, htmlSource.length);
		var expression = '<input type="hidden" id="' + fileUploadName + '_file" name="' + fileUploadName + '_file" value="">\n';
		expression =  expression + '<SELECT size=3 id="' + fileUploadName + '_file_list" name="' + fileUploadName + '_file_list"  ondblclick="selectedFileDown(this)">\n';
		expression =  expression + '<OPTION value="">----------------------------- attach file ----------------------------</OPTION>\n';
		expression =  expression + '</SELECT>\n';
		expression =  expression + '<input type=button class="btn"value="file add" onClick="popFile(\'' + fileUploadName + '\');"> <input type=button class="btn"value="file remove" onClick="removeAttach(\'' + fileUploadName + '\')">';
		
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}
</script>

<body onLoad="init();">
 
	
<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28" valign="bottom">
			<p><img src="../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
			<b>Form Information</b>
		</td>
	</tr>
	<tr>
		<td height="1" class="path_underline"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<%
		if(pdVer!=null){
	%>
		
		<tr>
			<td>	
				<br>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<form name=actionForm action="saveFormDefinition.jsp" method=POST>
					<tr>
						<td align="Right" valign="center">&nbsp;&nbsp;&nbsp;&nbsp;
							<input class="btn" value="Save" type=button onclick="saveForm()">
							<input class="btn" value="Update" key="button.update" type=button onclick="updateForm()">
							<input class="btn" value="Delete" type=button onclick="removeDefinition('<%=pdVer%>')">
		<%	
							if(pdr.isProduction()) {
		%>
								<font color=red>[This version is production]</font>
		<%
							} else {
		%>
								<input type=button class="btn" valign="center" value="Set as production" onclick="javascript:makeProduction()">
		<%
							}
		%>
						</td>
					</tr>				
				</table>
			</td>
		</tr>			
	<%
		}
	%>
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
			&nbsp;<b><%=GlobalContext.getLocalizedMessageForWeb("definition_version", loggedUserLocale, "Definition Version") %></b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<%=pdr.getName().getText()%> (Version: <%=pdr.getVersion()%>)
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>				
<%
	if(arrPdr != null){
%>	<tr height="30" >
		<td width="150" align=left bgcolor="f4f4f4">
			&nbsp;<b><%=GlobalContext.getLocalizedMessageForWeb("version", loggedUserLocale, "Version") %></b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<select name="processDefinitionVersionID" id="processDefinitionVersionID" onchange="refresh();">	
<%	
			String versionID = null;
			String version = "-1";
			for(int i=0; i<arrPdr.length; i++){
				versionID = arrPdr[i].getId();
				version = ""+arrPdr[i].getVersion() + (arrPdr[i].isProduction() ? "*":"");
%>
				<option value="<%=versionID%>" <%=(versionID.equals(pdVer))?"selected":""%>><%=version%></option>
<%
			}
%>
			</select>
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
<%
	}

	if (pdVer!=null) { 
		String desc = (pdr.getDescription()!=null ? pdr.getDescription().getText() : null);
		if ( desc == null ) desc = "";
%>	
	<tr height="30" >
		<td width="150" align=left bgcolor="f4f4f4">
			&nbsp;<b><%=GlobalContext.getLocalizedMessageForWeb("description", loggedUserLocale, "Description") %></b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<%=desc%>
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
<%
	}
%>	
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

			
			

			<br>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr><td>
								<a href="#" ><img onclick="openCalendarDlg();" src="../img/btn_calendar.gif" border="0" style="margin-left:1" title="달력"></a>
								<a href="#" ><img onclick="openFormUserListDlg();" src="../img/btn_manfind.gif" border="0"  style="margin-left:1" title="사용자찾기"></a>
								<a href="#" ><img onclick="openFileUploadDlg();" src="../img/btn_attach.gif" border="0" style="margin-left:1" title="파일첨부"></a>
							</td></tr>
						</table>

						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr height="20" >
								<td width="*" align=left style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:rgb(99,101,99); border-bottom-color:rgb(99,101,99); border-left-color:rgb(99,101,99); border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
								<p style="line-height:100%; margin-top:0; margin-bottom:0;">
						            <OBJECT WIDTH="0" HEIGHT="0" CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
						              <param name="LPKPath" value="../formmanager/lib/namo/ActiveSquare6/user/NamoWec6_korealife_eagle.lpk"/>
						            </OBJECT>
						            <OBJECT ID="Wec" style="width:100%;height:400px;text-align:center;" 
										CLASSID="CLSID:F5BF0251-F07B-42a6-85B7-8A6ABBB35C78" 
										codebase="../formmanager/lib/namo/ActiveSquare6/user/NamoWec.cab#version=6,0,0,25" viewMode="edit">
						            </OBJECT>
								</p>
								</td>		
							</tr>
						
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<span style="visibility:hidden;"><textarea name="ValueContent"><%=formDefinitionValue%></textarea></span>

<input name="defId" value="<%=pd%>" type=hidden>
<input name="definitionName" value="<%=pdr.getName().getText()%>" type=hidden>
<input name="version" value="<%=maxVersion%>" type=hidden>
<input name="definition" value="" type=hidden>
<input name="objectType" value="form" type=hidden>
<input name="mimeContents" value="" type=hidden>
</form>
</body>
</html>