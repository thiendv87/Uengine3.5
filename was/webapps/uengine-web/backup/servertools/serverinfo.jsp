<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.apache.commons.lang.SystemUtils"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Server Info</title>
</head>
<body>

<%
	StringBuffer sb = new StringBuffer("");
	sb.append("<table>");
	sb.append("<tr><td>").append("FILE_ENCODING").append("</td><td>").append(SystemUtils.FILE_ENCODING).append("</td></tr>");
	sb.append("<tr><td>").append("FILE_SEPARATOR").append("</td><td>").append(SystemUtils.FILE_SEPARATOR).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_CLASS_PATH").append("</td><td>").append(SystemUtils.JAVA_CLASS_PATH).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_CLASS_VERSION").append("</td><td>").append(SystemUtils.JAVA_CLASS_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_COMPILER").append("</td><td>").append(SystemUtils.JAVA_COMPILER).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_EXT_DIRS").append("</td><td>").append(SystemUtils.JAVA_EXT_DIRS).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_HOME").append("</td><td>").append(SystemUtils.JAVA_HOME).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_IO_TMPDIR").append("</td><td>").append(SystemUtils.JAVA_IO_TMPDIR).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_LIBRARY_PATH").append("</td><td>").append(SystemUtils.JAVA_LIBRARY_PATH).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_RUNTIME_NAME").append("</td><td>").append(SystemUtils.JAVA_RUNTIME_NAME).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_RUNTIME_VERSION").append("</td><td>").append(SystemUtils.JAVA_RUNTIME_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_SPECIFICATION_NAME").append("</td><td>").append(SystemUtils.JAVA_SPECIFICATION_NAME).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_SPECIFICATION_VENDOR").append("</td><td>").append(SystemUtils.JAVA_SPECIFICATION_VENDOR).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_SPECIFICATION_VERSION").append("</td><td>").append(SystemUtils.JAVA_SPECIFICATION_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VENDOR").append("</td><td>").append(SystemUtils.JAVA_VENDOR).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VENDOR_URL").append("</td><td>").append(SystemUtils.JAVA_VENDOR_URL).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VERSION").append("</td><td>").append(SystemUtils.JAVA_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_INFO").append("</td><td>").append(SystemUtils.JAVA_VM_INFO).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_NAME").append("</td><td>").append(SystemUtils.JAVA_VM_NAME).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_SPECIFICATION_NAME").append("</td><td>").append(SystemUtils.JAVA_VM_SPECIFICATION_NAME).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_SPECIFICATION_VENDOR").append("</td><td>").append(SystemUtils.JAVA_VM_SPECIFICATION_VENDOR).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_SPECIFICATION_VERSION").append("</td><td>").append(SystemUtils.JAVA_VM_SPECIFICATION_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_VENDOR").append("</td><td>").append(SystemUtils.JAVA_VM_VENDOR).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VM_VERSION").append("</td><td>").append(SystemUtils.JAVA_VM_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("LINE_SEPARATOR").append("</td><td>").append(SystemUtils.LINE_SEPARATOR).append("</td></tr>");
	sb.append("<tr><td>").append("OS_ARCH").append("</td><td>").append(SystemUtils.OS_ARCH).append("</td></tr>");
	sb.append("<tr><td>").append("OS_NAME").append("</td><td>").append(SystemUtils.OS_NAME).append("</td></tr>");
	sb.append("<tr><td>").append("OS_VERSION").append("</td><td>").append(SystemUtils.OS_VERSION).append("</td></tr>");
	sb.append("<tr><td>").append("PATH_SEPARATOR").append("</td><td>").append(SystemUtils.PATH_SEPARATOR).append("</td></tr>");
	sb.append("<tr><td>").append("USER_COUNTRY").append("</td><td>").append(SystemUtils.USER_COUNTRY).append("</td></tr>");
	sb.append("<tr><td>").append("USER_DIR").append("</td><td>").append(SystemUtils.USER_DIR).append("</td></tr>");
	sb.append("<tr><td>").append("USER_HOME").append("</td><td>").append(SystemUtils.USER_HOME).append("</td></tr>");
	sb.append("<tr><td>").append("USER_LANGUAGE").append("</td><td>").append(SystemUtils.USER_LANGUAGE).append("</td></tr>");
	sb.append("<tr><td>").append("USER_NAME").append("</td><td>").append(SystemUtils.USER_NAME).append("</td></tr>");
	sb.append("<tr><td>").append("USER_TIMEZONE").append("</td><td>").append(SystemUtils.USER_TIMEZONE).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VERSION_FLOAT").append("</td><td>").append(SystemUtils.JAVA_VERSION_FLOAT).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VERSION_FLOAT").append("</td><td>").append(SystemUtils.JAVA_VERSION_FLOAT).append("</td></tr>");
	sb.append("<tr><td>").append("JAVA_VERSION_INT ").append("</td><td>").append(SystemUtils.JAVA_VERSION_INT ).append("</td></tr>");
	sb.append("<tr><td>").append("IS_JAVA_1_1").append("</td><td>").append(SystemUtils.IS_JAVA_1_1).append("</td></tr>");
	sb.append("<tr><td>").append("IS_JAVA_1_2 ").append("</td><td>").append(SystemUtils.IS_JAVA_1_2).append("</td></tr>");
	sb.append("<tr><td>").append("IS_JAVA_1_3").append("</td><td>").append(SystemUtils.IS_JAVA_1_3).append("</td></tr>");
	sb.append("<tr><td>").append("IS_JAVA_1_4").append("</td><td>").append(SystemUtils.IS_JAVA_1_4).append("</td></tr>");
	sb.append("<tr><td>").append("IS_JAVA_1_5").append("</td><td>").append(SystemUtils.IS_JAVA_1_5).append("</td></tr>");
	sb.append("<tr><td>").append("IS_JAVA_1_6").append("</td><td>").append(SystemUtils.IS_JAVA_1_6).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_AIX").append("</td><td>").append(SystemUtils.IS_OS_AIX).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_HP_UX").append("</td><td>").append(SystemUtils.IS_OS_HP_UX).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_IRIX").append("</td><td>").append(SystemUtils.IS_OS_IRIX).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_LINUX").append("</td><td>").append(SystemUtils.IS_OS_LINUX).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_MAC").append("</td><td>").append(SystemUtils.IS_OS_MAC).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_MAC_OSX").append("</td><td>").append(SystemUtils.IS_OS_MAC_OSX).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_OS2").append("</td><td>").append(SystemUtils.IS_OS_OS2).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_SUN_OS").append("</td><td>").append(SystemUtils.IS_OS_SUN_OS).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS_2000").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS_2000).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS_95").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS_95).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS_98 ").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS_98 ).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS_ME").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS_ME).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS_NT").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS_NT).append("</td></tr>");
	sb.append("<tr><td>").append("IS_OS_WINDOWS_XP").append("</td><td>").append(SystemUtils.IS_OS_WINDOWS_XP).append("</td></tr>");
	sb.append("</table>");
	out.print(sb.toString());
%>
</body>
</html>