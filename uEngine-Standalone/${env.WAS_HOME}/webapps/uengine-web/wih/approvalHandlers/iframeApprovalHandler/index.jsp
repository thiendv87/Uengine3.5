<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>

<html>

<head>
<%@include file="../../wihDefaultTemplate/header.jsp"%>
<%@include file="../../wihDefaultTemplate/definition.jsp"%>
<%@include file="../../wihDefaultTemplate/initialize.jsp"%>
<%@include file="../../../scripts/importCommonScripts.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/formdefault.css" />

<script type="text/javascript">
		function init(){
			document.formIndexPassValues.submit();
		}
	</script>
</head>
<body onload="init();" style="overflow: hidden;">
<%
	try {
		isMine = initiate
				|| "yes".equals(request.getParameter("isMine"));
		ProcessInstance instance = piRemote;
%>
<iframe width="100%" height="100%" name="iframeWihContent" id="iframeWihContent" scrolling="auto" marginheight="0" marginwidth="0" frameborder="0" src="about:blank"></iframe>
<form action="<%=instance.get("url")%>" name="formIndexPassValues" method="POST" target="iframeWihContent">
	<%@include file="../../wihDefaultTemplate/passValues.jsp"%>
	<%@include file="../../wihDefaultTemplate/addIndexPassValues.jsp"%>
</form>
<%
	} catch (Exception e) {
		throw e;
	} finally {
		try { pm.cancelChanges(); } catch (Exception ex) {}
		try { pm.remove(); } catch (Exception ex) {}
	}
%>

</body>
</html>
