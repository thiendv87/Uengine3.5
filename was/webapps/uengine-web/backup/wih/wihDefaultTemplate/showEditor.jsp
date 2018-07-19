<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@include file="header.jsp"%>
<%@include file="definition.jsp"%>
<%@include file="initialize.jsp"%>
<%--@page language="java" import="com.fredck.FCKeditor.*" --%>
<!--
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: sample01.jsp
 * 	FCKeditor sample file 1.
 * 
 * Version:  2.1
 * Modified: 2005-03-29 21:30:00
 * 
 * File Authors:
 * 		Simone Chiaretta (simo@users.sourceforge.net)
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>FCKeditor - JSP Sample</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="robots" content="noindex, nofollow">
		<link href="../sample.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

			function FCKeditor_OnComplete( editorInstance )
			{
				window.status = editorInstance.Description ;
			}
			
			function restoreAsDefault(){
				document.customizingForm.restore.value = "yes";
				document.customizingForm.submit();
			}
			
		</script>
	</head>
	<body>
		<h1>Customizing Form</h1>
		Change the input form and click 'submit' button when to save it.
		<hr>
		<form action="saveForm.jsp" method="post" name="customizingForm">
<%--
RequestDispatcher dis = getServletContext().getRequestDispatcher("/html/uengine-web/wih/wihDefaultTemplate/standalone_showInputForm.jsp?isCustomizing=yes");
final StringWriter sw = new StringWriter();
dis.include(request, new HttpServletResponseWrapper(response){
	public PrintWriter getWriter() throws IOException {	
		return new PrintWriter(sw);
	}
});

String html = sw.toString();

FCKeditor oFCKeditor ;
oFCKeditor = new FCKeditor( request, "FCKeditor1" ) ;
oFCKeditor.setBasePath( GlobalContext.WEB_CONTEXT_ROOT + "/FCKeditor/" ) ;
oFCKeditor.setHeight("500px");
html = html.replace('\'', '\"');

oFCKeditor.setValue(html);
out.println( oFCKeditor.create() ) ;
--%>
<%
String val = request.getParameter("CKeditor1");
val = (val == null) ? "" : HtmlUtils.htmlEscape(val);
%>
<textarea id="CKeditor1" name="CKeditor1" ><%=val%></textarea>
<script type="text/javascript">
//<![CDATA[
	CKEDITOR.replace('CKeditor1',
	{
		skin : '<%=GlobalContext.getPropertyString("ckeditor.skin", "kama")%>', 
		height : ($(document).height() - 320) + "px"
	});
//]]>
</script>
			<br>
			<%@include file="passValues.jsp"%>
			<input type="submit" value="Submit">
			<input type="button" value="Restore default" onclick="restoreAsDefault()">
			<input type="hidden" name="restore">
		</form>
	</body>
</html>
