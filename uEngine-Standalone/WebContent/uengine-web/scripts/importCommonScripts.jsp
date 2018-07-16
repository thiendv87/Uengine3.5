<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../lib/jquery/importJquery.jsp"%><%
String webContextRoot = org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT;
String defaultLocale = (String) session.getAttribute("loggedUserLocale");//org.uengine.kernel.GlobalContext.DEFAULT_LOCALE;
if (defaultLocale == null) {
	defaultLocale = org.uengine.kernel.GlobalContext.DEFAULT_LOCALE;	
}
%>

<script type="text/javascript">
	var WEB_CONTEXT_ROOT = "<%=webContextRoot%>";
	var LOGGED_USER_LOCALE = "<%=defaultLocale%>";
</script>
<script type="text/javascript" src="<%=webContextRoot%>/scripts/crossBrowser/elementControl.js"></script>
<script type="text/javascript" src="<%=webContextRoot%>/scripts/ajax/ajaxCommon.js"></script>
<script type="text/javascript" src="<%=webContextRoot%>/scripts/common.js"></script>
<script type="text/javascript" src="<%=webContextRoot%>/lib/ckeditor/ckeditor.js"></script>
