<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%
	String TEMP_DIRECTORY = GlobalContext.getPropertyString(
			"filesystem.path",
			"." + File.separatorChar + "uengine" + File.separatorChar + "fileSystem" + File.separatorChar
		);
	TEMP_DIRECTORY = TEMP_DIRECTORY + "telnet" + File.separatorChar;
	File f = new File(TEMP_DIRECTORY);
	if (!f.exists()) {
		f.mkdirs();
	}
	
	String fileName = request.getParameter("fileName");
	String filePath = TEMP_DIRECTORY + File.separatorChar;
	File file = new File(filePath + fileName);
	
	String Str = "";
	String totalStr = "";
	if (file.exists()) {
		BufferedReader br = new BufferedReader(new FileReader(file));
		while ((Str = br.readLine()) != null) {
			totalStr += Str + "\r\n<br />";
		}
		br.close();
		if (totalStr.indexOf("\r\n") != -1)
			totalStr = totalStr.substring(0, totalStr.lastIndexOf("\r\n<br />"));
	} else {
		totalStr = "Empty Total Result";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<font size="2"><%=totalStr %></font>
</body>
</html>