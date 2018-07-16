<%@include file="header.jsp"%>
<%@page import="java.net.*" %>
<%@include file="definition.jsp"%>
<%@include file="initialize.jsp"%>

<html>
<head>
	<title> Record Completion Pattern</title>
<%
	boolean isActiveXBrowser = false;

	String url = request.getParameter("url");
	if(!url.startsWith("http://")){
		String serverUrl = request.getRequestURL().toString();
		String codebase = serverUrl.substring( 0, serverUrl.lastIndexOf( "/" ) );
		URL urlURL = new java.net.URL(codebase);
		String host = urlURL.getHost();
		int port = urlURL.getPort();

		url = "http://" + host + (port != 80 ? ":"+port : "") + url;
	}
	

	String realPath=pageContext.getServletContext().getRealPath("html/uengine-web/forms/");
	String fileName = "completionPattern.xml";
	String urlPattern = null;
	String htmlPattern = null;
	String urlPattern2 = null;
	String htmlPattern2 = null;
	
	try{
		
		File dir = new File(realPath + "/" + processDefinition + "/" + tracingTag);

		FileInputStream fis = new FileInputStream(dir + "/" + fileName);

		Properties prop = (Properties)GlobalContext.deserialize(fis, String.class);
		urlPattern = prop.getProperty("urlPattern");
		htmlPattern = prop.getProperty("htmlPattern");
		if(htmlPattern!=null){
			htmlPattern = htmlPattern.replace('\n', ' ');
			htmlPattern = htmlPattern.replace('\r', ' ');
		}

		urlPattern2 = prop.getProperty("urlPattern2");
		htmlPattern2 = prop.getProperty("htmlPattern2");

		if(UEngineUtil.isNotEmpty(htmlPattern2)){
			htmlPattern2 = htmlPattern2.replace('\n', ' ');
			htmlPattern2 = htmlPattern2.replace('\r', ' ');
		}
		fis.close();
	}catch(Exception e){
		
	}
%>

<script>
 	function go(){
<%
	if(isActiveXBrowser){
%>
		Browser.go("<%=url%>")
<%
	}
%>
	}
</script>
</head>

<body onload="go()" bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="5" topmargin="0" marginwidth="0" marginheight="0">
 


<%
	if(isActiveXBrowser){
%>
<SCRIPT for="Browser" event="DocumentComplete(pDisp, URL)" language="javascript">

	if(!confirm('Set this event as completion?')) return;

	document.all.urlPattern.value = URL;

	var html = "";
	var element;
	element = pDisp.Document.body
	while (element.parentElement != null) {
		element = element.parentElement;
	}
	html = element.outerHTML;

	document.all.htmlPattern.value = html;

</SCRIPT>
<%
	}else{
%>
<SCRIPT language="javascript">

	function onApplicationLoaded(){
		if(!confirm('Set this event as completion?')) return;

 		var applicationFrame = document.frames["applicationFrame"];
 	
 		var URL = ""+ applicationFrame.window.location;
 		var html = applicationFrame.document.documentElement.innerHTML;
	
		document.all.urlPattern.value = URL;
		document.all.htmlPattern.value = html;
	}

</SCRIPT>
<%
	}
%>


<form action="saveCompletionPattern.jsp" method=POST>
<%@include file="passValues.jsp"%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
<tr>
<td height="28" valign="bottom">
<img src="../../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
 <b> Record Completion Pattern </b>
</td>
</tr>
<tr>
<td height="1" class="path_underline"></td>
</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
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
<tr height="20" >
<td width="150" align=left bgcolor="f4f4f4">
Pattern of URL
</td>
<td width="10"></td>
<td width="*" align=left>
	<input size=100 name="urlPattern" value="<%=urlPattern%>">
</td>		
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
<td width="10"></td>
<td align="center" height="1" class="bgcolor_head_upperline"></td>
</tr>
<tr height="20" >
<td width="150" align=left bgcolor="f4f4f4">
Pattern of result HTML
</td>
<td width="10"></td>
<td width="*" align="left">
	<textarea name="htmlPattern" cols=80 rows=5><%=htmlPattern%></textarea>
</td>		
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
<td width="10"></td>
<td align="center" height="1" class="bgcolor_head_upperline"></td>
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
<input type="button" value="OR" onclick="document.forms[0].urlPattern2.value=document.forms[0].urlPattern.value;document.forms[0].htmlPattern2.value=document.forms[0].htmlPattern.value;pattern2.style.display=(pattern2.style.display=='' ? 'NONE':'');">

<!-- or button click -->
<div id="pattern2" style="display : 'NONE'">
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
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
<tr height="20" >
<td width="150" align=left bgcolor="f4f4f4">
Pattern of URL
</td>
<td width="10"></td>
<td width="*" align="left">
	<input size="100" name="urlPattern2" value="<%=urlPattern2%>">
</td>		
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
<td width="10"></td>
<td align="center" height="1" class="bgcolor_head_upperline"></td>
</tr>
<tr height="20" >
<td width="150" align=left bgcolor="f4f4f4">
Pattern of result HTML
</td>
<td width="10"></td>
<td width="*" align="left">
	<textarea name="htmlPattern2" cols=80 rows=5><%=htmlPattern2%></textarea>
</td>		
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
<td width="10"></td>
<td align="center" height="1" class="bgcolor_head_upperline"></td>
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

</div>

<input type=submit value="Save Compeletion Pattern">

</form>


<%
	if(isActiveXBrowser){
%>


<OBJECT ID="Browser" CLASSID="CLSID:7665E723-3C49-4FAB-966F-A306A996C59B" width=100% height=800></OBJECT>
<%
	}else{
%>
<table cellpadding=1 cellspacing=1 border=0 width=100%><td bgcolor=gray><table cellpadding=0 cellspacing=0 border=0><td>

<iframe name="applicationFrame" onload="onApplicationLoaded()" frameborder=0 width=100% height=800 src="<%=request.getParameter("url")%>"></iframe>
</td></table></td></table>
<%
	}
%>

</html>