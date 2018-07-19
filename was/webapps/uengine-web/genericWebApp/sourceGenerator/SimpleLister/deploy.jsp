<%@page import="java.io.*"%>
<%
	String realPath=pageContext.getServletContext().getRealPath("html/uengine-web/");
	File dir = new File(realPath);

	String source = request.getParameter("_source");
	String location = request.getParameter("_fileName");
	
	FileWriter fw = new FileWriter(dir + "/" + location);
	fw.write(source);
	fw.close();
	
%>

<h1>Generate Simple Lister: 1.Enter Parameters > 2.Customize JSP > <font color=green>3.Deploy</font> </h1>

<form action="/html/uengine-web/<%=location%>">
<input type=submit value="Test">
</form>
