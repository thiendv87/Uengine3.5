<%@include file="../wih/wihDefaultTemplate/header.jsp"%>
<%@ page language="java" import="com.fredck.FCKeditor.*" %>
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

<!-- 폼 -->
<form name=name="customizingForm" action="saveFormDefinition.jsp" method=POST>
<%
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
oFCKeditor.setBasePath( "/FCKeditor/" ) ;
oFCKeditor.setHeight("500px");
html = html.replace('\'', '\"');

oFCKeditor.setValue(html);
out.println( oFCKeditor.create() ) ;

%>
		
            <%@include file="../wih/wihDefaultTemplate/passValues.jsp"%>	
			<input type="submit" value="Submit">
			<input type="button" value="Restore default" onclick="restoreAsDefault()">
			<input type="hidden" name="restore">

</form>
</body>
</html>
