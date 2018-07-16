<%@page import="java.util.Calendar"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	String rmClsName = request.getParameter("rmClsName");
%>
<script type="text/javascript">
var WEB_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
var RM_CLS_NAME = "<%=rmClsName%>";
</script>


<script type="text/javascript" src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/scripts/formcontrol/addrow.js"></script>
<script type="text/javascript" src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/scripts/formActivityUtil.js?<%=Calendar.getInstance().getTimeInMillis()%>"></script>
<script type="text/javascript" src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/scripts/fileUpload.js"></script>