<%@page import="org.uengine.util.UEngineUtil"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	/**	Session Remove	**/
	java.util.Enumeration enumeration = session.getAttributeNames();
	while(enumeration.hasMoreElements()){
		String attname = String.valueOf(enumeration.nextElement());
		session.removeAttribute(attname);
	}
	
	/** Cookie Remove **/
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if(request.getProtocol().equals("HTTP/1.1"))
	   response.setHeader("Cache-Control", "no-cache");
	
	boolean useCookie = "true".equals(org.uengine.kernel.GlobalContext.getPropertyString("web.cookie.use","false"));
	String cookieKey = GlobalContext.getPropertyString("web.cookie.key.autologin");
%>
<%@include file="./scripts/importCommonScripts.jsp" %>
<script type="text/javascript">
<% if (useCookie && UEngineUtil.isNotEmpty(cookieKey)) { %>
	$.cookie("<%=cookieKey%>","");
<% } %>
	window.location.href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/loginForm.jsp";
</script>