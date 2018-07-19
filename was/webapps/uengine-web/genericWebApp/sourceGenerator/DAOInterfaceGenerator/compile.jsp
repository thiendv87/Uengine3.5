<%@page import="java.io.*"%>
<%
	String realPath=pageContext.getServletContext().getRealPath("html/uengine-web/");
	File dir = new File(realPath);
	dir = dir.getParentFile().getParentFile();
	dir = new File(dir.getAbsolutePath() + "/WEB-INF/classes");

	String source = request.getParameter("_source");
	String location = request.getParameter("_fileName");
	String clsName = request.getParameter("_className");
	String tableName = request.getParameter("_tableName");
	
	location = dir + "/" + location;
	FileWriter fw = new FileWriter(location);
	fw.write(source);
	fw.close();
	
	String classpath = dir.getParentFile().getParentFile().getParentFile().getParentFile() + "/uengine.jar";
	
	com.sun.tools.javac.Main.compile(new String[]{"-classpath", classpath, location});
%>

<h1>Create a DAO interface: 1.Generate Interface > <font color=green>2.Compile</font></h1>

<form action="../..">
<input type=submit value="Return Step1" target="selection">
<input type=hidden name="_clsName" value="<%=clsName%>">
<input type=hidden name="_tableName" value="<%=tableName%>">
</form>

