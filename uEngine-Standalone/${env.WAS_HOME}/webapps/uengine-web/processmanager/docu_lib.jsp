﻿<%@page language="java" contentType="text/html; charset=UTF-8" import="java.util.*"%>

<%@ page import="com.liferay.portlet.documentlibrary.service.spring.DLFolderLocalServiceUtil"%>
<%@ page import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@include file="../common/headerMethods.jsp"%>

<html>
	<head>
		<title>Docuement Lib</title>
		<script language="javascript">
		
			var variable            = null;
			var FCK = window.opener.FCK;
			function ok(){
				FCK.Focus();
				var options = document.documentLib.folderIdList.options;
				for(i = 0 ; i< options.length ; i++){
					if(options[i].selected){
						
						selectedValue = document.documentLib.folderIdList.options[i].value;
						selectedName = document.documentLib.folderIdList.options[i].name;
						var html = "<table border=0><td width=10 style='background-IMAGE: url(/html/uengine-web/processmanager/images/Docu_Lib.gif); background-repeat: no-repeat; background-position: center;'>";
						html = html+"<input:documentlib name=\""+selectedName +"\" folderid=\""+selectedValue+"\" value=documentlib>";
					    html = html +"</td></table>";
					    FCK.InsertHtml(html);
 
        				window.close();	
					}
				}
			}
			
		</script>
	</head>
	
<form name=documentLib>
	<body onload=getFolderId() leftmargin="0" topmargin="0" >
<table width=100% height=100% cellpadding=0 cellspacing=0>
	<tr>
		<td bgcolor=E3E3C7 height= 35><font size=3 color=737357 face="돋음">&nbsp;&nbsp;<b>Docuement Lib</font></td>
	</tr>
	<tr>
		<td align=center bgcolor=F1F1E3>
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td ><font size=2 face="굴림">Choice document <br>
						<select name="folderIdList" size=1>
							<option  value=""> - Flder Name -</option>
<%
	java.util.List folders = DLFolderLocalServiceUtil.getFolders("liferay.com");
	
	com.liferay.portlet.documentlibrary.model.DLFolder[] dlFolders = (DLFolder[]) folders.toArray(new com.liferay.portlet.documentlibrary.model.DLFolder[0]);
	for(int i=0 ; i < dlFolders.length ; i++)
	{
		String dlValue = dlFolders[i].getFolderId();
		String dlName = replaceAmp(dlFolders[i].getName());
%>
							<option  value="<%=dlValue%>" name="<%=dlName%>" ><%=dlName%></option>
<%
	}
%>
 
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor=E3E3C7 height= 35 align=right><input type=button size=20 onClick="ok();" value="      OK      "> <input type=button size=5 onClick="javascript:window.close();"s value="CANCEL"></td>
	</tr>
</table>
 	
	
	
	</body>
</html>
</form>
